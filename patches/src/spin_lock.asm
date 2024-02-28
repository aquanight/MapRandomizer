!bank_85_free_space_start = $859800
!bank_85_free_space_end = $859880

incsrc "constants.asm"

org $9181B0
    jsl hook_spin_lock

org !bank_85_free_space_start
hook_spin_lock:
    lda !spin_lock_enabled
    beq .skip
    lda $0A1F
    and #$00FF
    cmp #$0003  ; spin-jumping movement type
    bne .skip

    ; Override up/down inputs to be treated as not held
    lda $14
    ora #$0C00
    sta $14

.skip:

    ; run hi-jacked instructions
    lda $0A1C
    asl A
    rtl
warnpc !bank_85_free_space_end
