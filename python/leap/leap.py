def is_leap_year(year):
  return False if year % 4 != 0 or (year % 100 == 0 and year % 400 != 0) else True
