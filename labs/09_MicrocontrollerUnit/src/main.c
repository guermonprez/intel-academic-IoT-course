/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

#include "mcu_api.h"
#include "mcu_errno.h"
 
#define PORT 0
 
void mcu_main()
{
	/* Configure PWM and enable it */
	debug_print(DBG_INFO, "PWM loop : loading ...\n");
	int period = 10000000 ;
	int dutymin =  500000;
	int dutymax = 2000000;
	int increment = 50000;
	int duty = dutymin;

	while (1)
	{
		pwm_configure(PORT, duty, period);
		pwm_enable(PORT);
		mcu_sleep(50);

		debug_print(DBG_INFO, "PWM loop : %u\n",duty);
		duty = duty +  increment;
		if ( duty > dutymax) {
			duty = dutymin;
			debug_print(DBG_INFO, "Restarting at %u ...\n",dutymin);
			pwm_configure(PORT, duty, period);
			pwm_enable(PORT);
			mcu_sleep(100);
		}
	}
}
