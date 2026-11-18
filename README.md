# COA Exam System — Group 8

A menu-driven multiple-choice examination system written in **8086 assembly language** for the **Computer Organization and Architecture (COA)** course project by **Group 8**.

The program asks the student for a name, presents COA questions, evaluates answers, and displays a score, grade, and review of incorrect answers. A student can take up to three attempts, with a different question set on each attempt, until they pass.

## Project details

| Item | Description |
| --- | --- |
| Course | Computer Organization and Architecture (COA) |
| Team | Group 8 |
| Project | COA Exam System |
| Language | 16-bit x86 / 8086 assembly, MASM-style syntax |
| Interface | Text-based console |
| Source file | [`main.asm`](main.asm) |
| Runtime interface | DOS services through `INT 21H` |

## Objectives

- Apply registers, addressing modes, arithmetic, comparisons, and conditional branches to an interactive application.
- Use procedures, loops, and the stack to organize program execution.
- Store and retrieve questions using tables of memory offsets.
- Perform console input and output through DOS interrupts.
- Implement answer validation, score calculation, grading, and attempt management.

## Features

- Personalized welcome message using the student's name.
- Main menu with **Start Exam**, **View Instructions**, and **Exit** options.
- **30 predefined questions**, divided into three sets of 10.
- Case-insensitive answer validation for `A`, `B`, `C`, and `D`.
- Immediate feedback after each accepted answer.
- A BEL character emitted for an incorrect answer; audible behavior depends on the runtime.
- One point for each correct answer, with no negative marking.
- Final score and grade after every attempt.
- Review of incorrect answers showing the question, submitted letter, and correct letter.
- Automatic progression to the next question set after a failed attempt.
- Exit after passing or exhausting all three attempts.

## Question sets and attempt rules

| Attempt | Table | Questions | Topics |
| --- | --- | --- | --- |
| 1 | `G1Table` | 10 | Basic architecture, datapath, ALU, control units, RISC/CISC, and 8086 basics |
| 2 | `G2Table` | 10 | Pipelining, hazards, memory hierarchy, cache, virtual memory, and TLB |
| 3 | `G3Table` | 10 | I/O, DMA, interrupts, 8086 registers, stack, and address calculation |

The question sets run in a fixed order. They are not randomized or selectable from the menu. The `G1`, `G2`, and `G3` names identify question sets, while **Group 8** identifies the project team.

A score of **6 out of 10 or higher** passes the exam and ends the program. A score below 6 automatically starts the next attempt, if one remains. The score and wrong-answer count reset before each attempt; scores are not combined.

### Grading scale

| Score | Grade | Result |
| --- | --- | --- |
| 9–10 | Excellent | Pass |
| 8 | Very Good | Pass |
| 7 | Good | Pass |
| 6 | Pass | Pass |
| 0–5 | Fail | Next attempt, or exit after attempt 3 |

## Requirements

Use an 8086 development environment that supports MASM-style directives and the DOS `INT 21H` services used by the source. Possible setups include:

- **EMU8086**, with its editor, assembler, and emulator.
- **A DOS environment or emulator**, such as DOSBox, with a compatible 16-bit assembler and linker such as TASM/TLINK or a legacy MASM/LINK toolchain.

The repository contains source code only. It does not bundle an assembler, emulator, executable, or automated build script. Modern 64-bit Windows does not run this DOS program directly.

## Building and running

### Using EMU8086

1. Open `main.asm` in EMU8086.
2. Compile the source and inspect any assembler diagnostics.
3. Open the compiled program in the emulator and run it.
4. Interact with the program's console using the instructions below.

### Using TASM and TLINK in a DOS environment

Make the project directory and toolchain accessible inside the DOS environment. For example, in DOSBox, mount the project directory as a drive:

```dos
mount c "C:\Users\savy\Desktop\COA PROJECT"
c:
```

With `TASM` and `TLINK` available on the DOS `PATH`, assemble, link, and run:

```dos
tasm main.asm
tlink main.obj
main.exe
```

