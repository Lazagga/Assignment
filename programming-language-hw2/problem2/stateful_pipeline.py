data = [3, -1, 4, 0, -2, 5, 8]


def make_greater_than(threshold):
    def predicate(value):
        return value > threshold

    return predicate


def make_transformer():
    count = 0

    def transformer(value):
        nonlocal count
        count += 1
        return value * 2

    transformer.get_count = lambda: count
    return transformer


def process(data, predicate, transformer):
    total = 0
    for value in data:
        if predicate(value):
            total += transformer(value)
    return total


def get_count(transformer):
    return transformer.get_count()


predicate = make_greater_than(2)
transformer = make_transformer()

result = process(data, predicate, transformer)
count = get_count(transformer)

print(f"result = {result}")
print(f"count = {count}")
