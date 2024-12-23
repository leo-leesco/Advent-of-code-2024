from enum import Enum
from dataclasses import dataclass


class Direction(Enum):
    N = 0
    E = 1
    S = 2
    W = 3

    @property
    def next(self):
        return Direction((self.value+1) % 4)


@dataclass
class Coordinates:
    x: int
    y: int
    d: Direction

    @property
    def next(self):
        if self.d == Direction.N:
            return Coordinates(self.x-1, self.y, self.d)
        if self.d == Direction.S:
            return Coordinates(self.x+1, self.y, self.d)
        if self.d == Direction.E:
            return Coordinates(self.x, self.y+1, self.d)
        if self.d == Direction.W:
            return Coordinates(self.x, self.y-1, self.d)

    @property
    def rotate(self):
        return Coordinates(self.x, self.y, self.d.next)


line = [""]
maze = []
c = 0
while line != []:
    line = list(input())
    if "^" in line:
        pos = Coordinates(c, line.index("^"), Direction.N)
        line[line.index("^")] = "X"
    c += 1
    maze.append(line)
maze.pop()

height = len(maze)
width = len(maze[0])


# invariant : we are on a valid cell (not on an obstacle and not out of bounds)
while 0 <= pos.x < height and 0 <= pos.y < width and 0 <= pos.next.x < height and 0 <= pos.next.y < width:
    if maze[pos.next.x][pos.next.y] == "#":
        pos = pos.rotate
    else:
        maze[pos.next.x][pos.next.y] = "X"
        pos = pos.next

# print(*map("".join, maze), sep='\n')
print(sum(line.count("X") for line in maze))
