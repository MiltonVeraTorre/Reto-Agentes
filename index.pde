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

// Declaramos los harvesters.
Harvester harvester1;
Harvester harvester2;

// Declaramos los tractores
Tractor tractor1;
Tractor tractor2;



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
  harvester1 = new Harvester(500, 600,5000,50,1);
  harvester2 = new Harvester(700, 600,5000,50,2);

  // Inicializa el objeto tractor en la posición (0, height - pixeles) y con el tamaño de celda especificado.
  tractor1 = new Tractor(600,600,5000,150);
  tractor2 = new Tractor(600,600,5000,150);
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
    harvester1.recolectar();
    harvester2.recolectar();

    // Mueve el harvester a la siguiente posición.
    harvester1.mover();
    harvester2.mover();


    // Si el harvester ha recolectado 10 unidades de trigo, el tractor se mueve hacia el harvester.
    if (harvester1.trigo >= 5 && !tractor1.trigoLleno()) {
        tractor1.seguirHarvester(harvester1);
    }
    //Si ya tiene el trigo lleno lo regresamos a base
    if(tractor1.trigoLleno()){
        tractor1.regresarBase();

    }
    // Si ya esta en la base entonces vaciamos su trigo
    if(tractor1.enBase()){
        tractor1.vaciarTrigo();
    }

    // Si el harvester ha recolectado 10 unidades de trigo, el tractor se mueve hacia el harvester.
    if (harvester2.trigo >= 5 && !tractor2.trigoLleno()) {
        tractor2.seguirHarvester(harvester2);
    }
    //Si ya tiene el trigo lleno lo regresamos a base
    if(tractor2.trigoLleno()){
        tractor2.regresarBase();

    }
    // Si ya esta en la base entonces vaciamos su trigo
    if(tractor2.enBase()){
        tractor2.vaciarTrigo();
    }

        // Muestra el harvester en la ventana.
    harvester1.mostrar();
    harvester2.mostrar();
    // Muestra el tractor en la ventana.
    tractor1.mostrar();
    tractor2.mostrar();

}
