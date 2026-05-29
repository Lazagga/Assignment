#include <stdio.h>

int main(void) {
    int data[] = {3, 5, -2, 4, 6, -1, 2, 8, 0, 100, 7};
    int n = (int)(sizeof(data) / sizeof(data[0]));

    int max_sum = 0;
    int max_start = -1;
    int max_end = -1;

    int current_sum = 0;
    int current_start = -1;

    for (int i = 0; i < n; i++) {
        if (data[i] == 0) {
            break; /* Sentinel: values after 0 are ignored. */
        }

        if (data[i] > 0) {
            if (current_start == -1) {
                current_start = i;
                current_sum = 0;
            }
            current_sum += data[i];

            if (current_sum > max_sum) {
                max_sum = current_sum;
                max_start = current_start;
                max_end = i;
            }
        } else {
            current_start = -1;
            current_sum = 0;
            continue; /* Negative values separate positive segments. */
        }
    }

    printf("max_sum = %d\n", max_sum);
    printf("start = %d\n", max_start);
    printf("end = %d\n", max_end);
    return 0;
}
