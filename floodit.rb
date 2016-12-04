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

def game
    $board = get_board($board_x, $board_y)
    turns = 0
    while true
        clear_screen
        puts
        kawaii_print
        puts "Number of turns: #{turns}"
        puts "Current completion: #{game_get_completion}%"
        print "Choose a color: "
        choice = gets.to_color
        turns += 1
    end
end

def game_get_completion
    current_color = $board[0][0]
    block_count = $board.flatten.length
    correct_count = 0
    $board.flatten.each do |block|
        if block == current_color
            correct_count += 1
        end
    end
    return (correct_count.to_f/block_count*100).round # Return percentage
end

class String
    def to_color
        case self.chomp.downcase
            when "r", "red"
                :red
            when "b", "blue"
                :blue
            when "g", "green"
                :green
            when "y", "yellow"
                :yellow
            when "c", "cyan"
                :cyan
            when "m", "magenta"
                :magenta
            else
                :red
        end
    end
end

################################

# Show splash screen
splash = ConsoleSplash.new
splash.write_header("CLI Flood-It", "Gokberk Yaltirakli", "1.0")
splash.write_horizontal_pattern("=")
splash.write_vertical_pattern("=")
splash.splash()
gets()

clear_screen

$board_x = 14
$board_y = 9
$board = [[]]

while true
    puts "Main menu:"
    puts "[s] Start game"
    puts "[c] Change size"
    puts "[q] Quit"

    puts "Game size #{$board_x} #{$board_y}"

    case gets.chomp.downcase
        when "s"
            puts "Starting the game"
            game
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
