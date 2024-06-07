

This is a basic example scene showing  script for the Godot GameNite ControlPads Addon:
https://github.com/RecBox-Games/godot-gamenite-controlpads 

Run this server while playing the game
https://github.com/RecBox-Games/controlpad_test_server

meant for this controller. rename folder to 'controller':
https://github.com/RecBox-Games/controlpad_test_server/tree/main/gamepad_controller

the input manager script is a quick extension of the godot gamenite controlpads component just to make it integrate nicely with godots InputMap and Input classes.

It's meant for the preset controlpad with the joystick and ABXY, but can be extended for other controllers. The goal is to make it take a bit less refactoring when developing for both gamenite and other platforms. 

Feel free to use for whatever
