module BeltsEngine::Tools
  class AssetManager
    class DefaultMeshes
      U = 1.0 # Unit size
      HU = U / 2 # Half unit size

      def self.cube
        common_vertices = [
          # Back face
          [-HU, HU, -HU],
          [-HU, -HU, -HU],
          [HU, -HU, -HU],
          [HU, HU, -HU],

          # Front face
          [HU, HU, HU],
          [HU, -HU, HU],
          [-HU, -HU, HU],
          [-HU, HU, HU]
        ]

        vertices = [
          # Back face
          *common_vertices[0], *Vec3.back,
          *common_vertices[1], *Vec3.back,
          *common_vertices[2], *Vec3.back,
          *common_vertices[3], *Vec3.back,

          # Right face
          *common_vertices[3], *Vec3.right,
          *common_vertices[2], *Vec3.right,
          *common_vertices[5], *Vec3.right,
          *common_vertices[4], *Vec3.right,

          # Front face
          *common_vertices[4], *Vec3.forward,
          *common_vertices[5], *Vec3.forward,
          *common_vertices[6], *Vec3.forward,
          *common_vertices[7], *Vec3.forward,

          # Left face
          *common_vertices[7], *Vec3.left,
          *common_vertices[6], *Vec3.left,
          *common_vertices[1], *Vec3.left,
          *common_vertices[0], *Vec3.left,

          # Top face
          *common_vertices[7], *Vec3.up,
          *common_vertices[0], *Vec3.up,
          *common_vertices[3], *Vec3.up,
          *common_vertices[4], *Vec3.up,

          # Bottom face
          *common_vertices[1], *Vec3.down,
          *common_vertices[6], *Vec3.down,
          *common_vertices[5], *Vec3.down,
          *common_vertices[2], *Vec3.down
        ]

        indexes = (0..5).map do |i|
          stride = i * 4

          [
            stride, stride + 1, stride + 2,
            stride + 2, stride + 3, stride
          ]
        end.flatten

        [vertices, indexes]
      end

      def self.square
        vertices = [
          -HU, HU, 0, *Vec3.back,
          -HU, -HU, 0, *Vec3.back,
          HU, -HU, 0, *Vec3.back,
          HU, HU, 0, *Vec3.back
        ]

        indexes = [
          0, 1, 2, 2, 3, 0
        ]

        [vertices, indexes]
      end

      def self.triangle
        vertices = [
          0, HU, 0, *Vec3.back,
          -HU, -HU, 0, *Vec3.back,
          HU, -HU, 0, *Vec3.back
        ]

        indexes = [
          0, 1, 2
        ]

        [vertices, indexes]
      end
    end
  end
end
