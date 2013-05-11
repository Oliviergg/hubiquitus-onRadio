onRadioAdapter = require "./onRadioAdapter"
libxmljs = require "libxmljs"
_ = require "underscore"

class onRadioSkyrockAdapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://www.skyrock.fm/front/xml/onair_a2i.xml"
		@radio="Skyrock"

	findInformation: (page) ->
		xmlDoc = libxmljs.parseXml(page)
		return {
				radio:@radio,
				track:{
					artist:xmlDoc.get("//Song[@current='true']/artist").text()
					title:xmlDoc.get("//Song[@current='true']/title").text()
				}
			}

module.exports = onRadioSkyrockAdapter;