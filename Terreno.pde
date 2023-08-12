class Terreno{
    int campo[][];


    Terreno(int anchoCampo,int altoCampo){
         // Inicializa la matriz campo con el número de celdas calculado en base al tamaño de la ventana y el tamaño de las celdas.

        campo = new int[width / anchoCampo][height / altoCampo];

        // Rellena la matriz campo con 1s, indicando que todo el campo tiene trigo.
        for (int i = 0; i < width / anchoCampo; i++) {
            for (int j = 0; j < height / altoCampo; j++) {
            campo[i][j] = 1;
            }
        }
    }

    void dibujar(){
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
    }

    int getEstadoCuadrante(float x,float y){
        return campo[int(x / anchoCampo)][int(y / altoCampo)];
    }

    void setEstadoCuadrante(float x,float y,int estado){
        campo[int(x / anchoCampo)][int(y / altoCampo)] = estado;
    }
}