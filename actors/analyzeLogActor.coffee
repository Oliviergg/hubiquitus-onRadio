{Actor} = require "hubiquitus"

class analyzeLogActor extends Actor
	constructor: (topology) ->
  	super
  	@type = "analyzeLogActor"
 
	onMessage: (hMessage) ->
		@log "info",JSON.stringify(hMessage,null,2)
		esPayload={
			type:"var_log_system_log",
			document:{line:hMessage.payload.line},
		}

		@send payload: esPayload,  actor: "urn:localhost:analyzeLogActor"
 

module.exports = analyzeLogActor