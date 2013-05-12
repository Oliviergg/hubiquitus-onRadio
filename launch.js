require("coffee-script");
hubiquitus=require("hubiquitus")

var onRadioAdapterProperties ={
	alert : "onRadioNewBroadcast",
	mode : "millisecond",
	period : 1000
}

hubiquitus.start({
   actor: "urn:localhost:tracker",
   type: "htracker",
   children: [
       {
           actor: "urn:localhost:gateway",
           type: "hgateway",
           log:{
               "logLevel":"info"
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
           actor: "urn:localhost:echo",
           type: "echoActor",
           adapters: [ { type: "socket_in"} ]
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
				       // {
				       //     actor: "urn:localhost:onRadioShowTrackActor",
				       //     type: "onRadioShowTrackActor",
				       //     adapters: [ { 
				       //     	type: "channel_in",
				       //     	channel: "urn:localhost:broadcastChannel"
				       //   } ]
				       // },
           ]
       },
       {
         actor: "urn:localhost:onRadioCompleteTrackActor",
         type: "onRadioCompleteTrackActor",
         adapters: [  { 
         	              type: "socket_in", 
                      },
                      {
                        type: "elasticSearchIndexAdapter",
                        targetActorAid: "urn:localhost:onRadioCompleteTrackActor",
                        properties:{
                          elasticSearchOptions:{
                            server:{
                              host: 'localhost',
                              port: 9200,
                              secure:false                              
                            },
                            index:"onradio"
                          }
                        }
                      }
                   ]
       },
       {
        actor: "urn:localhost:logWatcher",
        type:"analyzeLogActor",
        adapters: [
          {
            type:"fileWatcherAdapter",
            properties:{
              filename:"/var/log/system.log"
              // filename:"test.text"
            }
          },
          {
            type: "elasticSearchIndexAdapter",
            targetActorAid: "urn:localhost:analyzeLogActor",
            properties:{
              elasticSearchOptions:{
                server:{
                  host: 'localhost',
                  port: 9200,
                  secure:false                              
                },
                index:"systemlog"
              }
            }
          }
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
						 // OUT
	            // {
	            // 	type: "channel_out",
	            // 	targetActorAid:"urn:localhost:broadcastChannel"
	            // }
	            // 
	            // {
	            // 	type: "socket_out",
	            // 	targetActorAid:"urn:localhost:onRadioCompleteTrackActor"
	            // }

           ]
       }
   ],
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
   adapters: [ { type: "socket_in"} ]
});