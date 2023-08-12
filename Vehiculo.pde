class Vehiculo {
  float x, y;

  float velocidad;
  int trigo,trigoMax;
  int combustible;
  int direccion;

  Vehiculo(float x, float y,int combustible,int trigoMax) {
    this.x = x;
    this.y = y;

    this.combustible = combustible;
    this.trigoMax = trigoMax;

    velocidad = 2;
    trigo = 0;
    direccion = 1; // 0 significa arriba, 1 significa derecha, 2 significa abajo y 3 significa izquierda
  }

  void mostrar() {
    fill(255);
  }
}