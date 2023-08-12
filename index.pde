// Matriz que representa el campo de trigo.
// 0 indica que no hay trigo (ya ha sido cosechado) y 1 indica que hay trigo.
int campo[][];

// Define el ancho de cada celda del campo en píxeles.
int anchoCampo = 20;

// Define el alto de cada celda del campo en píxeles.
int altoCampo = 20;

// Declara un objeto Harvester llamado harvester.
Harvester harvester;

// Declara un objeto Tractor llamado tractor.
Tractor tractor;

// La función setup() se ejecuta una vez al inicio del programa.
void setup() {
  // Establece el tamaño de la ventana de visualización a 400x400 píxeles.
  size(400, 400);

  // Inicializa la matriz campo con el número de celdas calculado en base al tamaño de la ventana y el tamaño de las celdas.
  campo = new int[width / anchoCampo][height / altoCampo];

  // Rellena la matriz campo con 1s, indicando que todo el campo tiene trigo.
  for (int i = 0; i < width / anchoCampo; i++) {
    for (int j = 0; j < height / altoCampo; j++) {
      campo[i][j] = 1;
    }
  }

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
  for (int i = 0; i < width / anchoCampo; i++) {
    for (int j = 0; j < height / altoCampo; j++) {
      // Si la celda tiene trigo (valor 1), la pinta de verde.
      if (campo[i][j] == 1) {
        fill(34, 139, 34);
      } 
      // Si la celda no tiene trigo (valor 0), la pinta de marrón.
      else {
        fill(139, 69, 19);
      }
      // Dibuja la celda en la posición y tamaño correspondiente.
      rect(i * anchoCampo, j * altoCampo, anchoCampo, altoCampo);
    }
  }

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
