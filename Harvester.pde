class Harvester extends Vehiculo {
  // Variables para que pueda buscar el siguiente trigo
  boolean buscando;
  PVector busqueda;
  int numero;

  boolean enMedio; // Con esta variable haremos eficiente el caso en que el harvester caiga en medio
  boolean derecha;
  boolean izquierda;
  boolean ladoCompletado;


  Harvester(float x, float y,int combustible,int trigoMax,int numero) {
    super(x, y,combustible,trigoMax);
    buscando = false;
    busqueda = new PVector(0,0);
    this.numero = numero;
  }

  

// Algoritmo de BFS para encontrar el trigo mas cercano
  private PVector trigoMasCercano(PVector inicio){
    // Obtenemos el campo
    int[][] matriz = terreno.getCampo();

    // radio de ignorar
    float r = 3;

    // Obtenemos el otro harvester
    Harvester otroHarvester;

    if(numero == 1){
        otroHarvester = harvester2;
    }else{
        otroHarvester = harvester1;
    }

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

        // Calculamos la distancia al otro harvester
        float distanciaAV = dist(celdaActual.x, celdaActual.y, otroHarvester.x/pixeles, otroHarvester.y/pixeles);

        // Devolvemos el trigo mas cercano que este a un radio seguro del otro harvester
        if (distanciaAV > r && matriz[(int)celdaActual.x][(int)celdaActual.y] == 1) {
          return new PVector(celdaActual.x * pixeles, celdaActual.y * pixeles);
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

    // Verificamos si esta cerca de otro tractor
    Harvester otroHarvester;

    if(numero == 1){
        otroHarvester = harvester2;
    }else{
        otroHarvester = harvester1;
    }

    float distanciaAV = dist(x/pixeles, y/pixeles, otroHarvester.x/pixeles, otroHarvester.y/pixeles);

    // Si esta cerca de otro tractor entonces hya que calcular el trigo mas cercano que no afecte en el radio del otro tractor
    if(distanciaAV <= 4 && this.combustible > otroHarvester.combustible){
        PVector trigoCercano = trigoMasCercano(new PVector(int(x/pixeles),int(y/pixeles)));

        // Si ya no hay mas trigos entonces que no haga nada
        if(trigoCercano == null){
            return;
        }

        buscando = true;
        busqueda = trigoCercano;

        return;
    }



    // Hacemos variable de si hay trigo en cada lado

    boolean[] trigoDireccion = new boolean[4];



    trigoDireccion[0] = terreno.getEstadoCuadrante(x,y+pixeles-1) == 1;
    trigoDireccion[1] = terreno.getEstadoCuadrante(x+pixeles-1,y) == 1;
    trigoDireccion[2] = terreno.getEstadoCuadrante(x,y-pixeles+1) == 1;
    trigoDireccion[3] = terreno.getEstadoCuadrante(x-pixeles+1,y) == 1;

    // Si toco del lado derecho primero
    if(derecha && !ladoCompletado){
      // Si hay trigo nos movemos
      if(trigoDireccion[1]){
        moverHacia(1);
        return;
      }
      // Si ya no hay mas trigos desactivamos el modo derecha y marcamos que ya esta el lado completado
      else{
        ladoCompletado = true;
        derecha = false;
        izquierda=true;
        return;
      }
    }

    // Si toco del lado izquierdo primero
    if(izquierda && !ladoCompletado){
      // Si hay trigo nos movemos
      if(trigoDireccion[3]){
        moverHacia(3);
        return;
      }
      // Si ya no hay mas trigos desactivamos el modo izquierda y marcamos que ya esta el lado completado
      else{
        ladoCompletado = true;
        izquierda = false;
        derecha=true;
        return;
      }
    }

    // Si ya se completo el lado entonces nos movemos hacia el otro lado
    if(ladoCompletado){
      if(derecha){
        // Si hay algo en la derecha entonces ya la desactivamos y dejamos el flujo normal
        if(trigoDireccion[1]){
          ladoCompletado = false;
          derecha = false;
          izquierda = false;
          return;
        }
        // Sino hay nada en la dirección activa nos seguimos moviendo
        moverHacia(1);
        return;
      }
      if(izquierda){
        // Si hay algo en la izquierda entonces ya la desactivamos y dejamos el flujo normal
        if(trigoDireccion[3]){
          ladoCompletado = false;
          derecha = false;
          izquierda = false;
          return;
        }
        // Sino hay nada en la dirección activa nos seguimos moviendo
        moverHacia(3);
        return;
      }
    }

    // Verificamos el caso de que haya caido en medio de dos trigos despues de la busqueda

    if(trigoDireccion[1] && trigoDireccion[3]){
       println("Trigo en medio detectado");
        enMedio = true;
        // Vemos de que lado nos conviene comenzar
        if(terreno.irDerecha(x,y)){
            derecha = true;
            izquierda = false;
        }else{
            derecha = false;
            izquierda = true;
        }

        return;
    }


    // Verificamos si hacia la direccion que vamos hay trigo
    if(trigoDireccion[direccion]){
        if(direccion == 1){
            moverHacia(1);

            return;
        }
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


    buscando = true;
    busqueda = trigoCercano;

    

  }


  
}