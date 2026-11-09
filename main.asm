.MODEL SMALL
.STACK 100H

.DATA

welcome_msg DB 0DH,0AH,'=====================================$'
welcome_msg2 DB 0DH,0AH,'     Welcome To Exam System         $'
welcome_msg3 DB 0DH,0AH,'=====================================$'
get_name    DB 0DH,0AH,'Enter your name : $'
array       DB 10, ?, 10 DUP('$')
welcome     DB 0DH,0AH,'Welcome, $'

menu_msg    DB 0DH,0AH,0DH,0AH,'========== MAIN MENU ==========$'
menu1       DB 0DH,0AH,'1) Start Exam$'
menu2       DB 0DH,0AH,'2) View Instructions$'
menu3       DB 0DH,0AH,'3) Exit$'
menu_choose DB 0DH,0AH,'Choose option: $'

inst1 DB 0DH,0AH,'========== INSTRUCTIONS ==========$'
inst2 DB 0DH,0AH,'- Exam contains 10 MCQ questions.$'
inst3 DB 0DH,0AH,'- Choose only A, B, C, or D.$'
inst4 DB 0DH,0AH,'- Correct answer increases score.$'
inst5 DB 0DH,0AH,'- Wrong answers will be reviewed at the end.$'
inst6 DB 0DH,0AH,'Press any key to return to menu...$'

ready_msg   DB 0DH,0AH,'Ready to start exam? (Y/N): $'
start_msg   DB 0DH,0AH,0DH,0AH,'=== Starting Exam... Good Luck! ===$'
get_answer  DB 0DH,0AH,'Your Answer (A/B/C/D): $'
ans_buf     DB 3, ?, 3 DUP('$')

correct_msg DB 0DH,0AH,'>> Correct! :)$'
wrong_msg   DB 0DH,0AH,'>> Wrong! :($'
score_msg   DB 0DH,0AH,0DH,0AH,'Your Score : $'
out_of_msg  DB ' out of 10$'

; ===== GRADE MESSAGES =====
grade_ex    DB 0DH,0AH,'Grade: EXCELLENT! Outstanding! :$'
grade_vg    DB 0DH,0AH,'Grade: VERY GOOD! Well done! :)$'
grade_gd    DB 0DH,0AH,'Grade: GOOD! Keep it up! :)$'
grade_pass  DB 0DH,0AH,'Grade: PASS. You made it!$'
grade_fail  DB 0DH,0AH,'Grade: FAIL :(  Better luck next time.$'
pass_msg    DB 0DH,0AH,'Congratulations! You PASSED :)$'
fail_msg    DB 0DH,0AH,'Sorry, You FAILED :($'
att2_msg    DB 0DH,0AH,'=== Second Attempt ===$'
att3_msg    DB 0DH,0AH,'=== Third and Final Attempt ===$'
no_more_msg DB 0DH,0AH,'No more attempts. Goodbye!$'
div_line    DB 0DH,0AH,'-------------------------------------$'

; ===== NEW: REVIEW MESSAGES =====
review_hdr  DB 0DH,0AH,'===== WRONG ANSWERS REVIEW =====$'
review_q    DB 0DH,0AH,'Question #$'
review_your DB 0DH,0AH,'  Your Answer  : $'
review_cor  DB 0DH,0AH,'  Correct Ans  : $'
review_none DB 0DH,0AH,'All answers were correct! Great job!$'

score       DW 0

; ===== NEW: Wrong Answers Storage =====
wrong_q_ptr  DW 10 DUP(0)
wrong_q_ans  DB 10 DUP(0)
wrong_count  DB 0

; ============================================================
; QUESTION BLOCK STRUCTURE (COA SPECIFIC)
; ============================================================

; ===== GROUP 1 QUESTIONS (Basic Architecture & Data Path) =====

g1q1   DB 0DH,0AH,'Q1) Which memory architecture uses separate buses for data and instructions?$'
g1q1a  DB 0DH,0AH,'   A) Von Neumann$'
g1q1b  DB 0DH,0AH,'   B) Harvard$'
g1q1c  DB 0DH,0AH,'   C) CISC$'
g1q1d  DB 0DH,0AH,'   D) RISC$'
g1q1ans DB 'B'

