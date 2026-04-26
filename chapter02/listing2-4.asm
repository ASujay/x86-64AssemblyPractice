                option casemap:none

NULL    =       0
nl      =       10
maxLen  =       256

                .const
titleStr        byte        'Listing 2-4', 0
moPrompt        byte        'Enter current month: ', 0
dayPrompt       byte        'Enter current day: ',  0
yearPrompt      byte        'Enter current year: '
                byte        '(last 2 digits only): ', 0
packed          byte        'Packed date is %04x', nl, 0
theDate         byte        'The date is %02d/%02d/%02d', nl, 0
badDayStr       byte        'Bad day value was entered '
                byte        '(expected 1-31)', nl, 0
badMonthStr     byte        'Bad month value was entered'
                byte        '(expected 1-12)', nl, 0
badYearStr      byte        'Bad year value was entered'
                byte        '(expected 00-99)', nl, 0

                .data
month           byte        ?
day             byte        ?
year            byte        ?
date            word        ?

input           byte    maxLen  dup (?)

                .code
                externdef   printf:proc
                externdef   readLine:proc
                externdef   atoi:proc

                public getTitle
getTitle        proc
                lea     rax, titleStr
                ret
getTitle        endp
                
                ; this readNum function will be like this
                ; int readNum(char *prompt)
                ; so will have the prompt in the rcx register when this function is called
                public readNum
readNum         proc
                ; print the prompt
                sub     rsp, 56

                call    printf

                ; setting up the registers for readLine function
                lea     rcx, input
                mov     rdx, maxLen
                call    readLine
                cmp     rax, NULL
                je badInput

                ; we want to call atoi
                lea     rcx, input
                call    atoi
badInput:
                add     rsp, 56
                ret
readNum         endp

                public asmMain
asmMain         proc
                
                sub     rsp, 56
                
                lea     rcx, moPrompt
                call    readNum

                ; We have the result in rax
                cmp     rax, 1
                jl      badMonth
                cmp     rax, 12
                jg      badMonth

                mov     month,  al

                lea     rcx, dayPrompt
                call    readNum

                cmp     rax, 1
                jl      badDay
                cmp     rax, 31
                jg      badDay

                mov     day, al

                lea     rcx, yearPrompt
                call    readNum

                cmp     rax, 0
                jl      badYear
                cmp     rax, 99
                jg      badYear

                mov     year, al

                ; We are going to perform packing and un packing now
                ; first we are going to create the packed date
                ; this is 16 bits
                movzx   ax, month
                shl     ax, 5           ; 5 since the date will be represented by 5 bits
                or      al, day
                shl     ax, 7           ; 7 beceuase the year will be 7 bits long
                or      al, year
                mov     date, ax

                ; Print the packed data
                lea     rcx, packed
                movzx   edx, date
                call    printf

                ; Print the unpacked data
                lea     rcx, theDate
                ; Unpack in sequence one by one
                movzx   rdx, date
                mov     r9, rdx
                and     r9, 7fh
                shr     rdx, 7
                mov     r8, rdx
                and     r8, 1fh
                shr     rdx, 5
                call    printf


                jmp     allDone
badYear:
                lea     rcx, badYearStr
                call    printf
                jmp     allDone

badDay:
                lea     rcx, badDayStr
                call    printf
                jmp     allDone

badMonth:
                lea     rcx, badMonthStr
                call    printf
allDone:                
                add     rsp, 56
                ret

asmMain         endp
                end

