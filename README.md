# Advent of code 2024

While waiting for Christmas, [Advent of code](https://adventofcode.com) is a very nice series of mini-coding challenges. The idea is to do one per day.

I will try to go as far as possible relying solely on OCaml to hone my functional programming skills, and if possible in [rhythm](https://www.youtube.com/watch?v=tZOdrbRKCrI) !

## Usage of programs

Arguably the easiest way to do so is to call each self-contained program with :
```shell
ocaml Day<n>.ml
```

Special cases are listed below.

### Day 3

Pass the sequence of instructions directly as a parameter :
```fish
ocaml Day3.ml 'your commands'
ocaml Day3.ml $(cat file | string collect)
```

Note the use of single quote to avoid variable interpolation (when using `fish`) and `string collect` to pass the actual content of `file` and not multiple lines (as there might be line breaks in the puzzle input).

## Examples of input

### Day 1

```
3   4
4   3
2   5
1   3
3   9
3   3
```

### Day 2

```
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
```
