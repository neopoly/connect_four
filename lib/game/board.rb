require 'matrix'

class Board

  attr_accessor :fields

  def initialize(num_rows, num_cols)
    #initialize board as '.'  filled matrix
    @fields = Matrix.build(num_rows, num_cols) {'.'}
  end

  def to_s
    string_value = ""
    @fields.row_vectors().each do |r|
      string_value << r.to_a.join("") << "\n"
    end
    string_value
  end

end
