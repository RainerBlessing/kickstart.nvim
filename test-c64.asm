; Simple C64 "Hello World" program
; Assemble with: acme -f cbm -o hello.prg test-c64.asm
; Run with: x64sc hello.prg

* = $0801                    ; BASIC start address

; BASIC program: 10 SYS 2064
!byte $0c,$08,$0a,$00,$9e,$20,$32,$30,$36,$34,$00,$00,$00

; Assembly code starts here
* = $0810                    ; Start of machine code

CHROUT = $ffd2              ; KERNAL routine to output character
BGCOLOR = $d020             ; Background color register
BORDERCOLOR = $d021         ; Border color register

start:
    lda #$00                ; Load black color
    sta BGCOLOR             ; Set background color
    sta BORDERCOLOR         ; Set border color

    ldx #$00                ; Initialize string index
print_loop:
    lda message,x           ; Load character from message
    beq done                ; If zero, we're done
    jsr CHROUT              ; Output character
    inx                     ; Next character
    bne print_loop          ; Continue loop

done:
    rts                     ; Return to BASIC

message:
    !text "hello, c64 world!"
    !byte $0d, $00          ; CR + string terminator