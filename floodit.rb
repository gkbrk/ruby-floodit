require 'console_splash'

def get_board(width, height)
    # Returns a randomly generated board of given width and height
    board = Array.new
    for y in 0..height
        line = [:red, :blue, :green, :yellow, :cyan, :magenta].sample(width)
        board.push(line)
    end
    return board
end

def clear_screen
    puts "\e[H\e[2J"
end

################################

# Show splash screen
splash = ConsoleSplash.new
splash.write_header("CLI Flood-It", "Gokberk Yaltirakli", "1.0")
splash.write_top_pattern("=")
splash.write_bottom_pattern("=")
splash.write_left_pattern("=")
splash.write_right_pattern("=")
splash.splash()
gets()

clear_screen

$board = get_board(5, 5)
puts $board.inspect
