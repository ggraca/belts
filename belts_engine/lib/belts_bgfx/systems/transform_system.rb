module BeltsBGFX::Systems
  class TransformSystem < BeltsEngine::System
    phase :pre_store

    query :objects,
      with: [:position, :rotation, :scale, :transform_matrix]

    def update
      objects.each_with_components do |position:, rotation:, scale:, transform_matrix:|
        transform_matrix.set_transform!(position, rotation, scale)
      end
    end
  end
end