g1q2   DB 0DH,0AH,'Q2) What does ALU stand for?$'
g1q2a  DB 0DH,0AH,'   A) Arithmetic Logic Unit$'
g1q2b  DB 0DH,0AH,'   B) Array Logic Unit$'
g1q2c  DB 0DH,0AH,'   C) Arithmetic Load Unit$'
g1q2d  DB 0DH,0AH,'   D) Access Logic Unit$'
g1q2ans DB 'A'

g1q3   DB 0DH,0AH,'Q3) RISC stands for?$'
g1q3a  DB 0DH,0AH,'   A) Reduced Instruction Set Comp.$'
g1q3b  DB 0DH,0AH,'   B) Rapid Instruction Set Comp.$'
g1q3c  DB 0DH,0AH,'   C) Real Instruction Set Comp.$'
g1q3d  DB 0DH,0AH,'   D) Random Instruction Set Comp.$'
g1q3ans DB 'A'

g1q4   DB 0DH,0AH,'Q4) Which register holds the address of the next instruction?$'
g1q4a  DB 0DH,0AH,'   A) Accumulator$'
g1q4b  DB 0DH,0AH,'   B) Stack Pointer$'
g1q4c  DB 0DH,0AH,'   C) Program Counter$'
g1q4d  DB 0DH,0AH,'   D) Index Register$'
g1q4ans DB 'C'

g1q5   DB 0DH,0AH,'Q5) Which unit generates timing and control signals?$'
g1q5a  DB 0DH,0AH,'   A) ALU$'
g1q5b  DB 0DH,0AH,'   B) Control Unit$'
g1q5c  DB 0DH,0AH,'   C) Memory Unit$'
g1q5d  DB 0DH,0AH,'   D) I/O Unit$'
g1q5ans DB 'B'

g1q6   DB 0DH,0AH,'Q6) CISC processors typically have:$'
g1q6a  DB 0DH,0AH,'   A) Fixed length instructions$'
g1q6b  DB 0DH,0AH,'   B) Few registers$'
g1q6c  DB 0DH,0AH,'   C) Variable length instructions$'
g1q6d  DB 0DH,0AH,'   D) No memory access$'
g1q6ans DB 'C'

g1q7   DB 0DH,0AH,'Q7) IEEE 754 is a standard for?$'
g1q7a  DB 0DH,0AH,'   A) Integer math$'
g1q7b  DB 0DH,0AH,'   B) Floating-point math$'
g1q7c  DB 0DH,0AH,'   C) Character encoding$'
g1q7d  DB 0DH,0AH,'   D) Bus arbitration$'
g1q7ans DB 'B'

g1q8   DB 0DH,0AH,'Q8) Which of these is a basic functional unit of a computer?$'
g1q8a  DB 0DH,0AH,'   A) Operating System$'
g1q8b  DB 0DH,0AH,'   B) Compiler$'
g1q8c  DB 0DH,0AH,'   C) Datapath$'
g1q8d  DB 0DH,0AH,'   D) Internet$'
g1q8ans DB 'C'

g1q9   DB 0DH,0AH,'Q9) The 8086 microprocessor has a data bus size of?$'
g1q9a  DB 0DH,0AH,'   A) 8 bits$'
g1q9b  DB 0DH,0AH,'   B) 16 bits$'
g1q9c  DB 0DH,0AH,'   C) 20 bits$'
g1q9d  DB 0DH,0AH,'   D) 32 bits$'
g1q9ans DB 'B'

g1q10  DB 0DH,0AH,'Q10) Hardwired control units are generally:$'
g1q10a DB 0DH,0AH,'   A) Slower than microprogrammed$'
g1q10b DB 0DH,0AH,'   B) Faster than microprogrammed$'
g1q10c DB 0DH,0AH,'   C) Easier to modify$'
g1q10d DB 0DH,0AH,'   D) Made of RAM$'
g1q10ans DB 'B'

; ===== GROUP 2 QUESTIONS (Pipelining & Memory) =====

