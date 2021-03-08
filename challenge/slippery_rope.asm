[bits 64]

global _start

section .text
_start:
        ; print banner
        mov  rax, 0x1
        mov  rdi, 0x1
        mov  rsi, banner
        mov  rdx, 1240
        syscall
        ; jump to main
        call main
        ; exit
        xor  rdi, rdi
        mov  rax, 60
        syscall

main:
        ; prepare stack frame
        push rbp
        mov  rbp, rsp
        sub  rsp, 200
        ; print welcome message
        mov  rax, 0x1
        mov  rdi, 0x1
        mov  rsi, welcome
        mov  rdx, welcomel
        syscall
        ; read input
        xor  rax, rax
        xor  rdi, rdi
        mov  rsi, rsp
        mov  rdx, 0x200
        syscall
        cmp byte [rsp + rax - 1], 10
        jne skip
        mov byte [rsp + rax - 1], 0
        dec rax
skip:   mov  rcx, prefixl
        mov  rdi, banner
        mov  rsi, prefix
        rep movsb
        mov  rcx, rax
        mov  rsi, rsp
        rep movsb
        mov  rcx, suffixl
        mov  rsi, suffix
        rep movsb
        ; print result
        mov  rdx, rdi
        sub  rdx, banner
        mov  rax, 0x1
        mov  rdi, 0x1
        mov  rsi, banner
        syscall
        leave
        ret
gift:   pop rax
        ret


section .data
        banner   db ".---------------------[ Slippery Rope ]---------------------.", 0x0a, \
                    "|   \\//                                             \\//   |", 0x0a, \
                    "|    //                                               //    |", 0x0a, \
                    "|   //\\                                             //\\   |", 0x0a, \
                    "|   \\//         _ _                                 \\//   |", 0x0a, \
                    "|    //      ___| (_)_ __  _ __   ___ _ __ _   _      //    |", 0x0a, \
                    "|   //\\    / __| | | '_ \| '_ \ / _ \ '__| | | |    //\\   |", 0x0a, \
                    "|   \\//    \__ \ | | |_) | |_) |  __/ |  | |_| |    \\//   |", 0x0a, \
                    "|    //     |___/_|_| .__/| .__/ \___|_|   \__, |     //    |", 0x0a, \
                    "|   //\\            |_|   |_|              |___/     //\\   |", 0x0a, \
                    "|   \\//            _ __ ___  _ __   ___             \\//   |", 0x0a, \
                    "|    //            | '__/ _ \| '_ \ / _ \             //    |", 0x0a, \
                    "|   //\\           | | | (_) | |_) |  __/            //\\   |", 0x0a, \
                    "|   \\//           |_|  \___/| .__/ \___|            \\//   |", 0x0a, \
                    "|    //                      |_|                      //    |", 0x0a, \
                    "|   //\\                                             //\\   |", 0x0a, \
                    "|   \\//                                             \\//   |", 0x0a, \
                    "|    //                                               //    |", 0x0a, \
                    "|   //\\                                             //\\   |", 0x0a, \
                    "'-------------------------[ by hfz ]------------------------'", 0x0a, 0x00
        bannerl  equ $-banner
        welcome  db "Dude I can't climb, that rope is so slippery... what should I do?", 10, "> ", 0
        welcomel equ $-welcome
        prefix   db "I already tried to ", 34
        prefixl  equ $-prefix
        suffix   db 34, ", but it didn't work :/", 10, "Thanks anyways <:", 10, 0
        suffixl  equ $-suffix
