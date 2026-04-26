                option  casemap:none
nl      =       10

                .const
titleStr        byte    "Listing 4-3", 0
fmtStr          byte    "Addresses returned by malloc: %ph, %ph", nl, 0

                .data
ptrVar          qword   ?
ptrVar2         qword   ?

                .code
                externdef   printf:proc
                externdef   malloc:proc
                externdef   free:proc

                public getTitle
getTitle        proc
                lea     rax, titleStr
                ret
getTitle        endp

                public asmMain
asmMain         proc
                sub     rsp, 56
                
                ; C standard library malloc function
                ; ptr = malloc(byteCnt)

                mov     rcx, 256        ; This will allocate 256 bytes
                call    malloc
                mov     ptrVar, rax

                mov     rcx, 1024
                call    malloc
                mov     ptrVar2, rax

                lea     rcx, fmtStr
                mov     rdx, ptrVar
                mov     r8, rax
                call    printf

                mov     rcx, ptrVar
                call    free

                mov      rcx, ptrVar2
                call    free 

                add     rsp, 56
                ret
asmMain         endp
                end