#include "matrix_mult.h"
#include <iostream>
using namespace std;

int main() {

/*
    mat_a a[16][16] = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    };

    mat_b b[16][16] = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    };

    mat_prod true_prod[16][16] = {
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
        {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16},
    };
    */
   mat_a a[16][16] = {
  {87, 247, 58, 6, 3, 234, 31, 161, 46, 40, 5, 103, 110, 114, 187, 161},
  {140, 215, 99, 187, 83, 169, 147, 168, 40, 127, 131, 218, 24, 167, 120, 125},
  {83, 237, 139, 97, 20, 127, 26, 16, 121, 146, 26, 188, 18, 216, 29, 102},
  {97, 5, 250, 90, 252, 213, 15, 150, 94, 215, 196, 214, 136, 38, 24, 201},
  {42, 130, 194, 83, 213, 3, 25, 69, 6, 67, 153, 219, 28, 238, 40, 64},
  {76, 137, 89, 147, 177, 80, 233, 120, 67, 62, 194, 124, 245, 32, 246, 108},
  {242, 228, 227, 99, 250, 176, 32, 179, 179, 23, 134, 105, 88, 247, 225, 72},
  {80, 169, 207, 80, 80, 194, 199, 57, 196, 155, 1, 255, 113, 185, 132, 161},
  {175, 117, 208, 117, 65, 133, 236, 17, 119, 41, 239, 51, 27, 72, 161, 36},
  {146, 161, 76, 111, 252, 227, 137, 63, 49, 106, 255, 79, 102, 24, 79, 240},
  {181, 76, 194, 73, 71, 103, 188, 85, 36, 197, 137, 59, 195, 121, 137, 176},
  {153, 248, 234, 156, 152, 119, 194, 73, 6, 148, 36, 198, 150, 159, 220, 50},
  {254, 208, 236, 40, 91, 159, 49, 145, 100, 235, 248, 173, 193, 236, 109, 239},
  {12, 65, 21, 111, 26, 224, 202, 193, 17, 153, 182, 174, 69, 189, 92, 114},
  {195, 71, 149, 247, 6, 143, 58, 176, 31, 120, 57, 77, 166, 45, 96, 97},
  {49, 145, 11, 201, 25, 32, 238, 81, 13, 217, 239, 171, 104, 37, 112, 56},
};

mat_b b[16][16] = {
  {67, 58, 18, 212, 205, 2, 114, 51, 130, 193, 89, 39, 159, 149, 126, 107},
  {252, 84, 123, 50, 200, 42, 58, 91, 214, 77, 12, 208, 72, 101, 207, 20},
  {148, 5, 224, 215, 42, 171, 249, 162, 63, 255, 97, 51, 65, 104, 85, 106},
  {226, 212, 127, 127, 186, 215, 44, 197, 227, 121, 184, 240, 75, 95, 2, 37},
  {244, 58, 69, 69, 77, 77, 191, 132, 67, 249, 250, 197, 197, 23, 54, 147},
  {124, 191, 190, 114, 94, 65, 109, 53, 124, 15, 60, 227, 209, 232, 213, 93},
  {148, 31, 143, 116, 155, 186, 15, 123, 199, 157, 105, 182, 237, 82, 179, 8},
  {202, 211, 162, 58, 3, 127, 34, 40, 18, 84, 97, 107, 15, 35, 43, 199},
  {63, 163, 217, 166, 12, 204, 124, 247, 97, 101, 88, 123, 5, 126, 228, 49},
  {184, 119, 81, 30, 106, 140, 130, 90, 194, 198, 136, 39, 85, 176, 147, 50},
  {127, 217, 156, 37, 53, 179, 42, 233, 245, 70, 110, 216, 169, 180, 124, 146},
  {220, 159, 2, 56, 14, 200, 114, 192, 197, 121, 201, 150, 74, 31, 198, 204},
  {204, 249, 223, 62, 105, 253, 75, 138, 82, 231, 145, 194, 226, 1, 227, 61},
  {87, 2, 157, 88, 175, 151, 102, 47, 22, 150, 199, 214, 94, 25, 161, 55},
  {241, 80, 215, 86, 48, 26, 17, 182, 197, 174, 120, 195, 240, 42, 102, 92},
  {230, 71, 86, 210, 133, 61, 211, 249, 10, 25, 45, 85, 72, 114, 145, 201},
};

mat_prod true_prod[16][16] = {
  {292879, 190885, 231570, 165376, 166690, 159616, 150852, 191107, 191183, 178426, 150161, 255379, 199241, 153143, 252634, 163650},
  {384954, 252924, 268924, 217512, 234273, 267521, 202573, 282111, 305781, 271173, 257430, 344841, 255419, 210906, 294847, 217941},
  {267549, 162687, 201368, 171446, 181437, 202931, 182589, 209129, 211262, 203612, 183280, 240549, 153453, 162305, 251107, 141612},
  {386037, 281386, 281651, 235444, 176443, 297784, 283361, 320325, 258573, 312639, 282701, 306612, 260994, 227806, 291095, 267755},
  {284121, 152348, 189512, 150087, 152332, 216329, 189423, 219336, 195463, 242241, 231727, 251920, 175117, 119340, 200026, 178250},
  {402279, 274144, 308906, 205033, 208575, 291812, 182602, 318900, 309301, 312159, 266109, 362245, 320129, 176126, 293776, 205996},
  {419211, 265393, 354875, 278394, 250448, 284062, 268786, 323087, 298225, 362122, 305170, 393911, 308933, 225468, 336326, 252204},
  {386290, 238374, 311049, 254052, 223580, 305518, 252460, 316309, 288322, 312036, 267989, 339700, 268061, 211975, 356864, 210672},
  {284616, 192449, 266815, 212637, 191017, 232774, 170346, 265592, 279542, 255630, 201114, 288227, 257680, 202441, 251253, 155471},
  {378817, 258720, 267163, 223054, 225201, 243962, 228515, 306510, 287058, 266594, 242341, 340366, 298316, 232922, 291488, 226890},
  {344278, 221556, 282788, 228271, 219610, 263499, 216044, 274537, 259357, 305772, 234789, 286912, 279121, 200411, 287331, 192769},
  {422632, 233612, 307467, 236318, 254213, 287787, 230177, 294033, 324734, 357812, 287041, 361263, 309573, 195055, 318367, 202924},
  {452103, 309431, 358935, 293379, 281265, 337241, 305838, 364185, 334666, 374822, 308451, 383758, 323007, 277152, 398918, 286215},
  {317908, 242221, 250984, 163014, 180337, 256463, 153774, 236984, 254459, 212819, 225264, 310016, 239357, 185845, 265940, 190127},
  {303600, 236914, 239936, 199991, 189802, 230786, 167659, 224918, 228749, 242936, 201055, 253437, 209238, 173471, 216965, 169366},
  {321558, 235620, 217590, 141392, 187397, 258084, 124814, 256262, 305750, 230785, 214889, 287074, 232704, 172803, 239243, 152624},
};
    mat_prod prod[16][16];

    mat_prod difference[16][16];

    int isEqual =1;
    matrix_mult(a, b, prod);

    for( int i=0; i<16; i++) {
        for(int j=0; j<16; j++){
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
        for(int i=0; i<16; i++){
            cout << "{ " ;
            for(int j=0; j<16; j++){
                cout << difference[i][j] << " " ;
            }
            cout << "} \n" ;
        }
    } else{
        cout << "TEST PASSED" << "\n" ;
    }

    return 0;
}