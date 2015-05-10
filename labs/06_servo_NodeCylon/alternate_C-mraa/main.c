#include <unistd.h>

#include "mraa.h"

int
main (int ac, char **av)
{
    mraa_init();
//! [Interesting]
    mraa_pwm_context pwm;
    pwm = mraa_pwm_init(3);
    if (pwm == NULL) {
	printf("Cannot init pwm\n");
        return 1;
    }

    float value = 0.0f;

    mraa_pwm_period_us(pwm, 200);
    mraa_pwm_enable(pwm, 1);

    int period = 0;

    while (1) {
        /* mraa_pwm_period_us(pwm, atoi(av[1]) * 1000); */
        /* mraa_pwm_enable(pwm, 1); */
         /* period += 10; */

        value = value + 0.01f;
        mraa_pwm_write(pwm, value);
        printf ("value %f & period %d\n", value, period);
        if (value >= 1.0f) {
            value = 0.0f;
            printf ("set to 0\n");
        }
        float output = mraa_pwm_read(pwm);
        printf("output = %f\n", output);
    }
//! [Interesting]
    return 0;
}
