<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.cya.dao.NoticeDao,com.cya.pojo.Notice,com.cya.pojo.Admin,com.cya.dao.AdminDao,com.cya.pojo.Book,com.cya.dao.BookDao" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title>图书管理系统</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/bootstrap.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/bootstrap-theme.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/bootstrap-admin-theme.css">
        <script src="${pageContext.request.contextPath}/books/js/jquery-3.1.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/books/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/books/js/bootstrap-dropdown.min.js"></script>
        <script src="${pageContext.request.contextPath}/books/js/reader.js"></script>

        <script src="${pageContext.request.contextPath}/books/js/readerUpdateInfo.js"></script>
        <script src="${pageContext.request.contextPath}/books/js/readerUpdatePwd.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/books/css/index.css" />
	</head>

	<body>
	
	<!-- 判断是否已经登录 -->
  <%
  Admin admin = new Admin();
  String uid = (String) session.getAttribute("uid");
  if(uid==null || uid.equals("")){
	  //没有登录
	  response.sendRedirect("../login.jsp"); //重定向到登录页面
      return ;
  }
  else{
	  AdminDao admindao = new AdminDao();
      admin = admindao.get_AidInfo2(uid);
  }


   %>

		<div class="head">
			<img class="img" src="${pageContext.request.contextPath}/books/img/title-yellow1.png"></img>
			<div class="userName">
				<a href="${pageContext.request.contextPath}/books/user/index.jsp"><% out.write(admin.getName());%></a>
			</div>
			<div class="daohang">
				<ul>
					<li style="margin-left: 100px;">
						<a href="${pageContext.request.contextPath}/books/user/select.jsp">图书查询</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/books/user/borrow.jsp">借阅信息</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/books/user/history.jsp">借阅历史</a>
					</li>
					<li class="dropdown">
						<a href="#" class="" role="button" data-hover="dropdown">我的</a>
						<ul class="dropdown-menu">
                                <li><a href="#updateinfo" data-toggle="modal">个人资料</a></li>
                                <li><a href="#updatepwd" data-toggle="modal">修改密码</a></li>
                                <li><a href="/manage_books/ExitServlet?id=<%=uid %>&&status=uid">退出</a></li>
                         </ul>
					</li>
				</ul>
			</div>
		</div>
		<div style="width: 100%;float: left;height: 310px;"></div>
		<div class="body">
			<div class="content">
				<div class="left">
					<div class="gongGao">
					<%
					    //获取公告
					    List<Notice> noticeList=new ArrayList<Notice>();
					    NoticeDao noticeDao=new NoticeDao();
					    noticeList=noticeDao.get_ListInfo();
					    if(noticeList.size()<=0){
					    	Notice notice=new Notice();
					    	notice.setnContext("暂无公告，等待管理员发布哦");
					    	notice.setnPerson("");
					    	notice.setnTime(null);
					    	noticeList.add(notice);
					    }
					    System.out.print(noticeList);
					%>
						<div class="title">公 告</div>
						<div class="context import">
						  <marquee width="100%" height="100%" direction="up" scrolldelay="200">
						    <% for(Notice bean:noticeList){ %>
						    <label>发布人：<%=bean.getnPerson() %></label><br>
						    <label>发布时间：<%=bean.getnTime() %></label><br>
						    <label><%=bean.getnContext() %></label><br>
						    <label>-------------------------------------------</label><br>
						    <%} %>
						  </marquee>
						
						</div>
					</div>
					<div class="gongGao">
						<div class="title">华 广 图 书 馆</div>
						<div class="context">
						   <a href="https://www.baidu.com">》百度一下</a>
						   <a href="https://www.7k7k.com">》7k7k小游戏</a>
						   <a href="https://www.4399.com">》4399小游戏</a>
						   <a href="https://www.bilibili.com">》哔哩哔哩动画</a>
						</div>
					</div>
					<div class="gongGao" style="height:400px;">
						<div class="title">gcu library</div>
						<div class="context">
						   <div style="font-size:14px; width: 100%;  height: 400px;margin-bottom: 20px;">
			<div style="padding: 5px;  color: black">
                                <label style="font-size:15px;font-weight: normal;">图书馆条约</label><br />
				<label style="font-size:15px;font-weight: normal;">1、保持安静</label><br />
				<label style="font-size:15px;font-weight: normal;">2、注意卫生</label><br />
				<label style="font-size:15px;font-weight: normal;">3、注意携带个人物品</label><br />
				<label style="font-size:15px;font-weight: normal;">4、好好学习，天天向上</label>
			</div>
                        <img width="160px" style="position: relative;left: 50%;margin-left: -80px;" src="${pageContext.request.contextPath}/books/img/hg.jpg" />
		</div>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="container">
    <!-- left, vertical navbar & content -->
    <div class="row">

        <!-- content -->
        <div class="col-md-10">

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default bootstrap-admin-no-table-panel">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">查询</div>
                        </div>
                        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                            <form class="form-horizontal" action="/manage_books/selectServlet" method="post">
                                <input type="hidden" name="tip" value="2">
                                <div class="col-lg-8 form-group">
                                    <label class="col-lg-4 control-label" for="query_bname">图书名称</label>
                                    <div class="col-lg-8">
                                        <input class="form-control" id="bookName" name="name" type="text" value="">
                                        <label class="control-label" for="query_bname" style="display: none;"></label>
                                    </div>
                                </div>


                                <div class="col-lg-4 form-group">

                                    <button type="submit" class="btn btn-primary" id="btn_query">查询</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-lg-12">
                    <table id="data_list" class="table table-hover table-bordered" cellspacing="0" width="100%">
                        <thead>
                        <tr>
                            <th>图书号</th>
                            <th>图书类型</th>
                            <th>图书名称</th>
                            <th>作者名称</th>
                            <th>出版社</th>
                            <th>总数量</th>
                            <th>操作</th>

                        </tr>
                        </thead>


                        <!---在此插入信息-->
                        <!---在此插入信息-->
                        <%
                            ArrayList<Book> bookdata = new ArrayList<Book>();
                            bookdata = (ArrayList<Book>) request.getAttribute("data");
                            if (bookdata == null) {
                                BookDao bookdao = new BookDao();
                                bookdata = (ArrayList<Book>) bookdao.get_ListInfo();
                               
                            }

                            for (Book bean:bookdata) {
                        %>
                        
                        <tbody>
                        <td><%=bean.getCard() %></td>
                        <td><%=bean.getType() %></td>
                        <td><%=bean.getName() %></td>
                        <td><%=bean.getAutho() %></td>
                        <td><%=bean.getPress() %></td>
                        <td><%=bean.getNum() %></td>
                        <td>
                            <button type="button" class="btn btn-info btn-xs" data-toggle="modal"
                                    onclick="borrowbook(<%= bean.getBid() %>)">借阅</button>
                        </td>
                    
                        </tbody>
                        <%} %>
                      

                    </table>


                </div>
            </div>

            <script type="text/javascript">
            
           
                function borrowbook(bid) {
                    con = confirm("是否借阅?");
                    if (con == true) {
                        location.href = "/manage_books/borrowServlet?status=user&tip=1&bid=" + bid;
                    }
                }
            </script>
        </div>
    </div>