g2q1   DB 0DH,0AH,'Q1) Pipelining primarily improves CPU performance by?$'
g2q1a  DB 0DH,0AH,'   A) Increasing clock speed$'
g2q1b  DB 0DH,0AH,'   B) Increasing instruction throughput$'
g2q1c  DB 0DH,0AH,'   C) Decreasing cache misses$'
g2q1d  DB 0DH,0AH,'   D) Adding ALUs$'
g2q1ans DB 'B'

g2q2   DB 0DH,0AH,'Q2) A situation preventing the next instruction from executing in its cycle?$'
g2q2a  DB 0DH,0AH,'   A) Hazard$'
g2q2b  DB 0DH,0AH,'   B) Stall$'
g2q2c  DB 0DH,0AH,'   C) Fault$'
g2q2d  DB 0DH,0AH,'   D) Exception$'
g2q2ans DB 'A'

g2q3   DB 0DH,0AH,'Q3) Trying to read data before a previous instruction writes it causes a?$'
g2q3a  DB 0DH,0AH,'   A) Structural hazard$'
g2q3b  DB 0DH,0AH,'   B) Control hazard$'
g2q3c  DB 0DH,0AH,'   C) Data hazard$'
g2q3d  DB 0DH,0AH,'   D) Memory hazard$'
g2q3ans DB 'C'

g2q4   DB 0DH,0AH,'Q4) Branch instructions primarily cause which type of hazard?$'
g2q4a  DB 0DH,0AH,'   A) Data hazard$'
g2q4b  DB 0DH,0AH,'   B) Control hazard$'
g2q4c  DB 0DH,0AH,'   C) Structural hazard$'
g2q4d  DB 0DH,0AH,'   D) Execution hazard$'
g2q4ans DB 'B'

g2q5   DB 0DH,0AH,'Q5) Which is the fastest component in the memory hierarchy?$'
g2q5a  DB 0DH,0AH,'   A) Cache memory$'
g2q5b  DB 0DH,0AH,'   B) Main Memory (RAM)$'
g2q5c  DB 0DH,0AH,'   C) CPU Registers$'
g2q5d  DB 0DH,0AH,'   D) Magnetic Disk$'
g2q5ans DB 'C'

g2q6   DB 0DH,0AH,'Q6) The principle of locality of reference justifies the use of?$'
g2q6a  DB 0DH,0AH,'   A) Virtual memory$'
g2q6b  DB 0DH,0AH,'   B) Cache memory$'
g2q6c  DB 0DH,0AH,'   C) DMA$'
g2q6d  DB 0DH,0AH,'   D) Interrupts$'
g2q6ans DB 'B'

g2q7   DB 0DH,0AH,'Q7) A cache miss occurs when?$'
g2q7a  DB 0DH,0AH,'   A) Data is found in cache$'
g2q7b  DB 0DH,0AH,'   B) Data is not found in cache$'
g2q7c  DB 0DH,0AH,'   C) CPU halts$'
g2q7d  DB 0DH,0AH,'   D) Disk is full$'
g2q7ans DB 'B'

g2q8   DB 0DH,0AH,'Q8) Which mapping allows a memory block to go anywhere in cache?$'
g2q8a  DB 0DH,0AH,'   A) Direct mapping$'
g2q8b  DB 0DH,0AH,'   B) Set-associative$'
g2q8c  DB 0DH,0AH,'   C) Fully associative$'
g2q8d  DB 0DH,0AH,'   D) Indirect mapping$'
g2q8ans DB 'C'

g2q9   DB 0DH,0AH,'Q9) Virtual memory is typically managed jointly by?$'
g2q9a  DB 0DH,0AH,'   A) The ALU and CU$'
g2q9b  DB 0DH,0AH,'   B) The OS and MMU$'
g2q9c  DB 0DH,0AH,'   C) The compiler and linker$'
g2q9d  DB 0DH,0AH,'   D) The I/O controller$'
g2q9ans DB 'B'

g2q10  DB 0DH,0AH,'Q10) In memory management, TLB stands for?$'
g2q10a DB 0DH,0AH,'   A) Translation Lookaside Buffer$'
g2q10b DB 0DH,0AH,'   B) Time Limit Buffer$'
g2q10c DB 0DH,0AH,'   C) Total Logic Block$'
g2q10d DB 0DH,0AH,'   D) Table Load Base$'
g2q10ans DB 'A'

