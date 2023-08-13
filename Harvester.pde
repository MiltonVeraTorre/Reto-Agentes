class Harvester extends Vehiculo {
  // Variables para que pueda buscar el siguiente trigo
  boolean buscando;
  PVector busqueda;


  Harvester(float x, float y,int combustible,int trigoMax) {
    super(x, y,combustible,trigoMax);
    buscando = false;
    busqueda = new PVector(0,0);
  }

// Algoritmo de BFS para encontrar el trigo mas cercano
  private PVector trigoMasCercano(PVector inicio){
    // Obtenemos el campo
    int[][] matriz = terreno.getCampo();

    // Obtenemos el numero de filas y columnas
    int filas = matriz.length;
    int columnas = matriz[0].length;
    
    // Creamos la cola
    ArrayList<PVector> cola = new ArrayList<PVector>();

    // Creamos la matriz de visitados
    boolean[][] visitados = new boolean[filas][columnas];
    
    // Añadimos el primer valor por defecto como 
    cola.add(inicio);
    visitados[(int)inicio.x][(int)inicio.y] = true;
    // Declaramos el primer valor

    int[] dx = {-1, 1, 0, 0};
    int[] dy = {0, 0, -1, 1};

    while (cola.size() > 0) {
        PVector celdaActual = cola.remove(0);  // Simula el poll() de una cola

        if (matriz[(int)celdaActual.x][(int)celdaActual.y] == 1) {
        return new PVector(celdaActual.x*pixeles,celdaActual.y*pixeles);  // Encontraste el trigo más cercano
        }

        for (int i = 0; i < 4; i++) {
        int nx = (int)celdaActual.x + dx[i];
        int ny = (int)celdaActual.y + dy[i];

        if (nx >= 0 && ny >= 0 && nx < filas && ny < columnas && !visitados[nx][ny]) {
            cola.add(new PVector(nx, ny));
            visitados[nx][ny] = true;
        }
        }
    }

  return null;  // No hay trigo en la matriz
  }



  private void moverHacia(int direccion){

    // Verificar si hay combustible
    if(combustible <= 0){
        print("Sin Combustible \n");
        return;
    }

    // Verificamos si estamos fuera de los limites
    if(x >= width && direccion == 1){
        print("Fuera de los limites \n");
        direccion=2;
        return;
    }
    if(x <= 0 && direccion == 3){
        print("Fuera de los limites \n");
        direccion=4;
        return;
    }
    if(y >= height && direccion == 0){
        print("Fuera de los limites \n");
        direccion=1;
        return;
    }
    if(y <= 0 && direccion == 2){
        print("Fuera de los limites \n");
        direccion=3;
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

    // Algoritmo para movernos hacia una coordenada

 private void haciaCoordenada(PVector coordenada){
    // Nos desplazamos por la X
    if (x < coordenada.x) moverHacia(1);
    else if (x > coordenada.x) moverHacia(3);

    // Nos desplazamos por la Y
    if (y < coordenada.y) moverHacia(0);
    else if (y > coordenada.y) moverHacia(2);

    // Si llegamos a la coordenada entonces cambiamos el estado de buscando
    if(dist(x,y,coordenada.x,coordenada.y) <= 1){
        buscando = false;
        busqueda = new PVector(0,0);
    }
 }

  void quitarTrigo(){
    trigo--;
  }

  void mostrar() {
  
    image(aradoraI,x,y); // Textura del harvester
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

    // Si esta en modo de busqueda
    if(buscando){
        haciaCoordenada(busqueda);
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

    // Si no había trigo en ninguna direccion entonces nos movemos 

    PVector trigoCercano = trigoMasCercano(new PVector(int(x/pixeles),int(y/pixeles)));

    // Si ya no hay mas trigos entonces que no haga nada
    if(trigoCercano == null){
        return;
    }

    print(trigoCercano);

    buscando = true;
    busqueda = trigoCercano;

    

  }


  
}