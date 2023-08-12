class Harvester extends Vehiculo {
  Harvester(float x, float y) {
    super(x, y);
  }

  void mostrar() {
    super.mostrar();
    rect(x, y, anchoCampo, altoCampo); // Representación simple del harvester
  }

  void recolectar() {
    if (campo[int(x / anchoCampo)][int(y / altoCampo)] == 1) {
      trigo++;
      campo[int(x / anchoCampo)][int(y / altoCampo)] = 0;
    }
  }

  void mover() {
    x += velocidad;
    if (x >= width-1) {
      x = 0;
      y += altoCampo;
    }
  }
}