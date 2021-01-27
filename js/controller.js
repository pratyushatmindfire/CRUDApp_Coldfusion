function deleteItem(codetoDelete){
	console.log(codetoDelete);
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "deleteItembyCode", productCodetoDelete: (codetoDelete)},
    success: function (data){
      window.location.reload();
      },
    error: function (xhr, textStatus, errorThrown){
      console.log(errorThrown); //This will alert you of any errors.
      }
      });
}