function deleteItem(codetoDelete){
	console.log("Code to delete", codetoDelete);
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "deleteItembyCode", productCodetoDelete: (codetoDelete)},
    success: function (deleteStatus){
      if(deleteStatus.includes("<boolean value='true'/>"))
      {
        window.location='/CRUDApp/dashboard.cfm';
      }

      else
      {
        window.location="/CRUDApp/somethingwentwrong.cfm";
      }
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
    success: function (editStatus){

      if(editStatus.includes("<boolean value='true'/>"))
      {
        window.location='/CRUDApp/dashboard.cfm';
      }

      else
      {
        window.location="/CRUDApp/somethingwentwrong.cfm";
      }
      },
    // error: function (xhr, textStatus, errorThrown){
    //   console.log(errorThrown); //This will alert you of any errors.
    //   }
      });
}

function createItem()
{
    var new_productcode=document.getElementsByName("new_productcode")[0].value;
    var new_productname=document.getElementsByName("new_productname")[0].value;
    var new_productdesc=document.getElementsByName("new_productdesc")[0].value;

    console.log(new_productcode);
    console.log(new_productname);
    console.log(new_productdesc);

    $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "createNewItem", productCodetoCreate: (new_productcode), productNametoCreate: (new_productname), productDesctoCreate: (new_productdesc) },
    success: function (createStatus){
      console.log(createStatus);
      // window.location='/CRUDApp/dashboard.cfm';
      window.location='/CRUDApp/dashboard.cfm';
      },
    error: function (xhr, textStatus, errorThrown){
      console.log(errorThrown); //This will alert you of any errors.
      }
      });
}