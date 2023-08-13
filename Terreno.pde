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

        // Establece una línea delimitadora de 0s en el centro verticalmente
        for (int j = 0; j < height / pixeles; j++) {
            for (int i = (width / pixeles) / 2 - 1; i <= (width / pixeles) / 2 + 1; i++) {
                campo[i][j] = 0;
            }
        }

        // Establece una línea delimitadora de 0s en el centro horizontalmente
        for (int i = 0; i < width / pixeles; i++) {
            for (int j = (height / pixeles) / 2 - 1; j <= (height / pixeles) / 2 + 1; j++) {
                campo[i][j] = 0;
            }
        }
    }

    void dibujar(){
        // Dibuja el campo en la ventana.
        for (int i = 0; i < width / pixeles; i++) {
            for (int j = 0; j < height / pixeles; j++) {
            // Si la celda tiene trigo (valor 1), la pinta de verde.
            if (campo[i][j] == 1) {
                
                image(trigoI,i*pixeles,j*pixeles);
            } 
            // Si la celda no tiene trigo (valor 0), la pinta de marrón.
            else {
                
                image(tierraI,i*pixeles,j*pixeles);

            }
            
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

    int[][] getCampo(){
        return campo;
    }
}