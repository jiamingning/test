<%@ page language="java" import="java.util.*,dao.*,dao.impl.*,entity.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>����ѧԱ��̳--�����б�</TITLE>
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

<%

request.setCharacterEncoding("gbk");
int p=Integer.parseInt(request.getParameter("p"));
int boardId=Integer.parseInt(request.getParameter("boardId"));
BoardDao bd=new BoardDaoImpl();
Board board=bd.findBoard(boardId);



TopicDao td=new TopicDaoImpl();
UserDao ud=new UserDaoImpl();
ReplyDao rd=new ReplyDaoImpl();
List list=td.findListTopic(p, boardId);

int prep=p;
int nextp=p;
if(list.size()==20)
	nextp=p+1;
if(p>1)
	prep=p-1;
	
 %>
 
<!--      ����        -->
<DIV>
<!--      ����        -->
<br/>
<DIV>
	&gt;&gt;<B><a href="index.jsp">��̳��ҳ</a></B>&gt;&gt;
	<B><a href="list.jsp?p=1&boardId=<%=boardId%>"><%=board.getBoardName() %></a></B>
</DIV>
<br/>
<!--      ����        -->
	<DIV>
		<A href="post.jsp?boardId=<%=boardId%>"><IMG src="image/post.gif" name="td_post" border="0" id=td_post></A>
	</DIV>
<!--         �� ҳ         -->
	<DIV>
		<a href="list.jsp?p=<%=prep%>&boardId=<%=boardId%>">��һҳ</a>|
		<a href="list.jsp?p=<%=nextp%>&boardId=<%=boardId%>">��һҳ</a>
	</DIV>

	<DIV class="t">
		<TABLE cellSpacing="0" cellPadding="0" width="100%">		
			<TR>
				<TH class="h" style="WIDTH: 100%" colSpan="4"><SPAN>&nbsp;</SPAN></TH>
			</TR>
<!--       �� ͷ           -->
			<TR class="tr2">
				<TD>&nbsp;</TD>
				<TD style="WIDTH: 80%" align="center">����</TD>
				<TD style="WIDTH: 10%" align="center">����</TD>
				<TD style="WIDTH: 10%" align="center">�ظ�</TD>
			</TR>
<!--         �� �� �� ��        -->

<%
for(int i=0;i<list.size();i++){
   Topic topic= (Topic)list.get(i);
   User user=ud.findUser(topic.getUid()); //���ҵ�������

 %>			
			<TR class="tr3">
				<TD><IMG src="image/topic.gif" border=0></TD>
				<TD style="FONT-SIZE: 15px">
					<A href="detail.jsp?p1=1&topicId=<%=topic.getTopicId()%>&boardId=<%=boardId%>"><%=topic.getTitle() %></A>
				</TD>
				<TD align="center"><%=user.getUName() %></TD>
				<TD align="center"><%=rd.findCountReply(topic.getTopicId()) %></TD>
			</TR>
			
<%
}
 %>
			
		</TABLE>
	</DIV>
<!--            �� ҳ          -->
	<DIV>
		<a href="list.jsp?p=<%=prep%>&boardId=<%=boardId%>">��һҳ</a>|
		<a href="list.jsp?p=<%=nextp%>&boardId=<%=boardId%>">��һҳ</a>
	</DIV>
</DIV>
<!--             �� ��          -->
<BR/>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
Information Technology Co.,Ltd ��Ȩ����</CENTER>

</BODY>
</HTML>
