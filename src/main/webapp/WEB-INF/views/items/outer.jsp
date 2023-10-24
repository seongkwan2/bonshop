<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OUTER</title>
<script src="/js/jquery.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<link href="/css/main.css" rel="stylesheet"/>
<link href="/css/rent.css" rel="stylesheet"/>
<link href=/css/rent_Wait.css rel="stylesheet" />

</head>
<body>



<!-- 10-19 마무리 수정해야 하는것 여기 싹 날려버리고 쇼핑몰처럼 만들기 참고자료는 나이키온라인스토어 ㄱㄱ -->
<div class="CARBig">
  <jsp:include page="../include/header.jsp"/>
  </div>
  <div class="CARBig">
  
  <div class="clear"></div>
<%-- 예약 선택 메뉴 --%>
<form action="/rent/rent" method="post">
<input type="hidden" name="cr_mid" id="cr_mid" value="${memberInfo.m_id}" required><br>

<input type="hidden" name="cr_cname" id="cr_cname" value="${car.c_name}">


		
		
</div>
<div class="clear"></div>

<!-- 로그인 아이디 값을 히든으로 넘김 -->

<!-- 차 이름값을 히든으로 넘김 -->
<%-- 예약 선택 메뉴 --%>
<div class="clear"></div>

<br><br>

<%-- 선택별 메뉴 --%>
<div class="tab_content">
	<input type="radio" name="tabmenu" id="tab01" checked>
	<label for="tab01">전체</label>
	<input type="radio" name="tabmenu" id="tab02">
	<label for="tab02">경형</label>
	<input type="radio" name="tabmenu" id="tab03">
	<label for="tab03">소형</label>
	<input type="radio" name="tabmenu" id="tab04">
	<label for="tab04">중형(세단)</label>
	<input type="radio" name="tabmenu" id="tab05">
	<label for="tab05">중형(SUV)</label>
	<input type="radio" name="tabmenu" id="tab06">
	<label for="tab06">전기차</label>
	
	
	<input type="hidden" name="cr_cname" id="cr_cname" value="${cr_cname}">
	
	<div class="conbox con1"> <!-- 전체 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
					<input type="hidden" name=currentCar${status.index} value="${c.c_name}" />
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<td>
							<div id="box01">
								<br><br><br>
								<img id="imgC" src="../images/car/${c.c_img}">
								<br><br><br>
								<hr>
								<b>${c.c_brand} ${c.c_name}</b><br>
								${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
								<p>
									1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
									<br>
									24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
								</p>
								<div id="box02">
								    <input id="yes" type="button" value="예 약 하 기" onclick="showCar(currentCar${status.index})" />
								</div>
								</div>
							</div>
						</td>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con2"> <!-- 경형 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<c:if test="${c.c_type2.equals('경형')}">
						<input type="hidden" name=currentCar2${status.index} value="${c.c_name}" />
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02">
										<input id="yes" type="button" value="예 약 하 기" onclick="showCar2(currentCar2${status.index})" />
									</div>
								</div>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con3"> <!-- 소형 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<c:if test="${c.c_type2.equals('소형')}">
						<input type="hidden" name=currentCar3${status.index} value="${c.c_name}" />
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02">
										<input id="yes" type="button" value="예 약 하 기" onclick="showCar3(currentCar3${status.index})" />
									</div>
								</div>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con4"> <!-- 중형(세단) -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${c.c_name.equals('아테온')}">
							</tr><tr>
						</c:if>
						<c:if test="${c.c_type2.equals('중형 세단')}">
						<input type="hidden" name=currentCar4${status.index} value="${c.c_name}" />
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02">
										<input id="yes" type="button" value="예 약 하 기" onclick="showCar4(currentCar4${status.index})" />
									</div>
								</div>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con5"> <!-- 중형(SUV) -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${c.c_type2.equals('중형 SUV')}">
						<input type="hidden" name=currentCar5${status.index} value="${c.c_name}" />
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02">
										<input id="yes" type="button" value="예 약 하 기" onclick="showCar5(currentCar5${status.index})" />
									</div>
								</div>
							</td>
						</c:if>
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
	<div class="conbox con6"> <!-- 전기차 -->
		<table>
			<c:if test="${!empty clist}">
				<tr>
					<c:forEach var="c" items="${clist}" varStatus="status">
						<c:if test="${status.index % 3 == 0}">
							</tr><tr>
						</c:if>
						<c:if test="${c.c_type2.equals('전기차')}">
						<input type="hidden" name=currentCar6${status.index} value="${c.c_name}" />
							<td>
								<div id="box01">
									<br><br><br>
									<img id="imgC" src="../images/car/${c.c_img}">
									<br><br><br>
									<hr>
									<b>${c.c_brand} ${c.c_name}</b><br>
									${c.c_type} | ${c.c_oil} | ${c.c_year} <br><br>
									<p>
										1시간 : \ <fmt:formatNumber value="${c.c_price*60}" pattern="#,###"/>
										<br>
										24시간 : \ <fmt:formatNumber value="${c.c_price*60*24}" pattern="#,###"/>
									</p>
									<div id="box02">
										<input id="yes" type="button" value="예 약 하 기" onclick="showCar6(currentCar6${status.index})" />
									</div>
								</div>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:if>
		</table>
	</div>
</div>
</form>


<br>
<br>
<br>
<br>
<br>

<div class="clear"></div>

<c:if test="${not empty msg}">
    <script>
        ${msg}
    </script>
    <%-- 스크립트가 실행되었으므로 alertScript를 삭제 --%>
    <c:remove var="alertScript" scope="page" />
</c:if>

</div>
<div class="CARBig">
<jsp:include page="../include/footer.jsp"/>
</div>
</body>
</html>