# ProcessingProjects

This repository contains several different processing projects. All projects with a short description will be listed below.
Feel free to use/change the code or create a pull request for some projects. Have fun! :)

## Table of Content <a name="toc"></a>
- <a href="#growingCircles">Growing Circles</a>
- <a href="#growingCircles2">Growing Circles 2</a>
- <a href="#visDownCam">Visualize Downsampled Camera</a>
- <a href="#gameOfLife">Conway's Game of Life</a>
- <a href="#particleswarm">Particle Swarm</a>
- <a href="#analogueClock">Analogue Clock</a>
- <a href="#pendulumWave">Pendulum Wave</a>
- <a href="#mathDrawing">Math Drawing</a>
- <a href="#snakeGame">Snake Game</a>
- <a href="#particlefilter">Particle Filter</a>
- <a href="#fourierSeries">Fourier Series</a>
- to be continued ...

## Projects
### Growing Circles <a href="#toc">[↑]</a> <a name="growingCircles"></a>
This project uses a kind of "circle packing algorithm" to generate and show circles on a canvas. The circles will only be generated on a specific area of the canvas, e.g. the white area of an greyscale image.
<p>
<img src="https://github.com/Thommynator/ProcessingProjects/blob/master/GrowingCircles/GrowingCircles/data/img.jpg" width="400" />
<img src="https://github.com/Thommynator/ProcessingProjects/blob/master/GrowingCircles/GrowingCircles/demo.png" width="400" />
</p>

### Growing Cirles 2 <a href="#toc">[↑]</a> <a name="growingCircles2"></a>
This project is very similar to _Growing Circles_. The canvas will be filled with multiple circles and the circle color depends on a background image.
<p>
<img src="https://github.com/Thommynator/ProcessingProjects/blob/master/GrowingCircles/GrowingCircles2/data/img.jpg" width="400" />
<img src="https://github.com/Thommynator/ProcessingProjects/blob/master/GrowingCircles/GrowingCircles2/demo.jpg" width="400" />
</p>

### Visualize Downsampled Camera <a href="#toc">[↑]</a> <a name="visDownCam"></a>
This project uses a webcam or any other camera, which is connected to the computer and converts the current captured image into a new visualization. The visualization is a downsampled version of the original image, where each brightness value corresponds to a specific rectangle or ellipse size.
This could look like this:
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/VisualizeDownsampledCamera/circleMe.jpg" width="400" /></p>

### Conway's Game of Life <a href="#toc">[↑]</a> <a name="gameOfLife"></a>
This project is an implementation of <a href="https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life">Conway's Game of Life</a>. The following gif way created by my project.
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/GameOfLife/demo.gif" width="400" /></p>

### Particle Swarm <a href="#toc">[↑]</a> <a name="particleswarm"></a>
This project creates alot of different sized and colored particles, which follow the mouse movement on the canvas. An additional random particle movement ensures more diversity. Pressing the left mouse button increases the particle speed.
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/ParticleSwarm/demo.jpg" width="400" /></p>

### Analogue Clock <a href="#toc">[↑]</a> <a name="analogueClock"></a>
This projects displays a simple analogue clock with daylight indicator.
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/AnalogueClock/data/demo.jpg" width="400" /></p>

### Pendulum Wave <a href="#toc">[↑]</a> <a name="pendulumWave"></a>
Several pendulums with a different length. The length is computed in a way, that leads to a synchronization of all pendulums each "n" periods. In the following gif, you can see a period-time of 10, which means, after 10 periods of the longest pendulum, all pendulums will line up in a straight line again.
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/PendulumWave/demo.gif" width="400" /></p>

### Math Drawing <a href="#toc">[↑]</a> <a name="mathDrawing"></a>
The coordinates of two points were defined by 4 different equations. Connecting these points results in interesting figures:
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/MathDrawing/demo1.JPG" width="400" />
<img src="https://github.com/Thommynator/ProcessingProjects/blob/master/MathDrawing/demo2.JPG" width="400" /></p>
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/MathDrawing/demo3.JPG" width="400" />
<img src="https://github.com/Thommynator/ProcessingProjects/blob/master/MathDrawing/demo4.JPG" width="400" /></p>

### Snake Game <a href="#toc">[↑]</a> <a name="snakeGame"></a>
Do you know the old game "snake", where you have to collect some targets with a snake and each target will make the snaker longer? This project is basically the same **but** you also have an opponent controled by the computer. ;)
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/SnakeGame/demo1.JPG" width="400" />
<p>You're blue, the computer is red. As you can see, it's no so easy to win against the computer. Currently that's because the AI has less restrictions (e.g. no collision detection). I think I'll add it in future Releases. Feel free to add a pull request if you want to implement it. :)</p>

### Particle Filter <a href="#toc">[↑]</a> <a name="particlefilter"></a>
This projet implements a basic <a href="https://en.wikipedia.org/wiki/Particle_filter">particle filter</a>. It's like one of these "kidnapped robot" scenarios, where you take a robot and put it anywhere in a room (or whatever) and the robot has to find out, where it is. For this it uses only a map, some distance measurements and logging of it's heading changes. The position isn't used/measured, but the filter can estimate the position of the robot.
<p><img src="https://github.com/Thommynator/ProcessingProjects/blob/master/Particlefilter/demo1.JPG" width="400" />
<img src="https://github.com/Thommynator/ProcessingProjects/blob/master/Particlefilter/demo2.JPG" width="400" /></p>

### Fourier Series
This projects visualizes a Fourier Series, which approaches a square wave.
<p><img src="https://raw.githubusercontent.com/Thommynator/ProcessingProjects/master/FourierSeries/demo.png" /></p>

[Demo Video](https://github.com/Thommynator/ProcessingProjects/blob/master/FourierSeries/demo.mp4)
