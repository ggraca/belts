class GreenTriangle < Prefab
  renderer :triangle, color: Float3.up
  component :spinner, Spinner.new
end