; ===== GROUP 3 QUESTIONS (I/O & 8086 Assembly) =====

g3q1   DB 0DH,0AH,'Q1) Which I/O technique bypasses the CPU for memory transfers?$'
g3q1a  DB 0DH,0AH,'   A) Programmed I/O$'
g3q1b  DB 0DH,0AH,'   B) Interrupt-driven I/O$'
g3q1c  DB 0DH,0AH,'   C) Direct Memory Access (DMA)$'
g3q1d  DB 0DH,0AH,'   D) Polling$'
g3q1ans DB 'C'

g3q2   DB 0DH,0AH,'Q2) An external signal that pauses current CPU execution?$'
g3q2a  DB 0DH,0AH,'   A) Trap$'
g3q2b  DB 0DH,0AH,'   B) Interrupt$'
g3q2c  DB 0DH,0AH,'   C) DMA request$'
g3q2d  DB 0DH,0AH,'   D) Wait state$'
g3q2ans DB 'B'

g3q3   DB 0DH,0AH,'Q3) In programmed I/O, the CPU wastes time doing what?$'
g3q3a  DB 0DH,0AH,'   A) Polling/waiting for device$'
g3q3b  DB 0DH,0AH,'   B) Processing ALU ops$'
g3q3c  DB 0DH,0AH,'   C) Fetching instructions$'
g3q3d  DB 0DH,0AH,'   D) Executing another task$'
g3q3ans DB 'A'

g3q4   DB 0DH,0AH,'Q4) The total physical memory addressable by the 8086 is?$'
g3q4a  DB 0DH,0AH,'   A) 1 MB$'
g3q4b  DB 0DH,0AH,'   B) 64 KB$'
g3q4c  DB 0DH,0AH,'   C) 16 MB$'
g3q4d  DB 0DH,0AH,'   D) 4 GB$'
g3q4ans DB 'A'

g3q5   DB 0DH,0AH,'Q5) Which of these is a segment register in 8086?$'
g3q5a  DB 0DH,0AH,'   A) AX$'
g3q5b  DB 0DH,0AH,'   B) CX$'
g3q5c  DB 0DH,0AH,'   C) CS$'
g3q5d  DB 0DH,0AH,'   D) SI$'
g3q5ans DB 'C'

g3q6   DB 0DH,0AH,'Q6) The 8086 physical address bus size is?$'
g3q6a  DB 0DH,0AH,'   A) 16 bits$'
g3q6b  DB 0DH,0AH,'   B) 20 bits$'
g3q6c  DB 0DH,0AH,'   C) 24 bits$'
g3q6d  DB 0DH,0AH,'   D) 32 bits$'
g3q6ans DB 'B'

g3q7   DB 0DH,0AH,'Q7) The stack operates on which principle?$'
g3q7a  DB 0DH,0AH,'   A) LIFO (Last In First Out)$'
g3q7b  DB 0DH,0AH,'   B) FIFO (First In First Out)$'
g3q7c  DB 0DH,0AH,'   C) Round-robin$'
g3q7d  DB 0DH,0AH,'   D) Random access$'
g3q7ans DB 'A'

g3q8   DB 0DH,0AH,'Q8) What is a software interrupt?$'
g3q8a  DB 0DH,0AH,'   A) A hardware failure$'
g3q8b  DB 0DH,0AH,'   B) An instruction like INT 21H$'
g3q8c  DB 0DH,0AH,'   C) A power loss event$'
g3q8d  DB 0DH,0AH,'   D) A physical reset switch$'
g3q8ans DB 'B'

g3q9   DB 0DH,0AH,'Q9) Which register is the default counter for loop instructions?$'
g3q9a  DB 0DH,0AH,'   A) AX$'
g3q9b  DB 0DH,0AH,'   B) BX$'
g3q9c  DB 0DH,0AH,'   C) CX$'
g3q9d  DB 0DH,0AH,'   D) DX$'
g3q9ans DB 'C'

g3q10  DB 0DH,0AH,'Q10) The 20-bit physical address in 8086 is calculated by?$'
g3q10a DB 0DH,0AH,'   A) Segment * 16 + Offset$'
g3q10b DB 0DH,0AH,'   B) Segment + Offset$'
g3q10c DB 0DH,0AH,'   C) Segment * 10 + Offset$'
g3q10d DB 0DH,0AH,'   D) Offset * 16 + Segment$'
g3q10ans DB 'A'

