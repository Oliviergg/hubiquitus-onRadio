onRadioAdapter = require "./onRadioAdapter"
libxmljs = require "libxmljs"
_ = require "underscore"

class onRadioFunRadioAdapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://radio.funradio.fr/player.xml"
		@radio="Fun Radio"

	findInformation: (page) ->
		xmlDoc = libxmljs.parseXml(page)
		return {
				radio:@radio,
				track:{
					artist:xmlDoc.get("//song[1]/artist").text()
					title:xmlDoc.get("//song[1]/title").text()
				}
			}

module.exports = onRadioFunRadioAdapter;