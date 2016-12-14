#!/usr/bin/ruby
require 'console_splash'
require 'colorize'

# Written by: Gokberk Yaltirakli
# Student number: 160153732

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
    # Clears the screen using an ANSI escape sequence
    print "\e[H\e[2J"
end

def board_print
    # Prints the board on the terminal with ANSI backgrounds
    $board.each do |line|
        line.each do |box|
            print "  ".colorize(:background => box)
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
        board_print
        puts "Number of turns: #{turns}"
        puts "Current completion: #{game_get_completion}%"
        print "Choose a color: "
        choice = gets.to_color
        if choice == :quit
            break
        end
        update_board(0, 0, choice)
        turns += 1

        if game_get_completion == 100
            if $best_score == nil || turns < $best_score
                $best_score = turns
            end
            clear_screen
            puts
            board_print
            puts "You won after #{turns} turns\n"
            break
        end
    end
end

def game_get_completion
    # Get the color on the top-left corner
    # Count the number of block with the same color
    # Divide by the number of total blocks on the board

    current_color = $board[0][0]
    block_count = $board.flatten.length
    correct_count = 0
    $board.flatten.each do |block|
        if block == current_color
            correct_count += 1
        end
    end
    return (correct_count.to_f/block_count*100).to_i # Return percentage
end

def update_board(x, y, color)
    # Update the board colors using a recursive algorithm
    old_color = $board[y][x]
    $board[y][x] = color

    if old_color == color
        return
    end

    if y > 0 && $board[y-1][x] == old_color
        update_board(x, y-1, color)
    end
    
    if y < $board_y && $board[y+1][x] == old_color
        update_board(x, y+1, color)
    end

    if x > 0 && $board[y][x-1] == old_color
        update_board(x-1, y, color)
    end
    
    if x < $board_x && $board[y][x+1] == old_color
        update_board(x+1, y, color)
    end
end

class String
    def to_color
        # Add a method to Ruby strings that can parse colors
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
            when "q", "quit"
                :quit
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
gets # Keep the splash screen on the terminal

clear_screen

# Global variables make this code so much
# shorter and a lot easier to understand
$board_x = 13
$board_y = 8
$board = [[]]
$best_score = nil

while true
    puts "Main menu:"
    puts "[s] Start game"
    puts "[c] Change size"
    puts "[q] Quit"
    
    if $best_score == nil
        puts "No games played yet."
    else
        puts "Best game: #{$best_score} turns"
    end

    print "Please enter your choice: "
    case gets.chomp.downcase
        when "s"
            game
        when "c"
            print "Width [Currently #{$board_x + 1}]: "
            $board_x = gets.to_i - 1

            print "Height [Currently #{$board_y + 1}]: "
            $board_y = gets.to_i - 1

            # Reset best score when changing the board size
            $best_score = nil
        when "q"
            puts "Goodbye"
            break
        else
            puts "I didn't understand that option"
    end
end
