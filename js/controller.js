function deleteItem(codetoDelete){
	console.log("Code to delete", codetoDelete);
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "deleteItembyCode", productCodetoDelete: (atob(codetoDelete))},
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
    data: {method: "editItembyCode", productCodetoEdit: (atob(codetoEdit)), newproductname: (new_productname), newproductdesc: (new_productdesc) },
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
  getUserType().then(m => {
    let userType=m.slice(1,-1);
    console.log("UserData", userType);

    $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getVerifiedProducts"},
    success: function (retrievedData){
        let response=JSON.parse(retrievedData);
        console.log(response);

        for(let each of response)
        {
          dashboardcontent.innerHTML+= generateDashboardItem(each[0], each[1], userType);
        }
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      });


  });
}

function seedVerifyPanel()
{
  console.log("Duh");
  console.log(document.getElementById('verifyPanel'));
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getUnverifiedProducts"},
    success: function (retrievedData){
        let response=JSON.parse(retrievedData);
        console.log(response);

        for(let each of response)
        {
          verifyPanel.innerHTML+= generateVerificationItem(each[0], each[1], each[2]);
        }
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      });
}

function doVerifyProduct(code)
{
  console.log(atob(code));
  
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "acceptProduct", productCodetoAccept: (atob(code))},
    success: function (response){
        console.log(response);
        if(response==='true')
        {
          // $('#'+atob(code))[0].style.display='none';
          $('#'+atob(code))[0].style.display='none';
          // window.location='/CRUDApp/verifyproducts.cfm';
        }
        
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      });
}

function doRejectProduct(code)
{
  console.log(code);
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "rejectProduct", productCodetoReject: (atob(code))},
    success: function (response){
        console.log(response);
        if(response==='true')
        { $('#'+atob(code))[0].style.display='none';
          // window.location='/CRUDApp/verifyproducts.cfm';
        }
        
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      });
}



function generateVerificationItem(code, name, desc)
{
  return '<div id="'+code+'" class="formcontainer" style="height:50%"><h1 class="heading" name="view_productcode">'
  +code+
  '</h1><form class="form-content" name="viewform"><div class="formfield productname"><h3 class="view-header" name="view_productname">'
  +name+
  '</h3></div><div class="formfield productdescription"><h3 class="view-header" name="view_productdesc" style="color: rgb(129, 122, 152)">'
  +desc+
  '</h3></div> <div class="formfield submitbutton"><input style="margin-right: 0.5vw;" type="button" class="form-verify" name="verifybutton" value="Accept" onclick="event.preventDefault(); doVerifyProduct(\''
  +btoa(code)+
  '\');"><input style="margin-left: 0.5vw;" type="button" class="form-verify" name="verifybutton" value="Reject" onclick="event.preventDefault(); doRejectProduct(\''
  +btoa(code)+
  '\')"></div></form></div>';
}

function generateDashboardItem(code, name, role)
{
  if(role==="admin")
  {
    return '<div class="col-sm-12 col-md-6 col-lg-4 dynamic-gridbox"><div class="container eachItem"><div class="itemheader"><p>'
  +code+
  '</p></div><div class="itemname"><p>'
  +name+
  '</p></div><div class="makechanges"><button class="button leftcurve" value="View" id="'
  +code+
  '" onclick="'+urlgen('view', code)+'">View</button><button class="button" value="Edit" id="'+code+'" onclick="'+urlgen('edit', code)+'">Edit</button><button class="button rightcurve" value="Delete" id="'+code+'" onclick="'+urlgen('delete', code)+'">Delete</button></div></div></div>';
  }

  else
  {
    return '<div class="col-sm-12 col-md-6 col-lg-4 dynamic-gridbox"><div class="container eachItem"><div class="itemheader"><p>'
  +code+
  '</p></div><div class="itemname"><p>'
  +name+
  '</p></div><div class="userview"><button class="button" value="View" id="'
  +code+
  '" onclick="'+urlgen('view', code)+'">View</button>';
  }
  
}

async function getUserType()
{
  var userType='';
  return await $.ajax({
    url: "./services/userdataService.cfc", 
    type: "post",
    cache: false,
    data: {method: "getUserInfo"},
    success: function (userTypeInfo){
        userType=userTypeInfo;
        console.log("Usertype", userType);
        return userType;
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm';
      }
      });
    console.log("Usertype main", userType);
}


