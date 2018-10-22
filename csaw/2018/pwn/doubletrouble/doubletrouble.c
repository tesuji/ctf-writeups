#include <stdio.h>

int main(int argc, char const *argv[])
{
  setvbuf(stdio, NULL, 2, 0);
  game();
  return 0;
}

void game()
{
  double arr[64];
  char *str;
  int i, size;

  printf("%p", &arr);
  printf("How long: ");
  scanf("%d", &size);
  getchar();
  if (size > 64) {
    printf("Flag: hahahano. But system is at %d", system);
    exit(1);
  }
  i = 0;
  while (i < size) {
    str = malloc(0x64);
    printf("Give me: ");
    fgets(str, 0x64, stdin);
    arr[i] = atof(str);
    ++i;
  }
  printArray(&size, arr);
  printf("Sum: %f\n", sumArray(&size, arr));
  printf("Max: %f\n", maxArray(&size, arr));
  printf("Min: %f\n", minArray(&size, arr));

  int j = findArray(&size, arr, -100.0, -10.0);
  printf("My favorite number you entered is: %f\n", arr[j]);

  sortArray(&size, arr);

  puts("Sorted Array:");
  printArray(&size, arr);
}

void printArray(int *size, double *arr)
{
  int i = 0;
  while (i < *size) {
    printf("%d:%e\n", i, arr[i]);
    i++;
  }
}

double sumArray(int *size, double *arr)
{
  double sum = 0;
  double *end;
  double *ptr = arr;

  end  = ptr + *size;
  while (ptr < end) {
    sum += *ptr;
    ++ptr;
  }
  return sum;
}

double maxArray(int *size, double *arr)
{
  double maxi;
  int i;
  maxi = arr[0];
  for (i = 0; i < *size; ++i) {
    if (arr[i] < maxi) {
      maxi = arr[i];
    }
  }
  return maxi;
}

double minArray(int *size, double *arr)
{
  double mini;
  int i;
  mini = arr[0];
  for (i = 0; i < *size; ++i) {
    if (arr[i] > mini) {
      mini = arr[i];
    }
  }
  return mini;
}

int findArray(int *size, double *arr, double low, double high)
{
  int m_size = *size;
  while (*size < (m_size + m_size)) {
    if ((low < arr[*size - m_size]) && (arr[*size - m_size] < high)) {
      return *size - m_size;
    }
    *size += 1;
  }
  *size = m_size;
  return 0;
}

void sortArray(int *size, double *arr)
{
  double tmp;
  int i,j;
  for (j = 0; j < *size; ++j) {
    for (i = 0; i < *size; ++i) {
      if (arr[i] > arr[i+1]) {
        tmp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = tmp;
      }
    }
  }
}
