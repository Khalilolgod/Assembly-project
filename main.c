#include <stdio.h>

void getMatrix(int* matrix, int y,int x){
    printf("getting input %d x %d\n",y,x);
    for(int i = 0 ; i < y ; i++){
        for(int j = 0 ; j < x; j++){
            scanf("%d",((matrix+y*i)+j));
        }
    }
}

void printMatrix(int* matrix, int y,int x){
    for(int i = 0 ; i < y ; i++){
        for(int j = 0 ; j < x; j++){
            printf("%d ",*((matrix+x*i)+j));
        }
        printf("\n");
    }
}

int main(){
    //memory
    int A [625]= {2,3,4,8,9,10};
    int B [625] = {1,2,3,4,5,6};
    int Ay = 3;
    int Ax = 2;
    int By = 2;
    int Bx = 3;
    
    int tmp[625];
    int tmpY;
    int tmpX;
    
    //-------------------------------
    // A * B
    tmpY = Ay;
    tmpX = Bx;
    for(int i = 0 ; i < Ay; i++){
        for(int j = 0; j < Bx; j++){
            *((tmp+tmpX*i)+j) = 0;
            for(int k = 0 ; k < Ax; k++){
                *((tmp+tmpX*i)+j) += *((A+Ax*i)+k) * *((B+Bx*k)+j);
            }
        }
    }


    // getMatrix(A,Ay,Ax);
    printMatrix(A,Ay,Ax);
    printMatrix(B,By,Bx);
    printMatrix(tmp,tmpY,tmpX);
    
    
}