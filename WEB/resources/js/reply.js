console.log("Reply Module.......");
var replyService = (function(){
	
	function add(cmt_content, callback, error){
		console.log("add cmt_content......");
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(cmt_content),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error) {
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error){
		var cmt_board = param.cmt_board;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + cmt_board + "/" + page + ".json",
				function(data){
			if(callback){
				callback(data.cmt_cnt, data.list);
			}
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	
	function remove(cmt_id, cmt_writer, callback, error){
		$.ajax({
			type : 'delete',
			url :  '/replies/' + cmt_id,
			
			data : JSON.stringify({cmt_id:cmt_id, cmt_writer:cmt_writer}),
			
			contentType : "application/json; charset=utf-8",
			
			success : function(deleteResult, status, xhr) {
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});	
	}
	
	function update(cmt_content, callback, error){
		console.log("cmt_id : cmt_content.cmt_id");
		$.ajax({
			type : 'put',
			url : '/replies/' + cmt_content.cmt_id,
			data : JSON.stringify(cmt_content),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
			if(callback) {
				callback(result);
			}
		},
		error : function(xhr, status, er) {
			if(error){
				error(er);
			}
		}
	});
}
	function get(cmt_id, callback, error){
		$.get("/replies/" + cmt_id + ".json", function(result){
			if(callback){
				callback(result);
			}
			
		}).fail(function(xhr, status, err){
			if(error) {
				error();
			}
		});
	}
	
	function displayTime(timeValue) {
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap<(1000 * 60 * 60 * 24)) {
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
				':', (ss > 9 ? '' : '0') + ss].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	};
	return {add : add,
			get : get,
			getList : getList,
			remove : remove,
			update : update,
			displayTime : displayTime
		};
	})();