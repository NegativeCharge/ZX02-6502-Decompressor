LOAD_ADDR = &5800

\ Allocate vars in ZP
ORG &80
GUARD &9F
.zp_start
    INCLUDE ".\lib\zx02_optim.h.asm"
.zp_end

\ Main
CLEAR 0, LOAD_ADDR
GUARD LOAD_ADDR
ORG &1100
.start
    INCLUDE ".\lib\zx02_optim.s.asm"

.entry_point

    \\ Turn off cursor by directly poking crtc
    lda #&0b
    sta &fe00
    lda #&20
    sta &fe01
    
    jsr full_decomp

.loop
    jmp loop
    
.comp_data
    INCBIN ".\tests\test_0.bin.zx02"

.end

SAVE "ZX02TST", start, end, entry_point

\ ******************************************************************
\ *	Memory Info
\ ******************************************************************

PRINT "------------------------"
PRINT "ZX0 Decompressor"
PRINT "------------------------"
PRINT "CODE size      = ", ~end-start
PRINT "------------------------"
PRINT "LOAD ADDR      = ", ~start
PRINT "HIGH WATERMARK = ", ~P%
PRINT "RAM BYTES FREE = ", ~LOAD_ADDR-P%
PRINT "------------------------"

PUTBASIC "loader.bas","LOADER"
PUTFILE  "BOOT","!BOOT", &FFFF  