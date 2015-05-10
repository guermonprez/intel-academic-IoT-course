/* Author : Paul Guermonprez 2015
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

#include <iostream>
#include <string>
#include <libusb-1.0/libusb.h>
#include <unistd.h>
#include <stdlib.h>

using namespace std;

int main(int argc, char *argv[]){

	if(argc < 3)
		cout << "Usage: binary servo_number target_value_usec" << endl;

	int servo = atoi(argv[1]);
	int value = atoi(argv[2]);
	
	libusb_context *ctx = NULL; 
	libusb_device_handle *handle;

	//specific to pololu card
 	uint16_t pid = 0x0089; 
	uint16_t vid = 0x1ffb;

	//error value	
	int r;
       
	r = libusb_init(&ctx);
	handle = libusb_open_device_with_vid_pid(ctx,vid,pid);
	
	r = libusb_detach_kernel_driver(handle,0);
	if(r < 0 && r != LIBUSB_ERROR_NOT_FOUND) {
		cout<<"Error: detach kernel driver failed"<<endl;
		return 1;
	}
	
	r = libusb_claim_interface(handle,0);

	r = libusb_control_transfer( 	handle,
					0x40,	//request type
					0x85,	//request
					4*value, //value
					servo,	//servo number
					NULL,
					0,
					5000	); 	
	r = libusb_release_interface(handle,0);
	libusb_close(handle); 	
	libusb_exit(ctx);
	return 0;
}


