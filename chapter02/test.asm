                option casemap:none
nl      =       10

                .const
first           byte    1
                align   2
second          word    2
                align   4
third           dword   4
                align   8
fourth          qword   8

titleStr        byte    "Test", 0
fmtStr          byte    "The address for %d byte structure is %p", nl, 0

                .code

                externdef   printf:proc

                public      getTitle
getTitle        proc
                lea         rax, titleStr
                ret
getTitle        endp

                public      asmMain
asmMain         proc
                sub         rsp, 56

                lea         rcx, fmtStr
                movzx       edx, first
                lea         r8, first
                call        printf

                lea         rcx, fmtStr
                movzx       edx, second    
                lea         r8, second
                call        printf

                lea         rcx, fmtStr
                mov         edx, third  
                lea         r8, third
                call        printf

                lea         rcx, fmtStr
                mov         rdx, fourth    
                lea         r8, fourth
                call        printf

                add         rsp, 56
                ret
asmMain         endp
                end
