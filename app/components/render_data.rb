RenderData = Struct.new(:type, :color, :flip) do
  def print
    puts "type: #{type}, color: #{color}"
  end
end
