# frozen_string_literal: true
require './codebreaker.rb'
require './codemaker.rb'
require './board.rb'

puts "Enter the number of turns you are going to play: "
turns = gets.chomp.to_i

board = Board.new(12)
codemaker = Codemaker.new("computer", board)
codebreaker = Codebreaker.new("Diego", board)

message = "Diego... you lose!"

turns.times do
  code = codebreaker.get_code_attempt
  feedback = codemaker.get_code_feedback(code)
  if feedback.all? { |key| key == :black}
    message = "Diego you win!"
    break
  end
end

puts "correct answer: "+ codemaker.secret_code.to_s
puts message



