#include <stdio.h>
#include <stdbool.h>

typedef struct {
    int threshold;
    bool (*test)(void *self, int value);
} Predicate;

typedef struct {
    int count;
    int (*apply)(void *self, int value);
} Transformer;

bool greater_than(void *self, int value) {
    Predicate *predicate = (Predicate *)self;
    return value > predicate->threshold;
}

Predicate make_greater_than(int threshold) {
    Predicate predicate = {threshold, greater_than};
    return predicate;
}

int double_value(void *self, int value) {
    Transformer *transformer = (Transformer *)self;
    transformer->count++;
    return value * 2;
}

Transformer make_transformer(void) {
    Transformer transformer = {0, double_value};
    return transformer;
}

int process(int data[], int length, Predicate *predicate, Transformer *transformer) {
    int sum = 0;

    for (int i = 0; i < length; i++) {
        if (predicate->test(predicate, data[i])) {
            sum += transformer->apply(transformer, data[i]);
        }
    }

    return sum;
}

int get_count(Transformer *transformer) {
    return transformer->count;
}

int main(void) {
    int data[] = {3, -1, 4, 0, -2, 5, 8};
    int length = (int)(sizeof(data) / sizeof(data[0]));

    Predicate predicate = make_greater_than(2);
    Transformer transformer = make_transformer();

    int result = process(data, length, &predicate, &transformer);
    int count = get_count(&transformer);

    printf("result = %d\n", result);
    printf("count = %d\n", count);
    return 0;
}
