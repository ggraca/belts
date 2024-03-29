module BeltsAssets
  # TODO: returns a model and can become Model.from_file
  # Note: Model should hold all info, ready to be registered.
  # Asset: manager should hold models, ready to be loaded, unloaded,
  class Importer
    attr_reader :model

    def initialize(key, file_path)
      @scene = Assimp.aiImportFile(file_path,
        Assimp::Process::Preset::TARGET_REALTIME_MAX_QUALITY |
        Assimp::Process::CONVERT_TO_LEFT_HANDED |
        Assimp::Process::EMBED_TEXTURES)

      @model = Model.new
      @model.id = @global_id = key
      @model.materials = import_materials
      @model.meshes = import_meshes
      @model.root_node = import_nodes
    end

    private

    def import_meshes
      Array.new(@scene[:mNumMeshes]) do |i|
        pointer = Assimp::MeshPointer.new(@scene[:mMeshes].to_ptr + i * Assimp::MeshPointer.size)
        import_mesh(pointer[:mesh], i)
      end
    end

    def import_mesh(mesh_data, index)
      mesh = Mesh.new
      mesh.id = fetch_mesh_id(index)
      mesh.name = mesh_data[:mName][:data].to_s
      mesh.material_id = fetch_material_id(mesh_data[:mMaterialIndex])

      Array.new(mesh_data[:mNumVertices]) do |i|
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

        mesh.colors << [1, 0, 0, 1]
      end

      Array.new(mesh_data[:mNumFaces]) do |i|
        face = Assimp::Face.new(mesh_data[:mFaces] + i * Assimp::Face.size)
        mesh.indices << face[:mIndices].to_ptr.read_array_of_uint(face[:mNumIndices])
      end

      mesh.indices.flatten!
      # pp mesh.vertices
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

      material = Material.new
      material.id = fetch_material_id(index)
      material.name = properties["?mat.name"]
      material.color = Vec4[*properties["$clr.diffuse"]]

      material
    end

    def import_property(property_data)
      # pp property[:mType].to_s + " " + property[:mKey][:data].to_s + " #{import_property(property)}"

      case property_data[:mType]
      when 1 # float (4 bytes)
        property_data[:mData].to_ptr.read_array_of_float(property_data[:mDataLength] / 4)
      when 2 # double (8 bytes)
        property_data[:mData].to_ptr.read_array_of_double(property_data[:mDataLength] / 8)
      when 3 # aiString
        Assimp::String.new(property_data[:mData])[:data].to_s
      when 4 # int (4 bytes)
        property_data[:mData].to_ptr.read_array_of_int(property_data[:mDataLength] / 4)
      when 5 # aiShadingMode (4 bytes)
        property_data[:mData].to_ptr.read_array_of_int(property_data[:mDataLength] / 4)
      else
        raise "Unknown property type: #{property_data[:mType]} for #{property_data[:mKey][:data]}"
      end
    end

    def import_nodes(parent_node = nil, cur_node_data = @scene[:mRootNode])
      model_node = ModelNode.new
      model_node.name = cur_node_data[:mName][:data].to_s
      model_node.transformation = Mat4[*cur_node_data[:mTransformation]]
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
      :"#{@global_id}_mesh_#{local_id}"
    end

    def fetch_material_id(local_id)
      :"#{@global_id}_material_#{local_id}"
    end
  end
end
