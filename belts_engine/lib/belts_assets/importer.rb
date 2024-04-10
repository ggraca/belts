require "rmagick"
module BeltsAssets
  class Importer
    attr_reader :model, :textures, :materials, :meshes

    def initialize(key, file_path)
      @scene = import_scene(file_path)

      @model = Model.new(key)

      @textures = import_textures
      @materials = import_materials
      @meshes = import_meshes

      @model.root_node = import_nodes
    end

    private

    def import_scene(file_path)
      store = Assimp.aiCreatePropertyStore
      Assimp.aiSetImportPropertyInteger(store, "PP_RVC_FLAGS", Assimp::Component::COLORS)

      scene = Assimp.aiImportFileExWithProperties(file_path,
        Assimp::Process::Preset::TARGET_REALTIME_MAX_QUALITY |
        Assimp::Process::CONVERT_TO_LEFT_HANDED |
        Assimp::Process::EMBED_TEXTURES |
        # Assimp::Process::PRE_TRANSFORM_VERTICES |
        Assimp::Process::REMOVE_COMPONENT |
        0,
        nil, store)

      Assimp.aiReleasePropertyStore(store)

      scene
    end

    def import_textures
      Array.new(@scene[:mNumTextures]) do |i|
        pointer = Assimp::TexturePointer.new(@scene[:mTextures].to_ptr + i * Assimp::TexturePointer.size)
        import_texture(pointer[:texture], i)
      end
    end

    def import_texture(texture_data, index)
      image = Magick::Image.from_blob(texture_data[:pcData].get_bytes(0, texture_data[:mWidth]).to_s) do |img|
        img.format = texture_data[:achFormatHint].to_s
      end.first

      texture = Texture.new(fetch_texture_id(index))
      texture.width = image.columns
      texture.height = image.rows
      texture.data = image.export_pixels_to_str(0, 0, image.columns, image.rows, "RGBA")
      texture
    end

    def import_meshes
      Array.new(@scene[:mNumMeshes]) do |i|
        pointer = Assimp::MeshPointer.new(@scene[:mMeshes].to_ptr + i * Assimp::MeshPointer.size)
        import_mesh(pointer[:mesh], i)
      end
    end

    def import_mesh(mesh_data, index)
      mesh = Mesh.new(fetch_mesh_id(index))
      mesh.name = mesh_data[:mName][:data].to_s
      mesh.material_id = fetch_material_id(mesh_data[:mMaterialIndex])
      mesh.total_vertices = mesh_data[:mNumVertices]

      Array.new(mesh.total_vertices) do |i|
        mesh.positions << Assimp::Vector3D.new(mesh_data[:mVertices].to_ptr + i * Assimp::Vector3D.size).values

        if !mesh_data[:mNormals].null?
          mesh.normals << Assimp::Vector3D.new(mesh_data[:mNormals].to_ptr + i * Assimp::Vector3D.size).values
        end

        if !mesh_data[:mTangents].null?
          mesh.tangents << Assimp::Vector3D.new(mesh_data[:mTangents].to_ptr + i * Assimp::Vector3D.size).values
        end

        if !mesh_data[:mBitangents].null?
          mesh.bitangents << Assimp::Vector3D.new(mesh_data[:mBitangents].to_ptr + i * Assimp::Vector3D.size).values
        end

        mesh_data[:mTextureCoords].each do |texture_coords|
          break if texture_coords.null?

          mesh.texture_coords << Assimp::Vector3D.new(texture_coords.to_ptr + i * Assimp::Vector3D.size).values[0..1]
        end
      end
      pp mesh.normals[0]
      pp mesh.tangents[0]
      pp mesh.bitangents[0]
      pp mesh.texture_coords[0]

      Array.new(mesh_data[:mNumFaces]) do |i|
        face = Assimp::Face.new(mesh_data[:mFaces] + i * Assimp::Face.size)
        mesh.indices << face[:mIndices].to_ptr.read_array_of_uint(face[:mNumIndices])
      end

      mesh.indices.flatten!
      mesh.total_elements = mesh.indices.size

      mesh
    end

    def import_materials
      Array.new(@scene[:mNumMaterials]) do |i|
        pointer = Assimp::MaterialPointer.new(@scene[:mMaterials].to_ptr + i * Assimp::MaterialPointer.size)
        import_material(pointer[:material], i)
      end
    end

    def import_material(material_data, index)
      properties = {}
      material_data[:mNumProperties].times do |i|
        pointer = Assimp::MaterialPropertyPointer.new(material_data[:mProperties].to_ptr + i * Assimp::MaterialPropertyPointer.size)
        property = pointer[:material_property]
        properties[property[:mKey][:data].to_s] = import_property(property)
      end

      # pp properties

      material = Material.new(fetch_material_id(index))
      material.name = properties["?mat.name"]
      pp material.name

      albedo_index = fetch_embeded_texture_index(material_data, Assimp::TextureType[:BASE_COLOR])
      normals_index = fetch_embeded_texture_index(material_data, Assimp::TextureType[:NORMALS])
      roughness_index = fetch_embeded_texture_index(material_data, Assimp::TextureType[:DIFFUSE_ROUGHNESS])
      metalness_index = fetch_embeded_texture_index(material_data, Assimp::TextureType[:METALNESS])
      ao_index = fetch_embeded_texture_index(material_data, Assimp::TextureType[:AMBIENT_OCCLUSION])
      color = fetch_color(material_data, Assimp::Matkey::COLOR_DIFFUSE)

      material.texture_ids[:albedo] = fetch_texture_id(albedo_index) if albedo_index
      material.texture_ids[:normals] = fetch_texture_id(normals_index) if normals_index
      material.texture_ids[:roughness] = fetch_texture_id(roughness_index) if roughness_index
      material.texture_ids[:metalness] = fetch_texture_id(metalness_index) if metalness_index
      material.texture_ids[:ambient_occlusion] = fetch_texture_id(ao_index) if ao_index
      material.color = color if color

      material
    end

    def import_property(property_data)
      case property_data[:mType]
      when 1 # float (4 bytes)
        property_data[:mData].to_ptr.read_array_of_float(property_data[:mDataLength] / 4)
      when 2 # double (8 bytes)
        property_data[:mData].to_ptr.read_array_of_double(property_data[:mDataLength] / 8)
      when 3 # aiString
        Assimp::String.new(property_data[:mData])[:data].to_s
      when 4 # int (4 bytes)
        property_data[:mData].to_ptr.read_array_of_int(property_data[:mDataLength] / 4)
      when 5 # binary buffer
        property_data[:mData].to_ptr.read_bytes(property_data[:mDataLength])
      else
        raise "Unknown property type: #{property_data[:mType]} for #{property_data[:mKey][:data]}"
      end
    end

    def import_nodes(parent_node = nil, cur_node_data = @scene[:mRootNode])
      model_node = ModelNode.new
      model_node.name = cur_node_data[:mName][:data].to_s
      model_node.transformation = Mat4[*cur_node_data[:mTransformation]].invert_major
      model_node.parent = parent_node

      local_ids = cur_node_data[:mMeshes].read_array_of_uint(cur_node_data[:mNumMeshes])
      model_node.mesh_ids = local_ids.map { |id| fetch_mesh_id(id) }

      cur_node_data[:mNumChildren].times do |i|
        pointer = Assimp::NodePointer.new(cur_node_data[:mChildren].to_ptr + i * Assimp::NodePointer.size)
        child_node_data = pointer[:node]

        model_node.children << import_nodes(model_node, child_node_data)
      end

      model_node
    end

    def fetch_mesh_id(local_id)
      :"#{@model.id}_mesh_#{local_id}"
    end

    def fetch_material_id(local_id)
      :"#{@model.id}_material_#{local_id}"
    end

    def fetch_texture_id(local_id)
      :"#{@model.id}_texture_#{local_id}"
    end

    def fetch_embeded_texture_index(material_data, texture_type)
      s = Assimp::String.new
      result = Assimp.aiGetMaterialTexture(material_data, texture_type, 0, s, nil, nil, nil, nil, nil, nil)
      return nil if result != :Success

      path = s[:data].to_s
      raise "Invalid texture path: #{path}\nOnly embedded textures are supported" unless path.start_with?("*")

      path[1..].to_i
    end

    def fetch_color(material_data, key)
      color = Assimp::Color4D.new
      result = Assimp.aiGetMaterialColor(material_data, key, 0, 0, color)
      return nil if result != :Success

      Vec4[color[:r], color[:g], color[:b], color[:a]]
    end
  end
end
