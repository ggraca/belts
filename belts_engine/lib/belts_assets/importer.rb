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
      @model.meshes = import_meshes
      @model.materials = import_materials
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
      mesh.id = "#{@global_id}_mesh_#{index}".to_sym
      mesh.vertices = vertices.flatten
      mesh.indices = indices.flatten
      mesh
    end

    def import_materials
      @scene[:mNumMaterials].times.map do |i|
        pointer = Assimp::MaterialPointer.new(@scene[:mMaterials].to_ptr + i * Assimp::MaterialPointer.size)
        import_material(pointer[:material])
        return
      end
    end

    def import_material(material_data)
      material_data[:mNumProperties].times.map do |i|
        pointer = Assimp::MaterialPropertyPointer.new(material_data[:mProperties].to_ptr + i * Assimp::MaterialPropertyPointer.size)
        property = pointer[:material_property]
        # pp property[:mType].to_s + " " + property[:mKey][:data].to_ptr.read_string(property[:mKey][:length]) + " " + property[:mData].to_ptr.read_array_of_uint(property[:mDataLength]).to_s
      end
    end

#    pp '-' * depth + ">" + name + " " + cur_node_data[:mNumChildren].to_s + " " + cur_node_data[:mNumMeshes].to_s
    def import_nodes(parent_node = nil, cur_node_data = @scene[:mRootNode])
      model_node = ModelNode.new
      model_node.parent = parent_node
      model_node.name = cur_node_data[:mName][:data].to_s
      # TODO: mesh_ids and transform matrix

      cur_node_data[:mNumChildren].times.each do |i|
        pointer = Assimp::NodePointer.new(cur_node_data[:mChildren].to_ptr + i * Assimp::NodePointer.size)
        child_node_data = pointer[:node]

        model_node.children << import_nodes(model_node, child_node_data)
      end

      model_node
    end
  end
end
