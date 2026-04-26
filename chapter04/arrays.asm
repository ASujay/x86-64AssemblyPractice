            option casemap:none

nl      =   10
null    =   0

            .const
titleStr    byte    "Array practice", nl, null

            .data

            .code
            externdef print:proc

            public getTitle
getTitle    proc
            lea     rax, titleStr
            ret
getTitle    endp

            public asmMain
asmMain     proc
asmMain     endp
            end