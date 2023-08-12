int campo[][]; // Representa el campo de trigo: 0 = sin trigo, 1 = con trigo
int anchoCampo = 20; // Tamaño de las celdas del campo
int altoCampo = 20;



Harvester harvester;
Tractor tractor;

void setup() {
  size(400, 400);
  campo = new int[width / anchoCampo][height / altoCampo];
  for (int i = 0; i < width / anchoCampo; i++) {
    for (int j = 0; j < height / altoCampo; j++) {
      campo[i][j] = 1; // Inicialmente, todo el campo tiene trigo
    }
  }

  harvester = new Harvester(0, 0,anchoCampo,altoCampo);
  tractor = new Tractor(0, height - altoCampo,anchoCampo,altoCampo);
}

void draw() {
  background(200);

  // Dibujar campo
  for (int i = 0; i < width / anchoCampo; i++) {
    for (int j = 0; j < height / altoCampo; j++) {
      if (campo[i][j] == 1) {
        fill(34, 139, 34); // Verde para trigo
      } else {
        fill(139, 69, 19); // Marrón para tierra cosechada
      }
      rect(i * anchoCampo, j * altoCampo, anchoCampo, altoCampo);
    }
  }

  harvester.recolectar();
  harvester.mover();
  harvester.mostrar();

  if (harvester.trigo >= 10) { // Si el harvester tiene 10 unidades de trigo, el tractor se acerca
    tractor.moverHacia(harvester.x, harvester.y);
  }

  tractor.mostrar();
}
