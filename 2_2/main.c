/**
 * Dainis Tillers
 * dt08050
 * md2_2
 */
#include <stdio.h>

//Globālie mainīgie
int gx; //globālais X
int st; //stāvokli/rezultāts

void test(int x) {

    int lx = gx;

    gx = gx + 1;

    x = x + 1;

    if(x == gx && (lx + 1 == gx)) { //pēc vērtības
        st = 1;
    }
    else if(x == gx) { //pēc adreses
        st = 2;
    }
    else if(x == gx + 1) { //pēc vērtības un vārda
        st = 4;
    }

    x = x - 1;
}

int main()
{

    //Inicializē vērtības
    gx = 0;
    st = 0;

    int lx = gx;

    test(gx);

    //Pēc vērtības un rezultāta
    if(st == 1 && lx == gx) {
        st = 3;
    }

    //Rezultāta izdrukāšana
    switch(st) {
        case 1 :
            printf("V");
            break;
        case 2 :
            printf("A");
            break;
        case 3 :
            printf("R");
            break;
        case 4 :
            printf("N");
            break;
    }

    return 0;
}
