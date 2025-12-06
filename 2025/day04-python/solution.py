def solution_func(input_arr, remove_rolls):
    ROLL = '@'
    ROLL_THRES = 4
    MIN = 0
    MAX_ROW = len(input_arr) - 1
    MAX_COL = len(input_arr[0]) - 1

    total = 0
    for row in range(0, len(input_arr)):
        for col in range(0, len(input_arr[0])):
            if input_arr[row][col] != ROLL:
                continue

            roll_count = 0
            for i in range(row-1, row+2):
                for j in range(col-1, col+2):
                    if MIN <= i <= MAX_ROW and MIN <= j <= MAX_COL and not (i == row and j == col):
                        if input_arr[i][j] == ROLL:
                            roll_count += 1

            if roll_count < ROLL_THRES:
                if remove_rolls:
                    input_arr[row][col] = '.'
                
                total += 1
    
    return total

if __name__ == "__main__":
    input_file = "input.txt"
    input_arr = []
    with open(input_file, 'r') as f:
        for line in f:
            input_arr.append(list(line.strip()))

    # part 1
    rolls = solution_func(input_arr, False)
    print(rolls)

    # part 2
    prev = -1
    total = 0
    itr_count = 0
    while(prev != total):
        prev = total
        additional_rolls = solution_func(input_arr, True)
        total += additional_rolls
        itr_count += 1

    print(total)