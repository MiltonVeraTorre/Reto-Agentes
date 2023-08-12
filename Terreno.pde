class Terreno{
    int campo[][];


    Terreno(int pixeles){
         // Inicializa la matriz campo con el número de celdas calculado en base al tamaño de la ventana y el tamaño de las celdas.

        campo = new int[width / pixeles][height / pixeles];

        // Rellena la matriz campo con 1s, indicando que todo el campo tiene trigo.
        for (int i = 0; i < width / pixeles; i++) {
            for (int j = 0; j < height / pixeles; j++) {
            campo[i][j] = 1;
            }
        }
    }

    void dibujar(){
        // Dibuja el campo en la ventana.
        for (int i = 0; i < width / pixeles; i++) {
            for (int j = 0; j < height / pixeles; j++) {
            // Si la celda tiene trigo (valor 1), la pinta de verde.
            if (campo[i][j] == 1) {
                fill(34, 139, 34);
            } 
            // Si la celda no tiene trigo (valor 0), la pinta de marrón.
            else {
                fill(139, 69, 19);
            }
            // Dibuja la celda en la posición y tamaño correspondiente.
            rect(i * pixeles, j * pixeles, pixeles, pixeles);
            }
        }
    }

    int getEstadoCuadrante(float x,float y){
        // Verificar que no se pase de los limites
        if(x < 0 || x > width-pixeles || y < 0 || y > height-pixeles){
            return 0;
        }

        return campo[int(x / pixeles)][int(y / pixeles)];
    }

    void setEstadoCuadrante(float x,float y,int estado){
        campo[int(x / pixeles)][int(y / pixeles)] = estado;
    }
}