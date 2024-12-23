# Advent of code 2024

While waiting for Christmas, [Advent of code](https://adventofcode.com) is a very nice series of mini-coding challenges. The idea is to do one per day.

I will try to go as far as possible relying solely on OCaml to hone my functional programming skills, and if possible in [rhythm](https://www.youtube.com/watch?v=tZOdrbRKCrI) ! There are some cases where I don't see a nice functional approach to solving the problem, in this case I will rely on Python.

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

### Day 4

The simplest way to execute the script on arbitrary input is to run the following command :
```zsh
(cat file ; echo) | python3 Day4.py
```

In fish :
```fish
begin; cat file; echo; end | python3 Day4.py
```

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

### Day 3

```
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
```

### Day 4

```
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
```

### Day 5

```
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
```

### Day 6

```
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
```
