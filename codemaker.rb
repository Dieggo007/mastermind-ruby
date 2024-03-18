# frozen_string_literal: true

require 'set'
require './codes_format.rb'

class Codemaker

  include CodesFormat

  attr_reader :name, :board, :secret_code

  def initialize(name, board, secret_code = generate_secret_code)
    @name = name
    @board = board
    @secret_code = secret_code
  end

  def generate_secret_code
    COLORS.sample(4)
  end

  def get_code_feedback(guess)

    secret_code_copy = secret_code.clone
    guess_copy = guess.clone
    key_pegs = []

    # correct color and position
    guess.each_with_index do |code_peg, index|
      if code_peg == secret_code[index]
        key_pegs << :black
        secret_code_copy[index] = nil
        guess_copy[index] = nil
      end
    end
    # just correct color
    guess_copy.each do |code_peg|
      if code_peg && secret_code_copy.include?(code_peg)
        key_pegs << :light_white
        index = secret_code_copy.index(code_peg)
        secret_code_copy.delete_at(index)
      end
    end
    (4 - key_pegs.length).times {key_pegs.push(nil)}
    board.add_feedback(key_pegs)
    key_pegs
  end

end


array1 = [:red, :blue, :light_yellow, :green, :light_white, :black]
array2 = ['a', 'b', 'c']

# Generate permutations with repeated elements from both arrays
permutations = array1.product(array1).product(array1).product(array1).flatten
array3 = Array.new(1296) { Array.new }
array3.each do |array|
  4.times { array.push(permutations.pop)}
end

my_set = Set.new(array3)