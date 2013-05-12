{OutboundAdapter} = require "hubiquitus"
_ = require "underscore"
ElasticSearchClient = require('elasticsearchclient')

class elasticSearchIndexAdapter extends OutboundAdapter

  constructor: (properties) ->
    super
    # Add your initializing instructions

  start: ->
    return if @started
    @elasticsearchOptions = @properties.elasticSearchOptions
    @elasticsearchclient=new ElasticSearchClient(@elasticsearchOptions.server)
    super


  stop: ->
    if @started
      # Add your stopping instructions
      super

  send: (message) ->
    @elasticsearchclient.index(@elasticsearchOptions.index, "track", message.payload.track, undefined, undefined)
    .on 'data', (data) ->
        console.log(data)
    .exec()


module.exports = elasticSearchIndexAdapter