#include "matrix_mult.h"
#include <iostream>
using namespace std;

int main() {
    mat_a a[4][4] = {
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
    };

    mat_b b[4][4] = {
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1},
        {1, 1, 1, 1}
    };

    mat_prod true_prod[4][4] = {
        {4, 4, 4, 4},
        {4, 4, 4, 4},
        {4, 4, 4, 4},
        {4, 4, 4, 0}
    };
    mat_prod prod[4][4];

    mat_prod difference[4][4];

    int isEqual =1;
    matrix_mult(a, b, prod);

    for( int i=0; i<4; i++) {
        for(int j=0; j<4; j++){
            if (prod[i][j] == true_prod[i][j] ) {
                difference[i][j] = 0;
            } else {
                difference[i][j] = abs(true_prod[i][j] - prod[i][j]) ;
                isEqual = 0;
            }
        }
    }

    if(isEqual == 0){
        cout << "TEST FAILED" << "\n";
        cout << "Error in product:" << "\n" ;
        for(int i=0; i<4; i++){
            cout << "{ " ;
            for(int j=0; j<4; j++){
                cout << difference[i][j] << " " ;
            }
            cout << "} \n" ;
        }
    } else{
        cout << "TEST PASSED" << "\n" ;
    }

    cout << difference ;
    return 0;

}