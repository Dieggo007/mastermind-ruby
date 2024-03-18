# frozen_string_literal: true
require 'colorize'
require './codes_format.rb'
require './board'
require 'io/console'

class Codebreaker

  include CodesFormat

  attr_accessor :name, :code_attempts, :board

  def initialize(name, board)
    @name = name
    @code_attempts = []
    @board = board
  end

  def get_code_attempt
    code = get_code_player(board.string_board)
    code_attempts.push(code)
    board.add_code_attempt(code)
    code
  end

end





