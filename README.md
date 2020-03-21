the game consist of a game object which contains the wold object

world object the scene or current scene of the game

the world object has three layers bgLayer ,fgLayer and camLayer
objects attached to camLayer will be camera target ,fg and bgLayer objects
will move along with the camera .can be used for HUD or paralax backgrounds


the world contains a camera objects,it tracks the position of the objects
attached to camera.shoot

For all elements attached to layers,their update  and draw functions are called
every frame.

the world also consisits of a physics world-- pWorld .
