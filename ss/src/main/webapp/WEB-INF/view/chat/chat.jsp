<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();

   String wsURL = "ws://"+request.getServerName()+":"+request.getServerPort()+cp+"/chat.msg";
%>

<style type="text/css">
.ui-widget-header{
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}

#roomListContainer{
   clear:both;
   border: 1px solid #ccc;
   height: 285px;
   overflow-y: scroll;
   padding: 3px;
   width: 100%;
}
#roomListContainer p{
   padding-top: 3px;
   padding-bottom: 3px;
   margin-bottom: 0px;
   cursor: pointer;
}
#roomListContainer p:hover{
   background-color: azure;
}
#roomInfoContainer{
	clear:both;
	width: 100%;
	height: 315px;
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border: 1px solid #ccc;
}

#chatMsgContainer{
   clear:both;
   border: 1px solid #ccc;
   height: 285px;
   overflow-y: scroll;
   padding: 3px;
   width: 100%;
}
#chatMsgContainer p{
   padding-bottom: 0px;
   margin-bottom: 0px;
}
#chatRoomJoinList{
	clear:both;
	width: 100%;
	height: 315px;
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border: 1px solid #ccc;
}
#chatRoomJoinList p{
   padding-top: 3px;
   padding-bottom: 3px;
   margin-bottom: 0px;
   cursor: pointer;
}
#chatRoomJoinList p:hover{
   background-color: azure;
}

.selection{
    color: #424951;
    font-weight: bold;
    background: none;
    background-color: #F6F6F6;
    border-color: #D5D5D5;
    /* text-shadow: 0 -1px 0 #286090; */
}
</style>

