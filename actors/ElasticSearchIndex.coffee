{Actor} = require "hubiquitus"
_ = require "underscore"
ElasticSearchClient = require('elasticsearchclient')

class ElasticSearchIndex extends Actor
  
  constructor: (topology) ->
    super
    @elasticsearchOptions = @properties.elasticSearchOptions
    @elasticsearchclient=new ElasticSearchClient(@elasticsearchOptions.server)
    @type = "ElasticSearchIndex"
  
  onMessage: (hMessage) ->
    esIndex = hMessage.payload.index || @elasticsearchOptions.index
    esType = hMessage.payload.type || @elasticsearchOptions.type
    esDocument = hMessage.payload.document
    @elasticsearchclient.index(esIndex,esType,esDocument, undefined, undefined)
    .on 'data', (data) ->
        console.log(data)
    .exec()

module.exports = ElasticSearchIndex;