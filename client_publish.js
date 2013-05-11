
var argv = require('optimist')    
    .usage('Usage: $0 -echo [message]')
    .demand(['echo'])
    .argv;

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
      setInterval(function(){
        var message_to_send = hClient.buildMessage("urn:localhost:broadcastChannel", "string", argv.echo, {timeout:10000});
        hClient.send(message_to_send, function(error){
             // console.log(error)
        })
      },1000);

    }
};
hClient.connect('urn:localhost:u2', 'urn:localhost:u2', hOptions);
