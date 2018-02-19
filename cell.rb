class Cell
    attr_accessor :bomb, :cleared
    def initialize
        @bomb = false
        @cleared = false
    end
end