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
    mraa_result_t result;
    mraa_gpio_context gpio;
    int value;

    mraa_init();
    
    if (ac != 3) {
        fprintf(stderr, "Usage: %s pin_number\n"        \
               "\nExample: %s 7 -> Read pin 7\n"
               , av[0], av[0]);
        return -1;
    }

    iopin = atoi(av[1]);

    /* Initialisation of pin */
    gpio = mraa_gpio_init(iopin);
    if (gpio == NULL) {
        fprintf(stderr, "[-] Initialisation of pin %d failed. Is this pin exist on your platform?\n", iopin);
        return -1;
    }

    /* Set GPIO direction */
    result = mraa_gpio_dir(gpio, MRAA_GPIO_IN);
    if (result != MRAA_SUCCESS) {
        mraa_result_print(result);
        return -1;
    }

    value = mraa_gpio_read(gpio);
    if (result != MRAA_SUCCESS)
        mraa_result_print(result);
    printf("%d", value);
    return 0;
}
