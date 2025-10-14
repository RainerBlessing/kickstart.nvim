# C64 Assembly Development mit Neovim

Diese Konfiguration stellt eine vollständige Entwicklungsumgebung für C64-Assembly mit ACME-Assembler und VICE-Emulator bereit.

## Installierte Komponenten

- **vim-acme**: Syntax-Highlighting für ACME-Assembler
- **ACME**: Cross-Assembler für 6502/6510 (Version 0.97)
- **VICE**: C64-Emulator (Version 3.9)

## Datei-Unterstützung

Das Plugin erkennt automatisch folgende Dateierweiterungen als ACME-Assembly:
- `.asm`
- `.a`
- `.acme`
- `.s`

## Verfügbare Tastenkürzel

Wenn Sie eine ACME-Assembly-Datei öffnen, stehen folgende Tastenkürzel zur Verfügung:

### `<leader>cb` - Build mit ACME
Kompiliert die aktuelle Datei mit ACME:
```
acme -f cbm -o [dateiname].prg [dateiname].asm
```

### `<leader>cr` - Run in VICE
Startet die kompilierte `.prg`-Datei im VICE-Emulator (x64sc).

### `<leader>cR` - Build und Run
Kompiliert die Datei und startet sie direkt in VICE (nur bei erfolgreichem Build).

## Beispiel-Programm

```assembly
; Simple C64 "Hello World" program
* = $0801                    ; BASIC start address

; BASIC program: 10 SYS 2064
!byte $0c,$08,$0a,$00,$9e,$20,$32,$30,$36,$34,$00,$00,$00

; Assembly code starts here
* = $0810                    ; Start of machine code

CHROUT = $ffd2              ; KERNAL routine
BGCOLOR = $d020             ; Background color register

start:
    lda #$00                ; Load black color
    sta BGCOLOR             ; Set background color

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
```

## Workflow

1. Erstellen Sie eine neue `.asm`-Datei
2. Schreiben Sie Ihren 6502/6510-Assembly-Code
3. Drücken Sie `<leader>cb` zum Kompilieren
4. Drücken Sie `<leader>cr` zum Testen im Emulator
5. Oder verwenden Sie `<leader>cR` für Build + Run in einem Schritt

## ACME-Assembler Features

- Unterstützt 6502, 6510 (mit illegalen Opcodes), 65C02 und 65816
- Globale/lokale/anonyme Labels
- Conditional Assembly
- Include-Direktiven für andere Dateien
- Verschiedene Output-Formate (CBM, Plain Binary, etc.)

## Nützliche C64-Konstanten

```assembly
; Speicher-Adressen
BASIC_START = $0801         ; BASIC-Programmstart
SCREEN_RAM = $0400          ; Bildschirmspeicher
COLOR_RAM = $d800           ; Farbspeicher

; Hardware-Register
BGCOLOR = $d020             ; Hintergrundfarbe
BORDERCOLOR = $d021         ; Rahmenfarbe
SID_BASE = $d400            ; SID-Soundchip
VIC_BASE = $d000            ; VIC-II Videochip

; KERNAL-Routinen
CHROUT = $ffd2              ; Zeichen ausgeben
CHRIN = $ffcf               ; Zeichen eingeben
CLRSCR = $e544              ; Bildschirm löschen
```

## Troubleshooting

- **Plugin lädt nicht**: Starten Sie Neovim neu oder führen Sie `:Lazy sync` aus
- **ACME nicht gefunden**: Installieren Sie mit `sudo apt install acme`
- **VICE nicht gefunden**: Installieren Sie mit `sudo apt install vice`
- **Syntax-Highlighting fehlt**: Überprüfen Sie, dass die Datei die richtige Erweiterung hat

## Weiterführende Ressourcen

- [ACME Assembler Documentation](https://sourceforge.net/projects/acme-crossass/)
- [VICE Emulator](https://vice-emu.sourceforge.io/)
- [C64 Programming Tutorial](https://codebase64.org/)
- [6502 Instruction Set](http://www.6502.org/tutorials/6502opcodes.html)