
# -- User Input Helper Functions ---------------------------------------------

class UserInput:
    def yes_no() -> bool:
        while True:
            inp_str = input().strip().lower()
            if inp_str in ['yes', 'y']:
                return True

            elif inp_str in ['no', 'n']:
                return False
                break

            else:
                print("Unrecognized input. Try again.")



if __name__ == '__main__':
    pass