class Knight
  attr_accessor :queue, :visited_squares

  KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  # @queue and @visited_squares are initialized inside #knigth_moves
  def knight_moves(start, target)
    @queue = []
    @visited_squares = []

    shortest_path = build_path(start, target)

    puts "\nYou made it in #{shortest_path.length - 1} moves!  Here's your shortest path:"
    (0...shortest_path.length).each do |i|
      p shortest_path[i]
    end
  end

  private

  def build_path(start, target)
    @queue << [start]
    @visited_squares << start

    until @queue.empty?
      current_path = @queue.shift

      # current_path.last is the current visited square
      return current_path if current_path.last == target

      valid_moves = generate_valid_moves(current_path.last)

      # each move contains the coordinates of newly visited squares
      valid_moves.each do |move|
        next if @visited_squares.include?(move)

        @visited_squares << move

        # concatenate current_path with nested move, add new path array to queue
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
    x.between?(0, 7) && y.between?(0, 7)
  end
end
