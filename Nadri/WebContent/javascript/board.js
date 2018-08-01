function ccTag(content){
	var cc = content;
	var addTag = "";
	if( cc.indexOf("@")!=-1 ) { //친구소환O
		var friend = cc.split("@");
		//console.log((friend.length-1)+"명의 친구가 소환됨");
		for( var i=1; i<friend.length; i++) {
			var friendId = friend[i].split(" ")[0];
			//console.log(friendId+"친구가 소환됨");
			
			if(i==friend.length-1){
				var cl = cc.length; //문자열 총 길이
				var ci = cc.indexOf(friend[i]); //마지막 친구이름 시작위치
				var cp = ci + friendId.length; //마지막 친구이름 시작위치 + 마지막 친구이름 길이
				var msg = cc.substring(cp+1,cc.length); //문자열 총 길이 - (마지막 친구이름 시작위치 + 마지막 친구이름 길이)
			}else{
				var msg = friend[i].split(" ")[1];
			}
			addTag += "<span class='commTag'>@"+friendId+"</span> "+msg;
		}
	}else { //친구소환X
		addTag = cc;
	}
	
	return addTag;
}