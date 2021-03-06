#include "saddle_points.h"
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MAX_COLUMNS 255
#define MAX_POINTS 10

static uint8_t get_row_max(uint8_t columns, uint8_t row[columns]) {
  uint8_t max = 0;
  for (size_t i = 0; i < columns; i++) {
    if (row[i] > max) {
      max = row[i];
    }
  }
  return max;
}

static uint8_t get_column_min(uint8_t column, uint8_t rows, uint8_t columns, uint8_t matrix[rows][columns]) {
  uint8_t min = MAX_COLUMNS;
  for (size_t i = 0; i < rows; i++) {
    if (matrix[i][column] < min) {
      min = matrix[i][column];
    }
  }
  return min;
}

saddle_points_t *saddle_points(size_t rows, size_t columns, uint8_t matrix[rows][columns]) {
  if (rows > MAX_COLUMNS || columns > MAX_COLUMNS) goto error;
  size_t count = 0;
  saddle_point_t points[MAX_POINTS];

  uint8_t ROW_MAX[MAX_COLUMNS];
  uint8_t COLUMN_MIN[MAX_COLUMNS];

  for (size_t i = 0; i < rows; i++) {
    ROW_MAX[i] = get_row_max(columns, matrix[i]);
  }
  for (size_t i = 0; i < columns; i++) {
    COLUMN_MIN[i] = get_column_min(i, rows, columns, matrix);
  }

  for (size_t i = 0; i < rows; i++) {
    for (size_t j = 0; j < columns; j++) {
      if (matrix[i][j] == ROW_MAX[i] && matrix[i][j] == COLUMN_MIN[j]) {
        count++;
        if (count > MAX_POINTS) goto error;
        points[count - 1] = (saddle_point_t){ i + 1, j + 1 };
      }
    }
  }
  
  saddle_points_t *res = (saddle_points_t*)malloc(sizeof(saddle_points_t) + count * sizeof(saddle_point_t));
  if (!res) goto error;
  res->count = count;
  memcpy(res->points, points, count * sizeof(saddle_point_t));
  return res;
error:
  return NULL;
}

void free_saddle_points(saddle_points_t *points) {
  if (points) {
    free(points);
  }
}
