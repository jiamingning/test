<%@ page language="java" import="java.util.*,dao.*,dao.impl.*,entity.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>��ӭ��������ѧԱ��̳</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<Link rel="stylesheet" type="text/css" href="style/style.css" />
</HEAD>

<BODY>

<DIV>
	<IMG src="image/logo.gif">
</DIV>

<!--      �û���Ϣ����¼��ע��        -->
<%
User loginedUser=(User)session.getAttribute("loginedUser");
if(loginedUser!=null){
 %>
 <DIV class="h">
	��ӭ����<%=loginedUser.getUName() %>
	&nbsp;| &nbsp; <A href="logOut.jsp">�ǳ�</A> |
</DIV>
<%
}
else{
 %>  
<DIV class="h">
	����δ��<a href="login.jsp">��¼</a>
	&nbsp;| &nbsp; <A href="reg.jsp">ע��</A> |
</DIV>
<%
}
 %>
<!--      ����        -->
<DIV class="t">
	<TABLE cellSpacing="0" cellPadding="0" width="100%">
		<TR class="tr2" align="center">
			<TD colSpan="2">��̳</TD>
			<TD style="WIDTH: 10%;">����</TD>
			<TD style="WIDTH: 30%">��󷢱�</TD>
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
		
	<!--       �����       -->
		
		<TR class="tr3">
			<TD colspan="4"><%=mainBoard.getBoardName() %></TD>
		</TR>
	<!--       �Ӱ��       -->
		
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
Information Technology Co.,Ltd ��Ȩ����</CENTER>
</BODY>
</HTML>
