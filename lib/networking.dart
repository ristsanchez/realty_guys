//I think best approach would be
//  implement local play, fully functional
//  THEN, introduce sockets/networking aspect into foundation
//    
//  
//  Consider authentication for way later

//local game pass n play
//local game against Ai players
//local game mi of both
//
//Online game
//  setup flow
//    main screen options: local and online
//      online options: host and join
//      host ui: game parameters grid + current setup screen 
//                + autogenerate room code + current clients list
//      join ui: current set up screen + code # 
//Separate network game into client/host
//  where host runs all the logic and communicates it to clients
//    client only receives info and displays animations/sequences
//    client only sends their own rolls, actions etc.
//    host dispatches display info by round
//      this can be a que of actions/resolvable 
//      current player, listen to actions
//        UI-> open controls, highlight player
//    host migration for a better experience
//  
//  host after pressing host creates an id and enters game customization
//    listen for new clients
//      once connected to client
//        listen for player avatar changes
//        transmit changes to other clients
//    wait for user to complete customization
//  host creates game with at least 1 client in
//    
//
//  client has option to 'join room' e.g., 'by code 4567' 
//     client can customize icon/name when not-yet/connected
//  client receives changes in data to notify their ui
//  client can reconnect if closed app/ disconnected
//    connection status on top left

//minimizing information data sent over socket
//PLayer class
//Final data
//  socket client unique id?
//  icon
//  color
//  name
//  id

//local data
//  tile info
//  card info (add ids to all cards to only send which id resulted)

//Online game data
//Changing data
//  Money
//  location
//  houses
//  mortgages
//
//player state related
//(this can be optional, it results in better player experience)
//  roll result for roll sequence (This one is a must)
//  buy/sell real time player decisions house sequence
//  same with mortgage
//  trade real time decisions (adding/rem money properties to trade)