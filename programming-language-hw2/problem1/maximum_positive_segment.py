data = [3, 5, -2, 4, 6, -1, 2, 8, 0, 100, 7]

max_sum = 0
max_start = -1
max_end = -1

current_sum = 0
current_start = None

for index, value in enumerate(data):
    if value == 0:
        break

    if value <= 0:
        current_sum = 0
        current_start = None
        continue

    if current_start is None:
        current_start = index
        current_sum = 0

    current_sum += value

    # Use only ">" so the first segment wins when sums are equal.
    if current_sum > max_sum:
        max_sum = current_sum
        max_start = current_start
        max_end = index

print(f"max_sum = {max_sum}")
print(f"start = {max_start}")
print(f"end = {max_end}")
