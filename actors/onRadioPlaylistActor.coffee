{Actor} = require "hubiquitus"
validator = require "hubiquitus/lib/validator"

class onRadioPlaylistActor extends Actor
	constructor: (topology) ->
		super
		@type = "onRadioPlaylistActor"
		@playlist = {}
	
	# can update the Playlist or can send the playlist to someone.
	onMessage: (hMessage) ->
		if validator.getBareURN(hMessage.publisher) is "urn:localhost:onRadioITunesFinder"
			@playlist[hMessage.payload.radio]= hMessage.payload
		else
			@send payload:@playlist,actor: hMessage.publisher

module.exports = onRadioPlaylistActor;