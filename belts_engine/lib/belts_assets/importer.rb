module BeltsAssets
  class Importer
    attr_reader :meshes

    def initialize(file_path)
      @scene = Assimp.aiImportFile(file_path, 32779)
      @meshes = import_meshes
      @materials = import_materials
      # @node_tree = import_nodes
    end

    private

    def import_meshes
      @scene[:mNumMeshes].times.map do |i|
        pointer = Assimp::MeshPointer.new(@scene[:mMeshes].to_ptr + i * Assimp::MeshPointer.size)
        import_mesh(pointer[:mesh])
      end
    end

    def import_mesh(mesh_data)
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
        pp property[:mType].to_s + " " + property[:mKey][:data].to_ptr.read_string(property[:mKey][:length]) + " " + property[:mData].to_ptr.read_array_of_uint(property[:mDataLength]).to_s
      end
    end
  end
end
