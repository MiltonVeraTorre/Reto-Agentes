class Tractor extends Vehiculo {
  Tractor(float x, float y,int combustible,int trigoMax) {
    super(x, y,combustible,trigoMax);
  }


  void mostrar() {
  
    image(tractorI,x,y); // Textura del tractor

  }

  boolean trigoLleno(){
    return trigo >= trigoMax;
  }

  void seguirHarvester(Harvester harvester) {
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
    if (x < granero.x) x += velocidad;
    else if (x > granero.x) x -= velocidad;

    if (y < granero.y) y += velocidad;
    else if (y > granero.y) y -= velocidad;
  }

  boolean enBase(){
    if (dist(x,y,granero.x,granero.y) < 1){
      return true;
    }
    return false;
  }

  void vaciarTrigo(){
    trigo = 0;
  }
}