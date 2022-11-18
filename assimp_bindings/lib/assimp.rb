require "ffi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "vector_3d" => "Vector3D"
loader.setup

module Assimp
  extend FFI::Library
  ffi_lib :libassimp

  attach_function :aiImportFile, [:string, :uint], Scene.by_ref, blocking: true
end
