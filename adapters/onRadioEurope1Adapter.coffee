onRadioAdapter = require "./onRadioAdapter"
libxmljs = require "libxmljs"
_ = require "underscore"

class onRadioEurope1Adapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://www.europe1.fr/Radio/Direct/pvr.html"
		@radio="Europe 1"

	findInformation: (page) ->
		htmlDoc = libxmljs.parseHtml(page)
		return {
				radio:@radio,
				track:{
					artist:htmlDoc.get("//div[@id='player-wrapper']//span[@class='program_speaker']").text()
					title:htmlDoc.get("//div[@id='player-wrapper']//h1[@class='program_name']").text()
				}
			}

module.exports = onRadioEurope1Adapter;