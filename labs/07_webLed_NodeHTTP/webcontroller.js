/* Author : Paul Guermonprez 2015, Nicolas Vailliet 2014
 * paul.guermonprez@intel.com
 * This work is licensed under a
 * Creative Commons Attribution-ShareAlike 3.0 Unported License.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

/**** indicate if led is on or off ****/
var ledstatus = "off";

var system = require('child_process').exec;
var mraa = require('mraa');

/*
 * About controlling galileo with a webpage
 */
function startServer()
{
	console.log("Digital pin 7 ...");
	var pin = new mraa.Gpio(7);
	pin.dir(mraa.DIR_OUT);

	console.log("Starting web controller...");

	var http = require('http');
	http.createServer(function (req, res) {

		 function respond() {
			res.writeHead(200, { "Content-Type": "text/html" });
			res.write("<!DOCTYPE html><html><body>");		
			res.write("<h1>Intel Galileo web controller</h1>");
			res.write("</p><p>LED Status : ");
			res.write(ledstatus);
			res.write("</p><p>Actions</p>");
			res.write("<p><input type='button' onclick='location.pathname = \"/ledOn\"' value='Turn LED on'/></p>");
			res.write("<p><input type='button' onclick='location.pathname = \"/ledOff\"' value='Turn LED off'/></p>");
			res.write("</body></html>");
	  		res.end();
		}

		console.log("Request: " + req.url);

		if(req.url === "/ledOn") {
			pin.write(0);
    			ledstatus = "on";
			console.log("pin 7 on");
		}
		if(req.url === "/ledOff") {
			pin.write(1);
    			ledstatus = "off";
			console.log("pin 7 off");
		}


		respond();
  		
	}).listen(1337);
	console.log('Server running at http://your_board_IP:1337/');
}

/*
 * What we want to run
 */
console.log("Starting server");
startServer();



