#include <iostream>


extern "C" {
    // declaration of the function written in assembly
    void asmFunc(void);
}

int main() {
    std::cout << "Before running the assembly function\n";
    asmFunc();
    std::cout << "After running the assembly function\n";
    return 0;
}
