## Mid-term Project Journal

I plan to make a single-player space shooter game. There will be the initial homescreen with buttons for instructions and play.
The game play:
- The player will control a spaceship using the left and right arrow keys
- Background will be moving to give the illusion of forward motion
- Bullets will be fired using up arrow key
- There will be enemy spaceships randomly firing bullets and must be killed
- Other obstacles like asteroids?
- After a specific number of enemies are killed a boss enemy will appear that will fire more bullets and will take longer to kill
- Killing the boss will change the level
- Powerups?
- Second level will have moving enemies
- Background music different for every level
- Sound of bullets


### **18th October:**

- I selected all the images to be used in the game:
  - homescreen background
  - three level backgrounds
  - three enemy spaceships
  - three boss spaceships
  - lasers/bullets
  - blast
  
- Found sounds and music:
  - background music for home screen
  - backround music for three levels
  - laser/bullet sounds for player and enemy
  - blast sound


### **24th October:**

- Created the homescreen without any problem
- Since the Instructions had a lot of written text I decided to use a 700x1000 px picture with the written instructions rather than writing through code. I used Photoshop to make the picture
- Figuring out the rolling background without making it seem like different images was difficult to figure out. Rather than using the same image repeatedly, I saved an inverted and flipped copy and displayed these two continuously one after the other.
- The movement of the spaceship was easy to implement once I figured out how to make use of the keyPressed() and keyReleased() functions.
- Coded random appearance of enemy.
- I am currently stuck on how to track the fired bullets.


### **26th October:**

- It took me a long time to figure out the bullets;
- Initially, I could only see a dynamic 2d array as a solution and that is difficult to implement in Java.
- I decided to create static 2d arrays with enough elements to contain all the bullets on screen at any specific time.
- Elements containing bullets that run off screen get recycled to store the position if the next bullet to be created.
- Created all the other parts of the game:
  - Difference in enemy behavior across stages.
  - Transition between stages.
  - The 3 bosses and their behavior.
  - Conditions for enemy and boss to be killed.
  - Health bar to track damage to ship.
  - Score counter.
  - Game over conditions and screen.
  - Game win conditions and screen.
  - Asteroids - random positions and size
  - 2 powerups: to absorb bullets and to restore health.
- Coding the bosses was tricky. They fired 5 bullets at once and any of these could hit the spaceship. All their positions had to be individually stored.
- I got around this by creating two 2d arrays to store x-coordinates and y-coordinates of bullets respectively.
- I have not been able to win the game even once :P
