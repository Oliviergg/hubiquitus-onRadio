onRadioAdapter = require "./onRadioAdapter"
_ = require "underscore"

class onRadioOuiFMAdapter extends onRadioAdapter
	constructor: (properties) ->
		super
		@url = "http://rock.ouifm.fr/onair.json"
		@radio="Oui FM"

	findInformation: (page) ->
		json = JSON.parse(page)
		json = json["rock"][0]
		return {
				radio:@radio,
				track:{
					artist:json["artist"]
					title:json["title"]
				}
			}

module.exports = onRadioOuiFMAdapter;