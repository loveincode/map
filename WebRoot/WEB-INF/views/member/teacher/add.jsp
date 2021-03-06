<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/common/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>
<title>添加</title>
<%@include file="/WEB-INF/views/common/commoncss.jsp" %>
<link href="${ctxStatic}/user/css/plugins/chosen/chosen.css" rel="stylesheet">
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content">
        <div class="row">
         <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>新增</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="row form-body form-horizontal m-t">
                       		
                        <!-- ********* Form start  *********  -->
	                    <form class="form-horizontal m-t" id="addform">
							<div class="col-md-12">
								<div class="form-group">
									<label class="col-sm-4 control-label">用户名：</label>
									<div class="col-sm-4">
										<input type="text" id="username" name="username" class="form-control required"
											placeholder="请输入用户名" onblur="onblus()">
										<font id="errorpass" style="display:none" color="red">用户名存在，请重新输入用户名</font>
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label class="col-sm-4 control-label">密码：</label>
									<div class="col-sm-4">
										<input type="password" id="password" name="password" class="form-control required"
											placeholder="请输入密码">
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label class="col-sm-4 control-label">真实名：</label>
									<div class="col-sm-4">
										<input type="text" id="realname" name="realname" class="form-control required"
											placeholder="请输入真实名">
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label class="col-sm-4 control-label">手机号：</label>
									<div class="col-sm-4">
										<input type="text" id="phone" name="phone" class="form-control required isPhone"
											placeholder="请输入手机号">
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label class="col-sm-4 control-label">邮箱：</label>
									<div class="col-sm-4">
										<input type="text" id="email" name="email" class="form-control required email"
											placeholder="请输入邮箱">
									</div>
								</div>
							</div>
							
							<div class="col-md-12">
								<div class="form-group">
									<label class="col-sm-4 control-label">管理班级权限：</label>
									<div class="col-sm-4">
										<select data-placeholder="选择班级" id="manageClass" name="manageClass"
											class="chosen-select" multiple style="width:350px;" tabindex="4">
		                                    <c:forEach items="${administrativeClasss}" var="administrativeClass">
				        					<option value="${administrativeClass.id}" hassubinfo="true">${administrativeClass.name}</option>
				        					</c:forEach> 
		                                </select>	
									</div>
								</div>
							</div>
							
							<div class="col-md-7 col-sm-offset-5">
								<button  class="btn btn-primary"  type="submit"   >
								<i class="fa fa-check"> </i>新增</button>
							</div>
						</form>
						<!-- ********* Form end  *********  -->
						
                        </div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- 全局js -->
	<%@include file="/WEB-INF/views/common/commonjs.jsp" %>
	
	<!-- jQuery Validation plugin javascript-->
	<script src="${ctxStatic}/user/js/plugins/validate/jquery.validate.min.js"></script>
	<script src="${ctxStatic}/user/js/plugins/validate/messages_zh.min.js"></script>
	<script src="${ctxStatic}/js/ajaxfileupload.js"></script>
	
	<script src="${ctxStatic}/user/js/plugins/chosen/chosen.jquery.js"></script>
	<script>
		var t = 0;
		
		function onblus(){ 
			$.ajax({
				type : "post",
				contentType:"application/x-www-form-urlencoded; charset=utf-8",
				url : "${ctxStatic}/personal/checkusername",
				data : {
					username : $("#username").val(),
				},
				dataType : "json",
				async : true,
				success : function(data) {
					if(data.success==false){
						$('#errorpass').css('display','block');
						t = 0;
					}
					else{
						$('#errorpass').css('display','none');
						t = 1;
					}
               		console.log(data);
				},
				error : function(data) {
					alert("error");
				}
			});
		}
	</script>
	<script type="text/javascript">
	
	/* var config = {
		".chosen-select": {},
		".chosen-select-deselect": {
			allow_single_deselect: !0
		},
		".chosen-select-no-single": {
			disable_search_threshold: 10
		},
		".chosen-select-no-results": {
			no_results_text: "Oops, nothing found!"
		},
		".chosen-select-width": {
			width: "95%"
		}
	}; */
	/* for (var selector in config) $(selector).chosen(config[selector]); */
	$(".chosen-select").chosen();
	
		//数据校验
	$().ready(function () {
		// 在键盘按下并释放及提交后验证提交表单
		$("#addform").validate({
			rules: {
				username: {
					maxlength: 10,
				},
				password: {
				    minlength:6,
					maxlength: 15,
				},
			},
			submitHandler: function (form) {
				var manageClasss ='';
				$("#manageClass option:selected").each(function(){
					manageClasss += $(this).val()+",";
				});
				console.log(manageClasss);
				if(t==1){
				$.ajax({
					type : "post",
					contentType:"application/x-www-form-urlencoded; charset=utf-8",
					url : "${ctxStatic}/teachermember/add",
					data : {
						username : $("#username").val(),
						password : $("#password").val(),
						realname : $("#realname").val(),
						phone : $("#phone").val(),
						email : $("#email").val(),
						manageClass: manageClasss,
					},
					dataType : "json",
					async : true,
					success : function(data) {
						alert(data.message);
	               		console.log(data);
						window.location.href = "${ctxStatic}/teachermember/index";
					},
					error : function(data) {
						alert("error");
					} 
				}); 
				}
			}
		})
		;
	});
	</script>
</body>
</html>