{Actor} = require "hubiquitus"
class onRadioActor extends Actor
	
	constructor: (topology) ->
		super
		@type = "onRadioActor"
	
	onMessage: (hMessage) ->
		broadcast=hMessage.payload
		@log "info", broadcast.radio \
			+ " - Current broadcast : Artist:" + broadcast.track.artist \
			+ " Title " + broadcast.track.title
		# broadcast.debug = true
		@send payload:broadcast, actor:"urn:localhost:onRadioCompleteTrackActor"

module.exports = onRadioActor;