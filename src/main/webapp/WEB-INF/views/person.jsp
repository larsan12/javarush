<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html>
<head>
	<title>Admin Page</title>
	<style type="text/css">
		  body {background-color:#f0f0f0 }
		.tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
		.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
		.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
		.tg .tg-4eph{background-color:#f9f9f9}
		.siz {width: 30px;}
	</style>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	<script type="text/javascript">
		//check correct values
		function submitUserForm() {
			var name = $('#name').val().trim();
			var age = $('#age').val();
			var isAdmin = $('#isAdmin').val();

			if(name.length ==0) {
				alert('Please enter name');
				$('#name').focus();
				return false;
			}

			if (isNaN(age) || (parseInt(age) != age)) {
				alert( "Incorrect value in field Age" );
				$('#age').focus();
				return false;
			}

			if(age <= 0) {
				alert('Incorrect value in field Age: enter positive value');
				$('#age').focus();
				return false;
			}

			if (!(((isAdmin+"")=="true")||((isAdmin+"")=="false")||(isAdmin==1)||(isAdmin==0))) {
				alert("Incorrect values in field isAdmin (possible values:'1','0','true','false')")
				return false;
			}
			return true;
		}

	</script>

</head>
<body>

<h2>Users List</h2>

<form action="searchUser">
<div class="row">
	<div class="tg"><div class="tg">Name pattern:</div><div class="tg">
		<input type="text" name="searchName" id="searchName" value=${NameSearch}></div></div>
	<div ><input type='submit' value='Search'/></div>
</div>
</form>

<c:if test="${!empty NameSearch}">
	<h4 class="tg">name's pattern "${NameSearch}" :</h4>
</c:if>

<br>
<c:if test="${!empty listPersons}">
	<table class="tg">
	<tr>
		<th width="80">User ID</th>
		<th width="120">User Name</th>
		<th width="40">User Age</th>
		<th width="40">isAdmin</th>
		<th width="80">CreatedDate</th>
		<th width="60">Edit</th>
		<th width="60">Delete</th>
	</tr>
	<c:forEach items="${listPersons}" var="person">
		<tr>
			<td>${person.id}</td>
			<td>${person.name}</td>
			<td>${person.age}</td>
			<td>${person.isAdmin}</td>
			<td>${person.createdDate}</td>
			<td><a href="<c:url value='/edit/${person.id}' />" >Edit</a></td>
			<td><a href="<c:url value='/remove/${person.id}' />" >Delete</a></td>
		</tr>
	</c:forEach>
	</table>
</c:if>

<br>

<h3>
	Add a User
</h3>
<h5>Please use only English characters</h5>
<c:url var="addAction" value="/add" ></c:url>
<form:form action="${addAction}" commandName="person">
	<table>
		<c:if test="${!empty person.name}">
			<tr>
				<td>
					<form:label path="id">
						<spring:message text="ID"/>
					</form:label>
				</td>
				<td>
					<form:input path="id" readonly="true" size="8"  disabled="true" />
					<form:hidden path="id" />
				</td>
			</tr>
		</c:if>
		<tr>
			<td>
				<form:label path="name">
					<spring:message text="Name"/>
				</form:label>
			</td>
			<td>
				<form:input path="name"/>
			</td>
		</tr>
		<tr>
			<td>
				<form:label path="age">
					<spring:message text="Age"/>
				</form:label>
			</td>
			<td>
				<form:input path="age" />
			</td>
		</tr>
		<tr>
			<td>
				<form:label path="isAdmin">
					<spring:message text="isAdmin"/>
				</form:label>
			</td>
			<td>
				<form:input path="isAdmin" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:if test="${!empty person.name}">
					<input type="submit"
						   value="<spring:message text="Edit Person"/>" onclick="return submitUserForm();" />
				</c:if>
				<c:if test="${empty person.name}">
					<input type="submit"
						   value="<spring:message text="Add Person"/>" onclick="return submitUserForm();"/>
				</c:if>
			</td>
		</tr>
	</table>
</form:form>
<h5>
	Created by Kuvakin Alexander specially for JavaRush
</h5>
</body>
</html>
