{Actor} = require "hubiquitus"
class onRadioCompleteTrackActor extends Actor
	
	constructor: (topology) ->
		super
		@type = "onRadioCompleteTrackActor"
	
	onMessage: (hMessage) ->
		broadcast=hMessage.payload
		@log "info", JSON.stringify broadcast
		

module.exports = onRadioCompleteTrackActor;