; ============================================================
; QUESTION TABLES
; Each entry = 6 WORDs: Q, A, B, C, D, ANS_OFFSET
; ============================================================

G1Table:
    DW offset g1q1,  offset g1q1a,  offset g1q1b,  offset g1q1c,  offset g1q1d,  offset g1q1ans
    DW offset g1q2,  offset g1q2a,  offset g1q2b,  offset g1q2c,  offset g1q2d,  offset g1q2ans
    DW offset g1q3,  offset g1q3a,  offset g1q3b,  offset g1q3c,  offset g1q3d,  offset g1q3ans
    DW offset g1q4,  offset g1q4a,  offset g1q4b,  offset g1q4c,  offset g1q4d,  offset g1q4ans
    DW offset g1q5,  offset g1q5a,  offset g1q5b,  offset g1q5c,  offset g1q5d,  offset g1q5ans
    DW offset g1q6,  offset g1q6a,  offset g1q6b,  offset g1q6c,  offset g1q6d,  offset g1q6ans
    DW offset g1q7,  offset g1q7a,  offset g1q7b,  offset g1q7c,  offset g1q7d,  offset g1q7ans
    DW offset g1q8,  offset g1q8a,  offset g1q8b,  offset g1q8c,  offset g1q8d,  offset g1q8ans
    DW offset g1q9,  offset g1q9a,  offset g1q9b,  offset g1q9c,  offset g1q9d,  offset g1q9ans
    DW offset g1q10, offset g1q10a, offset g1q10b, offset g1q10c, offset g1q10d, offset g1q10ans

G2Table:
    DW offset g2q1,  offset g2q1a,  offset g2q1b,  offset g2q1c,  offset g2q1d,  offset g2q1ans
    DW offset g2q2,  offset g2q2a,  offset g2q2b,  offset g2q2c,  offset g2q2d,  offset g2q2ans
    DW offset g2q3,  offset g2q3a,  offset g2q3b,  offset g2q3c,  offset g2q3d,  offset g2q3ans
    DW offset g2q4,  offset g2q4a,  offset g2q4b,  offset g2q4c,  offset g2q4d,  offset g2q4ans
    DW offset g2q5,  offset g2q5a,  offset g2q5b,  offset g2q5c,  offset g2q5d,  offset g2q5ans
    DW offset g2q6,  offset g2q6a,  offset g2q6b,  offset g2q6c,  offset g2q6d,  offset g2q6ans
    DW offset g2q7,  offset g2q7a,  offset g2q7b,  offset g2q7c,  offset g2q7d,  offset g2q7ans
    DW offset g2q8,  offset g2q8a,  offset g2q8b,  offset g2q8c,  offset g2q8d,  offset g2q8ans
    DW offset g2q9,  offset g2q9a,  offset g2q9b,  offset g2q9c,  offset g2q9d,  offset g2q9ans
    DW offset g2q10, offset g2q10a, offset g2q10b, offset g2q10c, offset g2q10d, offset g2q10ans

G3Table:
    DW offset g3q1,  offset g3q1a,  offset g3q1b,  offset g3q1c,  offset g3q1d,  offset g3q1ans
    DW offset g3q2,  offset g3q2a,  offset g3q2b,  offset g3q2c,  offset g3q2d,  offset g3q2ans
    DW offset g3q3,  offset g3q3a,  offset g3q3b,  offset g3q3c,  offset g3q3d,  offset g3q3ans
    DW offset g3q4,  offset g3q4a,  offset g3q4b,  offset g3q4c,  offset g3q4d,  offset g3q4ans
    DW offset g3q5,  offset g3q5a,  offset g3q5b,  offset g3q5c,  offset g3q5d,  offset g3q5ans
    DW offset g3q6,  offset g3q6a,  offset g3q6b,  offset g3q6c,  offset g3q6d,  offset g3q6ans
    DW offset g3q7,  offset g3q7a,  offset g3q7b,  offset g3q7c,  offset g3q7d,  offset g3q7ans
    DW offset g3q8,  offset g3q8a,  offset g3q8b,  offset g3q8c,  offset g3q8d,  offset g3q8ans
    DW offset g3q9,  offset g3q9a,  offset g3q9b,  offset g3q9c,  offset g3q9d,  offset g3q9ans
    DW offset g3q10, offset g3q10a, offset g3q10b, offset g3q10c, offset g3q10d, offset g3q10ans