function getCache()
{
  $.ajax({
    url: "./services/loggerService.cfc", 
    type: "post",
    cache: false,
    data: {method: "retrieveCache"},
    success: function (retrievedData){
      var response = JSON.parse(retrievedData);
      console.log(response);
      },
    error: function (xhr, textStatus, errorThrown){
     console.log("Error!!")
     console.log(errorThrown);
      }
      });
}

function getAllItems()
{
  $.ajax({
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getVerifiedProducts"},
    success: function (retrievedData){
        let response=JSON.parse(retrievedData).DATA;
        console.log(response);
        return response;
      },
    error: function (xhr, textStatus, errorThrown){
      window.location='/CRUDApp/somethingwentwrong.cfm'; //This will alert you of any errors.
      }
      });
}

function urlgen(mode, code)
{

  if(mode==='view')
  {
    return "window.location='/CRUDApp/view.cfm?codetoView="+btoa(code)+"'";
  }

  if(mode==='edit')
  {
    return "window.location='/CRUDApp/editpage.cfm?codetoEdit="+btoa(code)+"'";
  }

  if(mode==='delete')
  {
    return "window.location='/CRUDApp/confirmdelete.cfm?codetoDelete="+btoa(code)+"'";
  }
}

function loadViewComponentData(code)
{
  console.log("Code is=", code);

  $.ajax(
  {
    url: "./services/crudservices.cfc", 
    type: "post",
    cache: false,
    data: {method: "getProductbyId", productCodetoSearch: (atob(code))},
    success: function (retrievedData){
      console.log("Retrieved Data=", retrievedData);
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
      console.log(xhr);
      console.log(textStatus);
      console.log(errorThrown);
       // window.location='/CRUDApp/somethingwentwrong.cfm';
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
    data: {method: "getProductbyId", productCodetoSearch: (atob(code))},
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
    data: {method: "getProductbyId", productCodetoSearch: (atob(code))},
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

  var nameofUser=$('input[name="username"]')[0].value;
  var passwordofUser=$('input[name="userpassword"]')[0].value;

  $.ajax({
    url: "./services/authentication.cfc", 
    type: "post",
    cache: false,
    data: {method: "validateUser", userName: (nameofUser), userPassword: (passwordofUser)},
    success: function (validatorResponse){
      if(validatorResponse==="true")
      {
        console.log("Logging in");
        $.ajax({
          url: "./services/authentication.cfc", 
          type: "post",
          cache: false,
          data: {method: "doLogin", userName: (nameofUser), userPassword: (passwordofUser)},
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

function previewExportData()
{
  let mode=$('#exportMode').val();
  let sortSubject=$('#sortBy').val();
  let orderSubject=$('#orderBy').val();
  let minPrice=parseInt($('#slider-range span')[0].innerText.slice(1));
  let maxPrice=parseInt($('#slider-range span')[1].innerText.slice(1));
  window.open("/CRUDApp/exportPreview.cfm?exportMode="+mode+"&exportsortSubject="+sortSubject+"&exportorderSubject="+orderSubject+"&exportminPrice="+minPrice+"&exportmaxPrice="+maxPrice);
}

function exportData()
{

  let mode=$('#exportMode').val();
  let sortSubject=$('#sortBy').val();
  let orderSubject=$('#orderBy').val();
  let minPrice=parseInt($('#slider-range span')[0].innerText.slice(1));
  let maxPrice=parseInt($('#slider-range span')[1].innerText.slice(1));


  console.log(mode, sortSubject, orderSubject, minPrice, maxPrice);
  window.open("/CRUDApp/exportExecutor.cfm?exportMode="+mode+"&exportsortSubject="+sortSubject+"&exportorderSubject="+orderSubject+"&exportminPrice="+minPrice+"&exportmaxPrice="+maxPrice);
}

function resetExportFilter()
{
  var animatorRef=setInterval(()=>{
    let [currentMin, currentMax]=$("#slider-range").slider("values");
    let originalMin = $("#slider-range").slider("option", "min");
    let originalMax = $("#slider-range").slider("option", "max");

    if(currentMin>originalMin)
    {
      currentMin=currentMin-1;
    }

    if(currentMax<originalMax)
    {
      currentMax=currentMax+1;
    }

    $("#slider-range").slider({values:[currentMin, currentMax]})
    $('#slider-range span')[0].innerText="$"+(currentMin);
    $('#slider-range span')[1].innerText="$"+(currentMax);

    if(currentMin===originalMin && currentMax===originalMax)
    {
      $('#exportMode').val('PDF');
      $('#sortBy').val('productName');
      $('#orderBy').val('asc');
      clearInterval(animatorRef);
    }

    console.log('Running');
  }, 40);
}