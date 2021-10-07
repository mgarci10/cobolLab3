       IDENTIFICATION DIVISION.
       PROGRAM-ID. LAB3.
       AUTHOR. MARIO GARCIA.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE   ASSIGN TO 'DA-S-INPUT'
                   ORGANIZATION IS LINE SEQUENTIAL.
           SELECT PRNT-FILE    ASSIGN TO 'UR-S-PRNT'
                   ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.
       FD  INPUT-FILE.
       01 INPUT-REC.
        88 EOF VALUE HIGH-VALUES.
        02 EMP-NAME PIC X(20).
        02 EMP-DEGREE PIC X(4).
        02 EMP-YEAR PIC 9(4).
        02 LOAN-AMT PIC 9(5)V99.
        02 LOAN-PAID-1 PIC 9(4)V99.
        02 LOAN-PAID-2 PIC 9(4)V99.
        02 LOAN-PAID-3 PIC 9(4)V99.
        02 LOAN-PAID-4 PIC 9(4)V99.
        02 FILLER PIC X(21) VALUE SPACES.

       FD PRNT-FILE.
       01 PRNT-REC PIC X(200).

       WORKING-STORAGE SECTION.
       01 PRNT-HEADING.
        02 FILLER PIC X(4) VALUE "NAME".
        02 FILLER PIC X(22) VALUE SPACES.
        02 FILLER PIC X(6) VALUE "DEGREE".
        02 FILLER PIC X(4) VALUE SPACES.
        02 FILLER PIC X(4) VALUES "YEAR".
        02 FILLER PIC X(3) VALUE SPACES.
        02 FILLER PIC X(4) VALUE "LOAN".
        02 FILLER PIC X(7) VALUE SPACES.
        02 FILLER PIC X(5) VALUE "PAID1".
        02 FILLER PIC X(5) VALUE SPACES.
        02 FILLER PIC X(5) VALUE "PAID2".
        02 FILLER PIC X(5) VALUE SPACES.
        02 FILLER PIC X(5) VALUE "PAID3".
        02 FILLER PIC X(5) VALUE SPACES.
        02 FILLER PIC X(5) VALUE "PAID4".
        02 FILLER PIC X(5) VALUE SPACES.
        02 FILLER PIC X(8) VALUE "TOT PAID".
        02 FILLER PIC X(3) VALUE SPACES.
        02 FILLER PIC X(7) VALUE "BALANCE".

       01 PRNT-DATA.
        02 PRN-EMP-NAME PIC X(20).
        02 FILLER PIC X(6) VALUE SPACES.
        02 PRN-EMP-DEGREE PIC X(4).
        02 FILLER PIC X(6) VALUE SPACES.
        02 PRN-EMP-YEAR PIC 9(4).
        02 FILLER PIC X(3) VALUE SPACES.
        02 PRN-LOAN-AMT PIC 9(5).99.
        02 FILLER PIC X(3) VALUE SPACES.
        02 PRN-LOAN-PAID-1 PIC 9(4).99.
        02 FILLER PIC X(3) VALUE SPACES.
        02 PRN-LOAN-PAID-2 PIC 9(4).99.
        02 FILLER PIC X(3) VALUE SPACES.
        02 PRN-LOAN-PAID-3 PIC 9(4).99.
        02 FILLER PIC X(3) VALUE SPACES.
        02 PRN-LOAN-PAID-4 PIC 9(4).99.
        02 FILLER PIC X(3) VALUE SPACES.
        02 PRN-TOT-PAID PIC 9(5).99.
        02 FILLER PIC X(3) VALUE SPACES.
        02 PRN-BALANCE PIC 9(5).99.

       01 PRNT-CALCULATIONS.
        02 TOT-PAID PIC 9(7).
        02 BALANCE PIC 9(7).

       PROCEDURE DIVISION.
       MAIN.
       OPEN INPUT INPUT-FILE
       OUTPUT PRNT-FILE.

       READ INPUT-FILE INTO INPUT-REC
               AT END SET EOF TO TRUE
               END-READ
       PERFORM PRINT-HEADING

       PERFORM UNTIL EOF
          PERFORM PRINT-INFORMATION
          READ INPUT-FILE INTO INPUT-REC
            AT END SET EOF TO TRUE
          END-READ
       END-PERFORM

       CLOSE INPUT-FILE, PRNT-FILE
       STOP RUN.

        PRINT-HEADING.
          WRITE PRNT-REC FROM PRNT-HEADING
           AFTER ADVANCING PAGE.
           MOVE SPACES TO PRNT-REC.
           WRITE PRNT-REC AFTER ADVANCING 1 LINE.

        PRINT-INFORMATION.
          MOVE EMP-NAME TO PRN-EMP-NAME
          MOVE EMP-DEGREE TO PRN-EMP-DEGREE
          MOVE EMP-YEAR TO PRN-EMP-YEAR
          MOVE LOAN-AMT TO PRN-LOAN-AMT
          MOVE LOAN-PAID-1 TO PRN-LOAN-PAID-1
          MOVE LOAN-PAID-2 TO PRN-LOAN-PAID-2
          MOVE LOAN-PAID-3 TO PRN-LOAN-PAID-3
          MOVE LOAN-PAID-4 TO PRN-LOAN-PAID-4

          PERFORM CALC-TOT-AND-BAL
          MOVE TOT-PAID TO PRN-TOT-PAID
          MOVE BALANCE TO PRN-BALANCE

          WRITE PRNT-REC FROM PRNT-DATA
          AFTER ADVANCING 1 LINE.

       CALC-TOT-AND-BAL.
          COMPUTE TOT-PAID = LOAN-PAID-1 + LOAN-PAID-2 + LOAN-PAID-3 +
           LOAN-PAID-4
          COMPUTE BALANCE = LOAN-AMT - TOT-PAID.
