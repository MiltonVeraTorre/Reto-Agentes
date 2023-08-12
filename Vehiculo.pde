class Vehiculo {
  float x, y;
  int xBoundary,yBoundary;
  float velocidad;
  int trigo;

  Vehiculo(float x, float y,int xBoundary,int yBoundary) {
    this.x = x;
    this.y = y;
    this.xBoundary = xBoundary;
    this.yBoundary = yBoundary;

    velocidad = 2;
    trigo = 0;
  }

  void mostrar() {
    fill(255);
  }
}