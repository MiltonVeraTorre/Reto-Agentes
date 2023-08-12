// Define el ancho de cada celda del campo en píxeles.
int anchoCampo = 20;

// Define el alto de cada celda del campo en píxeles.
int altoCampo = 20;

// Declaramos la variable global de terreno
Terreno terreno;

// Declara un objeto Harvester llamado harvester.
Harvester harvester;

// Declara un objeto Tractor llamado tractor.
Tractor tractor;



// La función setup() se ejecuta una vez al inicio del programa.
void setup() {
  // Establece el tamaño de la ventana de visualización a 400x400 píxeles.
  size(400, 400);

  // Inicializamos el terreno

  terreno = new Terreno(anchoCampo,altoCampo);


  // Inicializa el objeto harvester en la posición (0,0) y con el tamaño de celda especificado.
  harvester = new Harvester(0, 0);

  // Inicializa el objeto tractor en la posición (0, height - altoCampo) y con el tamaño de celda especificado.
  tractor = new Tractor(0, height - altoCampo);
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
  if (harvester.trigo >= 10) {
    tractor.moverHacia(harvester.x, harvester.y);
  }

  // Muestra el tractor en la ventana.
  tractor.mostrar();
}
