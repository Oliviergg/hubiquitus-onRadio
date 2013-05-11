{Actor} = require "hubiquitus"

class EchoActor extends Actor
 
 constructor: (topology) ->
   super
   @type = "echoActor"
 

 onMessage: (hMessage) ->
   @log "info", "echoActor receive a name: " + hMessage.payload + " from " + hMessage.publisher
   @send { payload : "Hello " + hMessage.payload,  actor : hMessage.publisher }
 

module.exports = EchoActor