{InboundAdapter} = require "hubiquitus"
_ = require "underscore"
S = require "string"
Tail = require('tail').Tail

class fileWatcherAdapter extends InboundAdapter
  constructor: (properties) ->
    super
    @fileHandler = new Tail(@properties.filename) 
    @fileHandler.on "line", (data) =>
      console.log(data)
      @owner.emit "message", 
                @owner.buildMessage(
                  @owner.actor,
                  "filelog", 
                  {
                    filename:@properties.filename,
                    line:data
                  }
                )

module.exports = fileWatcherAdapter;