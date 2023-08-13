class Tractor extends Vehiculo {
  Tractor(float x, float y,int combustible,int trigoMax) {
    super(x, y,combustible,trigoMax);
  }


  void mostrar() {
    float llenado = trigo*100/trigoMax;

    if(llenado >= 0){
      fill(0,255,0);
    }
    if(llenado >= 50){
      fill(255,255,0);
    }
    if(llenado >= 80){
      fill(255,0,0);
    }
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