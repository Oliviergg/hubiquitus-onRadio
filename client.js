// Import hClient
// var argv = require('optimist')    
//     .usage('Usage: $0 -echo [message]')
//     .demand(['echo'])
//     .argv;

var hClient = require('hubiquitus4js').hClient;
var hOptions = {
    transport : 'socketio',
    endpoints : ['http://localhost:8080/']
};


hClient.onMessage = function(hMessage){
    console.log('Received :', hMessage);
};

hClient.onStatus = function(hStatus){
    console.log('hClient New Status', hStatus);
    if(hStatus.status == hClient.statuses.CONNECTED){
      console.log('You are connected, now you can execute commands. Look at the browser example!');
      hClient.subscribe("urn:localhost:broadcastChannel", function(hMessage){
        console.log("subscribe : ",hMessage)
      });

    }
};
hClient.connect('urn:localhost:u1', 'urn:localhost:u1', hOptions);