<script type="text/javascript">
//존재하지 않는 JSON값을 get 하거나 script에 오류가 있으면 socket가 종료됨 
$(function(){
    var uid = "${sessionScope.member.userId}";
    if(! uid) {
    	location.href="<%=cp%>/member/login";
    	return;
    }

	// *********************************
    // 소켓 객체 생성 -----------------------------
	var socket=null;
	// - 채팅창을 실행할 때 다음과 같이 ip로 실행
	//   http://아이피주소:포트번호/cp/chat/main

	// - 채팅서버
	//   ws://ip주소:포트번호/cp/chat.msg
	var host="<%=wsURL%>";
	// var host='wss://' + window.location.host + '/wchat.msg';  // https
	
	if ('WebSocket' in window) {
		socket = new WebSocket(host);
    } else if ('MozWebSocket' in window) {
    	socket = new MozWebSocket(host);
    } else {
    	$("#roomInfoContainer").html('Your browser does not support WebSockets');
        return false;
    }

	socket.onopen = function(evt) { onOpen(evt) };
	socket.onclose = function(evt) { onClose(evt) };
	socket.onmessage = function(evt) { onMessage(evt) };
	socket.onerror = function(evt) { onError(evt) };
	
	// *********************************
    // 서버 접속이 성공한 경우 호출되는 콜백함수
	function onOpen(evt) {
	    // 아이디를 JSON으로 서버에 전송
	    var obj = {};
	    var jsonStr;
	    obj.type="conn";
	    obj.guestId=uid;
	    jsonStr = JSON.stringify(obj);  // JSON.stringify() : 자바스크립트 값을 JSON 문자열로 변환
	    socket.send(jsonStr);
	    
	    $("#roomInfoContainer").html('Info: Server connection.');
	    
	    // $("#roomListContainer").append("<p data-roomId='1'>예제1</p>");
	}

	// *********************************
	// 연결이 끊어진 경우에 호출되는 콜백함수
	function onClose(evt) {
		$("#roomInfoContainer").html('Info: WebSocket error.');
	}

	// *********************************
	// 서버로부터 메시지를 받은 경우에 호출되는 콜백함수
	function onMessage(evt) {
    	// JSON으로 전송 받는다.
    	var data=JSON.parse(evt.data); // JSON 파싱
    	var type = data.type;
    	
    	if(type=="room") {
    		roomProcerss(data);
    	} else if(type=="talk") {
    		talkProcerss(data);
    	} 
	}

	// *********************************
	// 에러 발생시 호출되는 콜백함수
	function onError(evt) {
	}
	
	// ---------------------------------------------
	// 채팅방 제목을 클릭한 경우
	$("body").on("click", "#roomListContainer p", function(){
		$("#roomListContainer p").each(function(){
			$(this).removeClass("selection");
		});
		$("#roomInfoContainer").empty();
		
		$(this).addClass("selection");
		var roomId = $(this).attr("data-roomId");
		if(! roomId) return;
		
		if(roomId==uid) {
			var subject=$(this).text();
			chatMsgProcerss(roomId, subject);
			return;
		}
		// 룸 정보를 전송하도록 요청
		var obj = {};
	    var jsonStr;
	    obj.type="room";
	    obj.cmd="info";
	    obj.roomId=roomId;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	});
	
	// ---------------------------------------------
	// 채팅방 만들기 버튼
	$("#btnRoomAdd").click(function(){
		  $('#roomAdd-dialog').dialog({
			  modal: true,
			  height: 310,
			  width: 400,
			  title: '채팅방 만들기',
			  buttons: {
			       " 만들기 " : function() {
						roomAdd();
			        },
			       " 닫기 " : function() {
			    	   $(this).dialog("close");
			        }
			  },
			  close: function(event, ui) {
				  $("#roomSubject").val("");
				  $("#roomMaximum").val("");
				  $("#roomAddNickName").val("");
			  }
		  });
	});
	
	// ---------------------------------------------
	// 채팅방 만들기
	function roomAdd() {
		var subject=$("#roomSubject").val().trim();
		if(! subject) {
			$("#roomSubject").focus();
			return;
		}
		
		var maximum=$("#roomMaximum").val().trim();
		if(! /^(\d){1,2}$/g.test(maximum)) {
			$("#roomMaximum").focus();
			return;
		}
		if(parseInt(maximum)<2||parseInt(maximum)>20) {
			alert("참여 인원은 2~20사이 입니다.");
			$("#roomMaximum").focus();
			return;
		}

		var nickName=$("#roomAddNickName").val().trim();
		if(! nickName || nickName.indexOf(":")!=-1) {
			$("#roomAddNickName").focus();
			return;
		}
		
		// 룸 개설 정보를 전송
		var obj = {};
	    var jsonStr;
	    obj.type="room";
	    obj.cmd="add";
	    obj.subject=subject;
	    obj.maximum=maximum;
	    obj.roomId=uid;
	    obj.nickName=nickName;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	    // $('#roomAdd-dialog').dialog("close");
	}

	// ---------------------------------------------
	// 채팅방 들어가기 버튼
	$("#btnRoomJoin").click(function(){
		if(! $("#roomListContainer p").hasClass("selection")) {
			alert("입장할 채팅방을 먼저 선택 하세요 !!!");
			return;
		}
		
		var $p = $("#roomListContainer .selection");
		var roomId = $p.attr("data-roomId");
		
		  $('#roomJoin-dialog').dialog({
			  modal: true,
			  height: 180,
			  width: 400,
			  title: '채팅방 입장',
			  close: function(event, ui) {
				  $("#roomJoinNickName").val("");
			  }
		  });		
	});
	
	// ---------------------------------------------
	// 입장하기 버튼
	$("#btnRoomJoinOk").click(function(){
		var nickName=$("#roomJoinNickName").val().trim();
		if(! nickName || nickName.indexOf(":")!=-1) {
			$("#roomJoinNickName").focus();
			return;
		}
		
		var $p = $("#roomListContainer .selection");
		var roomId = $p.attr("data-roomId");		
		
		// 채팅방 입장 요청
		var obj = {};
	    var jsonStr;
	    obj.type="room";
	    obj.cmd="join";
	    obj.roomId=roomId;
	    obj.nickName=nickName;
	    jsonStr = JSON.stringify(obj);
	    socket.send(jsonStr);
	    
	 	// $('#roomJoin-dialog').dialog("close");
	});
	
	// ---------------------------------------------
	// type:room을 전송 받은 경우
	function roomProcerss(data) {
		var cmd=data.cmd;
		
		if(cmd=="room-list") {
			// 처음 접속후 채팅방 리스트를 전송 받은 경우
			var roomId = data.roomId;
			var subject = data.subject;
			
			$("#roomListContainer").append("<p data-roomId='"+roomId+"'>"+subject+"</p>");
			
		} else if(cmd=="add-ok") {
			// 채팅방 개설이 성공한 경우
			var roomId=data.roomId;
			var maximum=data.maximum;
			var subject=data.subject;
			
			$('#roomAdd-dialog').dialog("close");
			
			alert("채팅방이 개설되었습니다.");
			
			// 채팅 대화상자 open
			chatMsgProcerss(roomId, subject);
			
		} else if(cmd=="info") {
			// 채팅방 정보를 전달 받은 경우
			$("#btnRoomJoin").prop("disabled", false);
			
			var roomId=data.roomId;
			var nickName=data.nickName;
			var maximum=data.maximum;
			var number=data.number;
			var guestList=data.guestList;
			if(maximum<=number) {
				$("#btnRoomJoin").prop("disabled", true);
			}
			
			var s="개설자 : " + nickName + "(" + roomId +") <br>"
			s+="최대접속인원 : " + maximum + "<br>";
			s+="현재접속인원 : " + number + "<br>";
			s+="접속자 리스트 : <br>";
			
			$.each(guestList, function(index, value){
				var a=value.split(":");	// a[0]:아이디, a[1]:닉네임
				 s+="&nbsp;&nbsp;- "+a[1]+"("+a[0]+")<br>";
			});

			$("#roomInfoContainer").html(s);
			
		} else if(cmd=="join-ok") {
			// 게스트의 채팅방에 들어가기
			var roomId=data.roomId;
			var subject=data.subject;
			
			$('#roomJoin-dialog').dialog("close");
			
			// 채팅창 띄우기
			chatMsgProcerss(roomId, subject);
			
		} else if(cmd=="join-fail") {
			// 채팅방에 정원초과등으로 들어가지 못하는 경우
			var roomId=data.roomId;
			var subject=data.subject;
			alert(subject+" 채팅방은 입장이 불가능 합니다.");
			
		} else if(cmd=="closed") {
			// 채팅방이 종료 된경우 채팅방 리스트 정보 지우기
			var roomId=data.roomId;
			var subject=data.subject;
			
			if($("#roomListContainer p[data-roomId="+roomId+"]").hasClass("selection")) {
				$("#roomInfoContainer").empty();
			}
			
			$("#roomListContainer p[data-roomId="+roomId+"]").remove();
		}
		
	}
	
	// ---------------------------------------------
	// type:talk를 전송 받은 경우
	function talkProcerss(data) {
		var cmd=data.cmd;
		
		if(cmd=="join-list") {
			// 채팅방에 처음 입장 할 때 채팅 참여자 리스트를 전송 받음
			var guestList=data.guestList;
			$.each(guestList, function(index, value){
				var a=value.split(":");	// a[0]:아이디, a[1]:닉네임
				$("#chatRoomJoinList").append("<p data-guestId='"+a[0]+"'>"+a[1]+"("+a[0]+")</p>");
			});
			
		} else if(cmd=="join-add") {
			// 채팅방에 새로운 게스트가 입장한 경우
			var guestId=data.guestId;
			var nickName=data.nickName;
			$("#chatRoomJoinList").append("<p data-guestId='"+guestId+"'>"+nickName+"("+guestId+")</p>");
			
    		var s=nickName+"("+guestId+") 님이 입장했습니다.";
    		writeToScreen(s);
			
		} else if(cmd=="chatMsg") {
			// 채팅메시지를 받은 경우
			var to=data.to;
			var msg=data.message;
			var senderId=data.senderId;
			var senderName=data.senderName;
			
			var s;
			if(to=="all") {
				s="[일반] ";
			} else {
				s="[귓속] ";
			}
			s+=senderName+"> "+msg;
			
			writeToScreen(s);
			
		} else if(cmd=="closed") {
			// 채팅방 개설자가 채팅방을 나간 경우
			var roomId=data.roomId;
			var subject=data.subject;
			
			alert("["+subject+"] 채팅방이 종료 되었습니다.");
			
			// 채팅 대화상자 종료
			chatMsgClose(roomId, "close");
			
		} else if(cmd=="leave") {
			// 게스트가 채팅방을 나간 경우
			var guestId=data.guestId;
			var nickName=data.nickName;
			
    		var s=nickName+"("+guestId+") 님이 나가셨습니다.";
    		writeToScreen(s);
    		
			$("#chatRoomJoinList p[data-guestId="+guestId+"]").remove();
		}
		
	}
	
	// ---------------------------------------------
	// 채팅 대화상자 띄우기
	function chatMsgProcerss(roomId, subject) {
		  $("#chatMsgContainer").empty();
		  $("#chatRoomJoinList").empty();
		  
		  var t="채팅-"+subject;
		  if(roomId==uid) {
			  t+="(방장)";
		  } else {
			  t+="(게스트)";
		  }
		
		  $('#chatting-dialog').dialog({
			  modal: true,
			  height: 450,
			  width: 630,
			  title: t,
			  close: function(event, ui) {
				  chatMsgClose(roomId);
			  }
		  });
		  
		  $("#chatRoomMsg").on("keydown",function(event) {
		    	// 채팅. 엔터키가 눌린 경우, 서버로 메시지를 전송한다.
		        if (event.keyCode == 13) {
		            sendRoomMessage();
		        }
		  });
		  
		  $("#chatOneMsg").on("keydown",function(event) {
			  // 귓속말. 엔터키가 눌린 경우, 서버로 메시지를 전송한다.
		        if (event.keyCode == 13) {
		            sendOneMessage();
		        }
		  });
	}
	
	// ---------------------------------------------
	// 채팅방 참여자 리스트를 클릭한 경우 위스퍼(귓속말) 대화상자 열기
	$("body").on("click", "#chatRoomJoinList p", function(){
		$("#chatRoomJoinList p").each(function(){
			$(this).removeClass("selection");
		});
			
		$(this).addClass("selection");
		var guestId = $(this).attr("data-guestId");
		if(! guestId) return;
		
		// 귓속말 대화상자 열기
		  $('#whisper-dialog').dialog({
			  modal: true,
			  height: 120,
			  width: 300,
			  title: '귓속말-'+guestId,
			  close: function(event, ui) {
				  $("#chatOneMsg").val("");
			  }
		  });		
	});
	
	// ---------------------------------------------
	// 채팅문자열 전송
	function sendRoomMessage() {
		var msg=$("#chatRoomMsg").val().trim();
		if(! msg) {
			$("#chatRoomMsg").focus();
			return;
		}
		
        var obj = {};
        var jsonStr;
        obj.type="talk";
        obj.cmd="chatMsg";
        obj.to="all";
        obj.message=msg;
        jsonStr = JSON.stringify(obj);
        socket.send(jsonStr);
        
        writeToScreen("[일반] 보냄> "+msg);
        
        $("#chatRoomMsg").val("");
        $("#chatRoomMsg").focus();
	}

	// ---------------------------------------------
	// 귓속말 전송
	function sendOneMessage() {
		var msg=$("#chatOneMsg").val().trim();
		if(! msg) {
			$("#chatOneMsg").focus();
			return;
		}
		
		var $p = $("#chatRoomJoinList .selection");
		var guestId = $p.attr("data-guestId");
		
        var obj = {};
        var jsonStr;
        obj.type="talk";
        obj.cmd="chatMsg";
        obj.to="one";
        obj.message=msg;
        obj.receiveId=guestId;
        jsonStr = JSON.stringify(obj);
        socket.send(jsonStr);
        
        writeToScreen("[귓속] 보냄-"+guestId+"> "+msg);
        
        $("#chatOneMsg").val("");
        $('#whisper-dialog').dialog("close");
	}
	
	// ---------------------------------------------
	// 채팅창을 종료 한 경우
	function chatMsgClose(roomId, state) {
		$("#chatRoomMsg").on("keydown",null);
		$("#chatOneMsg").on("keydown",null);
		
		if(state != undefined) {
			$('#chatting-dialog').dialog("close");
			return;
		}
		
		if(roomId==uid) {
			// 개설자가 창을 닫은 경우, closed를 전송
	        var obj = {};
	        var jsonStr;
	        obj.type="room";
	        obj.cmd="closed";
	        jsonStr = JSON.stringify(obj);
	        socket.send(jsonStr);
	        
			alert("채팅방을 종료합니다.");
			
		} else {
			// 기타 사용자가 창을 닫은 경우, 리브(leave)를 전송
	        var obj = {};
	        var jsonStr;
	        obj.type="talk";
	        obj.cmd="leave";
	        jsonStr = JSON.stringify(obj);
	        socket.send(jsonStr);
		}
		
	}
});

