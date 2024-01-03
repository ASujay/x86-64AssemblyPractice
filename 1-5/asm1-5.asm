; Hello world program using the C/C++ printf functino to print to console

        .data
        option      casemap:none
        
fmtStr  byte        "Hello World", 10, 0            ; String to be printed, the 10 is a linefeed character

        .code

        externdef   printf:proc
        public      asmFunc

asmFunc proc
        sub         rsp,    56                      ; Doing something to the stack pointer???
        lea         rcx,    fmtStr                  ; Loading the address of the string into rcx as the first argument to printf
        call        printf                          ; Calling the prinf function from C/C++
        add         rsp,    56                      ; This undoes the sub rsp, 56 instruction
        ret                                         ; Return to caller
asmFunc endp
        
        end
