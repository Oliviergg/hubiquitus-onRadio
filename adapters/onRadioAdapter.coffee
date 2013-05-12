{TimerAdapter} = require "hubiquitus"
request = require "request" 
libxmljs = require "libxmljs"
_ = require "underscore"
S = require('string');

class onRadioAdapter        extends TimerAdapter
  constructor: (properties) ->
    super
    @url = ""
    @radio=""

  startJob: =>
    request {url:@url}, (error, response, body) =>
      return if (error? or (response.statusCode isnt 200))
      broadcast = @findInformation(body)
      return if _.isEqual(broadcast,@previousBroadcast)
      @previousBroadcast = broadcast
      @owner.emit "message", 
                @owner.buildMessage(
                  @owner.actor, 
                  "onRadioBroadcast", 
                  @clean broadcast
                )
  
  findInformation: (page) ->
    return {
      }

  clean: (dirty) ->
    cleaner = {};
    cleaner.radio=dirty.radio
    cleaner.timestamp = new Date().getTime();
    cleaner.track={}
    cleaner.track.artist = S(dirty.track.artist or "").trim().s
    cleaner.track.title = S(dirty.track.title or "").trim().s
    cleaner.track.album = S(dirty.track.album or "").trim().s
    return cleaner

module.exports = onRadioAdapter;