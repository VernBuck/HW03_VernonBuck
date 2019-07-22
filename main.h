#define NUMBOXES 2

//Prototypes
void init();
void update();
void draw();

//Struct definitions
typedef struct {
	int row, oldRow;
	int col, oldCol;
	int rowDel;
	int colDel;
	int height;
	int width;
	int collisionChecked;
	unsigned short color;
} BOX;