// Conway Game of Life Simulation

// constants
final int SCREEN_WIDTH = 800;
final int SCREEN_HEIGHT = 600;
final int CELL_SIZE = 200;
final int ALIVE = 1;
final int DEAD = 0;
final int NUM_COLS = SCREEN_WIDTH / CELL_SIZE;
final int NUM_ROWS = SCREEN_HEIGHT / CELL_SIZE;

// globals
int[][] world;
ArrayList<int[]> spriteLocations;

// test
int[][] seed = { {1, 1, 0, 0}, 
                 {1, 0, 0, 0},
                 {0, 0, 0, 0}
               };

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  init_world(new int[SCREEN_WIDTH/CELL_SIZE][SCREEN_HEIGHT/CELL_SIZE]);
}

void init_world(int[][] seed) {
  world = seed;
  spriteLocations = new ArrayList<int[]>();
}

// logic that update the cells alive or die state
int update_cell(int x) {
  return 1;
}

// world update
void update_world() {
  int[][] newWorld = new int[NUM_ROWS][NUM_COLS];
  spriteLocations = newArrayList<int[]>();
  
  // update the world
  for (int row=0; row<world.length; row++) {
    for (int col=0; col<world[row].length; col++) {
      newState = update_cell(world[row][col]);
      newWorld[row][col] = newState;
      if (newState == ALIVE) {
        int[] location = {row, col};
        spriteLocations.add(location);        
      }
    }
  }
  
  world = newWorld;
}

void draw() {
  update_world();
}
  
}
