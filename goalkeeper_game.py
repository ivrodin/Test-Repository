import random  # Import random module for computer's choice
import curses  # Import curses for terminal-based UI and arrow key input


def play_game(stdscr):
    """Main function to play the goalkeeper game using curses for arrow key input."""
    try:
        curses.curs_set(0)  # Hide the cursor
        stdscr.clear()  # Clear the screen
        stdscr.refresh()

        choices = ['left', 'right', 'center']  # Possible shooting directions
        stdscr.addstr(0, 0, "Welcome to the Goalkeeper Game!")
        stdscr.addstr(1, 0, "You are the goalkeeper. Use arrow keys to guess where the striker will shoot:")
        stdscr.addstr(2, 0, "LEFT ARROW: left, RIGHT ARROW: right, SPACE: center")
        stdscr.addstr(3, 0, "Press 'q' to quit.\n")
        stdscr.refresh()

        score = {'saved': 0, 'goals': 0}  # Track saves and goals

        while True:
            stdscr.addstr(5, 0, "Press a key to make your guess...")
            stdscr.refresh()

            # Get user input
            key = stdscr.getch()
            if key == ord('q'):
                stdscr.addstr(7, 0, "Thanks for playing!")
                stdscr.addstr(8, 0, f"Final Score - Saved: {score['saved']}, Goals: {score['goals']}")
                stdscr.refresh()
                stdscr.getch()  # Wait for any key to exit
                break

            # Map keys to choices
            if key == curses.KEY_LEFT:
                user_guess = 'left'
            elif key == curses.KEY_RIGHT:
                user_guess = 'right'
            elif key == ord(' '):  # Space for center
                user_guess = 'center'
            else:
                stdscr.addstr(7, 0, "Invalid key. Use LEFT/RIGHT arrows or SPACE for center.")
                stdscr.refresh()
                curses.napms(1000)  # Pause for 1 second
                stdscr.clear()
                continue

            # Computer randomly chooses the shot direction
            computer_choice = random.choice(choices)
            stdscr.addstr(7, 0, f"You guessed: {user_guess.upper()}")
            stdscr.addstr(8, 0, f"The striker shoots to the {computer_choice.upper()}!")

            # Check if user guessed correctly
            if user_guess == computer_choice:
                stdscr.addstr(9, 0, "Great save! You blocked the shot.")
                score['saved'] += 1
            else:
                stdscr.addstr(9, 0, "Goal! The striker scored.")
                score['goals'] += 1

            # Display current score
            stdscr.addstr(10, 0, f"Current Score - Saved: {score['saved']}, Goals: {score['goals']}")
            stdscr.addstr(11, 0, "Press any key to continue...")
            stdscr.refresh()
            stdscr.getch()  # Wait for key press to continue
            stdscr.clear()  # Clear screen for next round
    except KeyboardInterrupt:
        # Handle Ctrl+C gracefully
        pass
    finally:
        # Ensure terminal is restored
        curses.endwin()


if __name__ == "__main__":
    curses.wrapper(play_game)