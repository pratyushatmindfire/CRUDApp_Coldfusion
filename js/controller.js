function deleteItem(codetoDelete){
	console.log("Code to delete", codetoDelete);
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

function editItem(codetoEdit)
{
    console.log("Code to edit", codetoEdit);
    var new_productname=document.getElementsByName("productname")[0].value;
    var new_productdesc=document.getElementsByName("productdesc")[0].value;

    console.log(new_productname, new_productdesc);

    $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "editItembyCode", productCodetoEdit: (codetoEdit), newproductname: (new_productname), newproductdesc: (new_productdesc) },
    success: function (data){
      window.location='/CRUDApp/loginpage.cfm';
      },
    error: function (xhr, textStatus, errorThrown){
      console.log(errorThrown); //This will alert you of any errors.
      }
      });
}