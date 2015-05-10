/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

#include <stdio.h>
#include <unistd.h>
#include "mraa.h"

#define PIN 7

int main()
{
    int iopin = PIN;
    mraa_result_t result;
    mraa_gpio_context gpio;

    mraa_init();
    
    /* Initialisation of pin */
    gpio = mraa_gpio_init(iopin);
    if (gpio == NULL) {
        fprintf(stderr, "[-] Initialisation of pin %d failed. Is this pin exist on your platform?\n", iopin);
        return -1;
    }

    printf("[+] Pin %d is initialised\n", iopin);

    /* Set GPIO direction */
    result = mraa_gpio_dir(gpio, MRAA_GPIO_OUT);
    if (result != MRAA_SUCCESS)
        mraa_result_print(result);

    while (1) {

        /* Shut down the LED */
        result = mraa_gpio_write(gpio, 0);
        if (result != MRAA_SUCCESS)
            mraa_result_print(result);
        else
            printf("Off\n");


        usleep(500000);


        /* Light up the LED */
        result = mraa_gpio_write(gpio, 1);
        if (result != MRAA_SUCCESS)
            mraa_result_print(result);        
        else
            printf("On\n");


        usleep(500000);
    }
    return 0;
}
