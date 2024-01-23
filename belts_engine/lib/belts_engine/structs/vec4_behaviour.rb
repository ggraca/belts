module Vec4Behaviour
  class << self
    def included(base)
      base.layout(:values, [:float, 4])

      [:x, :y, :z, :w].each_with_index do |key, index|
        base.define_method(key) { self[:values][index] }
        base.define_method("#{key}=") { |value| self[:values][index] = value }
      end
    end
  end
end
