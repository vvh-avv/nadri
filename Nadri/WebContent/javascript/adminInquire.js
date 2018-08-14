/**
 * 
 */

	google.charts.load('current', {'packages' : [ 'corechart' ]});
		
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/admin/listInquire").submit();
	}

	$(function() {
		
		var lister = $('.listing').val();
		
		if(lister == 'not_listed'){
			console.log('not listed');
		}else{
			console.log('listed');
		}

		$('.texts').on('mouseover', function() {
			if ($(this).text() == '??') {
				$(this).css('cursor', 'pointer');
				$(this).css('color', 'skyblue');
			}
		})

		$('.texts').on('mouseleave', function() {
			$(this).css('color', 'black');
		})

		$('.inquirebutton').on(
				'click',
				function() {
					var id = $(this).attr('id');
					console.log(id);
					$('.inquireCodeHidden').val(id);
				});

		$('td[colspan=7]').hide();

		$('.texts').on('click', function() {
			var id = $(this).attr('id');
			if (id.length == 4) {
				var lastindex = id.charAt(id.length - 1);
				$('.' + lastindex).toggle();

			} else {
				console.log(id);
				var sublast = id.charAt(id.length - 1);
				console.log(sublast);
				var lastindex = id.lastIndexOf(sublast);
				console.log(lastindex);
				var realcount = id.substring(3, lastindex + 1);
				console.log(realcount);
				$('.' + realcount).toggle();
			}
		})

		$('.sended').on(
				'click',
				function() {
					var inqCode = $('.inquireCodeHidden').val();
					var chkCode = $('.inquireChkCode').val();
					var reason = $('.inquireChkReason').val();
					console.log('checked code value = ' + chkCode);
					$.get('/restAdmin/updateInquire/'+inqCode+'/'+chkCode+'/'+reason,function(data,status){
						if(status == 'success'){
							console.log(data);
							self.location = '/admin/listInquire';
						}
					})
					
				})

		$('img').on('mouseover', function() {
			$(this).css('cursor', 'pointer');
			$(this).css('opacity', '0.5');
		})

		$('img').on('click', function() {
			window.open($(this).attr('src'), "_blank");
		})

		$('img').on('mouseleave', function() {
			$(this).css('opacity', '1');
		})

		$('.userInqLog').on('click',function() {
			$('.block-user').css('visibility','hidden');
			
			var id = $(this).attr('name');
			console.log(id);

			var duration = "all";
			$('.userIdLog').text(id);
			$('.duration').val('');

			$.get("/restAdmin/userLog/" + id + "/" + duration,function(jdata, status) {
				console.log(status);
				console.log(jdata);
				console.log(jdata.rows);

			
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {

					// Create our data table out of JSON data loaded from server.
					var data = new google.visualization.DataTable();
					data.addColumn("string","activity");
					data.addColumn("number","count");
					$.each(jdata.rows,function(key,value) {
						console.log('key:'+ key+ ' / '+ 'value:'+ value);
						data.addRow([key,value ]);});

					var options = {
						chartArea : {
							left : 10,
							top : 10,
							width : "100%",
							height : "90%"
						}
					};

					// Instantiate and draw our chart, passing in some options.
					var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	
					chart.draw(data, options);
	
				}
	
			});

		});

		$('.userReportLog').on('click',function() {
							
			$('.block-user').css('visibility','visible');
			
			$('.duration').val('');
							
			var id = $(this).attr('name');
			console.log(id);

			var duration = "전체";
			$('.userIdLog').text(id);
			$('.userIdLog-check').text(id);

			$.get("/restAdmin/userLog/" + id + "/"+ duration,function(jdata, status) {
				console.log(status);
				console.log(jdata);
				console.log(jdata.rows);

				
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {
	
					// Create our data table out of JSON data loaded from server.
					var data = new google.visualization.DataTable();
					data.addColumn("string","activity");
					data.addColumn("number","count");
					
					var checker = 0;

					$.each(jdata.rows,function(key,value) {
						console.log('key:'+ key+ ' / '+ 'value:'+ value);
						checker++;
						data.addRow([key,value ]);
					});
					
					if (checker > 0) {
						
						var data = new google.visualization.DataTable();
						data.addColumn("string","activity");
						data.addColumn("number","count");
	
						$.each(jdata.rows,function(key,value) {
							console.log('key:'+ key+ ' / '+ 'value:'+ value);
							data.addRow([key,value ]);
						});
	
						var options = {
							chartArea : {
								left : 10,
								top : 10,
								width : "100%",
								height : "90%"
							}
						};
	
					} else {
	
						var data = new google.visualization.DataTable();
						data.addColumn("string","NoData");
						data.addColumn("number","capacity");
	
						data.addRow(['what.',100 ]);
	
						var options = {
							colors : [ '#ccc','grey' ],
							chartArea : {
								left : 10,
								top : 10,
								width : "100%",
								height : "90%"
							}
						};
	
					}

					var options = {
						chartArea : {
							left : 10,
							top : 10,
							width : "100%",
							height : "90%"
						}
					};

					// Instantiate and draw our chart, passing in some options.
					var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	
					chart.draw(data, options);

				}

			});

		});

		$('.duration').on('change',function() {

			var id = $('.userIdLog').text();
			console.log(id);

			var duration = $(this).val();
			console.log(duration);

			$.get("/restAdmin/userLog/" + id + "/"+ duration,function(jdata, status) {
				console.log(status);
				console.log(jdata);
				console.log(jdata.rows);

	
				google.charts.setOnLoadCallback(drawChart);

				function drawChart() {

					// Create our data table out of JSON data loaded from server.
	
					var checker = 0;
	
					$.each(jdata.rows,function(key,value) {
						if (value > 0) {
							checker++;
							console.log(checker);
						}
					});
	
					if (checker > 0) {
	
						var data = new google.visualization.DataTable();
						data.addColumn("string","activity");
						data.addColumn("number","count");
	
						$.each(jdata.rows,function(key,value) {
							console.log('key:'+ key+ ' / '+ 'value:'+ value);
							data.addRow([key,value ]);
						});
	
						var options = {
							chartArea : {
								left : 10,
								top : 10,
								width : "100%",
								height : "90%"
							}
						};
	
					} else {
	
						var data = new google.visualization.DataTable();
						data.addColumn("string","NoData");
						data.addColumn("number","capacity");
	
						data.addRow(['what.',100 ]);
	
						var options = {
							colors : [ '#ccc','grey' ],
							chartArea : {
								left : 10,
								top : 10,
								width : "100%",
								height : "90%"
							}
						};
	
					}
	
					// Instantiate and draw our chart, passing in some options.
					var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	
					chart.draw(data, options);

				}

			})

		});

		$('.modal-close').on('click',function() {
			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
			chart.clearChart();
		})
		
		$('.block-user').on('click',function(){
			var id = $('.userIdLog').text();
			console.log(" "+id+" .");
			$('.userIdLog-check').text(id);
			$('.blockedUserFine').val(id);
		})
		
		$('.block-fine').on('click',function(){
			var id = $('.userIdLog-check').text();
			$.get('/restAdmin/blockUser/'+id,function(data){
				console.log(data);
				if(data == 'success'){
					console.log('처리완료!');
					alert('정상적으로 차단되었습니다!');
					$('#modal3').modal('hide');
				}else{
					console.log('처리실패!');
					alert('차단에 실패하였습니다!');
					$('#modal4').modal('show');
				}
			})
		})
		
		$('.inquire-detail-view').on('click',function(){
			var inquirecode = $(this).attr('id');
			var inquirelink = $(this).attr('name');
			
			console.log(inquirecode+' / '+inquirelink);
			
			if(inquirecode == '2'){
				$.ajax({
		            type: "GET",
		            url: '/restAdmin/getReplyDetail/'+inquirelink,
		            success: function (msg) {
		            	console.log(msg);
						$('.reply-detail').text(msg.commContent);
						$('.userIdLog').text(msg.userId);
		            },
		            error: function (errormessage) {
		                console.log(errormessage);
		            }
		        });
			}else if(inquirecode == '1'){
				window.open('/board/getBoard?boardNo='+inquirelink,'_blank');
				$.get('/restAdmin/getWriter/'+inquirelink,function(data,status){
					console.log(data);
					console.log(status);
					$('.reply-detail').text('작성자를 차단하시려면 차단하기를 눌러주세요.');
					$('.userIdLog-check').text(data);
				})
				$('.block-reported-user').css('display','block');
				
				
			}else if(inquirecode == '3'){
				window.open('/spot/getSpot?spotNo='+inquirelink,'_blank');
				$('.block-reported-user').css('display','none');
				$('.reply-detail').text('신고내용이 확인 되었으면 닫기를 눌러주세요.');
			}
			
			
		})
/*		
		$("button.btn.btn-default:contains('')").on("click", function() {
			fncGetList(1);
		});*/
		
		var chk = true;
		var male;
		$('.switch').on('change',function(){
			
			
			if(chk){
				console.log("hihi");
				$('.option-box > div').css('height','200px');
				console.log($('.inquire-title').css('margin-left'));
				male = $('.inquire-title').css('margin-left');
				$('.inquire-title').css('margin-left','0%');
				chk = false;
			}else{
				console.log("byebye");
				$('.option-box > div').css('height','50px');
				$('.inquire-title').css('margin-left',male);
				
				chk = true;
			}
		})
		
		$('.inquireKeyword').on('focusin',function(){
			$('.inquireKeyword').attr('placeholder','');
			$('.glyphicon-search').css('color','#1c2144');
			$('.options > div').css('border','1px solid #1c2144');
		})
		
		$('.inquireKeyword').on('focusout',function(){
			$('.inquireKeyword').attr('placeholder','검색어를 입력해주세요');
			$('.glyphicon-search').css('color','#adadad');
			$('.options > div').css('border','1px solid #c1c1c154');
		})
		
		$('.inquireKeyword').on('keydown',function(e){
			console.log($('input:radio[name=searchCondition]').is(':checked'));
			var radio = $('input:radio[name=searchCondition]').is(':checked');
			if(e.which == 13){
				if(radio){
					fncGetList(0);	
				}else{
					alert('검색조건을 하나이상 선택해주세요!');
				}
			}
		})
		
/*		
		var boxchk = true;
		$('.cons-label').on('click',function(){
			var id = $(this).attr('id');
			if(boxchk){
				$('input[name='+id+']').attr('checked',false);		
				boxchk = false;
			}else{
				$('input[name='+id+']').attr('checked',true);
				boxchk = true;
			}
		})
		
		$('.conditions').on('change',function(){
			if(boxchk){
				$('input[name='+id+']').attr('checked',false);	
				boxchk = false;
			}else{
				$('input[name='+id+']').attr('checked',true);
				boxchk = true;
			}
		})*/
		
		
	}); // javaScript function 