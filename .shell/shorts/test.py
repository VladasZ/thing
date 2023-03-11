import pygame

# Initialize Pygame
pygame.init()
pygame.joystick.init()

# Find the first DualSense controller
ds_controller = None

print(pygame.joystick.get_count())

for i in range(pygame.joystick.get_count()):
    joystick = pygame.joystick.Joystick(i)
    print(joystick.get_name())
    if "PS5" in joystick.get_name():
        ds_controller = joystick
        break

# If no DualSense controller was found, exit the script
if ds_controller is None:
    print("DualSense controller not found")
    exit()

# Initialize the controller
ds_controller.init()

# Loop to read left stick position
while True:
    pygame.event.get()  # Get the latest events from the controller
    left_x = ds_controller.get_axis(0)
    left_y = ds_controller.get_axis(1)
    print(f"Left stick position: ({left_x}, {left_y})")
