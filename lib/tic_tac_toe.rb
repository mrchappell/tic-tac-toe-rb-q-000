WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [2,4,6],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if position_taken?(board, index)
    false
  elsif board[index] == "X" || board[index] == "O"
    false
  elsif index >= 0 && index <= 8
    true
  end
end

def turn(board)
  puts 'Please enter 1-9:'
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.count do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
    return turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
  win_index_1 = combo[0]
  win_index_2 = combo[1]
  win_index_3 = combo[2]

  position_1 = board[win_index_1]
  position_2 = board[win_index_2]
  position_3 = board[win_index_3]

  if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
    return combo
  else
    false
    end
  end
end

def full?(board)
  board.all?{|position|
    position == "X" || position == "O"
  }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
 if winning_combo = won?(board)
   board[winning_combo.first]
 end
end

def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
