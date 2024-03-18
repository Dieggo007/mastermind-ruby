# frozen_string_literal: true
require './codes_format.rb'

class Board

  include CodesFormat

  attr_accessor :code_attempts, :code_feedbacks, :turns, :attempt_index, :feedback_index, :string_board

  def initialize(turns = 12)
    @turns = turns
    @code_attempts = Array.new(turns) { Array.new(4) }
    @code_feedbacks = Array.new(turns) { Array.new(4) }
    @attempt_index = 0
    @feedback_index = 0
    @string_board = to_s
  end


  def to_s
    string = ""
    turns.times do |i|
      code_attempts_s = code_attempts[i].map { |color| get_code_pegs[color]}
      code_feedbacks_s = code_feedbacks[i].map { |key| KEY_PEGS[key]}
      string = center_one_line(code_attempts_s.push(KEY_PEGS[nil]) + code_feedbacks_s) + string
    end
    string
  end

  def add_code_attempt(code)
    code_attempts[attempt_index] = code
    @attempt_index += 1
    self.string_board = to_s
  end

  def add_feedback(keys)
    code_feedbacks[feedback_index] = keys
    @feedback_index += 1
    self.string_board = to_s
  end

end
