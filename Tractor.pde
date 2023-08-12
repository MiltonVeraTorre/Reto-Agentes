class Tractor extends Vehiculo {
  Tractor(float x, float y,int combustible,int trigoMax) {
    super(x, y,combustible,trigoMax);
  }


  void mostrar() {
    super.mostrar();
    ellipse(x, y,pixeles,pixeles); // Representación simple del tractor
  }

  boolean trigoLleno(){
    print(trigo,trigoMax,"\n");
    return trigo >= trigoMax;
  }

  void moverHacia(Harvester harvester) {
    if (x < harvester.x) x += velocidad;
    else if (x > harvester.x) x -= velocidad;

    if (y < harvester.y) y += velocidad;
    else if (y > harvester.y) y -= velocidad;

    if (dist(x, y, harvester.x, harvester.y) < 1 ) {
      // Guardamos una unidad de trigo
      trigo ++;
      // Y se la quitamos al harvester
      harvester.quitarTrigo();
    }
  }

  void regresarBase(){
    if (x < 0) x += velocidad;
    else if (x > width) x -= velocidad;

    if (y < 0) y += velocidad;
    else if (y > height) y -= velocidad;
  }

  boolean enBase(){
    if (x == 0 && y == 0){
      return true;
    }
    return false;
  }

  void vaciarTrigo(){
    trigo = 0;
  }
}