#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#include <stdlib.h>

#define MAX_VALUES 10

typedef int buffer_value_t;
typedef struct circular_buffer_t {
  buffer_value_t values[MAX_VALUES];
  size_t oldest_index;
  size_t size;
  size_t capacity;
} circular_buffer_t;

circular_buffer_t *new_circular_buffer(size_t capacity);
int16_t read(circular_buffer_t *buffer, buffer_value_t *value);
int16_t write(circular_buffer_t *buffer, buffer_value_t value);
int16_t overwrite(circular_buffer_t *buffer, buffer_value_t value);
void clear_buffer(circular_buffer_t *buffer);
void delete_buffer(circular_buffer_t *buffer);

#endif
