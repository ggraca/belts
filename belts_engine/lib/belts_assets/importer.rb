module BeltsAssets
  # TODO: returns a model and can become Model.from_file
  # Note: Model should hold all info, ready to be registered.
  # Asset: manager should hold models, ready to be loaded, unloaded,
  class Importer
    attr_reader :model

    def initialize(key, file_path)
      @scene = Assimp.aiImportFile(file_path, 32779)
      @model = Model.new
      @model.id = @global_id = key
      @model.materials = import_materials
      @model.meshes = import_meshes
      @model.root_node = import_nodes
    end

    private

    def import_meshes
      @scene[:mNumMeshes].times.map do |i|
        pointer = Assimp::MeshPointer.new(@scene[:mMeshes].to_ptr + i * Assimp::MeshPointer.size)
        import_mesh(pointer[:mesh], i)
      end
    end

    def import_mesh(mesh_data, index)
      vertices = mesh_data[:mNumVertices].times.map do |i|
        vert = Assimp::Vector3D.new(mesh_data[:mVertices].to_ptr + i * Assimp::Vector3D.size)
        norm = Assimp::Vector3D.new(mesh_data[:mNormals].to_ptr + i * Assimp::Vector3D.size)

        [*vert.values, *norm.values, 1, 0, 0, 1]
      end

      indices = mesh_data[:mNumFaces].times.map do |i|
        face = Assimp::Face.new(mesh_data[:mFaces] + i * Assimp::Face.size)
        face[:mIndices].to_ptr.read_array_of_uint(face[:mNumIndices])
      end

      mesh = Mesh.new
      mesh.id = fetch_mesh_id(index)
      mesh.vertices = vertices.flatten
      mesh.indices = indices.flatten
      mesh.material_id = fetch_material_id(mesh_data[:mMaterialIndex])
      mesh
    end

    def import_materials
      @scene[:mNumMaterials].times.map do |i|
        pointer = Assimp::MaterialPointer.new(@scene[:mMaterials].to_ptr + i * Assimp::MaterialPointer.size)
        import_material(pointer[:material], i)
      end
    end

    def import_material(material_data, index)
      material = Material.new
      material.id = fetch_material_id(index)
      material.color = Vec3[0.2, 0.7, 0.8]

      material_data[:mNumProperties].times.map do |i|
        pointer = Assimp::MaterialPropertyPointer.new(material_data[:mProperties].to_ptr + i * Assimp::MaterialPropertyPointer.size)
        property = pointer[:material_property]

        val =
          case property[:mType]
          when 1
            property[:mData].to_ptr.read_array_of_float(3)
          when 3
            property[:mData].to_ptr.read_string(property[:mDataLength])
          when 4
            property[:mData].to_ptr.read_uint
          else
            property[:mData].to_ptr.read_array_of_uint(property[:mDataLength])
          end

        pp property[:mType].to_s + " " + property[:mKey][:data].to_s + " #{val}"
      end

      material
    end

    def import_nodes(parent_node = nil, cur_node_data = @scene[:mRootNode])
      model_node = ModelNode.new
      model_node.name = cur_node_data[:mName][:data].to_s
      model_node.transformation = Mat4[*cur_node_data[:mTransformation]].transpose
      model_node.parent = parent_node

      local_ids = cur_node_data[:mMeshes].read_array_of_uint(cur_node_data[:mNumMeshes])
      model_node.mesh_ids = local_ids.map {|id| fetch_mesh_id(id) }

      cur_node_data[:mNumChildren].times.each do |i|
        pointer = Assimp::NodePointer.new(cur_node_data[:mChildren].to_ptr + i * Assimp::NodePointer.size)
        child_node_data = pointer[:node]

        model_node.children << import_nodes(model_node, child_node_data)
      end

      model_node
    end

    def fetch_mesh_id(local_id)
      "#{@global_id}_mesh_#{local_id}".to_sym
    end

    def fetch_material_id(local_id)
      "#{@global_id}_material_#{local_id}".to_sym
    end
  end
end