.CODE

; ============================================================
; PRINT_NUM: prints number in AX to screen (0-10)
; ============================================================
PRINT_NUM PROC

    CMP AX, 10
    JE PRINT_TEN

    CMP AX, 9
    JG DONE

    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    RET

PRINT_TEN:
    MOV DL, '1'
    MOV AH, 02H
    INT 21H

    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    RET

DONE:
    RET

PRINT_NUM ENDP

; ============================================================
; PRINT_GRADE: prints grade based on score variable
; Scale: 9-10=Excellent, 8=Very Good, 7=Good, 6=Pass, 0-5=Fail
; ============================================================
PRINT_GRADE PROC
    MOV AX, score
    CMP AX, 9
    JGE PG_EXCELLENT
    CMP AX, 8
    JGE PG_VERYGOOD
    CMP AX, 7
    JGE PG_GOOD
    CMP AX, 6
    JGE PG_PASS
    LEA DX, grade_fail
    MOV AH, 09H
    INT 21H
    RET
PG_EXCELLENT:
    LEA DX, grade_ex
    MOV AH, 09H
    INT 21H
    RET
PG_VERYGOOD:
    LEA DX, grade_vg
    MOV AH, 09H
    INT 21H
    RET
PG_GOOD:
    LEA DX, grade_gd
    MOV AH, 09H
    INT 21H
    RET
PG_PASS:
    LEA DX, grade_pass
    MOV AH, 09H
    INT 21H
    RET
PRINT_GRADE ENDP

; ============================================================
READ_ANSWER PROC
    LEA DX, get_answer
    MOV AH, 09H
    INT 21H

    LEA DX, ans_buf
    MOV AH, 0AH
    INT 21H

    MOV AL, ans_buf+2
    RET
READ_ANSWER ENDP

; ============================================================
VALIDATE_ANSWER PROC

    ; --  lowercase? --
    CMP AL, 'a'        ; 61H
    JL  CHECK_UPPER    
    CMP AL, 'z'        
    JG  NOT_VALID      ;74H
    SUB AL, 20H        
    JMP CHECK_ABCD     

    ; --  uppercase? --
CHECK_UPPER:
    CMP AL, 'A'        ; 41H
    JL  NOT_VALID      
    CMP AL, 'Z'        ; 5AH
    JG  NOT_VALID      

    ; -- A/B/C/D? --
CHECK_ABCD:
    CMP AL, 'A'
    JE  OK
    CMP AL, 'B'
    JE  OK
    CMP AL, 'C'
    JE  OK
    CMP AL, 'D'
    JE  OK

NOT_VALID:
    MOV AL, 0
    RET

OK:
    RET
VALIDATE_ANSWER ENDP

; ============================================================
; BEEP: Prints a hardware signal indicator in EMU8086
; ============================================================
BEEP PROC
    MOV AH, 02H
    MOV DL, 07H         ; BEL character
    INT 21H
    RET
BEEP ENDP

; ============================================================
; PRINT_REVIEW
; ============================================================
PRINT_REVIEW PROC
    ; --- header ---
    LEA DX, div_line
    MOV AH, 09H
    INT 21H

    LEA DX, review_hdr
    MOV AH, 09H
    INT 21H

    ; --- check if any wrong answers exist ---
    MOV AL, wrong_count
    CMP AL, 0
    JNE PR_LOOP_INIT

    ; no wrong answers -> print congratulations
    LEA DX, review_none
    MOV AH, 09H
    INT 21H
    RET

PR_LOOP_INIT:
    MOV BX, 0           ; BX = index into wrong_q_ptr / wrong_q_ans (byte index)
    MOV CH, 0
    MOV CL, wrong_count ; CX = loop counter (number of wrong questions)

