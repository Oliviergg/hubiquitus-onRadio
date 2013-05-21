onRadioAdapter = require "./onRadioAdapter"
jsyaml = require "js-yaml"
_ = require "underscore"

class onRadioNRJAdapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://players.nrjaudio.fm/wr_api/live?id_radio=1&act=get_plist&id_wr=158"
		@radio="NRJ"

	findInformation: (page) ->
		json = jsyaml.load(page);
		json = json["itms"];
		track = _.select json, (track) ->  
			track.id is 0
		track = track[0]
		return {
				radio:@radio,
				track:{
					artist:track.art
					title:track.tit
				}
			}

module.exports = onRadioNRJAdapter;