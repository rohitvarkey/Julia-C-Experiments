#include "test1.h"
#include <stdio.h>
#include <stdlib.h>

struct foo* create_foo(int bar, float car)
{
    struct foo *new = (struct foo *)malloc(sizeof(struct foo));
    new->bar = bar;
    new->car = car;
}

void print_foo(struct foo *a)
{
    printf("%d %f\n", a->bar, a->car);
}

float sum(struct foo bar){
    return bar.bar + bar.car;
}
