        .data
        option      casemap:none

fmtStr  byte        "Hello %s!", 10, 0
nameStr    byte        "Aniket", 0
        
        .code
        externdef   printf:proc
        public      asmFunc

asmFunc proc
        sub         rsp,    56
        lea         rcx,    fmtStr
        lea         rdx,    nameStr
        call        printf
        add         rsp,    56
        ret
asmFunc endp

        end
