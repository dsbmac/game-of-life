// Conway Game of Life Simulation

// constants
final int SCREEN_WIDTH = 800;
final int SCREEN_HEIGHT = 600;
final int CELL_SIZE = 100;
final int ALIVE = 1;
final int DEAD = 0;
final int NUM_COLS = SCREEN_WIDTH / CELL_SIZE;
final int NUM_ROWS = SCREEN_HEIGHT / CELL_SIZE;
final color BACKGROUND_COLOR = color(100); 
final int FRAME_RATE = 10;

// globals
int[][] world;
ArrayList<PVector> spriteLocations; //using PVector to store row (y) col (x) info
Boolean isGamePlaying;
color[] palette;

// test seed
int[][] debugSeed = { {0, 0, 0, 0, 0, 0, 0, 0}, 
                      {0, 1, 1, 1, 1, 0, 0, 0},
                      {0, 0, 0, 0, 0, 0, 0, 0},
                      {0, 0, 0, 0, 0, 0, 0, 0},
                      {0, 0, 0, 0, 0, 0, 0, 0},
                      {0, 0, 0, 0, 0, 0, 0, 0} };

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  frameRate(FRAME_RATE);
  noStroke();
  int[][] seed = debugSeed;
  init_world(seed);  
}

void init_world(int[][] seed) {
  world = seed;
  
  // init spriteLocations and populate with seed locations
  spriteLocations = new ArrayList<PVector>();
  for (int row=0; row<world.length; row++) {
    for (int col=0; col<world[row].length; col++) {
      if (world[row][col] == 1) {
        spriteLocations.add(new PVector(col, row));
      }
    }  
  }

  // start game
  isGamePlaying = true;  
}

// world update
void update_world() {
  int[][] newWorld = new int[NUM_ROWS][NUM_COLS];
  spriteLocations = new ArrayList<PVector>();
  
  // update each cell in the world
  for (int row=0; row<NUM_ROWS; row++) {
    for (int col=0; col<NUM_COLS; col++) {
      int newState = update_cell(row, col);
      newWorld[row][col] = newState;
      if (newState == ALIVE) {
        spriteLocations.add(new PVector(col, row));        
      }
    }
  }
  
  world = newWorld;
}
// logic that update the cells alive or die state
int update_cell(int row, int col) {
  int result;
  int aliveNeighbours = countAliveNeighbours(row, col);
  
  // evaluate cell
  if (world[row][col] == ALIVE) {
    
    // Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    if (aliveNeighbours < 2) {
      return 0;
      
    // Any live cell with two or three live neighbours lives on to the next generation.
    } else if (aliveNeighbours == 2 || aliveNeighbours == 3) {
      return 1;
      
    // Any live cell with more than three live neighbours dies, as if by overcrowding.      
    } else {
      return 0;
    }
  } else {
  
    // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    if (aliveNeighbours == 3) {
      return 1;
    } else {
      return 0;     
    }   
  }  
}

// sums the number of alive neghbours surrounding the cell x, y
int countAliveNeighbours(int row, int col) {
  int aliveNeighbours = -world[row][col];
  
  // count cells
  for (int i=-1; i<2; i++) {
    for (int j=-1; j<2; j++) {
      int newRow = row+i;
      int newCol = col+j;
      if (isInBounds(newRow, newCol)) {
        aliveNeighbours += world[newRow][newCol];
      }
    }
  }

  return aliveNeighbours;
}

Boolean isInBounds(int row, int col) {
 return row >= 0 && row < NUM_ROWS && col >= 0 && col < NUM_COLS;
}

int[][] createRandomSeed() {
  int[][] seed = new int[NUM_ROWS][NUM_COLS];
  for (int i=0; i<NUM_ROWS; i++) {
    for (int j=0; j<NUM_COLS; j++) {
      seed[i][j] = int(random(2));  
    }      
  }

  return seed;  
}

void draw() {
  if (isGamePlaying) {
    background(BACKGROUND_COLOR);
    for (int i=0; i<spriteLocations.size(); i++) {
      PVector location = spriteLocations.get(i);
      fill(255);
      rect(location.x*CELL_SIZE, location.y*CELL_SIZE, CELL_SIZE, CELL_SIZE);
    }
    
    update_world();
    
    // debug
    //isGamePlaying = false;
  }
}

// pauses and resumes game
void keyPressed() {
  isGamePlaying = !isGamePlaying;
}

void mousePressed() {
  isGamePlaying = !isGamePlaying;
}
