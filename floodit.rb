require 'console_splash'
require 'colorize'

def get_board(width, height)
    # Returns a randomly generated board of given width and height
    board = Array.new
    for y in 0..height
        line = (0..width).map { [:red, :blue, :green, :yellow, :cyan, :magenta].sample }
        board.push(line)
    end
    return board
end

def clear_screen
    print "\e[H\e[2J"
end

def kawaii_print
    for line in $board
        for box in line
            case box
                when :red
                    print "  ".on_red
                when :blue
                    print "  ".on_blue
                when :green
                    print "  ".on_green
                when :yellow
                    print "  ".on_yellow
                when :cyan
                    print "  ".on_cyan
                when :magenta
                    print "  ".on_magenta
                else
                    print "  ".on_white
            end
        end
        puts
    end
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

$board_x = 14
$board_y = 9
$board = [[]]

$board = get_board($board_x, $board_y)

while true
    puts "Main menu:"
    puts "[s] Start game"
    puts "[c] Change size"
    puts "[q] Quit"

    puts "Game size #{$board_x} #{$board_y}"

    case gets.chomp.downcase
        when "s"
            puts "Starting the game"
        when "c"
            print "Width [Currently #{$board_x}]: "
            $board_x = gets.to_i

            print "Height [Currently #{$board_y}]: "
            $board_y = gets.to_i
        when "q"
            puts "Goodbye"
            break
        else
            puts "I didn't understand that option"
    end
end

$board = get_board($board_x, $board_y)
kawaii_print
puts $board.inspect
