module BeltsAssets
  class Importer
    attr_reader :meshes

    def initialize(file_path)
      @scene = Assimp.aiImportFile(file_path, 32779)
      @meshes = import_meshes
      # @node_tree = import_nodes
    end

    private

    def import_meshes
      @scene[:mNumMeshes].times.map do |i|
        pointer = Assimp::MeshList.new(@scene[:mMeshes].to_ptr + i * Assimp::MeshList.size)
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
  end
end
