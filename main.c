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
            printf("%d ",*((matrix+y*i)+j));
        }
        printf("\n");
    }
}

int main(){
    //memory
    int A [625];
    int B [625];
    int Ay;
    int Ax;
    int By;
    int Bx;
    printf("getting A matrix axis (y*x)\n");
    printf("Enter y : ");
    scanf("%d",&Ay);
    printf("Enter x : ");
    scanf("%d",&Ax);

    // printf("getting A matrix axis (y*x)\n");
    // printf("Enter y : ");
    // scanf("%d",&By);
    // printf("Enter x : ");
    // scanf("%d",&Bx);

    getMatrix(A,Ay,Ax);
    printMatrix(A,Ay,Ax);
    
    
}