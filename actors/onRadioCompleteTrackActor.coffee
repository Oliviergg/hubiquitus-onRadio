{Actor} = require "hubiquitus"

class onRadioCompleteTrackActor extends Actor
	constructor: (topology) ->
		super
		@type = "onRadioCompleteTrackActor"
	
	onMessage: (hMessage) ->
		broadcast=hMessage.payload
		@log "info", JSON.stringify broadcast
		esPayload={
			type:"track",
			document:broadcast.track
		}
		@send payload:esPayload,actor:"urn:localhost:ElasticSearchIndex"
		
module.exports = onRadioCompleteTrackActor;