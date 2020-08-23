class MagicSquare
  attr_reader :matrix
  private :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def valid?
    uniq_values? && valid_range? &&
      row_sum == column_sum &&
      row_sum == diagonal_sum(matrix) &&
      row_sum == diagonal_sum(matrix.reverse) &&
      rows_sum_equal?(matrix) &&
      rows_sum_equal?(transformed_matrix)
  end

  private

  def uniq_values?
    flatten_matrix.size == flatten_matrix.uniq.size
  end

  def valid_range?
    range = 1..(flatten_matrix.size ** 2)
    range.cover?(Range.new(*flatten_matrix.minmax))
  end

  def flatten_matrix
    @flatten_matrix ||= matrix.flatten
  end

  def diagonal_sum(given_matrix)
    given_matrix.each_with_index.sum { |list, index| list[index] }
  end

  def row_sum
    @row_sum ||= matrix.first.sum
  end

  def column_sum
    matrix.map(&:first).sum
  end

  def rows_sum_equal?(given_matrix)
    given_matrix.map { |list| list.sum }.uniq.size == 1
  end

  def transformed_matrix
    [].tap do |new_matrix|
      matrix.size.times do |index|
        new_matrix << matrix.map { |list| list[index] }
      end
    end
  end
end

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

EXPECTATIONS = {
  a => false,
  b => true,
  c => false,
  d => false,
  e => false
}

EXPECTATIONS.each do |matrix, expected_result|
  result = MagicSquare.new(matrix).valid?

  if result == expected_result
    puts "++ Expectation for #{ matrix } passed: '#{ expected_result }' expected, '#{ result }' received."
  else
    puts "-- Expectation for #{ matrix } didn't pass: '#{ expected_result }' expected, '#{ result }' received."
  end
end
