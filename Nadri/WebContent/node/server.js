var express = require('express') ;
var app = express() ;
var http = require('http').Server(app) ;
var http2 =require('http') ;
//CSS파일 사용하기 위해서
var path = require('path') ;
app.use(express.static(path.join(__dirname,'public'))) ;
//소켓 io
var io = require('socket.io')(http) ;
//채팅 방 번호
var chatRoomNo ;
//메시지 유저 아이디 및 받은 유저 아이디
var senderId = '' ;
var receiverId = '' ;
//파일 io 담당
var fs = require('fs') ;
//현재 시간
var moment = require('moment') ;
//접속 유무 확인
var chatRoomClientList = '' ;

//File 가져오는 것 1번만 실행시킬 Flag
var flag = 0 ;
var multer = require("multer") ;
var upload  = multer({ dest : 'uploads/'})

app.get('/',function(request, response) {
  chatRoomNo = request.query.chatRoomNo ;
  senderId = request.query.senderId ;
  receiverId = request.query.receiverId ;
  console.log('채팅방 번호 : ' + chatRoomNo + " senderId : " + senderId + " receiverId : " + receiverId + "\n\n") ;
  chatRoomClientList += '{' + chatRoomNo + ':' + senderId + '}' ;
  response.contentType('text/html;charset=UTF-8') ;
  response.sendFile( __dirname + '/client.html') ;
}) ;

//이모티콘 업로드시
app.get("/emoticon" , function(request, response) {
	//파일 저장 한 후, json에 파일 경로 추가
	var currentTime = moment().format("YYYY-MM-DD HH:mm:ss") ;
    var protocol = '2' ;
    var chatting = '\n,{"sender_id":"'+ senderId + '","receiver_id":"' +  receiverId + '","message":"' + "이모티콘" + '","sending_date":"' + currentTime + '","protocol":' + '"'+ protocol +'",' + '"fileName":"' + request.query.fileName + '"' + '}' ;
   
    //파일 쓰기
    fs.appendFile( './WebContent/chatFiles/' + senderId + '/' + chatRoomNo + ".json" , chatting , 'utf8' , function(err) {
    		if(err) {
    			console.log( '1' + err ) ;
    		}
    }) ;
    //상대방한테 파일 보여주기
   var message = { "chatRoomNo":'' + chatRoomNo +  '' , "fileName" : '' + request.query.fileName + 
    	'',"protocol": '"' + protocol +'"' } ;
    io.to(chatRoomNo).emit( 'receiveMessage' , senderId , message , currentTime , protocol ) ;
}) ; //End of readFile temp에 있는 사진 가져옴. 


//파일 업로드시
app.post("/upload", upload.single('file') , function(req, res) {
    
	fs.readFile(req.file.path, function(err, data) {

    	var newPath = __dirname +  "/../chatFiles/" + chatRoomNo + "/images/" + req.file.originalname ;
    	fs.writeFile(newPath, data , function (err) {
    		res.status(204).end() ; 
    	}) ; //End of writeFile
    	
    	//파일 저장 한 후, json에 파일 경로 추가
    	var currentTime = moment().format("YYYY-MM-DD HH:mm:ss") ;
        var protocol = '1' ;
        var message = '사진' ;
        var chat = '\n,{"sender_id":"'+ senderId + '","receiver_id":"' +  receiverId + '","message":"' + message + 
        '","sending_date":"' + currentTime + '","protocol":' + '"' + protocol + '",' + '"fileName":"' + req.file.originalname + '"' ;
       
        //파일 쓰기
        fs.appendFile( './WebContent/chatFiles/' + senderId + '/' + 
        		chatRoomNo + ".json" , chat , 'utf8' ,function(err) {
        })
        
        //상대방한테 파일 보여주기         senderId , message , currentTime, protocol 
       var message = { "chatRoomNo":'' + chatRoomNo +  '' , "fileName" : '' + req.file.originalname } ;
       
        if( chatRoomClientList.indexOf( '{' + chatRoomNo + ':' + receiverId + '}' ) != -1 ) {
    		chat += ',"flag":' + '"Y"}' ;
    		io.to(chatRoomNo).emit('receiveMessage', senderId , message , currentTime,  protocol, 1 ) ;
    	}
    	//0이면 현재 방안에 없는 것. 알림 보낼 필요 O
    	else {
    		chat += ',"flag":' + '"N"}' ;
    		io.to(chatRoomNo).emit( 'receiveMessage', senderId , message , currentTime,  protocol, 0 ) ;
    	}
        
       
    }) ; //End of readFile temp에 있는 사진 가져옴. 
}); //end of Upload Post

