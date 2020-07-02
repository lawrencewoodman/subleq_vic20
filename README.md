subleq_vic20
============

A [SUBLEQ](https://techtinkering.com/articles/subleq-a-one-instruction-set-computer/ "SUBLEQ - A One Instruction Set Computer (OISC)") virtual machine for the Commodore VIC-20.


SUBLEQ
------
SUBLEQ is a computer architecture that has only one instruction: SUBLEQ.  The instruction stands for _SUbtract and Branch if Less than or EQual to zero_.  Because there is only one instruction, only the operands are specified, which consist of 3 memory addresses that are acted on as follows:

```` text
SUBLEQ a, b, c
Mem[b] := Mem[b] - Mem[a]
if (Mem[b] ≤ 0) goto c
````

To find out more, have a look at the article: [SUBLEQ - A One Instruction Set Computer (OISC)](https://techtinkering.com/articles/subleq-a-one-instruction-set-computer/) and its accompanying [video](https://www.youtube.com/watch?v=o0e7_U7ZmBM "SUBLEQ - A One Instruction Set Computer (OISC)").


Usage
-----

The SUBLEQ virtual machine is contained in the file `subleq.a65` which can be included into the file you want to run it from.  You need to define SL_MEM as a constant to point to where the program is in memory and then `jsr SL_run` to start the VM.  Please see the examples to see how this is done.


Examples
--------
There are number of example assembler files in `examples/`.

These can be assembled using the [XA](https://www.floodgap.com/retrotech/xa/) assembler from within `examples/`:

    $ xa -I .. -o fizzbuzz.prg fizzbuzz.a65

<dl>
  <dt>echo.a65</dt>
  <dd>Echos user input back to display.  Requires: Unexpanded Vic</dd>
  <dt>hello.a65</dt>
  <dd>Displays "HELLO, WORLD!".  Requires: Unexpanded Vic</dd>
  <dt>fizzbuzz.a65</dt>
  <dd>Plays Fizz Buzz up to 100.  Requires: Unexpanded Vic</dd>
  <dt>rock_paper_scissors.a65</dt>
  <dd>Play Rock, Paper, Scissors against the Vic.  Requires: 8k+</dd>
  <dt>sble.test.a65</dt>
  <dd>Tests the VM using the <code>sble</code> (SUBLEQ) instruction.  Requires: Unexpanded Vic</dd>
</dl>


Licence
-------
Copyright (C) 2020 Lawrence Woodman <lwoodman@vlifesystems.com>

This software is licensed under an MIT Licence.  Please see the file, [LICENCE.md](https://github.com/lawrencewoodman/subleq_vic20/blob/master/LICENCE.md), for details.
