            option casemap:none

            .data
nl          =           10
fmtStr      byte        "Hello World!", nl, 0

            .code
            externdef printf:proc

            public asmFunc
asmFunc     proc
            sub     rsp, 56
            lea     rcx, fmtStr
            call    printf
            add     rsp, 56
            ret
asmFunc     endp
            end