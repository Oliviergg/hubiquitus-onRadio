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
    esIndex = message.payload.index || @elasticsearchOptions.index
    esType = message.payload.type || @elasticsearchOptions.type
    esDocument = message.payload.document
    @elasticsearchclient.index(esIndex,esType,esDocument, undefined, undefined)
    .on 'data', (data) ->
        console.log(data)
    .exec()


module.exports = elasticSearchIndexAdapter