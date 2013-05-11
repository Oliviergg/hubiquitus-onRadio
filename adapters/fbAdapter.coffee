{TimerAdapter} = require "hubiquitus"
request = require "request"

class fbAdapter extends TimerAdapter
	constructor: (properties) ->
		super
		@count = 0

	startJob: =>
		request {url:"http://graph.facebook.com/cocacola"}, (error, response, body) =>
			if ((not error) and (response.statusCode is 200))
		    tmp = JSON.parse(body)
		    if (@count < tmp.likes)
		      @count = tmp.likes
		      @owner.emit "message", @owner.buildMessage @owner.actor, "fbLikes", { likes:@count , id:tmp.id, name:tmp.name}

module.exports = fbAdapter