PR_LOOP:
    PUSH CX
    PUSH BX

    ; --- print question number ---
    LEA DX, review_q
    MOV AH, 09H
    INT 21H

    ; print 1-based index: BX/2 + 1  (BX is word-index * 2)
    MOV AX, BX
    SHR AX, 1           ; AX = entry index (0-based)
    INC AX              ; make 1-based
    CALL PRINT_NUM

    ; --- print question text ---
    MOV SI, wrong_q_ptr[BX]    ; SI = base of the question table entry
    MOV DX, [SI]               ; DX = offset of question text string
    MOV AH, 09H
    INT 21H

    ; --- print student's wrong answer letter ---
    LEA DX, review_your
    MOV AH, 09H
    INT 21H

    ; wrong_q_ans index = BX/2 (each entry is 1 byte)
    MOV DI, BX
    SHR DI, 1                  ; DI = byte index into wrong_q_ans
    MOV DL, wrong_q_ans[DI]    ; DL = student letter (A/B/C/D)
    MOV AH, 02H
    INT 21H

    ; --- print correct answer letter ---
    LEA DX, review_cor
    MOV AH, 09H
    INT 21H

    MOV DI, [SI+10]            ; DI = pointer to correct answer byte
    MOV DL, [DI]               ; DL = correct letter
    MOV AH, 02H
    INT 21H

    POP BX
    POP CX

    ADD BX, 2           ; advance to next WORD entry in wrong_q_ptr
    LOOP PR_LOOP

    LEA DX, div_line
    MOV AH, 09H
    INT 21H

    RET
PRINT_REVIEW ENDP

; ============================================================
; DO_EXAM: runs 10 MCQ questions from a given table
; ============================================================
DO_EXAM PROC
    MOV score, 0
    MOV wrong_count, 0  ; NEW: reset wrong-answer tracker each attempt
    MOV CX, 10          ; 10 questions

EXAM_LOOP:
    PUSH CX
    PUSH SI

    LEA DX, div_line
    MOV AH, 09H
    INT 21H

    MOV DX, [SI]        ; print question
    MOV AH, 09H
    INT 21H

    MOV DX, [SI+2]      ; print choice A
    MOV AH, 09H
    INT 21H

    MOV DX, [SI+4]      ; print choice B
    MOV AH, 09H
    INT 21H

    MOV DX, [SI+6]      ; print choice C
    MOV AH, 09H
    INT 21H

    MOV DX, [SI+8]      ; print choice D
    MOV AH, 09H
    INT 21H

GET_VALID_ANSWER:
    CALL READ_ANSWER
    CALL VALIDATE_ANSWER

    CMP AL, 0
    JE GET_VALID_ANSWER

    MOV BL, AL                  ; BL = student answer letter
    MOV DI, [SI+10]             ; DI -> correct answer byte
    MOV AH, [DI]                ; AH = correct letter

    CMP BL, AH
    JE  EXAM_CORRECT

    ; ---- WRONG ANSWER ----
    CALL BEEP                   ; beep on wrong answer

    LEA DX, wrong_msg
    MOV AH, 09H
    INT 21H

    ; save this question entry to the wrong-answers arrays
    PUSH BX                     ; save student answer (in BL)

    MOV AL, wrong_count
    MOV AH, 0
    MOV BX, AX                  ; BX = wrong_count (0-based)

    SHL BX, 1                   ; BX = BX * 2  (word index)
    POP AX                      ; AX = student letter (was in BL, pushed as BX)
    MOV DL, AL                  ; DL = student letter (low byte of saved BX)

    MOV wrong_q_ptr[BX], SI     ; store question entry pointer

    SHR BX, 1
    MOV wrong_q_ans[BX], DL    ; store student answer byte

    INC wrong_count
    JMP EXAM_NEXT

EXAM_CORRECT:
    LEA DX, correct_msg
    MOV AH, 09H
    INT 21H
    INC score

EXAM_NEXT:
    POP SI
    ADD SI, 12          ; next question entry (6 words = 12 bytes)
    POP CX
    LOOP EXAM_LOOP

    ; ---- print score ----
    LEA DX, div_line
    MOV AH, 09H
    INT 21H

    LEA DX, score_msg
    MOV AH, 09H
    INT 21H
    MOV AX, score
    CALL PRINT_NUM
    LEA DX, out_of_msg
    MOV AH, 09H
    INT 21H

    CALL PRINT_GRADE

    ; print wrong-answers review after each attempt
    CALL PRINT_REVIEW

    RET
