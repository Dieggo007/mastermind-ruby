# frozen_string_literal: true
require 'colorize'

module CodesFormat

  CHAR_CODE = "⬤"
  CHAR_KEY = "●"
  CHAR_PLACE = "_"
  CURSOR = ">"
  COLORS = [:red, :light_yellow, :blue, :green, :black, :light_white]
  KEY_PEGS = {
    black: String.new(" #{CHAR_KEY}".colorize(:color => :black, :background => :gray)),
    light_white: String.new(" #{CHAR_KEY}".colorize(:color => :light_white, :background => :gray))
  }
  KEY_PEGS.default = "  ".colorize(:background => :gray)

  def get_code_pegs
    code_pegs = COLORS.reduce({}) do |hash, color_b|
      hash[color_b] = String.new(" #{CHAR_CODE} ".colorize(:color => color_b, :background => :gray))
      hash
    end
    code_pegs.default = String.new(" #{CHAR_PLACE} ".colorize(:color => :light_white, :background => :gray))
    code_pegs
  end

  def count_characters_excluding(string, excluded_chars)
    # Construct a regular expression pattern that matches any character not in the excluded set
    pattern = /[^#{Regexp.escape(excluded_chars)}]/

    # Use scan method to find all matches of non-excluded characters and count them
    string.scan(pattern).count
  end


  def get_code_player(board)

    colors_to_select = COLORS.map { |color| get_code_pegs[color] }
    selected_colors = [nil, nil, nil, nil]
    places_to_select = selected_colors.map { |color| get_code_pegs[color] }

    menu = {
      -1 => colors_to_select,
       1 => places_to_select,
    }
    selection = {
      -1 => { limit: 5, index: 0, },
       1 => { limit: 3, index: 0, },
    }

    index_place = 0
    i = 1
    while true
      menu[i][selection[i][:index]].sub!(" ", ">")
      print_input_user(board, menu[1], colors_to_select)
      menu[i][selection[i][:index]].sub!(">", " ")

      keydown = $stdin.getch
      unless keydown == "\e"
        if i == 1
          index_place = selection[i][:index]
          if selected_colors[index_place]
            selected_colors[index_place] = nil
          end
          selection[i][:index] += 1 if selection[i][:index] < selection[i][:limit]
        else
          selected_colors[index_place] = COLORS[selection[i][:index]]
          break if selected_colors.all? { |color| color != nil}
        end
        places_to_select[index_place] = get_code_pegs[selected_colors[index_place]]
        i *= -1
        next
      end
      keydown += $stdin.getch + $stdin.getch

      case keydown
      when "\e[C" then selection[i][:index] += 1 if selection[i][:index] < selection[i][:limit]
      when "\e[D" then selection[i][:index] -= 1 if selection[i][:index] > 0
      else next end
    end
    selected_colors
  end


  def print_input_user(board, places_to_select, colors_to_select)
    system("clear")
    board = board.to_s + center_one_line(places_to_select) + center_one_line(colors_to_select)
    puts board
  end

  def center_one_line(codes)
    excluded = " " + CHAR_PLACE + CHAR_CODE + CHAR_KEY + CURSOR
    codes_string = codes.join
    codes_string.center(`tput cols`.to_i + count_characters_excluding(codes_string, "#{excluded}")) + "\n"
  end

end


