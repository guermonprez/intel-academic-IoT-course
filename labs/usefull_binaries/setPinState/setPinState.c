/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

#include <stdio.h>
#include <unistd.h>
#include "mraa.h"

int main(int ac, char **av)
{
    int iopin;
    int state;
    mraa_result_t result;
    mraa_gpio_context gpio;

    mraa_init();
    
    if (ac != 3) {
        fprintf(stderr, "Usage: %s pin_number pin_state\n"       \
               "\nExample: %s 7 1 -> Enable pin 7\n"
               , av[0], av[0]);
        return -1;
    }

    iopin = atoi(av[1]);
    state = atoi(av[2]);

    if (state != 0 && state != 1) {
        fprintf(stderr, "Bad state number. Enter value 0 or 1\n");
        return -1;
    }

    /* Initialisation of pin */
    gpio = mraa_gpio_init(iopin);
    if (gpio == NULL) {
        fprintf(stderr, "[-] Initialisation of pin %d failed. Is this pin exist on your platform?\n", iopin);
        return -1;
    }

    /* Set GPIO direction */
    result = mraa_gpio_dir(gpio, MRAA_GPIO_OUT);
    if (result != MRAA_SUCCESS) {
        mraa_result_print(result);
        return -1;
    }

    result = mraa_gpio_write(gpio, state);
    if (result != MRAA_SUCCESS)
        mraa_result_print(result);

    return 0;
}
