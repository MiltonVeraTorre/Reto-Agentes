// Define el ancho y alto de cada celda del campo en píxeles.
int pixeles = 20;


// Declaramos la variable global de terreno
Terreno terreno;

// Declara un objeto Harvester llamado harvester.
Harvester harvester;

// Declara un objeto Tractor llamado tractor.
Tractor tractor;



// La función setup() se ejecuta una vez al inicio del programa.
void setup() {
  // Establece el tamaño de la ventana de visualización a 400x400 píxeles.
  size(1000, 1000);

  // Inicializamos el terreno

  terreno = new Terreno(pixeles);


  // Inicializa el objeto harvester en la posición (0,0) y con el tamaño de celda especificado.
  harvester = new Harvester(0, 0,2500,100);

  // Inicializa el objeto tractor en la posición (0, height - pixeles) y con el tamaño de celda especificado.
  tractor = new Tractor(0, height - pixeles,2500,300);
}

// La función draw() se ejecuta continuamente después de setup().
void draw() {
  // Establece el color de fondo de la ventana a un gris claro.
  background(200);

  // Dibuja el campo en la ventana.
  terreno.dibujar();



  // El harvester intenta recolectar trigo de la celda en la que se encuentra.
  harvester.recolectar();

  // Mueve el harvester a la siguiente posición.
  harvester.mover();

  // Muestra el harvester en la ventana.
  harvester.mostrar();

  // Si el harvester ha recolectado 10 unidades de trigo, el tractor se mueve hacia el harvester.
  if (harvester.trigo >= 5 && !tractor.trigoLleno()) {
    tractor.moverHacia(harvester);
  }
  //Si ya tiene el trigo lleno lo regresamos a base
  if(tractor.trigoLleno()){
    tractor.regresarBase();

  }
    // Si ya esta en la base entonces vaciamos su trigo
    if(tractor.enBase()){
        tractor.vaciarTrigo();
    }

  // Muestra el tractor en la ventana.
  tractor.mostrar();
}
