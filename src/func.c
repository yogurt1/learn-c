#include <stdio.h>
#include "app.h"

void func(void)
{
  int arr[10] = {
    9921,
    8921,
    218421,
    25,
    9124,
    5215,
    91241,
    21521,
    21421,
    521521
  };
  printf("Before: %d %d %d...\n", arr[0], arr[1], arr[2]);
  long size = 10;
  int* result = sort(arr, size);
  printf("Result: %d %d %d...\n", result[0], result[1], result[2]);
}

int* sort(int* arr, long size)
{
  int x;
  for (int i = 0; i < size; i++) {
    for (int j = size-1; j > i; j--) {
      if (arr[j-1] > arr[j]) {
        x = arr[j-1];
        arr[j-1] = arr[j];
        arr[j] = x;
      }
    }
  }
  return arr;
}