</div>
					
				</div>
			</div>
		</div>
		
		<div class="foot"><label class="lable">华广掌上图书馆</label></div>
		
		<!-------------------------个人资料模糊框------------------------------------->

<form class="form-horizontal" method="post" action="/manage_books/AdminServlet">   <!--保证样式水平不混乱-->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="updateinfo" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="ModalLabel">
                        个人资料
                    </h4>
                </div>

                <div class="modal-body">

                    <!--正文-->
                    <input type="hidden" name="tip" value="2">
                    <input type="hidden" name="url" value="user/select">
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">真实姓名</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="name" name="name" placeholder="请输入您的真实姓名"
                                   value='<% out.write(admin.getName());%>'>
                            <label class="control-label" for="name" style="display: none"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">手机号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="请输入您的手机号"
                                   value='<% out.write(admin.getPhone());%>'>
                            <label class="control-label" for="phone" style="display: none"></label>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">邮箱</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="email" name="email" placeholder="请输入您的邮箱"
                                   value='<% out.write(admin.getEmail());%>'>
                            <label class="control-label" for="email" style="display: none"></label>
                        </div>
                    </div>

                    <!--正文-->


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="submit" class="btn btn-primary">
                        修改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</form>
<!-------------------------------------------------------------->

<!-------------------------------------------------------------->

<form class="form-horizontal" method="post" action="/manage_books/AdminServlet">   <!--保证样式水平不混乱-->
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="updatepwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        修改密码
                    </h4>
                </div>
                <div class="modal-body">

                    <!--正文-->
                    <input type="hidden" name="tip" value="1">
                    <input type="hidden" name="url" value="user/select">
                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">原密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" name="password" id="oldPwd"
                                   placeholder="请输入原密码">
                            <label class="control-label" for="oldPwd" style="display: none"></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="firstname" class="col-sm-3 control-label">新密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" name="password2" id="newPwd"
                                   placeholder="请输入新密码">
                            <label class="control-label" for="newPwd" style="display: none"></label>
                        </div>
                    </div>

                    <!--正文-->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="submit" class="btn btn-primary">
                        修改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</form>
<!-------------------------------------------------------------->

	</body>

</html>