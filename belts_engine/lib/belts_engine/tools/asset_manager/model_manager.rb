module BeltsEngine
  module Tools
    class AssetManager
      class ModelManager < BaseManager
        def initialize(asset_manager)
          @asset_manager = asset_manager
        end

        def add_model(key, file_path)
          @scene = Assimp.aiImportFile(file_path, 32779)
          mesh = @scene[:mMeshes][:pointer]

          vertices = mesh[:mNumVertices].times.map do |i|
            vert = Assimp::Vector3D.new(mesh[:mVertices].to_ptr + i * Assimp::Vector3D.size)
            norm = Assimp::Vector3D.new(mesh[:mNormals].to_ptr + i * Assimp::Vector3D.size)

            [*vert.values, *norm.values, 1, 0, 0, 1]
          end

          indexes = mesh[:mNumFaces].times.map do |i|
            face = Assimp::Face.new(mesh[:mFaces] + i * Assimp::Face.size)
            face[:mIndices].to_ptr.read_array_of_uint(face[:mNumIndices])
          end

          @asset_manager.meshes.add_mesh(key, vertices.flatten, indexes.flatten)
        end

        def remove_model(key)
        end
      end
    end
  end
end
