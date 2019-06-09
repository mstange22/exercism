#include "binary.h"
#include <string.h>
#include <math.h>

int convert(char *s)
{
  int res = 0;
  int length = strlen(s);
  for (int i = length - 1; i >= 0; i--)
  {
    if (s[i] == '1') {
      res += pow(2, length - 1 - i);
    } else if (s[i] != '0') {
      return INVALID;
    }
  }
  return res;
}
