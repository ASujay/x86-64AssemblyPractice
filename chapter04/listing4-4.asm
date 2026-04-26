            option  casemap:none
nl          =       10

            .const
titleStr    byte    "Listing 4-4", 0
fmtStr      byte    "Pointer value= %p", nl, 0

            .data
ptrVal      qword   ?

            .code
            externdef   printf:proc

            public  getTitle
getTitle    proc
            lea     rax, titleStr
            ret
getTitle    endp

            public  asmMain
asmMain     proc
            sub     rsp, 56

            lea     rcx, fmtStr
            mov     rdx, ptrVal
            mov     rdx, [rdx]          ; Since ptrVal is initialized as 0, and the we try to use 0 as a address
            call    printf

            add     rsp, 56
            ret
asmMain     endp
            end