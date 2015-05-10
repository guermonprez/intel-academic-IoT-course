/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

#include <stdio.h>
#include <stdlib.h>
#include "mraa/aio.h"

int main(int ac, char **av)
{
    mraa_aio_context adc;
    uint16_t value;
    int pinNumber;

    if (ac != 2) {
        fprintf(stderr, "Usage: %s Analog_pin_number\nExample: %s 0\n", av[0], av[0]);
        return -1;
    }

    pinNumber = atoi(av[1]);

    /* Init Pin */
    adc = mraa_aio_init(pinNumber);
    if (adc == NULL) {
        fprintf(stderr, "[-] Cannot init pin %d\n", pinNumber);
        return -1;
    }
    
    /* Read the value on the Pin */
    value = mraa_aio_read(adc);
    fprintf(stdout, "%hu\n", value);

    mraa_aio_close(adc);

    return 0;
}
