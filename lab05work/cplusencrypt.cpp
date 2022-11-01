#include <iostream>
#include <cmath>
using namespace std;

int secret_formula_apply(int x, int y, int m){ 
    int e = 7;
    int n = x*y;
    int c = (int)pow(m,e)%n; //use power from previous assignments
//don’t worry about the typecast, just treat everything as an int in MIPS
    return c; 
}
int secret_formula_remove(int x, int y, int c){ 
    int d = 3;
    int n = x*y;
    int z = (int)pow(c,d)%n; //use power from previous assignments
    return z; 
}
//don’t worry about the typecast, just treat everything as an int in MIPS
// you don’t need to implement main exactly as shown below.
// it is just included here so you can see how it is called
// but you need to implement the loops or loop for using “secret_formula_apply/remove” 
int main(){
int a = 3; 
int b = 11;
int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}; 
int c_arr[10]; 
int m_arr[10];
//your arr (krabby in the template) should be unchanged 
for (int i = 0; i < 10; i++){
c_arr[i] = secret_formula_apply(a, b, arr[i]); 
}
//you don’t need two loops this is just to make it easier to understand 
for (int i = 0; i < 10; i++) {
m_arr[i] = secret_formula_remove(a, b, c_arr[i]); 
}

for(int i = 0; i<10; i++) {
    cout << c_arr[i] << " ";
}
cout << endl;

for(int i = 0; i<10; i++) {
    cout << m_arr[i] << " ";
}
cout << endl;
return 0;
}

