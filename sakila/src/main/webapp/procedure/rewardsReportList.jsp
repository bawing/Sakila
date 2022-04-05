<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int minMonthlyPurchases = 1;
	double minDollarAmountPurchased = 1;
	int count = 0;
	
	
	if((request.getParameter("minMonthlyPurchases")!=null && request.getParameter("minMonthlyPurchases")!="") && (request.getParameter("minDollarAmountPurchased")!=null && request.getParameter("minDollarAmountPurchased")!="")){
		minMonthlyPurchases = Integer.parseInt(request.getParameter("minMonthlyPurchases"));
		System.out.println(minMonthlyPurchases+"<--minMonthlyPurchases");
		minDollarAmountPurchased = Double.parseDouble(request.getParameter("minDollarAmountPurchased"));
		System.out.println(minDollarAmountPurchased+"<--minDollarAmountPurchased");
	}

	// 비지니스 로기직(모델계층)
	RewardsReportDao rewardsReportDao = new RewardsReportDao();
	Map<String,Object> map = rewardsReportDao.rewardsReportCall(minMonthlyPurchases, minDollarAmountPurchased);
	
	// count
	count = (Integer)map.get("count");
	List<Customer> list = (List<Customer>)map.get("customer");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RewardsReportList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<!-- 상단메뉴 -->
	<div class="col-sm-12 bg-secondary text-white">
		<tr>[스마트혼합]공공데이터 융합자바/스프링 개발자 양성과정(19회차) &nbsp&nbsp Teacher : P.SungHwan &nbsp&nbsp Manager : L.SunMin</tr>
	</div>
	<div class="col-sm-12">
		<div>
			<a class="btn bg-dark text-white" href="<%=request.getContextPath()%>/index.jsp">index</a>
		</div>
		<div class="mt-4 p-5 bg-dark text-white rounded">
			<h1>rewardsReport List(procedure)</h1>
		</div>
	<table class="table table-hover col-sm-11">
		<thead>
			<th>customerId</th>
			<th>storeId</th>
			<th>Name</th>
			<th>email</th>
			<th>addressId</th>
			<th>active</th>
			<th>createDate</th>
			<th>lastupDate</th>
		</thead>
		<tbody>
		<%
			for(Customer c : list) {
		%>
			<tr>
				<td><%=c.getCustomerId()%></td>
				<td><%=c.getStoreId()%></td>
				<td><%=c.getFirstName()%> + <%=c.getLastName()%></td>
				<td><%=c.getEmail()%></td>
				<td><%=c.getAddressId()%></td>
				<td><%=c.getActive()%></td>
				<td><%=c.getCreateDate()%></td>
				<td><%=c.getLastUpdate()%></td>
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<!--  하단정보표시 -->
	<div class="bg-secondary">
		<div>상호명 : GooDee Academy</div>
		<div>전화 : 02-2108-5900</div>
		<div>팩스 : 02-2108-5909</div>
		<div>사업자등록번호 : 457-85-00300</div>
		<div>홈페이지 : <A href="https://www.gdu.co.kr">https://www.gdu.co.kr</A></div>
		<div>주소 : 서울 금천구 가산디지털2로 115 대륭테크노타운 3차 1109호 71가산디지털단지역 5번 출구에서444m</div>
	</div>
</div>
</body>
</html>