onRadioAdapter = require "./onRadioAdapter"
libxmljs = require "libxmljs"
_ = require "underscore"

class onRadioNovaAdapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://www.novaplanet.com/radionova/ontheair?origin=/radionova/player"
		@radio="Nova"

	findInformation: (page) ->
		json = JSON.parse(page)
		HtmlDoc = libxmljs.parseHtml(json.track.markup)
		return {
				radio:@radio,
				track:{
					artist:HtmlDoc.get("//div[@class='artist']").text()
					title:HtmlDoc.get("//div[@class='title']").text()
				}
			}

module.exports = onRadioNovaAdapter;