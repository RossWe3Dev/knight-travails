class Knight
  attr_accessor :queue, :visited_squares

  KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def initialize
    @queue = []
    @visited_squares = []
  end

  def build_path(start, target)
    @queue << [start]
    @visited_squares << start

    until @queue.empty?
      current_path = @queue.shift

      # current_path.last is the current visited square
      return current_path if current_path.last == target

      valid_moves = generate_valid_moves(current_path.last)

      valid_moves.each do |move|
        next if @visited_squares.include?(move)

        @visited_squares << move

        # concatenate current_path with an array that contains move, the new visited square
        @queue << (current_path + [move])
      end
    end

    nil # target not found
  end

  # generate an array of valid moves
  def generate_valid_moves(position)
    x, y = position
    KNIGHT_MOVES.map { |dx, dy| [x + dx, y + dy] }.select { |move| valid_move?(move) }
  end

  def valid_move?(position)
    x, y = position
    (x >= 0 && x <= 7) && (y >= 0 && y <= 7)
  end

  def knight_moves(start, target)
    @queue = []
    @visited_squares = []

    shortest_path = build_path(start, target)

    puts "\nYou made it in #{shortest_path.length - 1} moves!  Here's your shortest path:"
    (0...shortest_path.length).each do |i|
      p shortest_path[i]
    end
  end
end

# test = Knight.new
# p test.generate_valid_moves([3, 3])
