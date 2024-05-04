Asteroids (Part 1)
==================
In this assignment we will start to replicate the old video game Asteroids. You will write a program that has a space ship that can be controlled by a player. You will need to write a `Spaceship` class as well as a `Star` class for the background. Your `Spaceship` class will extend the `Floater` class, a class that represents all things that float in space. _Note: To complete this assignment you will be writing two classes `Spaceship` and `Star`. Do not modify the `Floater` class._ You may find the [Asteroids Part 1 slide presentation here](https://docs.google.com/presentation/d/1HfHQTei9qgkBEBhNqUKqmAc6g2V3x8FDprajTp5IZuE/edit#slide=id.p1) [or here](http://chandrunarayan.github.io/cpjava/final_projects/asteroid_presentations/Unit_9b_AsteroidsProject_Part1.pdf) helpful in completing this assignment.

Suggested steps to complete this assignment
-------------------------------------------

1. Start a new program in Processing called `AsteroidsGame`. 
1. Copy the code in `AsteroidsGame.pde` into your program.
1. Open a new tab and name it `Spaceship.pde`. Copy the class definition from `Spaceship.pde` above. Do the same for `Floater.pde` and `Star.pde`.
4. Write the `Spaceship` constructor. Make sure you initialize all 9 of the inherited `protected` member variables. 
1. You may also find the [Asteroids Part 2 slide presentation here useful](https://docs.google.com/presentation/d/1pPeUvTAbIjtZYvfQIv54BDuunra8H6imO654amT6NI4/edit#slide=id.p1)  [or here](http://chandrunarayan.github.io/cpjava/final_projects/asteroid_presentations/Unit_9c_AsteroidsProject_Part2.pdf). 
1. In addition, [This sample Spaceship program](https://chandrunarayan.github.io/sketches/AsteroidsVariableDemo/) helpful in understanding how the `protected Floater` variables affect the Spaceship's movement.
5. At the top of `AsteroidsGame.pde`, declare a variable of type `Spaceship`
6. Initialize the `Spaceship` as a new instance of the class
7. In `draw()` in `AsteroidsGame.pde` call the Spaceship's `show()` function
8. When you are happy with appearance of the Spaceship, add a `public void keyPressed()` function in `AsteroidsGame.pde`
9. Write code in `keyPressed` that allows you to control the spaceship with the keyboard. You must include the ability to turn left, turn right, accelerate, and enter "hyperspace." (There is no requirement for any fancy visual effects, hyperspace just needs to stop the ship, and give it a new random position and direction.)
10. Add code to the `draw()` in `AsteroidsGame.pde` to `move()` the Spaceship
11. Finish the `Star` class in `Star.pde` 
12. Finally, add code to `AsteroidsGame.pde` that declares and initializes an array of instances of the `Star` class to create a number of stars in random positions
12. Note that for full credit, **you MUST include instructions on how to operate your Spaceship in the `index.html` file.** For an example look at slides 32 & 33 in the [Asteroids slide presentation here](https://docs.google.com/presentation/d/1HfHQTei9qgkBEBhNqUKqmAc6g2V3x8FDprajTp5IZuE/edit#slide=id.gac26ff81b9_2_0) [or here](https://chandrunarayan.github.io/cpjava/final_projects/asteroid_presentations/Unit_9b_AsteroidsProject_Part1.pdf)

These steps are only a suggestion. Your Asteroids game doesn't have to work or act like any other. Have fun and be creative.

Extensions
----------
* You can smooth out the control of the ship using booleans for each key press. [There is an example here](https://chandrunarayan.github.io/TwoKeys/)
* If you have extra time and are looking for a challenge, you might try to add an animation of "rockets" that appear from the back of the ship when you accelerate, simliar to the [this sample Spaceship program](https://chandrunarayan.github.io/sketches/AsteroidsVariableDemo/). The best way to do this is to override `show()` by copying the `show()` function from Floater into your Spaceship class. Then add an `if` statement in your Spaceship `show()` function right after `endShape(CLOSE);`. If your rockets are firing, draw additional shapes just behind your Spaceship. You can sketch out the shapes on graph paper with the ship centered at (0,0) and pointing right. The `show()` function will rotate and translate the rocket shapes to the correct position on the screen.

Some important things to keep in mind
-------------------------------------
1. You're collaborating with me (chandru) and with your Paired Programming partner! Most of the work for the `Spaceship` class has already been done in the parent `Floater` class by me (your 3rd partner!). 
1. In a real work environment, the `Floater` class would have been given to you as a Library (binary) and you would not be able to change it.
1. In this case you will be able to change it, but don't modify it! I will test it with the original version of the `Floater` class to verify. Your job is to extend the `Floater` class to "build on top of it" to make a `Spaceship` class. 
2. To create the `Spaceship` class you need to write a constructor.
1. Don't declare any duplicate variables in your `Spaceship` class. You are inheriting all the variables you need from `Floater`
1. Make sure your `Spaceship` constructor initializes all 9 of the `protected` variables it inherits from `Floater`

