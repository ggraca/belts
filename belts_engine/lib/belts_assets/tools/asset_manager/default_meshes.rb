module BeltsAssets::Tools
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
          *common_vertices[0], *Vec3.back, 1, 1, 0, 1,
          *common_vertices[1], *Vec3.back, 1, 1, 0, 1,
          *common_vertices[2], *Vec3.back, 1, 1, 0, 1,
          *common_vertices[3], *Vec3.back, 1, 1, 0, 1,

          # Right face
          *common_vertices[3], *Vec3.right, *Vec3.right, 1,
          *common_vertices[2], *Vec3.right, *Vec3.right, 1,
          *common_vertices[5], *Vec3.right, *Vec3.right, 1,
          *common_vertices[4], *Vec3.right, *Vec3.right, 1,

          # Front face
          *common_vertices[4], *Vec3.forward, *Vec3.forward, 1,
          *common_vertices[5], *Vec3.forward, *Vec3.forward, 1,
          *common_vertices[6], *Vec3.forward, *Vec3.forward, 1,
          *common_vertices[7], *Vec3.forward, *Vec3.forward, 1,

          # Left face
          *common_vertices[7], *Vec3.left, 0, 1, 1, 1,
          *common_vertices[6], *Vec3.left, 0, 1, 1, 1,
          *common_vertices[1], *Vec3.left, 0, 1, 1, 1,
          *common_vertices[0], *Vec3.left, 0, 1, 1, 1,

          # Top face
          *common_vertices[7], *Vec3.up, *Vec3.up, 1,
          *common_vertices[0], *Vec3.up, *Vec3.up, 1,
          *common_vertices[3], *Vec3.up, *Vec3.up, 1,
          *common_vertices[4], *Vec3.up, *Vec3.up, 1,

          # Bottom face
          *common_vertices[1], *Vec3.down, 1, 0, 1, 1,
          *common_vertices[6], *Vec3.down, 1, 0, 1, 1,
          *common_vertices[5], *Vec3.down, 1, 0, 1, 1,
          *common_vertices[2], *Vec3.down, 1, 0, 1, 1
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
          -HU, HU, 0, *Vec3.back, 1, 1, 0, 1,
          -HU, -HU, 0, *Vec3.back, 1, 1, 0, 1,
          HU, -HU, 0, *Vec3.back, 1, 1, 0, 1,
          HU, HU, 0, *Vec3.back, 1, 1, 0, 1
        ]

        indexes = [
          0, 1, 2, 2, 3, 0
        ]

        [vertices, indexes]
      end

      def self.triangle
        vertices = [
          0, HU, 0, *Vec3.back, 1, 1, 0, 1,
          -HU, -HU, 0, *Vec3.back, 1, 1, 0, 1,
          HU, -HU, 0, *Vec3.back, 1, 1, 0, 1
        ]

        indexes = [
          0, 1, 2
        ]

        [vertices, indexes]
      end
    end
  end
end
