#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern "C" {
    // asmMain is the assembly main function
    void asmFunc(void);
    char* getTitle(void);
    int readLine(char* dest, int maxlen);
}


int readLine(char* dest, int maxlen){
    char *result = fgets(dest, maxlen, stdin);
    if(result != NULL){
        int len = strlen(result);
        if(len > 0){
            dest[len - 1] = 0;
        }
        return len;
    }
    // if there is an error
    return -1;
}

int main() {
    try{
        char* title = getTitle();
        printf("Calling %s:\n", title);
        asmFunc();
        printf("%s termination.\n", title);
    }catch(...){
        printf(
            "Exception occured during program execution\n"
            "Abnormal program termination.\n"
                );
    }
}   
