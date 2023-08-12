class Tractor extends Vehiculo {
  Tractor(float x, float y) {
    super(x, y);
  }


  void mostrar() {
    super.mostrar();
    ellipse(x, y,anchoCampo,altoCampo); // Representación simple del tractor
  }

  void moverHacia(float tx, float ty) {
    if (x < tx) x += velocidad;
    else if (x > tx) x -= velocidad;

    if (y < ty) y += velocidad;
    else if (y > ty) y -= velocidad;
  }
}