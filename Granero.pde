class Granero{
    float x,y;

    Granero(float x,float y){
        this.x=x;
        this.y=y;
    }

    void dibujar(){
        fill(255);
        ellipse(x,y,pixeles,pixeles);
    }
}