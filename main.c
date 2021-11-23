#include <stdio.h>
#include <stdlib.h>
#define tamanho 10

extern void sort(int* array, int size);

int *le_array(int size){
    int *array = malloc(size*sizeof(int));
    int c = 0;
    while(c < size){
        scanf("%d", &array[c]);
        c++;
    }
    return array;
}


void printa(int *array, int size){
    for(int i = 0; i < size; i++){
        printf("%d ",array[i]);
    }
    printf("\n");
}

int main(){
    int size;
    int* array;
    
    printf("Por favor, digite o tamanho do vertor:");
    scanf("%d", &size);
    
    array = le_array(size);
    printa(array, size);
   
    sort(array, size);
    
    printa(array, size);
    return 0;
}