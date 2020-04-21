let xspacing = 10; // Distance between each horizontal location
let w; // Width of entire wave
let theta = 0.0; // Start angle at 0
let amplitude = 75.0; // Height of wave
let period = 500.0; // How many pixels before the wave repeats
let dx; // Value for incrementing x
let yvalues; // Using an array to store height values for the wave

function setup() {
  createCanvas(710, 400);
  w = width + 1;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new Array(floor(w / xspacing));
}

function draw() {
  background(0);
  calcWave();
  renderWave();
  // A design for a simple flower
  fill(204, 101, 192, 127);
  translate(580, 70);
  noStroke();
  for (let i = 0; i < 10; i ++) {
    ellipse(0, 15, 10, 40);
    rotate(PI/5);
  }
  
  
  
}

function calcWave() {
  // Increment theta (try different values for
  // 'angular velocity' here)
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  let x = theta;
  for (let i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x) * amplitude;
    x += dx;
  }
}

function renderWave() {
  noStroke();
  fill(204, 101, 192, 127);
  // A simple way to draw the wave with an ellipse at each location
  for (let x = 0; x < yvalues.length; x++) {
    ellipse(x * xspacing, height / 2 + yvalues[x]/1.5, 20, 20);
  }
  for (let x = 0; x < yvalues.length; x++) {
    ellipse(x * xspacing*1.5, height/1.5 + yvalues[x]/2, 20, 20);
  }
   
  
}
