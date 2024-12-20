line = "init"
grid = []
while line != "":
    line = input()
    grid.append(line)
grid.pop()


def look_around(i, j):
    """this function looks in a star-shaped pattern to see if, starting from character at (i,j) which should be "X", there is "XMAS" anywhere"""
    if grid[i][j] != "X":
        return 0
    c = 0

    # horizontal check
    if j <= len(grid[0])-4 and grid[i][j:j+4] == "XMAS":
        c += 1
    if j >= 3 and grid[i][j-3:j+1] == "SAMX":
        c += 1

    # vertical check
    if i <= len(grid)-4 and grid[i][j] == "X" and grid[i+1][j] == "M" and grid[i+2][j] == "A" and grid[i+3][j] == "S":
        c += 1
    if i >= 3 and grid[i][j] == "X" and grid[i-1][j] == "M" and grid[i-2][j] == "A" and grid[i-3][j] == "S":
        c += 1

    # positive diagonal check
    if i <= len(grid) - 4 and j <= len(grid[0]) - 4 and grid[i][j] == "X" and grid[i+1][j+1] == "M" and grid[i+2][j+2] == "A" and grid[i+3][j+3] == "S":
        c += 1
    if i >= 3 and j >= 3 and grid[i][j] == "X" and grid[i-1][j-1] == "M" and grid[i-2][j-2] == "A" and grid[i-3][j-3] == "S":
        c += 1
    # negative diagonal check
    if i <= len(grid) - 4 and j >= 3 and grid[i][j] == "X" and grid[i+1][j-1] == "M" and grid[i+2][j-2] == "A" and grid[i+3][j-3] == "S":
        c += 1
    if i >= 3 and j <= len(grid[0])-4 and grid[i][j] == "X" and grid[i-1][j+1] == "M" and grid[i-2][j+2] == "A" and grid[i-3][j+3] == "S":
        c += 1

    return c


print(sum(look_around(i, j) for i in range(len(grid))
      for j in range(len(grid[0]))))
