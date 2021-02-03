function deleteItem(codetoDelete){
	console.log("Code to delete", codetoDelete);
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "deleteItembyCode", productCodetoDelete: (codetoDelete)},
    success: function (deleteStatus){
      if(deleteStatus==="true")
      {
        window.location='/CRUDApp/dashboard.cfm';
      }

      else
      {
        window.location="/CRUDApp/somethingwentwrong.cfm";
      }
      },
    error: function (xhr, textStatus, errorThrown){
      window.location="/CRUDApp/somethingwentwrong.cfm"; //This will alert you of any errors.
      }
      });
}

function editItem(codetoEdit)
{
    console.log("Code to edit", codetoEdit);
    var new_productname= $('input[name="edit_productname"]')[0].value;
    var new_productdesc=$('input[name="edit_productdesc"]')[0].value;

    console.log(new_productname, new_productdesc);

    $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "editItembyCode", productCodetoEdit: (codetoEdit), newproductname: (new_productname), newproductdesc: (new_productdesc) },
    success: function (editStatus){

      if(editStatus==="true")
      {
        window.location='/CRUDApp/dashboard.cfm';
      }

      else
      {
        window.location="/CRUDApp/somethingwentwrong.cfm";
      }
      },
    error: function (xhr, textStatus, errorThrown){
      window.location="/CRUDApp/somethingwentwrong.cfm"; //This will alert you of any errors.
      }
      });
}

function createItem()
{
    var new_productcode=$('input[name="new_productcode"]')[0].value;
    var new_productname=$('input[name="new_productname"]')[0].value;
    var new_productdesc=$('input[name="new_productdesc"]')[0].value;

    console.log(new_productcode);
    console.log(new_productname);
    console.log(new_productdesc);

    $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "createNewItem", productCodetoCreate: (new_productcode), productNametoCreate: (new_productname), productDesctoCreate: (new_productdesc) },
    success: function (createStatus){

      if(createStatus==="true")
      {
        window.location='/CRUDApp/dashboard.cfm';
      }

      else
      {
        window.location="/CRUDApp/createpage.cfm";
      }},
    error: function (xhr, textStatus, errorThrown){
      window.location="/CRUDApp/somethingwentwrong.cfm"; //This will alert you of any errors.
      }
      })
};

function seedDashboard()
{
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getAllProducts"},
    success: function (retrievedData){
      var dashboardReference = $('#dashboardcontent');
        let response=JSON.parse(retrievedData).DATA;
        console.log(response);

        for(let each of response)
        {
          dashboardcontent.innerHTML+= generateDashboardItem(each[0], each[1]);
        }
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      });
}

function generateDashboardItem(code, name)
{
  return '<div class="col-sm-12 col-md-6 col-lg-4 dynamic-gridbox"><div class="container eachItem"><div class="itemheader"><p>'
  +code+
  '</p></div><div class="itemname"><p>'
  +name+
  '</p></div><div class="makechanges"><button class="button leftcurve" value="View" id="'
  +code+
  '" onclick="'+urlgen('view', code)+'">View</button><button class="button" value="Edit" id="'+code+'" onclick="'+urlgen('edit', code)+'">Edit</button><button class="button rightcurve" value="Delete" id="'+code+'" onclick="'+urlgen('delete', code)+'">Delete</button></div></div></div>';
}

function getAllItems()
{
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getAllProducts"},
    success: function (retrievedData){
        let response=JSON.parse(retrievedData).DATA;
        console.log(response);
        return response;
      },
    error: function (xhr, textStatus, errorThrown){
      console.log(errorThrown); //This will alert you of any errors.
      }
      });
}

function urlgen(mode, code)
{
  if(mode==='view')
  {
    return "window.location='/CRUDApp/view.cfm?codetoView="+code+"'";
  }

  if(mode==='edit')
  {
    return "window.location='/CRUDApp/editpage.cfm?codetoEdit="+code+"'";
  }

  if(mode==='delete')
  {
    return "window.location='/CRUDApp/confirmdelete.cfm?codetoDelete="+code+"'";
  }
}

