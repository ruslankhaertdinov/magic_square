a = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

b = [
  [2, 7, 6],
  [9, 5, 1],
  [4, 3, 8]
]

c = [
  [2, 2, 2],
  [2, 2, 2],
  [2, 2, 2]
]

d = [
  [1, 6, 5],
  [8, 4, 0],
  [3, 2, 7]
]

e = [
  [91, 96, 95],
  [98, 94, 90],
  [93, 92, 97]
]

class MatrixChecker
  attr_reader :matrix
  private :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def magic?
    uniq_values? && valid_range? &&
      row_sum == column_sum &&
      row_sum == diagonal1_sum &&
      row_sum == diagonal2_sum &&
      rows_magic? && columns_magic?
  end

  private

  def uniq_values?
    flatten_list.size == flatten_list.uniq.size
  end

  def valid_range?
    range = 1..(flatten_list.size ** 2)
    range.cover?(Range.new(*flatten_list.minmax))
  end

  def flatten_list
    @flatten_list ||= matrix.flatten
  end

  def rows_magic?
    matrix.map { |list| list.sum }.uniq.size == 1
  end

  def columns_magic?
    transformed_matrix.map { |list| list.sum }.uniq.size == 1
  end

  def diagonal1_sum
    matrix.each_with_index.sum { |list, index| list[index] }
  end

  def diagonal2_sum
    matrix.reverse.each_with_index.sum { |list, index| list[index] }
  end

  def row_sum
    @row_sum ||= matrix.first.sum
  end

  def column_sum
    matrix.map(&:first).sum
  end

  def transformed_matrix
    [].tap do |new_matrix|
      matrix.size.times do |index|
        new_matrix << matrix.map { |list| list[index] }
      end
    end
  end
end

p MatrixChecker.new(a).magic? # => false
p MatrixChecker.new(b).magic? # => true
p MatrixChecker.new(c).magic? # => false
p MatrixChecker.new(d).magic? # => false
p MatrixChecker.new(e).magic? # => false
