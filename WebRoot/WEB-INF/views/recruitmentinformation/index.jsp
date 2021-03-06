<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/common/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>
	<title>INDEX</title>
   <%@include file="/WEB-INF/views/common/commoncss.jsp" %>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content">
    	
    	<!-- ************************* Search Form Start  ************************* -->
    	<div class="row">
    	
    		<div class="col-md-3">
				<div class="form-group">
					<label class="col-sm-3 control-label" style="padding-left:5px;padding-top:6px;">单位：</label>
					<div class="col-sm-9">
						<input id="scompanyName" name="scompanyName" class="form-control"
								type="text" aria-required="true" aria-invalid="true"
								class="error" value="" placeholder="模糊">
					</div>
				</div>
			</div>
			
			<div class="col-md-3">
				<div class="form-group">
					<label class="col-sm-3 control-label" style="padding-left:5px;padding-top:6px;">类型：</label>
					<div class="col-sm-9">
						<select name="scompanyType" id="scompanyType" class="form-control">
        			 		<option value="-1">全部</option>
							<option>国有企业</option>
							<option>民营企业</option>
							<option>党政机关</option>
							<option>高等教育单位</option>
							<option>其他事业单位</option>
							<option>三资企业</option>
							<option>科研设计单位</option>
							<option>中初教育单位</option>
							<option>部队单位</option>
							<option>医疗卫生单位</option>
      					</select>
					</div>
				</div>
			</div>

		    <div class="col-md-3" style="padding-left:45px;">
            <button type="button"  id="query-btn" class="btn btn-success" ><i class="fa fa-search"></i> 搜索</button>
            <button type="button" id="addBtn" class="btn btn-primary" style="margin-left:10px;"> <i class="fa fa-plus-circle"></i>添加</button>
          	</div>
       </div>
       <!-- *************************   Search Form End  ************************* -->


	   <!-- *************************     Table Start    ************************* -->
       <div class="row">
           <div class="col-sm-12">
               <div class="ibox float-e-margins">
                       </br>
						<div class="mt-20">
							<table id="data-Table" class="table table-border table-bordered table-bg table-hover table-sort">
								<thead>
									<tr class="text-c">
										<th>id</th>
										<th>主题</th>
										<th>单位</th>
										<th>单位类型</th>
										<th>招聘截止日期</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
             </div>
       </div>
       <!-- *************************     Table End    ************************* -->
   </div>
   
    <!-- 全局js -->
    <%@include file="/WEB-INF/views/common/commonjs.jsp" %>
    
    <script src="${ctxStatic}/user/js/plugins/footable/footable.all.min.js"></script>
	<script src="${ctxStatic}/js/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script src="${ctxStatic}/user/js/plugins/dataTables/dataTables.bootstrap.js"></script>
	<script src="${ctxStatic}/user/js/demo/layer-demo.min.js"></script>
    <!-- 自定义js -->
    <script src="${ctxStatic}/user/js/content.min.js?v=1.0.0"></script>
    <script type="text/javascript">
    
    $('#addBtn').click(function () {
        window.location.href = "${ctxStatic}/recruitmentinformation/addPage";
    });
    
    var companyName1;
    var companyType1;

	$(document).ready(function(){
		
		var table = $('#data-Table').dataTable( {
		    "lengthChange":true, //是否允许用户自定义显示数量
		    "bPaginate":true, //翻页功能
		    "info": true, //页脚信息
			"pagingType": "full_numbers",
			"searching":false, //本地搜索
			"ordering":true, //排序功能
			"autoWidth":true, //自动宽度
			//是否开启不限制长度的滚动条
			"processing": false,
			"serverSide": true,
	        "ajax": {
	        	url:"${ctxStatic}/recruitmentinformation/data",
	    		headers: {
				        Accept: "application/json; charset=utf-8"
				    },
				type: "post",
			    data: function(request){   	
				    	if(companyName1 !=null && companyName1!="")
				    	{
				    		request.companyName = companyName1;
				    	}
				    	if(companyType1 !=null && companyType1!="")
				    	{
				    		request.companyType = companyType1;
				    	}
			    	return request;
			        }
	        },
	        "columns": [
	        	{ "data": "id","orderable":false},
	            { "data": "theme","orderable":false},
	            { "data": "companyName","orderable":false},
	            { "data": "companyType","orderable":false},
	            { "data": "deadline","orderable":false},
	            { "data": "Uuid","orderable":false}
	        ], 
	        "columnDefs": [
	            {
	            "defaultContent":"",
	            "targets":['_all']
	            },
	            {
	            "render": function(data, type, row) {
	                return "<a href='${ctxStatic}/recruitmentinformation/modifyPage?uuid=" + data + "'><i class=\"fa fa-edit text-navy\"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a value='" + data + "' onclick=deletefunc(" + "\'" + data + "\'" +")><i class=\"fa fa-times text-navy\"></i></a>";
	            },
	            "targets": 5}
	        ]
	    } );
	    
	    //综合搜索
	    $("#query-btn").on("click",function(){
			companyName1 = $("#scompanyName").val();
	    	companyType1 = $("#scompanyType").val();
	    	table.api().ajax.reload();
	    });
  
	}); 
	
	function deletefunc(data){
	    var result = confirm("确定要删除吗？");
       	if(result){
           $.ajax
           ({ 
               url: "delete?uuid="+data,
               method: 'GET',
               dataType: "json", 
               data: { 
               },
               success: function (data) {
               		alert(data.message);
               		console.log(data);
                    window.location.reload();
               }
           })
       	}
	}

</script>

</body>

</html>