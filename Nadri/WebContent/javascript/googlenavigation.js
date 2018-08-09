		// 그림을 그리기 위한 밑바탕
		var directionsDisplay1 = new google.maps.DirectionsRenderer; 
	    var directionsDisplay2 = new google.maps.DirectionsRenderer; 
	    var directionsDisplay3 = new google.maps.DirectionsRenderer; 
	    var directionsDisplay4 = new google.maps.DirectionsRenderer; 
	    var directionsDisplay5 = new google.maps.DirectionsRenderer; 
	    var directionsDisplay6 = new google.maps.DirectionsRenderer; 
	    var directionsService = new google.maps.DirectionsService; 
	    
	    // 시작지점
	    var start;
	    // 끝나는지점
	    var end;
	    
	    $( document ).ready(function() {    
	    	initMap();
	    });
	    
	    function initMap() {  
	        var map = new google.maps.Map(document.getElementById('map'), { 
	          zoom: 14, 
	          center: {lat: 37.494788, lng: 127.027594} 
	        }); 
	        directionsDisplay1.setMap(map);
	        directionsDisplay2.setMap(map);
	        directionsDisplay3.setMap(map);
	        directionsDisplay4.setMap(map);
	        directionsDisplay5.setMap(map);
	        directionsDisplay6.setMap(map);
	      }// end of initMap() 
		  
	    
	    // 메서드 네비게이션 장소입니다!!
	  //값이 있나 없나 valudation check 부분일뿐!!
	    function search(input) {
	    	alert(input);
		    	if( input == "#wayPointAddress0"){
		    		if($(input).val() != "") {
		    		start = document.getElementById('wayPointAddress0').value;
		    		alert(input);
		    			swal("출발지가 설정되었습니다!")
		    		} else {
		    			swal("출발지를 설정해주세요!!")
		    		}
		    	} else if (input == "#wayPointAddress1"){
		    		end = document.getElementById('wayPointAddress1').value;
		    		calculateAndDisplayRoute1(directionsService, directionsDisplay1);
		    	} else if (input == "#wayPointAddress2"){
		    		end = document.getElementById('wayPointAddress2').value;
		    		calculateAndDisplayRoute2(directionsService, directionsDisplay2);
		    	} else if (input == "#wayPointAddress3"){
		    		end = document.getElementById('wayPointAddress3').value;
		    		calculateAndDisplayRoute3(directionsService, directionsDisplay3);
		    	} else if (input == "#wayPointAddress4"){
		    		end = document.getElementById('wayPointAddress4').value;
		    		calculateAndDisplayRoute4(directionsService, directionsDisplay4);
		    	} else if (input == "#wayPointAddress5"){
		    		end = document.getElementById('wayPointAddress5').value;
		    		calculateAndDisplayRoute5(directionsService, directionsDisplay5);
		    	} else if (input == "#wayPointAddress6"){
		    		end = document.getElementById('wayPointAddress6').value;
		    		calculateAndDisplayRoute6(directionsService, directionsDisplay6);
		    	}
		    }
	    
	    function calculateAndDisplayRoute1(directionsService, directionsDisplay1) { 
	        directionsService.route({ 
	          origin: start,  
	          destination: end,   
	          travelMode: google.maps.TravelMode["TRANSIT"] 
	        }, function(response, status) { 
	      	  if (status == 'OK') { 
	                var route = response.routes[0];
	                var total = route.legs[0].duration.value;
	                if(total> 3600) {
	                    time = Math.floor(total/3600) + "시간 " + Math.floor(total%3600/60) + "분";
	                } else {
	                    time = Math.floor(total%3600/60) + "분 ";
	                }
	                
	                $("#wayPointMoveTime1").val(time);
	                for (var i = 0; i < route.legs[0].steps.length; i++) {
	                	try{
	                		var nav;
	                    	nav += "# "+route.legs[0].steps[i].instructions+"로 "+route.legs[0].steps[i].distance.text;
	                    	nav += "# 출발정류장:"+route.legs[0].steps[i].transit.departure_stop.name+"# 도착정류장:"+route.legs[0].steps[i].transit.arrival_stop.name + "# (지하철/버스):" + route.legs[0].steps[i].transit.line.short_name;
	                    	$("#wayPointNav1").val(nav);
	                	} catch (exception){			                     
	                	} finally {
	                    }
	                }
	           directionsDisplay1.setDirections(response); 
	           start = end;
	          } else { 
	          	swal("주소를 잘못 입력하셨어요! 다른 주소를 입력해주세요!");
	            }
	        }); 
	    };
	    
	    
	    function calculateAndDisplayRoute2(directionsService, directionsDisplay1) { 
	        directionsService.route({ 
	          origin: start,  
	          destination: end,   
	          travelMode: google.maps.TravelMode["TRANSIT"] 
	        }, function(response, status) { 
	      	  if (status == 'OK') { 
	      		var route = response.routes[0];
                var total = route.legs[0].duration.value;
                if(total> 3600) {
                    time = Math.floor(total/3600) + "시간 " + Math.floor(total%3600/60) + "분";
                } else {
                    time = Math.floor(total%3600/60) + "분 ";
                }
	                
	                $("#wayPointMoveTime2").val(time);
	                for (var i = 0; i < route.legs[0].steps.length; i++) {
	                	try{
	                		var nav;
	                    	nav += "# "+route.legs[0].steps[i].instructions+"로 "+route.legs[0].steps[i].distance.text;
	                    	nav += "# 출발정류장:"+route.legs[0].steps[i].transit.departure_stop.name+"# 도착정류장:"+route.legs[0].steps[i].transit.arrival_stop.name + "# (지하철/버스):" + route.legs[0].steps[i].transit.line.short_name;
	                    	$("#wayPointNav2").val(nav);
	                	} catch (exception){			                     
	                	} finally {
	                    }
	                }
	           directionsDisplay2.setDirections(response); 
	           start = end;
	          } else { 
	          	swal("주소를 잘못 입력하셨어요! 다른 주소를 입력해주세요!");
	            }
	        }); 
	    };
	    
	    function calculateAndDisplayRoute3(directionsService, directionsDisplay1) { 
	        directionsService.route({ 
	          origin: start,  
	          destination: end,   
	          travelMode: google.maps.TravelMode["TRANSIT"] 
	        }, function(response, status) { 
	      	  if (status == 'OK') { 
	      		var route = response.routes[0];
                var total = route.legs[0].duration.value;
                if(total> 3600) {
                    time = Math.floor(total/3600) + "시간 " + Math.floor(total%3600/60) + "분";
                } else {
                    time = Math.floor(total%3600/60) + "분 ";
                }
	                $("#wayPointMoveTime3").val(time);
	                for (var i = 0; i < route.legs[0].steps.length; i++) {
	                	try{
	                		var nav;
	                    	nav += "# "+route.legs[0].steps[i].instructions+"로 "+route.legs[0].steps[i].distance.text;
	                    	nav += "# 출발정류장:"+route.legs[0].steps[i].transit.departure_stop.name+"# 도착정류장:"+route.legs[0].steps[i].transit.arrival_stop.name + "# (지하철/버스):" + route.legs[0].steps[i].transit.line.short_name;
	                    	$("#wayPointNav3").val(nav);
	                	} catch (exception){			                     
	                	} finally {
	                    }
	                }
	           directionsDisplay3.setDirections(response); 
	           start = end;
	          } else { 
	          	swal("주소를 잘못 입력하셨어요! 다른 주소를 입력해주세요!");
	            }
	        }); 
	    };
	    
	    function calculateAndDisplayRoute4(directionsService, directionsDisplay1) { 
	        directionsService.route({ 
	          origin: start,  
	          destination: end,   
	          travelMode: google.maps.TravelMode["TRANSIT"] 
	        }, function(response, status) { 
	      	  if (status == 'OK') { 
	      		var route = response.routes[0];
                var total = route.legs[0].duration.value;
                if(total> 3600) {
                    time = Math.floor(total/3600) + "시간 " + Math.floor(total%3600/60) + "분";
                } else {
                    time = Math.floor(total%3600/60) + "분 ";
                }
	                $("#wayPointMoveTime4").val(time);
	                for (var i = 0; i < route.legs[0].steps.length; i++) {
	                	try{
	                		var nav;
	                    	nav += "# "+route.legs[0].steps[i].instructions+"로 "+route.legs[0].steps[i].distance.text;
	                    	nav += "# 출발정류장:"+route.legs[0].steps[i].transit.departure_stop.name+"# 도착정류장:"+route.legs[0].steps[i].transit.arrival_stop.name + "# (지하철/버스):" + route.legs[0].steps[i].transit.line.short_name;
	                    	$("#wayPointNav4").val(nav);
	                	} catch (exception){			                     
	                	} finally {
	                    }
	                }
	           directionsDisplay4.setDirections(response); 
	           start = end;
	          } else { 
	          	swal("주소를 잘못 입력하셨어요! 다른 주소를 입력해주세요!");
	            }
	        }); 
	    };
	    
	    function calculateAndDisplayRoute5(directionsService, directionsDisplay1) { 
	        directionsService.route({ 
	          origin: start,  
	          destination: end,   
	          travelMode: google.maps.TravelMode["TRANSIT"] 
	        }, function(response, status) { 
	      	  if (status == 'OK') { 
	      		var route = response.routes[0];
                var total = route.legs[0].duration.value;
                if(total> 3600) {
                    time = Math.floor(total/3600) + "시간 " + Math.floor(total%3600/60) + "분";
                } else {
                    time = Math.floor(total%3600/60) + "분 ";
                }
	                $("#wayPointMoveTime5").val(time);
	                for (var i = 0; i < route.legs[0].steps.length; i++) {
	                	try{
	                		var nav;
	                    	nav += "# "+route.legs[0].steps[i].instructions+"로 "+route.legs[0].steps[i].distance.text;
	                    	nav += "# 출발정류장:"+route.legs[0].steps[i].transit.departure_stop.name+"# 도착정류장:"+route.legs[0].steps[i].transit.arrival_stop.name + "# (지하철/버스):" + route.legs[0].steps[i].transit.line.short_name;
	                    	$("#wayPointNav5").val(nav);
	                	} catch (exception){			                     
	                	} finally {
	                    }
	                }
	           directionsDisplay5.setDirections(response); 
	           start = end;
	          } else { 
	          	swal("주소를 잘못 입력하셨어요! 다른 주소를 입력해주세요!");
	            }
	        }); 
	    };
	    
	    function calculateAndDisplayRoute6(directionsService, directionsDisplay1) { 
	        directionsService.route({ 
	          origin: start,  
	          destination: end,   
	          travelMode: google.maps.TravelMode["TRANSIT"] 
	        }, function(response, status) { 
	      	  if (status == 'OK') { 
	      		var route = response.routes[0];
                var total = route.legs[0].duration.value;
                if(total> 3600) {
                    time = Math.floor(total/3600) + "시간 " + Math.floor(total%3600/60) + "분";
                } else {
                    time = Math.floor(total%3600/60) + "분 ";
                }
	                $("#wayPointMoveTime6").val(time);
	                for (var i = 0; i < route.legs[0].steps.length; i++) {
	                	try{
	                		var nav;
	                    	nav += "# "+route.legs[0].steps[i].instructions+"로 "+route.legs[0].steps[i].distance.text;
	                    	nav += "# 출발정류장:"+route.legs[0].steps[i].transit.departure_stop.name+"# 도착정류장:"+route.legs[0].steps[i].transit.arrival_stop.name + "# (지하철/버스):" + route.legs[0].steps[i].transit.line.short_name;
	                    	$("#wayPointNav6").val(nav);
	                	} catch (exception){			                     
	                	} finally {
	                    }
	                }
	           directionsDisplay6.setDirections(response); 
	           start = end;
	          } else { 
	          	swal("주소를 잘못 입력하셨어요! 다른 주소를 입력해주세요!");
	            }
	        }); 
	    };
	    
	    function reset(){
	        directionsDisplay1.setMap(null);
	        directionsDisplay2.setMap(null);
	        directionsDisplay3.setMap(null);
	        directionsDisplay4.setMap(null);
	        directionsDisplay5.setMap(null);
	        directionsDisplay6.setMap(null);
	        directionsDisplay1.setMap(map);
	        directionsDisplay2.setMap(map);
	        directionsDisplay3.setMap(map);
	        directionsDisplay4.setMap(map);
	        directionsDisplay5.setMap(map);
	        directionsDisplay6.setMap(map);
	    }
	    