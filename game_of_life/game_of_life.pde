// Conway Game of Life Simulation

// constants
final int SCREEN_WIDTH = 800;
final int SCREEN_HEIGHT = 600;
final int CELL_SIZE = 100;

// globals
int[][] world;


void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  init_world(new int[SCREEN_WIDTH/CELL_SIZE][SCREEN_HEIGHT/CELL_SIZE]);
}

void init_world(int[][] seed) {
  world = seed;
  
}

int update(int x) {
  return x;
}

int[][] update_world() {
  int[][] result = new int[0][0];
  return result;
}

void draw() {
  world = update_world();
  for (int row=0; row<world.length; row++) {
    for (int col=0; col<world[row].length; col++) {
      if (world[row][col] == 1) {
        translate(row*CELL_SIZE, col*CELL_SIZE);
         rect(0, 0, CELL_SIZE, CELL_SIZE); 
      }
    }  
  }
  
}
