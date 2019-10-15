
<%@page import="web.holiday.reservation.ReservationDAO"%>
<%@page import="web.holiday.reservation.ReservationDTO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	ReservationDAO dao = new ReservationDAO();
	ReservationDTO dto = null;
	int x = 0; // x값이 0일경우 예약불가 // 1일경우 예약가능 // 2일경우 예약완료 // 3일경우 예약진행중
%>
<%
	Calendar cal = Calendar.getInstance();
	int year = request.getParameter("year") == null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("year"));
	int month = request.getParameter("month") == null ? cal.get(Calendar.MONTH) : (Integer.parseInt(request.getParameter("month")) - 1);
	cal.set(year, month, 1);
	int bgnWeek = cal.get(Calendar.DAY_OF_WEEK);	// 빈공간생성할때 필요한 변수(요일을 숫자로 바꿈)
	
	int prevYear = year;
	int prevMonth = (month + 1) - 1;
	int nextYear = year;
	int nextMonth = (month + 1) + 1;
	
	if (prevMonth < 1) {
		prevYear--;
		prevMonth = 12;
	}
	if (nextMonth > 12) {
		nextYear++;
		nextMonth = 1;
	}
%>

<table>
	<tr>
		<td align="center" colspan="7">
		<a href="bookingAdmin_01.jsp?year=<%=prevYear%>&month=<%=prevMonth%>">prev</a> 
		<%=year%>년 <%=month+1%>월 
		<a href="bookingAdmin_01.jsp?year=<%=nextYear%>&month=<%=nextMonth%>">next</a>		
		</td>
	</tr>
	<tr>
		<td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>
	</tr>
	<tr>
	<%	for(int i = 1; i < bgnWeek; i++){ // 앞빈공간생성 %>	
			<td></td>
	<%	}		
		while(cal.get(Calendar.MONTH) == month) { %>
			<td>
			<%=month+1%>월 <%=cal.get(Calendar.DATE) %>일 <br />
			<%
				for(int i = 1; i <= 3; i++){
					dto = new ReservationDTO();
					dto.setYear(cal.get(Calendar.YEAR));
					dto.setMonth(month+1);
					dto.setDay(cal.get(Calendar.DATE));
					dto.setRoom_num(i);%>
					<a href="bookingAdminForm.jsp?year=<%=dto.getYear() %>&month=<%=dto.getMonth() %>&day=<%=dto.getDay() %>&room_num=<%=dto.getRoom_num() %>">* <%=i %>번방</a>
			<% 	} // 관리자페이지로 년월일방번호보냄%>
			</td>
		<%	if(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY){ %>
				</tr><tr>
		<%	}
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE)+1);
		}
		for(int i = cal.get(Calendar.DAY_OF_WEEK); i <= 7; i++){ // 뒷빈공간생성 %>
			<td></td>
	<%	} %>
	</tr>
</table>
or
<form action="bookingAdminForm.jsp" method="post">
	예약자아이디입력
	<input type="text" name="id" />
	<input type="submit" value="전송"/>
</form>
	<h3>기본 이용 안내</h3>
	<hr>
	<p>※ 펜션 이용시 반드시 아래의 유의사항들을 꼭 읽어주시기 바랍니다.<br />
	※ 예약문의 : 010-4097-2628로 전화주시면 친절히 상담 해드립니다.<br />
	※ 계좌안내 : NH농협 312-1234-1234-12 (김농부)</p><br />
	
	<p>● 예약 후 출발 전 확인전화 부탁드립니다. <br />
	● 예약 시에는 환불 기준을 꼭 숙지하시고 예약하시기 바랍니다. <br />
	● 예약하신 후 전액 입금하셔야 예약이 완료됩니다. <br />
	● 예약 후 24시간 이내 입금이 안 될 경우 예약이 자동으로 취소됩니다.<br />
	● 예약자명과 입금자명이 다를 시 전화를 주셔야 예약이 됩니다. <br />
	● 기준인원 초과 시 1인당 10,000원이 추가됩니다. (유아 및 어린이 포함) <br />
	● 입실 시 예약하신 인원이 추가되었을 경우 퇴실조치 될 수 있습니다. <br />
	● 최대인원 초과시 입실이 제한될 수 있습니다. (환불불가) </p><br />
	
	<h3>입/퇴실 안내</h3>
	<hr>
	<p>● 입실 : 14:00 / 퇴실 : 11:00<br />
	● 객실 청소가 11 ~ 14시까지 이므로 이전 입실은 어렵습니다.<br />
	● 다음 이용객을 위하여 퇴실시간은 준수해 주시기 바랍니다.<br />
	● 퇴실 시 펜션지기에게 퇴실점검을 받으시길 바랍니다.<br />
	● 입실일 밤 10시 이후에 펜션도착시에는 사전에 미리 연락주시기 바랍니다.</p><br /> 
	
	<h3>즐길거리</h3>
	<hr>
	<p>● 바베큐, 숯, 그릴 이용료 : 10명기준 1,470,000원 / 15명기준 1,750,000원 / 30명기준 4,150,000원<br />
	● 가져오시는 숯은 반입금지입니다.</p><br />
	
	<h3>유의사항</h3>
	<hr>
	<p>● 화재 위험이 있어 객실에서는 흡연 및 촛불사용을 금지합니다.<br />
	● 시설물 파손 및 분실에 대한 책임은 고객에게 있으며, 변상을 하셔야 합니다.<br />
	● 쓰래기 배출 시 음식물, 소각용, 재활용으로 구분하여 지정된 장소에 버려주시기 바랍니다.<br />
	● 보호자 없는 미성년자는 예약이 불가능합니다.</p><br />
	
	<h3>환불규정</h3>
	<hr>
	<p>★ 올바른 예약문화 정착을 위하여 라스텔라 펜션에서는 예약 취소시 환불기준을 아래와 같이 운영하고 있으니, 꼭 확인바랍니다.<br />
	1. 예약완료후 취소시에는 날짜가 많이 남았더라도 예외없이 30% 공제되고 환불됩니다.<br />
	2. 환불은 입금자와 동일인에게만 가능합니다.<br />
	3. 취소수수료는 결제금액이 아닌 예약금 (객실요금 + 기타옵션요금) 기준으로 책정됩니다.<br />
	4. 예약완료후 날짜, 객실변경은 예약일 7일 이전에만 가능합니다.</p>
</body>
</html>