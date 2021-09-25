<%@ page language="java" import="java.util.*,dao.*,dao.impl.*,entity.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>青鸟学员论坛--看贴</TITLE>
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
<!--      主体        -->
<DIV><br/>
	<!--      导航        -->
<DIV>
	&gt;&gt;<B><a href="index.jsp">论坛首页</a></B>&gt;&gt;
	<B><a href="list.jsp?p=1&boardId=<%=boardId%>"><%=board.getBoardName() %></a></B>
</DIV>
	<br/>
	<!--      回复、新帖        -->
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
	<!--         翻 页         -->
	<DIV>
		<a href="detail.jsp?p1=<%=prep%>&topicId=<%=topicId%>&boardId=<%=boardId%>">上一页</a>|
		<a href="detail.jsp?p1=<%=nextp%>&topicId=<%=topicId%>&boardId=<%=boardId%>">下一页</a>
	</DIV>
	<!--      本页主题的标题        -->
	<DIV>
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR>
				<TH class="h">本页主题: <%=topic.getTitle()%></TH>	
			</TR>
			<TR class="tr2">
				<TD>&nbsp;</TD>
			</TR>
		</TABLE>
	</DIV>
	

	
	<!--      主题        -->
	
	<DIV class="t">
		<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
			<TR class="tr1">
				<TH style="WIDTH: 20%">
					<B><%=topicUser.getUName() %></B><BR/>
					<img src="image/head/<%=topicUser.getHead()%>"/><BR/>
					注册:<%=topicUser.getRegTime().substring(0, 10) %><BR/>
				</TH>
				<TH>
					<H4><%=topic.getTitle() %></H4>
					<DIV><%=topic.getContent() %></DIV>
					<DIV class="tipad gray">
						发表：[<%=topic.getPublishTime().substring(0, 16) %>] &nbsp;
						最后修改:[<%=topic.getModifyTime().substring(0, 16) %>]
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
	
	<!--      回复        -->
	
	<DIV class="t">
		<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" cellSpacing="0" cellPadding="0" width="100%">
			<TR class="tr1">
				<TH style="WIDTH: 20%">
					<B><%=replyUser.getUName() %></B><BR/><BR/>
					<img src="image/head/<%=replyUser.getHead()%>"/><BR/>
					注册:<%=replyUser.getRegTime().substring(0, 10) %><BR/>
				</TH>
				<TH>
					<H4><%=reply.getTitle() %></H4>
					<DIV><%=reply.getContent() %></DIV>
					<DIV class="tipad gray">
						发表：[<%=reply.getPublishTime().substring(0, 16) %>] &nbsp;
						最后修改:[<%=reply.getModifyTime().substring(0, 16) %>]
<%

						if(loginedUser.getUID()==replyUser.getUID()){
 %>						
						<A href="manage/doDeleteReply.jsp">[删除]</A>
						<A href="update.jsp">[修改]</A>
						
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

<!--      声明        -->
<BR>
<CENTER class="gray">2007 Beijing Aptech Beida Jade Bird
Information Technology Co.,Ltd 版权所有</CENTER>
</BODY>
</HTML>
