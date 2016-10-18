#include <GL/glut.h>
#include <stdio.h>

using namespace std;

void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	glBegin(GL_LINE_LOOP);
	glVertex2d(-0.9,-0.9);
	glVertex2d(0.9,-0.9);
	glVertex2d(0.9,0.9);
	glVertex2d(-0.9,0.9);
	glEnd();

	glFlush();
}

void init(void)
{
	glClearColor(1.0,0.0,1.0,1.0);
}

void mouse(int button, int state, int x, int y)
{
  switch (button) {
  case GLUT_LEFT_BUTTON:
    printf("left");
    break;
  case GLUT_MIDDLE_BUTTON:
    printf("middle");
    break;
  case GLUT_RIGHT_BUTTON:
    printf("right");
    break;
  default:
    break;
  }

  printf(" button is ");

  switch (state) {
  case GLUT_UP:
    printf("up");
    break;
  case GLUT_DOWN:
    printf("down");
    break;
  default:
    break;
  }

  printf(" at (%d, %d)\n", x, y);
}



int main(int argc, char *argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA);
	glutCreateWindow(argv[0]);
	glutDisplayFunc(display);
	glutMouseFunc(mouse);
	init();
	glutMainLoop();
	return 0;
}