// ---------------------------------------------
// 채팅 메시지를 출력하기 위한 함수
function writeToScreen(message) {
    var $chatContainer = $("#chatMsgContainer");
    $chatContainer.append("<p>");
    $chatContainer.find("p:last").css("wordWrap","break-word"); // 강제로 끊어서 줄 바꿈
    $chatContainer.find("p:last").html(message);

    // 추가된 메시지가 50개를 초과하면 가장 먼저 추가된 메시지를 한개 삭제
    while ($chatContainer.find("p").length > 50) {
    	$chatContainer.find("p:first").remove();
	}

    // 스크롤을 최상단에 있도록 설정
    $chatContainer.scrollTop($chatContainer.prop("scrollHeight"));
}

</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-comment-alt"></i> 채팅 <small style="font-size:65%; font-weight: normal;">Chatting</small></h3>
    </div>
    
    <div style="clear: both;">
        <div style="float: left; width: 250px;">
            <div style="clear: both; padding-bottom: 5px;">
                <span style="font-weight: 600;">＞</span>
                <span style="font-weight: 600; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">채팅방 리스트</span>
            </div>
            <div id="roomListContainer"></div>
            <div style="clear: both; padding-top: 5px;">
                <button type="button" id="btnRoomAdd" class="btn">채팅방 만들기</button>
                <button type="button" id="btnRoomJoin" class="btn">채팅방 들어가기</button>
            </div>
        </div>
        
        <div style="float: left; width: 20px;">&nbsp;</div>
        
        <div style="float: left; width: 230px;">
            <div style="clear: both; padding-bottom: 5px;">
                <span style="font-weight: 600;">＞</span>
                <span style="font-weight: 600; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">정보</span>
            </div>
            <div id="roomInfoContainer"></div>
        </div>
    </div>
    
    <div id="roomAdd-dialog" style="display: none;">
	    <table style="margin: 10px auto 0px; width: 100%; border-spacing: 0px;">
		    <tr height="50"> 
			      <td width="80" style="font-weight:600; padding-right:15px; text-align: right;">방제목</td>
			      <td> 
	                     <input id='roomSubject' type='text' class='boxTF' style="width:98%;" placeholder='채팅방 제목'>
	              </td>
		  </tr>
		    <tr height="50"> 
			      <td width="80" style="font-weight:600; padding-right:15px; text-align: right;">최대인원</td>
			      <td> 
	                     <input id='roomMaximum' type='text' class='boxTF' style="width:98%;" placeholder='접속 최대인원(2~20)'>
	              </td>
		  </tr>
		   <tr height="50"> 
			      <td width="80" style="font-weight:600; padding-right:15px; text-align: right;">닉네임</td>
			      <td> 
	                     <input id='roomAddNickName' type='text' class='boxTF' style="width:98%;" placeholder='채팅에 사용할 닉네임'>
	              </td>
		  </tr>
	    </table>
    </div>
    
    <div id="roomJoin-dialog" style="display: none;">
	    <table style="margin: 10px auto 0px; width: 100%; border-spacing: 0px;">
		    <tr height="40">
			      <td width="80" style="font-weight:600; padding-right:15px; text-align: right;">닉네임</td>
			      <td> 
	                     <input id='roomJoinNickName' type='text' class='boxTF' style="width:98%;" placeholder='채팅에 사용할 닉네임'>
	              </td>
		  </tr>
		    <tr height="50">
			      <td colspan="2" align="right"> 
	                     <button type="button" id="btnRoomJoinOk" class="btn">입장하기</button>
	              </td>
		  </tr>
	    </table>
    </div>
    
    <div id="chatting-dialog" style="display: none;">
	    <div style="clear: both; margin-top: 5px;">
	        <div style="float: left; width: 400px;">
	            <div style="clear: both; padding-bottom: 5px;">
	                <span style="font-weight: 600;">＞</span>
	                <span style="font-weight: 600; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">채팅 메시지</span>
	            </div>
	            <div id="chatMsgContainer"></div>
	            <div style="clear: both; padding-top: 5px;">
	                <input type="text" id="chatRoomMsg" class="boxTF"  style="width: 99%;"
	                            placeholder="채팅 메시지를 입력 하세요...">
	            </div>
	        </div>
	        
	        <div style="float: left; width: 20px;">&nbsp;</div>
	        
	        <div style="float: left; width: 170px;">
	            <div style="clear: both; padding-bottom: 5px;">
	                <span style="font-weight: 600;">＞</span>
	                <span style="font-weight: 600; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">접속자 리스트</span>
	            </div>
	            <div id="chatRoomJoinList"></div>
	        </div>
	    </div>
    </div>
    
    <div id="whisper-dialog" style="display: none">
        <div style="clear: both; padding-top: 5px;">
	          <input type="text" id="chatOneMsg" class="boxTF"  style="width: 99%;"
	                     placeholder="귓속말을 입력 하세요...">
	      </div>
    </div>
</div>