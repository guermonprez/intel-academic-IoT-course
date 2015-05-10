/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

#include <stdio.h>
#include <unistd.h>
#include "mraa/aio.h"

#define ANALOG_PIN 0

int main()
{
    mraa_aio_context adc;
    uint16_t value;

    /* Init Pin */
    adc = mraa_aio_init(ANALOG_PIN);
    if (adc == NULL) {
        fprintf(stderr, "[-] Cannot init pin %d\n", ANALOG_PIN);
        return (1);
    }
    
    while (1) {
        /* Read the value on the Pin */
	sleep(1);
        value = mraa_aio_read(adc);
        fprintf(stdout, "Pin A%d received %hu\n", ANALOG_PIN, value);
    }

    mraa_aio_close(adc);

    return 0;
}
