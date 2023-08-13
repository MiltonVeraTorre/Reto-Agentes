class Harvester extends Vehiculo {
  Harvester(float x, float y,int combustible,int trigoMax) {
    super(x, y,combustible,trigoMax);
  }

  private void moverHacia(int direccion){

    if(combustible <= 0){
        print("Sin Combustible \n");
        return;
    }

    if(direccion == 0){
        y += velocidad;
        combustible--;
        return;
    }
    if(direccion == 1){
        x += velocidad;
        combustible--;
        return;
    }
    if(direccion == 2){
        y -= velocidad;
        combustible--;
        return;
    }
    if(direccion == 3){
        x -= velocidad;
        combustible--;
        return;
    }
  }

  void quitarTrigo(){
    trigo--;
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
    rect(x, y, pixeles, pixeles); // Representación simple del harvester
  }

  void recolectar() {
    if (terreno.getEstadoCuadrante(x,y)== 1) {
      trigo++;
      terreno.setEstadoCuadrante(x,y,0);
    }
  }


  void mover() {
    // ==== Funcionalidad de moverse de manera inteligente

    // Si esta lleno de trigo omitimos la instruccion para ahorrar combustible

    if(trigo >= trigoMax){
        return;
    }

    // Hacemos variable de si hay trigo en cada lado

    boolean[] trigoDireccion = new boolean[4];


    trigoDireccion[0] = terreno.getEstadoCuadrante(x,y+pixeles) == 1;
    trigoDireccion[1] = terreno.getEstadoCuadrante(x+pixeles,y) == 1;
    trigoDireccion[2] = terreno.getEstadoCuadrante(x,y-pixeles) == 1;
    trigoDireccion[3] = terreno.getEstadoCuadrante(x-pixeles,y) == 1;


    // Verificamos si hacia la direccion que vamos hay trigo
    if(trigoDireccion[direccion]){
        // Si hay trigo entonces nos movemos a esa direccion
        // if(direccion == 0){
        //     moverHacia(0);
        //     return;
        // }
        if(direccion == 1){
            moverHacia(1);

            return;
        }
        // if(direccion == 2){
        //     moverHacia(2);

        //     return;
        // }
        if(direccion == 3){
            moverHacia(3);

            return;
        }
    }

    // Si no hay trigo en la direccion que vamos entonces buscamos hacia donde hay trigo, priorizaremos los cambios de eje
    if(trigoDireccion[1]){
        direccion = 1;
        moverHacia(1);
        return;
    }
    if(trigoDireccion[3]){
        direccion = 3;
        moverHacia(3);
        return;
    }

    if(trigoDireccion[0]){
        direccion = 0;
        moverHacia(0);
        return;
    }
    
    if(trigoDireccion[2]){
        direccion = 2;
        moverHacia(2);
        return;
    }
    

  }


  
}