DO_EXAM ENDP

; ============================================================
; SHOW_INSTRUCTIONS
; ============================================================
SHOW_INSTRUCTIONS PROC
    LEA DX, inst1
    MOV AH, 09H
    INT 21H

    LEA DX, inst2
    MOV AH, 09H
    INT 21H

    LEA DX, inst3
    MOV AH, 09H
    INT 21H

    LEA DX, inst4
    MOV AH, 09H
    INT 21H

    LEA DX, inst5
    MOV AH, 09H
    INT 21H

    LEA DX, inst6
    MOV AH, 09H
    INT 21H

    MOV AH, 01H         ; wait for any key
    INT 21H

    RET
SHOW_INSTRUCTIONS ENDP


SHOW_MENU PROC

MENU_START:
    LEA DX, menu_msg
    MOV AH, 09H
    INT 21H

    LEA DX, menu1
    MOV AH, 09H
    INT 21H

    LEA DX, menu2
    MOV AH, 09H
    INT 21H

    LEA DX, menu3
    MOV AH, 09H
    INT 21H

    LEA DX, menu_choose
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, '1'
    JE MENU_START_EXAM

    CMP AL, '2'
    JE MENU_INSTRUCTIONS

    CMP AL, '3'
    JE MENU_EXIT

    JMP MENU_START

MENU_INSTRUCTIONS:
    CALL SHOW_INSTRUCTIONS
    JMP MENU_START

MENU_START_EXAM:
    RET

MENU_EXIT:
    JMP END_PROGRAM

SHOW_MENU ENDP

; ============================================================
; MAIN
; ============================================================
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV BX, 2000H
    MOV SS, BX

    ; ----- Welcome Banner -----
    LEA DX, welcome_msg
    MOV AH, 09H
    INT 21H
    LEA DX, welcome_msg2
    MOV AH, 09H
    INT 21H
    LEA DX, welcome_msg3
    MOV AH, 09H
    INT 21H

    ; ----- Get Name -----
    LEA DX, get_name
    MOV AH, 09H
    INT 21H

    LEA DX, array
    MOV AH, 0AH
    INT 21H

    ; ----- Print "Welcome, <name>" -----
    LEA DX, welcome
    MOV AH, 09H
    INT 21H

    LEA DX, array+2
    MOV AH, 09H
    INT 21H
    
    CALL SHOW_MENU

    ; ----- Ready? -----
    LEA DX, ready_msg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, 'Y'
    JE  ATTEMPT_ONE
    CMP AL, 'y'
    JE  ATTEMPT_ONE
    JMP END_PROGRAM

; ===== ATTEMPT 1 - GROUP 1 =====
ATTEMPT_ONE:
    LEA DX, start_msg
    MOV AH, 09H
    INT 21H

    LEA SI, G1Table
    CALL DO_EXAM        ; score + BEEP + REVIEW all handled inside

    CMP score, 6
    JGE STUDENT_PASSED

    LEA DX, fail_msg
    MOV AH, 09H
    INT 21H

    LEA DX, att2_msg
    MOV AH, 09H
    INT 21H

; ===== ATTEMPT 2 - GROUP 2 =====
ATTEMPT_TWO:
    LEA SI, G2Table
    CALL DO_EXAM

    CMP score, 6
    JGE STUDENT_PASSED

    LEA DX, fail_msg
    MOV AH, 09H
    INT 21H

    LEA DX, att3_msg
    MOV AH, 09H
    INT 21H

; ===== ATTEMPT 3 - GROUP 3 =====
ATTEMPT_THREE:
    LEA SI, G3Table
    CALL DO_EXAM

    CMP score, 6
    JGE STUDENT_PASSED

    LEA DX, fail_msg
    MOV AH, 09H
    INT 21H

    LEA DX, no_more_msg
    MOV AH, 09H
    INT 21H

    JMP END_PROGRAM

STUDENT_PASSED:
    LEA DX, pass_msg
    MOV AH, 09H
    INT 21H

END_PROGRAM:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN