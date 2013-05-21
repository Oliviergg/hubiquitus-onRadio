onRadioAdapter = require "./onRadioAdapter"
libxmljs = require "libxmljs"
_ = require "underscore"

class onRadioRFMAdapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://viphttpplayers.yacast.net/V4/virginwebradio/playlist_49.xml"
		@radio="RFM"

	findInformation: (page) ->
		xmlDoc = libxmljs.parseXml(page)
		xmlPassage = xmlDoc.get("//passage[1]")
		return {
				radio:@radio,
				track:{
					artist:xmlPassage.attr("NOMINTERPRETE").value()
					title:xmlPassage.attr("TITREMUSICAL").value()
				}
			}

module.exports = onRadioRFMAdapter;