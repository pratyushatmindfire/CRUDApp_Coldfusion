<cfoutput>
    <div class="formcontainer" style="height:50%">

        <h1 class="heading" name="view_productcode">Product P100</h1>

        <form class="form-content" name="viewform">
            <div class="formfield productname">
                <h3 class="view-header" name="view_productname">Product Variant 100</h3>
            </div>
            
            <div class="formfield productdescription">
                <h3 class="view-header" name="view_productdesc" style="color: rgb(129, 122, 152)">A desc</h3>
            </div>

            <div class="formfield submitbutton">
                <input class="form-submit" type="submit" name="backbutton" value="Go to Dashboard" onclick="event.preventDefault(); window.location='/CRUDApp/dashboard.cfm';">

                <input class="form-verify" name="verifybutton" value="Accept" onclick="event.preventDefault(); doVerifyProduct(code);">

                <input class="form-verify" name="verifybutton" value="Reject" onclick="event.preventDefault(); doRejectProduct(code)">
            </div>
        </form>
    </div>

</cfoutput>