<%@ page language="java" import="java.util.*,dao.*,dao.impl.*,entity.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>����ѧԱ��̳--����</TITLE>
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
	int topicId=Integer.parseInt(request.getParameter("topicId"));
	int boardId=Integer.parseInt(request.getParameter("boardId"));
	int p1=Integer.parseInt(request.getParameter("p1"));
	TopicDao td=new TopicDaoImpl();
	UserDao ud=new UserDaoImpl();
	ReplyDao rd=new ReplyDaoImpl();
	BoardDao bd=new BoardDaoImpl();
	Board board=bd.findBoard(boardId);
    Topic topic=td.findTopic(topicId);
    User topicUser=ud.findUser(topic.getUid());   
    
    
    
    
    
	 %>
<!--      ����        -->
<DIV><br/>
	<!--      ����        -->
<DIV>
	&gt;&gt;<B><a href="index.jsp">��̳��ҳ</a></B>&gt;&gt;
	<B><a href="list.jsp?p=1&boardId=<%=boardId%>"><%=board.getBoardName() %></a></B>
</DIV>
	<br/>
	<!--      �ظ�������        -->
	<DIV>
		<A href="reply.jsp?boardId=<%=boardId%>&topicId=<%=topic.getTopicId()%>"><IMG src="image/reply.gif"  border="0" id=td_post></A> 
		<A href="post.jsp?boardId=<%=boardId%>"><IMG src="image/post.gif"   border="0" id=td_post></A>
	</DIV>
	<%
	List replyList=rd.findListReply(p1, topic.getTopicId());
	
	
	int prep=p1;
    int nextp=p1;
    if(replyList.size()==10)
	    nextp=p1+1;
    if(p1>1)
	  prep=p1-1;
	 %>
	<!--         �� ҳ         -->
	<DIV>
		<a href="detail.jsp?p1=<%=prep%>&topicId=<%=topicId%>&boardId=<%=boardId%>">��һҳ</a>|
		<a href="detail.jsp?p1=<%=nextp%>&topicId=<%=topicId%>&boardId=<%=boardId%>">��һҳ</a>
	</DIV>
	<!--      ��ҳ����ı���        -->
	<DIV>
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR>
				<TH class="h">��ҳ����: <%=topic.getTitle()%></TH>	
			</TR>
			<TR class="tr2">
				<TD>&nbsp;</TD>
			</TR>
		</TABLE>
	</DIV>
	

	
	<!--      ����        -->
	
	<DIV class="t">
		<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
			<TR class="tr1">
				<TH style="WIDTH: 20%">
					<B><%=topicUser.getUName() %></B><BR/>
					<img src="image/head/<%=topicUser.getHead()%>"/><BR/>
					ע��:<%=topicUser.getRegTime().substring(0, 10) %><BR/>
				</TH>
				<TH>
					<H4><%=topic.getTitle() %></H4>
					<DIV><%=topic.getContent() %></DIV>
					<DIV class="tipad gray">
						����[<%=topic.getPublishTime().substring(0, 16) %>] &nbsp;
						����޸�:[<%=topic.getModifyTime().substring(0, 16) %>]
					</DIV>
				</TH>
			</TR>
		</TABLE>
	</DIV>
	
	<%
	
	
	for(int i=0;i<replyList.size();i++){	
	  Reply reply= (Reply)replyList.get(i);
	  User replyUser=ud.findUser(reply.getUid());
	 %>
	
	<!--      �ظ�        -->
	
	<DIV class="t">
		<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
			<TR class="tr1">
				<TH style="WIDTH: 20%">
					<B><%=replyUser.getUName() %></B><BR/><BR/>
					<img src="image/head/<%=replyUser.getHead()%>"/><BR/>
					ע��:<%=replyUser.getRegTime().substring(0, 10) %><BR/>
				</TH>
				<TH>
					<H4><%=reply.getTitle() %></H4>
					<DIV><%=reply.getContent() %></DIV>
					<DIV class="tipad gray">
						����[<%=reply.getPublishTime().substring(0, 16) %>] &nbsp;
						����޸�:[<%=reply.getModifyTime().substring(0, 16) %>]
<%

						if(loginedUser.getUID()==replyUser.getUID()){
 %>						
						<A href="manage/doDeleteReply.jsp">[ɾ��]</A>
						<A href="update.jsp">[�޸�]</A>
						
		<%
		}		
		 %>				
						
					</DIV>
				</TH>
			</TR>
		</TABLE>
	</DIV>
<%
}

 %>	
	
	
</DIV>

<!--      ����        -->
<BR>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
Information Technology Co.,Ltd ��Ȩ����</CENTER>
</BODY>
</HTML>