These are build instructions for a compatible toolchain, not a verified build record. Toolchain-specific diagnostics may require source adjustments. See the implementation notes below before relying on a DOS executable.

## How to use

1. Enter a short name and press **Enter**. The name buffer is configured with a maximum size of 10 bytes, including space for the terminating carriage return in DOS buffered input.
2. At the main menu, press:
   - **1** to start the exam.
   - **2** to read the instructions, then press any key to return to the menu.
   - **3** to exit.
3. At the readiness prompt, press **Y** or **y** to begin. Any other character exits the program.
4. For each question, type a single answer letter (`A`–`D` or `a`–`d`) and press **Enter**.
5. Read the immediate feedback, then continue through all 10 questions.
6. Review the score, grade, and incorrect answers. If the score is below 6, the next attempt begins automatically.

**Input behavior:** Name and answer entry use buffered input and require Enter. Menu choices, readiness confirmation, and the instructions pause use single-character input; press only the requested key at those prompts to avoid leaving an extra Enter in the input buffer.

### Illustrative result

The following shows selected output for a passing attempt; it is not a captured execution log:

```text
Your Score : 8 out of 10
Grade: VERY GOOD! Well done! :)
-------------------------------------
===== WRONG ANSWERS REVIEW =====
Question #1
Q4) Which register holds the address of the next instruction?
  Your Answer  : A
  Correct Ans  : C
Question #2
Q6) CISC processors typically have:
  Your Answer  : A
  Correct Ans  : C
-------------------------------------
Congratulations! You PASSED :)
```

In the review, `Question #1`, `Question #2`, and so on count the incorrect entries. The question text retains its original exam number, such as `Q4`.

## Program flow

```text
Start → Initialize segments → Read name → Show main menu
                                           |
                     +---------------------+--------------------+
                     |                     |                    |
                 Start Exam          Instructions             Exit
                     |                     |
                Ready? Y/y           Return to menu
                     |
               Attempt 1: G1
                     |
            Score → Grade → Review
                     |
              Pass? ── Yes → Exit
                     |
                     No
                     |
               Attempt 2: G2
                     |
            Score → Grade → Review
                     |
              Pass? ── Yes → Exit
                     |
                     No
                     |
               Attempt 3: G3
                     |
            Score → Grade → Review
                     |
           Show final pass/fail → Exit
```

## Implementation

### Memory organization

The source declares `.MODEL SMALL`, `.STACK 100H` (256 bytes), `.DATA`, and `.CODE`. `DS` is initialized from `@DATA`. Display strings use `$` terminators for DOS string output, and most begin with carriage-return and line-feed bytes (`0DH`, `0AH`).

Each question-table entry contains **six words**, occupying **12 bytes**:

| Byte offset | Stored value |
| --- | --- |
| `+0` | Offset of question text |
| `+2` | Offset of option A |
| `+4` | Offset of option B |
| `+6` | Offset of option C |
| `+8` | Offset of option D |
| `+10` | Offset of the correct-answer byte |

`SI` points to the current entry. After processing a question, the exam procedure advances it by 12 bytes. The correct answer is stored separately as a letter such as `DB 'B'`.

### Main procedures

| Procedure | Responsibility |
| --- | --- |
| `MAIN` | Initializes segments, welcomes the student, and controls attempts and termination |
| `SHOW_MENU` | Handles menu selection |
| `SHOW_INSTRUCTIONS` | Displays exam rules and waits for a key |
| `DO_EXAM` | Runs one 10-question set, evaluates answers, stores errors, and displays results |
| `READ_ANSWER` | Reads buffered input and returns its first character in `AL` |
| `VALIDATE_ANSWER` | Converts lowercase letters to uppercase and accepts only A–D; returns zero for invalid input |
| `PRINT_NUM` | Prints values from 0 to 10 |
| `PRINT_GRADE` | Selects the grade message using `score` |
| `PRINT_REVIEW` | Displays stored incorrect answers and their correct letters |
| `BEEP` | Outputs ASCII BEL (`07H`) |

