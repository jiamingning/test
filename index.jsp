<%@ page language="java" import="java.util.*,dao.*,dao.impl.*,entity.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>欢迎访问青鸟学员论坛</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<Link rel="stylesheet" type="text/css" href="style/style.css" />
</HEAD>

<BODY>

<DIV>
	<IMG src="image/logo.gif">
</DIV>

<!--      用户信息、登录、注册        -->
<%
User loginedUser=(User)session.getAttribute("loginedUser");
if(loginedUser!=null){
 %>
 <DIV class="h">
	欢迎您！<%=loginedUser.getUName() %>
	&nbsp;| &nbsp; <A href="logOut.jsp">登出</A> |
</DIV>
<%
}
else{
 %>  
<DIV class="h">
	您尚未　<a href="login.jsp">登录</a>
	&nbsp;| &nbsp; <A href="reg.jsp">注册</A> |
</DIV>
<%
}
 %>
<!--      主体        -->
<DIV class="t">
	<TABLE cellSpacing="0" cellPadding="0" width="100%">
		<TR class="tr2" align="center">
			<TD colSpan="2">论坛</TD>
			<TD style="WIDTH: 10%;">主题</TD>
			<TD style="WIDTH: 30%">最后发表</TD>
		</TR>
		
<%
		TopicDao td=new TopicDaoImpl();
		UserDao ud=new UserDaoImpl();
		BoardDao boardDao=new BoardDaoImpl();
		Map mapBoard=boardDao.findBoard();
		List listMainBoard=(List) mapBoard.get(new Integer(0));
		for (int i = 0; i < listMainBoard.size(); i++) {
			Board mainBoard=(Board) listMainBoard.get(i);	
			List listSonBoard=(List) mapBoard.get(new Integer(mainBoard.getBoardId()));
					
 %>				
		
	<!--       主版块       -->
		
		<TR class="tr3">
			<TD colspan="4"><%=mainBoard.getBoardName() %></TD>
		</TR>
	<!--       子版块       -->
		
<%
	for (int j = 0; j < listSonBoard.size(); j++) {
				Board board=(Board) listSonBoard.get(j);	
				List list=td.findListTopic(1, board.getBoardId());
				Topic topic=(Topic)list.get(0);
				User user=ud.findUser(topic.getUid());
 %>	
		<TR class="tr3">
			<TD width="5%">&nbsp;</TD>
			<TH align="left">
				<IMG src="image/board.gif">
				<A href="list.jsp?p=1&boardId=<%=board.getBoardId()%>"><%=board.getBoardName() %></A>
			</TH>
			<TD align="center"><%=td.findCountTopic(board.getBoardId())%></TD>
			<TH>
				<SPAN>
					<A href="detail.jsp?p1=1&topicId=<%=topic.getTopicId()%>&boardId=<%=board.getBoardId()%>"><%=topic.getTitle() %></A>
				</SPAN>
				<BR/>
				<SPAN><%=user.getUName() %></SPAN>
				<SPAN class="gray"><%=topic.getPublishTime().substring(0,16) %></SPAN>
			</TH>
		</TR>
<%

}
}

 %>		
		
		
	</TABLE>
</DIV>

<BR/>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
Information Technology Co.,Ltd 版权所有</CENTER>
</BODY>
</HTML>
