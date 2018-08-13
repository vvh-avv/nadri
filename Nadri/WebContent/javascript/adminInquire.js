/**
 * 
 */

	google.charts.load('current', {'packages' : [ 'corechart' ]});
		
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/admin/listInquire").submit();
	}

	$(function() {
		
		$('.inquireKeyword').on('keydown',function(e){
			if(e.which == 13){
				console.log('검색어 = '+$(this).val());
				fncGetList(0);
			}
		})

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

					var code = $('#inq' + id + " td:nth-child(2)").text();
					var no = $('#inq' + id + " td:nth-child(1)").text();
					$('.inquireTransaction > span:nth-child(2)').text(code);
					$('.inquireTransaction > span:nth-child(2)').css(
							'font-weight', '800');
					$('.inquireTransaction > span:nth-child(1)').text(no);
					$('.inquireTransaction > span:nth-child(1)').css(
							'font-weight', '800');

					$('#modal1').modal();
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
					var inqCode = $('.inquiredCode').text();
					var chkCode = $('.inquireChkCode').val();
					console.log('checked code value = ' + chkCode);
					self.location = '/admin/updateInquire?inqCode=' + inqCode
							+ '&chkCode=' + chkCode;
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
			$('.duration').val('전체');

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
			
			$('.duration').val('전체');
							
			var id = $(this).attr('name');
			console.log(id);

			var duration = "all";
			$('.userIdLog').text(id);

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
			$('.blockedUser').text(id);
			$('.blockedUserFine').val(id);
		})
		
		$('.block-fine').on('click',function(){
			$('#modal3').modal('hide');
			var id = $('.blockedUserFine').val();
			$.get('/restAdmin/blockUser/'+id,function(data){
				console.log(data);
				if(data == 'success'){
					console.log('!');
					$('.block-status').text(' .');
					$('#modal4').modal('show');
				}else{
					console.log('!');
					$('.block-status').text(' .');
					$('#modal4').modal('show');
				}
			})
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