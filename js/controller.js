var deleteItem = function(codetoDelete){
	console.log(codetoDelete);
   $.ajax({
      type:"POST",
      url:"./services/delete.cfc?method=deleteItem",
      data: codetoDelete,
      cache:false,
      success: function(msg) {
      console.log('Message');
      }
  });
}