import time
import os

def loading_animation():
    for _ in range(5):
        print("*loading animation*")
        time.sleep(0.5)
        os.system('clear')

def draw_ascii(coin_faces):
    if coin_faces.count('T') == 3:
        print("""
             o\\
   _________/__\\__________
  |                  - (  |
 ,'-.                 . `-|
(____".       ,-.    '   ||
  |          /\\,-\\   ,-.  |
  |      ,-./     \\ /'.-\\ |
  |     /-.,\\      /     \\|
  |    /     \\    ,-.     \\
  |___/_______\\__/___\\_____\\

MOUNTAIN""")
    else:
        print("Not all tails!")

def main():
    for _ in range(6):
        input("Please shake three coins in your hand and let them fall (Press Enter when ready)")
        loading_animation()
        
        coin_faces = []
        for _ in range(3):
            face = input("Use 2 to mark TAILS, use 3 to mark HEADS: ")
            while face not in ['2', '3']:
                if face == 'c':
                    print("Canceled")
                    break
                elif face == 'r':
                    break
                elif face == '':
                    break
                else:
                    print("Invalid input, please try again")
                face = input("Use 2 to mark TAILS, use 3 to mark HEADS: ")

            if face == 'c':
                break
            elif face == 'r':
                break
            elif face == '':
                break
            else:
                coin_faces.append('T' if face == '2' else 'H')

        if len(coin_faces) != 3:
            continue

        print("You entered:", "".join(coin_faces))
        draw_ascii(coin_faces)
        
        choice = input("Press ENTER to continue, c to cancel, or r to retry: ")
        if choice == 'c':
            print("Canceled")
            break
        elif choice == 'r':
            print("Retry")
            continue

if __name__ == "__main__":
    main()

