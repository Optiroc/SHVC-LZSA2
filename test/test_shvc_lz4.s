; SHVC-LZ
; David Lindecrantz <optiroc@me.com>
;
; LZ4 test runner

.include "shvc_cpu.inc"
.include "shvc_mmio.inc"

.p816
.smart -
.feature c_comments

.import Compressed, Compressed_Length, LZ4_Decompress, LZ4_Length
.export Main

DESTINATION_PADDING = $36

Main:
    .a8
    .i16
    nop

Benchmark_START:
    ; Set source/destination
    ldx #Compressed_Length
    stx LZ4_Length
    ldy #.loword(Destination)
    ldx #.loword(Compressed)
    lda #^Destination
    xba
    lda #^Compressed

    jsl LZ4_Decompress

Benchmark_END:
    nop
Asserts_END:
    nop
Tests_DONE:
    nop
:   nop
    bra :-

.segment "BSS7F"
Padding:
    .res DESTINATION_PADDING
Destination:
    .res $ffff - DESTINATION_PADDING
