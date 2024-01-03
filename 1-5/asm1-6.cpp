#include <stdio.h>

extern "C"{
    void asmFunc(void);
}

int main() {
    printf("Calling asmFunc\n");
    asmFunc();
    printf("Returned from asmFunc\n");
    return 0;
}
