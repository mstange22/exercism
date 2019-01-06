#include "leap.h"

bool leap::is_leap_year(const int year) {
  // return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  if (year % 4 != 0) {
    return false;
  }
  if (year % 100 != 0) {
    return true;
  }
  return year % 400 == 0;
}