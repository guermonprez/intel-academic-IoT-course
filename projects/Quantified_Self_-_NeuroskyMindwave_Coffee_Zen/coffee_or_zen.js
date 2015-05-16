var Cylon = require('cylon');
var Twitter = require('twitter');
var Sleep = require('sleep');
var exec = require('child_process').exec;

console.log("rfkill unblock bluetooth");
exec('rfkill unblock bluetooth', function (error, stdout, stderr) {});
console.log("rfcomm bind 0 74:E5:43:D5:77:AA 1");
exec('rfcomm bind 0 74:E5:43:D5:77:AA 1', function (error, stdout, stderr) {});

Cylon.robot({


	connections: {
		neurosky: { adaptor: 'neurosky', port: '/dev/rfcomm0'  },
	edison: { adaptor: 'intel-iot' }
	},

	devices: {
		button: { driver: 'button', pin: 7, connection: 'edison' },
	neurosky: { driver: 'neurosky',connection: 'neurosky' },
	servoMeditation: { driver: 'servo', pin: 5,connection: 'edison'  },
	servoAttention: { driver: 'servo', pin: 3,connection: 'edison'  },
	    led: { driver: 'direct-pin', pin: 8,connection: 'edison' }
	},

	work: function(my) {
		var scoreMeditation = 0;
		var numMeditation = 0;
		var scoreAttention  = 0;
		var numAttention  = 0;

		// optimal angles
		var minAngleMed = 20 ;
		var maxAngleMed = 160 ;
		var minAngleAtt = 50 ;
		var medAngleAtt = 90 ;
		var maxAngleAtt = 160 ;

		console.log("Testing meditation servo ...");
		for (var i=0;i<10;i++) {
			my.led.digitalWrite(0);
			my.servoMeditation.angle( maxAngleMed );
			Sleep.sleep(1);

			my.led.digitalWrite(1);
			my.servoMeditation.angle( minAngleMed );
			Sleep.sleep(1);
		}

		console.log("Testing attention servo ...");
		for (var i=0;i<10;i++) {
			my.led.digitalWrite(0);
			my.servoAttention.angle( minAngleAtt );
			Sleep.sleep(1);

			my.servoAttention.angle( medAngleAtt );
			Sleep.sleep(1);

			my.led.digitalWrite(1);
			my.servoAttention.angle( maxAngleAtt );
			Sleep.sleep(1);
		}
		my.servoAttention.angle( minAngleAtt );


		// testing the LED
		for (var i=0;i<5;i++) {
			my.led.digitalWrite(0);
			Sleep.sleep(1);
			my.led.digitalWrite(1);
			Sleep.sleep(1);
		}


		my.button.on('release', function() {
			console.log("Starting analysis in 10s ...");

			// blink led
			for(var i = 1; i <= 5; i++) {
				my.led.digitalWrite(0);
				Sleep.sleep(1);
				my.led.digitalWrite(1);
				Sleep.sleep(1);
			}

			console.log("Starting analysis ...");
			my.led.digitalWrite(0);
			scoreMeditation = 0;
			numMeditation = 0;
			scoreAttention  = 0;
			numAttention  = 0;

			// finish analysis in 30 seconds
			setTimeout(function() {
				console.log("Finished analysis ...");
				my.led.digitalWrite(1);
				scoreMeditation = Math.round( scoreMeditation / numMeditation) ;
				scoreAttention  = Math.round( scoreAttention  / numAttention) ;
				console.log("scores : med / att : "+scoreMeditation+" / "+scoreAttention);
				console.log("values : med / att : "+numMeditation+" / "+numAttention);
				if (scoreMeditation+20 > scoreAttention ) {
					console.log("Launching action for Meditation ");
					my.servoMeditation.angle(maxAngleMed);
					Sleep.sleep(5);
					my.servoMeditation.angle(minAngleMed);
					console.log("Finished  action for Meditation ");
					client.post('statuses/update', {status: 'Zen, you are. Find what you are looking for, you will. #IntelEdison #AutomaticTweet'}, function(error, tweet, response){ if (!error) { console.log(tweet); } });

				} else {
					console.log("Launching action for Attention ");
					my.servoAttention.angle(medAngleAtt);
					Sleep.sleep(1);
					my.servoAttention.angle(maxAngleAtt);
					Sleep.sleep(1);
					my.servoAttention.angle(minAngleAtt);
					client.post('statuses/update', {status: 'Coffee, the finest organic suspension ever devised. #IntelEdison #AutomaticTweet'}, function(error, tweet, response){ if (!error) { console.log(tweet); } });
					console.log("Finished  action for Attention ");
				}
			},20000);
		});

		my.neurosky.on('meditation', function(data) {
			if (data > 1) {
				console.log('	meditation = '+data);
				scoreMeditation += data;
				numMeditation++;
			}

		});
		my.neurosky.on('attention', function(data) {
			if (data > 1 && data != 128) {
				console.log('	attention  = '+data);
				scoreAttention += data;
				numAttention++;
			}
		});

	}
});

var client = new Twitter({
	consumer_key: '',
    consumer_secret: '',
    access_token_key: '',
    access_token_secret: ''
});

Cylon.start();
