onRadioAdapter = require "./onRadioAdapter"
libxmljs = require "libxmljs"
_ = require "underscore"

class onRadioVirginRadioAdapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://viphttpplayers.yacast.net/V4/virginwebradio/playlist_50.xml"
		@radio="Virgin Radio"

	findInformation: (page) ->
		xmlDoc = libxmljs.parseXml(page)
		xmlPassage = xmlDoc.get("//passage[1]")
		return {
				radio:@radio,
				track:{
					artist:xmlPassage.attr("NRJ_ARTISTE").value()
					title:xmlPassage.attr("NRJ_TITRE").value()
				}
			}

module.exports = onRadioVirginRadioAdapter;