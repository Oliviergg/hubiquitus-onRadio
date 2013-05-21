onRadioAdapter = require "./onRadioAdapter"
_ = require "underscore"

class onRadioRTL2Adapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://radio.rtl2.fr/player.js"
		@radio="RTL2"

	findInformation: (page) ->
		reg=/updateData\("rtl2",(.*)\);/
		result = reg.exec(page)
		json = JSON.parse(result[1])

		return {
				radio:@radio,
				track:{
					artist:json['songs'][0]['artist']
					title:json['songs'][0]['title']
				}
			}

module.exports = onRadioRTL2Adapter;