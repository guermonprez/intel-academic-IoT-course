var Cylon = require('cylon');
var Twitter = require('twitter');
var Sleep = require('sleep');
var exec = require('child_process').exec;

// system calls in case you forgot to do it yourself
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
servoMeditation: { driver: 'servo', pin: 3,connection: 'edison'  },
servoAttention: { driver: 'servo', pin: 5,connection: 'edison'  },
led: { driver: 'direct-pin', pin: 8,connection: 'edison' }
},

work: function(my) {
var scoreMeditation = 0;
var numMeditation = 0;
var scoreAttention  = 0;
var numAttention  = 0;
var minAngle = 20 ;
var maxAngle = 160 ;

// stretch motors. test led
console.log("Testing led and servos ...");
my.led.digitalWrite(0);
my.servoMeditation.angle( my.servoMeditation.safeAngle( minAngle ));
my.servoAttention.angle(  my.servoAttention.safeAngle(  minAngle ));
Sleep.sleep(2);
my.servoMeditation.angle( my.servoMeditation.safeAngle( maxAngle ));
my.servoAttention.angle(  my.servoAttention.safeAngle(  maxAngle ));
Sleep.sleep(2);
my.servoMeditation.angle( my.servoMeditation.safeAngle( minAngle ));
my.servoAttention.angle(  my.servoAttention.safeAngle(  minAngle ));
my.led.digitalWrite(1);

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
				my.servoMeditation.angle(maxAngle);
				Sleep.sleep(2);
				my.servoMeditation.angle(minAngle);
				console.log("Finished  action for Meditation ");
				//	client.post('statuses/update', {status: 'Zen, you are. Find what you are looking for, you will. #IntelEdison #AutomaticTweet'}, function(error, tweet, response){ if (!error) { console.log(tweet); } });

				} else {
				console.log("Launching action for Attention ");
				my.servoAttention.angle(maxAngle);
				Sleep.sleep(2);
				my.servoAttention.angle(minAngle);
				//	client.post('statuses/update', {status: 'Coffee, the finest organic suspension ever devised. #IntelEdison #AutomaticTweet'}, function(error, tweet, response){ if (!error) { console.log(tweet); } });
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