function loadViewComponentData(code)
{
  console.log(code);

  $.ajax(
  {
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getProductbyId", productCodetoSearch: (code)},
    success: function (retrievedData){
      console.log(JSON.parse(retrievedData).DATA);
        if(JSON.parse(retrievedData).DATA.length==0)
        {
          window.location='/CRUDApp/productdoesntexist.cfm';
        }

        else
        {
          let response=JSON.parse(retrievedData).DATA[0];
          console.log(response);

          $('h1[name="view_productcode"]')[0].innerText="Viewing Product "+response[0];
          $('h3[name="view_productname"]')[0].innerText=response[1];
          $('h3[name="view_productdesc"]')[0].innerText=response[2];
        } 
      },
    error: function (xhr, textStatus, errorThrown){
       window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      }
    );
}

function loadEditComponentData(code)
{
  console.log(code);

  $.ajax(
  {
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getProductbyId", productCodetoSearch: (code)},
    success: function (retrievedData){
      console.log(JSON.parse(retrievedData).DATA);
        if(JSON.parse(retrievedData).DATA.length==0)
        {
          window.location='/CRUDApp/productdoesntexist.cfm';
        }

        else
        {
          let response=JSON.parse(retrievedData).DATA[0];
          console.log(response);

          $('h1[name="edit_productcode"]')[0].innerText="Editing Product "+response[0];
          $('input[name="edit_productname"]')[0].value=response[1];
          $('input[name="edit_productdesc"]')[0].value=response[2];
        } 
      },
    error: function (xhr, textStatus, errorThrown){
       window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      }
    );
}

function loadDeleteComponentData(code)
{
  console.log(code);

  $.ajax(
  {
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getProductbyId", productCodetoSearch: (code)},
    success: function (retrievedData){
      console.log(JSON.parse(retrievedData).DATA);
        if(JSON.parse(retrievedData).DATA.length==0)
        {
          window.location='/CRUDApp/productdoesntexist.cfm';
        }

        else
        {
          let response=JSON.parse(retrievedData).DATA[0];
          console.log(response);

          $('h2[name="delete_productcode"]')[0].innerText=response[0];
        } 
      },
    error: function (xhr, textStatus, errorThrown){
       window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      }
    );
}

function loginUser()
{
  event.preventDefault();
  console.log("Validating");

  $.ajax({
    url: "./services/authentication.cfc", 
    type: "post",
    cache: false,
    data: {method: "validateUser", userName: ($('input[name="username"]')[0].value), userPassword: ($('input[name="userpassword"]')[0].value)},
    success: function (validatorResponse){
      if(validatorResponse==="true")
      {
        console.log("Logging in");
        $.ajax({
          url: "./services/authentication.cfc", 
          type: "post",
          cache: false,
          data: {method: "doLogin", userName: ($('input[name="username"]')[0].value), userPassword: ($('input[name="userpassword"]')[0].value)},
          success: function (loginResponse){
            window.location='/CRUDApp/loginpage.cfm';
          },
          error: function (xhr, textStatus, errorThrown){
            window.location='/CRUDApp/somethingwentwrong.cfm'; //This will alert you of any errors.
          }
        });

      }

      else
      {
        window.location.reload();
      }
      },
    error: function (xhr, textStatus, errorThrown){
      console.log(errorThrown); 
      }
      });
}

function logoutUser()
{
  console.log("Logging out");

  $.ajax({
    url: "./services/authentication.cfc", 
    type: "post",
    cache: false,
    data: {method: "doLogout"},
    success: function (logoutResponse){
      if(logoutResponse==="true")
      {
        window.location='/CRUDApp/loginpage.cfm';
      }

      else
      {
        window.location.reload();
      }
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm'; 
      }
      });

}

function exportData(mode)
{
  console.log("Exporting to", mode);

  if(mode==="PDF")
  {
    window.open('/CRUDApp/pdfexport.cfm');
  }

  else if(mode="Excel")
  {
    window.open('/CRUDApp/excelexport.cfm');
  }

  $('select[name="exportOptions"]')[0].value="none"

}