### State and wrong-answer storage

| Variable | Purpose |
| --- | --- |
| `score` | Word-sized score for the current attempt |
| `wrong_count` | Number of incorrect answers in the current attempt |
| `wrong_q_ptr` | Ten word-sized pointers to incorrect question-table entries |
| `wrong_q_ans` | Ten bytes storing the student's corresponding answer letters |
| `array` | Buffered name input |
| `ans_buf` | Buffered answer input |

The review retrieves the question text and correct answer through the saved table-entry pointer. If no answers are wrong, it prints a congratulatory message instead of an error list.

### DOS services used

All of these services are invoked through `INT 21H`:

| `AH` | Service | Usage |
| --- | --- | --- |
| `01H` | Read a character with echo | Menu, readiness prompt, and instructions pause |
| `02H` | Write the character in `DL` | Numeric output, answer letters, and BEL |
| `09H` | Write a `$`-terminated string at `DS:DX` | Messages, questions, and options |
| `0AH` | Buffered keyboard input at `DS:DX` | Name and answer entry |
| `4CH` | Terminate program | Program exit |

## Current limitations and implementation notes

- **Stack initialization needs verification:** `MAIN` explicitly changes `SS` to `2000H` without establishing a matching `SP` or allocating that segment. This can conflict with the stack provided by a DOS executable loader and may cause failures in calls, interrupts, or returns. Verify and correct stack initialization for the chosen runtime before treating the executable as reliable.
- **Answer validation checks only the first character.** The buffered input length is not checked, so a multi-character entry beginning with A–D may be accepted. An empty entry is rejected and prompts again.
- **Invalid answers silently prompt again.** There is no dedicated validation-error message.
- **Name handling is minimal.** The program does not check for an empty name or explicitly replace the input carriage return with a `$` terminator; it relies on the buffer's prefilled `$` bytes when displaying the name.
- **Results exist only in memory.** There is no file storage, database, login, timer, or session history.
- **Review shows answer letters and question text.** It does not repeat the options or explain the answer.
- **Attempts use fixed question sets.** There is no shuffle, question selection, or confirmation before a retry.
- **Runtime verification is pending.** This README was checked against the source; no successful assembly or emulator execution is claimed.

## Manual verification checklist

Use these cases when validating the program in the selected assembler and emulator:

| Case | Expected behavior |
| --- | --- |
| Open instructions with menu option 2 | Instructions appear; a key returns to the menu |
| Select menu option 3 | Program terminates |
| Enter a menu character other than 1–3 | Menu is displayed again |
| Answer readiness with `Y` or `y` | First question set begins |
| Use another readiness character | Program terminates |
| Submit lowercase answers | They are evaluated as their uppercase equivalents |
| Submit an invalid answer such as `E` or `1` | Current answer prompt repeats without changing the score |
| Score 10/10 | Excellent grade, all-correct review message, and pass message |
| Score exactly 6/10 | Pass grade and termination after the review |
| Score 5/10 on attempt 1 | Failed attempt followed by question set 2 |
| Fail attempts 1 and 2 | Question set 3 begins with score and error count reset |
| Fail attempt 3 | Final failure and no-more-attempts messages, then termination |
| Submit incorrect answers | Review contains the corresponding questions, submitted letters, and correct letters |

For a deterministic first-attempt 10/10 check, the answer sequence stored in `G1Table` is:

```text
B A A C B C B C B B
```

## Repository structure

```text
COA PROJECT/
├── main.asm     # Question bank, data, procedures, and program entry point
└── README.md    # Project documentation
```

## Possible enhancements

- Correct and verify stack setup across the intended runtimes.
- Validate exact answer length and improve name handling.
- Add clear messages for invalid input.
- Randomize questions or allow topic selection.
- Save scores and student details to a file.
- Include answer explanations in the review.
- Add a timer and a summary of all attempts.

## Credits

Developed as the **Computer Organization and Architecture course project by Group 8**.

Member names, roll numbers, institution, and faculty details can be added here for the final submission.