app.get('/img', function (request, response) {
	//일반 사진 파일 IO
	if(request.query.protocol == '1') {
		fs.readFile('./WebContent/chatFiles/' + request.query.chatRoomNo + '/images/' + request.query.fileName , function (error, data) {
			response.writeHead(200,{'Content': 'image/jpeg'}) ;
			response.end(data) ;
	    })
	}
	
	//이모티콘 파일 IO
	else if( request.query.protocol == '2'  ) {
		fs.readFile('./WebContent/chatFiles/' + request.query.chatRoomNo + '/emoticon/' + request.query.fileName , function (error, data) {
			response.writeHead(200,{'Content': 'image/jpeg'}) ;
			response.end(data) ;
	    })
	}
}) ;

var count=0 ;
//들어왔을때
 io.on('connection', function(socket) {
  var chattingList ;
  //파일 불러오기.
  fs.readFile('./WebContent/chatFiles/' + senderId + '/'+ chatRoomNo +".json" , 'utf8' , function(err, data) {
	  
	  if(data != null && flag === 0) {
		  data += "] }" ;
		  chattingList = JSON.parse(data) ;
		  
		  //이름 변경
		  io.to(socket.id).emit('change name', senderId , receiverId , chatRoomNo) ;
		  //채팅 내역 출력.
		  io.emit( 'appendingContent' , chattingList.chattingList , chatRoomNo ) ;
		  //flag = 1 ;
	  }
  }) ;
  
  //방에 입장 시키기
  socket.join(chatRoomNo) ;
  
  //텍스트 메시지만 보낼 때
  socket.on('sendMessage', function(senderId , message , chatRoomNo, receiverId) {
	var currentTime = moment().format("YYYY-MM-DD HH:mm:ss") ;
	var protocol = '0' ;
    var chat =  '{"sender_id":"'+ senderId + '","receiver_id":"' +  receiverId + '","message":"' + message + 
    '","sending_date":"' + currentTime + '","protocol":"' + protocol +'"' + ',"flag":' + '"Y"}' ; 
    
    //1이면 현재 방안에 있는 것. 알림 보낼 필요 X
    var userId = receiverId.split(",") ;
    var chatRoomInner = '' ; //채팅방 안에 있는 확인해주는 데이터
    
    fs.appendFile( './WebContent/chatFiles/' + senderId + '/' + 
    		chatRoomNo + ".json" , "\n," + chat , 'utf8' ,function(err) {
    	if(err) {
    		console.log(' fs.appendFile error : ' + err) ;
    	}
   }) ;
    
    for(var i = 0 ; i < userId.length ; i++) {
       	chat ='{"sender_id":"'+ senderId + '","receiver_id":"' +  receiverId + '","message":"' + message + 
        '","sending_date":"' + currentTime + '","protocol":"' + protocol +'"' ;
    	
    	
    	if( (startPoint = chatRoomClientList.indexOf( '{' + chatRoomNo + ':' + userId[i]  ) ) != -1 ) {
 			chat += ',"flag":' + '"Y"}' ;
 			chatRoomInner += userId[i] + 1 + ',';
 		}
    	
 		//0이면 현재 방안에 없는 것. 알림 보낼 필요 O
 	    else {
 	    	chat += ',"flag":' + '"N"}' ;
 	    	chatRoomInner += userId[i] + 0 + ',';
 	    }
    	
    	//파일 쓰기
     	fs.appendFile( './WebContent/chatFiles/' + userId[i] + '/' + 
	    		chatRoomNo + ".json" , "\n," + chat , 'utf8' ,function(err) {
	    	if(err) {
	    		console.log(' fs.appendFile error : ' + err) ;
	    	}
	   }) ;
    	
 
    }//End of for
    
    //한번만 전송하기 위해 반복문 안에 안씀.
    io.to(chatRoomNo).emit('receiveMessage', senderId , message , currentTime,  protocol, chatRoomInner ) ;

//    var opts = {
//		    host: '192.168.0.43' ,
//		    port: 8080 ,
//		    method: 'POST' ,
//		    path: '/websocket/' + receiverId + '/transfer' ,
//		    path : '/websocket/transfer' ,
//		    headers: {'Content-type': 'application/json'} ,
//		    body: chat
//		} ;
//  var resData = '' ;
//
//  var req = http2.request(opts, function(res) {
//	    res.on('end', function() {
//	        
//	    }) ;
//	}) ;
//
//  opts.headers['Content-Type'] = 'application/x-www-form-urlencoded' ;
//  req.data = opts ;
//  opts.headers['Content-Length'] = req.data.length ;
//
//  // 요청 전송
//  req.write(JSON.stringify(chat)) ;
//  req.end() ;
  }) ;
  
  socket.on('close' , function(chatRoomNo , senderId) {
	chatRoomClientList = chatRoomClientList.replace( '\{'+ chatRoomNo + ':' +senderId + '\}'  , '' ) ;
	console.log( chatRoomClientList ) ;
	 }) ;
}) ;
 
 io.on('disconnect' , function() {
	 chatRoomClientList = chatRoomClientList.replace( '\{'+ chatRoomNo + ':' + senderId + '\}'  , '' ) ;
	 console.log( chatRoomClientList ) ;
 }) ;
 
http.listen(3000, function(req ,res){
  console.log('server is on') ;
}) ;
