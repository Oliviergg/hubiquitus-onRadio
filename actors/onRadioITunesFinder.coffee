{Actor} = require "hubiquitus"
request = require "request" 
_ = require "underscore"

class onRadioITunesFinder extends Actor
	constructor: (topology) ->
		super
		@type = "onRadioITunesFinder"
		@url = "http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStoreServices.woa/wa/wsSearch?country=fr&media=music&term="
	
	trace: (broadcasted,message) ->
		@log "info","#{broadcasted.radio} : " + message

	levenshtein = (str1, str2) ->
		m = str1.length
		n = str2.length
		d = []

		return n  unless m
		return m  unless n

		d[i] = [i] for i in [0..m]
		d[0][j] = j for j in [1..n]

		for i in [1..m]
			for j in [1..n]
				if str1[i-1] is str2[j-1]
					d[i][j] = d[i-1][j-1]
				else
					d[i][j] = Math.min(
						d[i-1][j]
						d[i][j-1]
						d[i-1][j-1]
					) + 1

		d[m][n]


	onMessage: (hMessage) =>
		broadcasted = hMessage.payload
		track = broadcasted.track
		findURL = "#{@url}#{encodeURIComponent(track.artist)}+#{encodeURIComponent(track.title)}+#{encodeURIComponent(track.collection||"")}"
		# @trace broadcasted,@findURL

		request {url:findURL}, (error, response, body) =>
			return if (error? or (response.statusCode isnt 200))
			# @log "info",body
			found = JSON.parse(body)
			@trace broadcasted,"Track : " + JSON.stringify track
			@trace broadcasted,findURL
			@trace broadcasted,"found :"+found.resultCount
			found.results.forEach (result) =>
				originStr = "#{track.artist} #{track.title}"
				resultStr = "#{result.artistName} #{result.trackName}"
				@trace broadcasted, "#{levenshtein originStr,resultStr} - #{result.artistName} #{result.trackName} #{result.collectionName}"
			
			# Save source information
			track = _.clone(track)
			broadcasted.track.dataProviders = broadcasted.track.dataProviders || {}
			broadcasted.track.dataProviders[broadcasted.radio] = track

			if found.resultCount isnt 0	
				# User iTunes as a data provider
				matchingTrack=found.results[0]
				broadcasted.track.dataProviders.iTunes = matchingTrack

				broadcasted.track.artist = matchingTrack.artistName
				broadcasted.track.title = matchingTrack.trackName
				broadcasted.track.collection = matchingTrack.collectionName
				broadcasted.track.artworkUrl = matchingTrack.artworkUrl100
				broadcasted.track.extract = matchingTrack.previewUrl

			@log "info",hMessage.publisher
			@send payload:broadcasted,actor:"urn:localhost:broadcastChannel"

		# broadcast=hMessage.payload
		# @log "info", JSON.stringify broadcast
		# esPayload={
		# 	type:"track",
		# 	document:broadcast.track
		# }
		# @send payload:esPayload,actor:"urn:localhost:ElasticSearchIndex"
		
module.exports = onRadioITunesFinder;

