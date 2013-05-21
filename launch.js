require("coffee-script");
hubiquitus=require("hubiquitus")

var onRadioAdapterProperties ={
  alert : "onRadioNewBroadcast",
  mode : "millisecond",
  period : 5000
}
var elasticSearchOptions ={
  server:{
    host: 'localhost',
    port: 9200,
    secure:false                              
  },
  index:"onradio"
}


hubiquitus.start({
  actor: "urn:localhost:tracker",
  type: "htracker",
  properties:{
     channel: {
         actor: "urn:localhost:trackChannel",
         type: "hchannel",
         properties: {
             subscribers: [],
             db:{
                 host: "localhost",
                 port: 27017,
                 name: "admin"
             },
             collection: "trackChannel"
         }
     }
  },
  adapters: [ { type: "socket_in"} ],
  children: [
    {
      actor: "urn:localhost:gateway",
      type: "hgateway",
      log:{
         logLevel:"info"
      },
      children: [
        {
          actor: "urn:localhost:auth",
          type: "hauth"
        }
      ],
      adapters: [ { type: "socket_in"} ],
      properties: {
         socketIOPort: 8080,
         authActor: "urn:localhost:auth",
         authTimeout: 3000
      }
    },
    {
      actor: "urn:localhost:broadcastChannel",
      type: "hchannel",
      properties: {
        subscribers: [],
        collection: "broadcastChannel",
        db:{
          host: "localhost",
          port: 27017,
          name: "onRadio"
        },
      },
      children:[
      ]
    },
    {
      actor:"urn:localhost:ElasticSearchIndex",
      type: "ElasticSearchIndex",
      adapters: [
        {
          type:"socket_in"
        }
      ],
      properties:{
        elasticSearchOptions:elasticSearchOptions
      }
    },
    {
      actor: "urn:localhost:onRadioITunesFinder",
      type: "onRadioITunesFinder",
      adapters: [  
        { 
          type: "socket_in", 
        },
      ]
    },
    {
      // The socket_in is needed because Actor need to receive subscription Ack       
      actor: "urn:localhost:onRadioPlaylistActor",
      type: "onRadioPlaylistActor",
      adapters: [  
        { 
          type: "channel_in",
          channel: "urn:localhost:broadcastChannel",
        },
        {
          type: "socket_in",
        }
      ]
    },

    {
      actor: "urn:localhost:onRadioCompleteTrackActor",
      type: "onRadioCompleteTrackActor",
      adapters: [  
        { 
          type: "socket_in", 
        },
      ]
    },
    {
       actor: "urn:localhost:onRadioActor",
       type: "onRadioActor",
       adapters: [
         // IN
          {
             type: "onRadioEurope1Adapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioSkyrockAdapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioNovaAdapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioNostalgieAdapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioNRJAdapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioOuiFMAdapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioRFMAdapter",
             properties : onRadioAdapterProperties
          },          
          {
             type: "onRadioVirginRadioAdapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioRTL2Adapter",
             properties : onRadioAdapterProperties
          },
          {
             type: "onRadioFunRadioAdapter",
             properties : onRadioAdapterProperties
          },

       ]
    }
  ],
});