class Granero{
    float x,y;

    Granero(float x,float y){
        this.x=x;
        this.y=y;
    }

    void dibujar(){
        image(contenedorI,x,y);
    }
}