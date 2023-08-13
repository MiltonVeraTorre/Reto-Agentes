// Define el ancho y alto de cada celda del campo en píxeles.
int pixeles = 40;

// Definir las imagenes
PImage aradoraI;
PImage contenedorI;
PImage tierraI;
PImage tractorI;
PImage trigoI;

// Declaramos la variable global de terreno
Terreno terreno;

// Declaramos la variable global del granero

Granero granero;

// Declara un objeto Harvester llamado harvester.
Harvester harvester;

// Declara un objeto Tractor llamado tractor.
Tractor tractor;



// La función setup() se ejecuta una vez al inicio del programa.
void setup() {
  // Establece el tamaño de la ventana de visualización a 400x400 píxeles.
  size(1200, 1200);

  // colocamos las imagenes

  aradoraI = loadImage("aradora.png");
  contenedorI = loadImage("contenedor.png");
  tierraI = loadImage("tierra.jpeg");
  tractorI = loadImage("tractor.png");
  trigoI = loadImage("trigo.jpeg");

  // Inicializamos el terreno

  terreno = new Terreno(pixeles);

  // Colocamos la posicion del granero

  granero = new Granero(600,600);


  // Inicializa el objeto harvester en la posición (0,0) y con el tamaño de celda especificado.
  harvester = new Harvester(0, 0,5000,50);

  // Inicializa el objeto tractor en la posición (0, height - pixeles) y con el tamaño de celda especificado.
  tractor = new Tractor(0, height - pixeles,5000,150);
}

// La función draw() se ejecuta continuamente después de setup().
void draw() {

  // Establece el color de fondo de la ventana a un gris claro.
  background(200);


  // Dibuja el campo en la ventana.
  terreno.dibujar();

  // Dibuja el granero en la ventana.
  granero.dibujar();



  // El harvester intenta recolectar trigo de la celda en la que se encuentra.
  harvester.recolectar();

  // Mueve el harvester a la siguiente posición.
  harvester.mover();


    // Si el harvester ha recolectado 10 unidades de trigo, el tractor se mueve hacia el harvester.
    if (harvester.trigo >= 5 && !tractor.trigoLleno()) {
        tractor.seguirHarvester(harvester);
    }
    //Si ya tiene el trigo lleno lo regresamos a base
    if(tractor.trigoLleno()){
        tractor.regresarBase();

    }
    // Si ya esta en la base entonces vaciamos su trigo
    if(tractor.enBase()){
        tractor.vaciarTrigo();
    }

    // Muestra el harvester en la ventana.
  harvester.mostrar();
  // Muestra el tractor en la ventana.
  tractor.mostrar();
}
