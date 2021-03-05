
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
  $( function() {
    $("#slider-range").slider({
      range: true,
      min: 0,
      max: 100,
      values: [ 0, 100 ],
      slide: function( event, ui ) {

        $('#slider-range span')[0].innerText="$" + ui.values[ 0 ];
        $('#slider-range span')[1].innerText="$" + ui.values[ 1 ];
      }
    });

    $('#slider-range span')[0].innerText="$" + $( "#slider-range" ).slider( "values", 0 );
    $('#slider-range span')[1].innerText="$" + $( "#slider-range" ).slider( "values", 1 );
  } );
</script>

<style>

  select:focus
  {
    outline: 0;
  }

  select
  {
    padding: 0.1em;
    font-size: larger;
    border: 0;
    border-radius: 0.6em;
    background-color: #dedbe0;
    text-align-last: center;
    cursor: pointer;
    color: #9a9a9a;
    font-weight: 500;
  }

  .eachOption-Line
  {
    margin-bottom: 1.2em;
  }

  #slider-range
  {
    width: 35%;
    display: inline-flex;
    margin-left: 1%;
  }

  #slider-range span
  {
    height: auto;
    font-size: 0.9em;
    width: auto;
    padding: 0.2em;
    border-radius: 0.5em;
    color: #9a9a9a;
    cursor: pointer;
  }

  #slider-range span:focus
  {
    outline:0;
    background-color: #f6f6f6;
    border: 0;
  }

  label 
  {
    font-size: 1.1em;
    font-weight: 500;
    font-family: inherit;
    color: #878787;
    margin-right: 1%;
  }
</style>

<cfoutput>
	<div class="formcontainer" style="height:fit-content">

		<h1 class="heading">Export Tool</h1>

		<form class="form-content">
			<div>
        <div class="eachOption-Line">
				  <label for="exportMode">Export as</label>
				  <select id="exportMode" name="exportOptions">
  					<option value="PDF" selected>PDF</option>
  					<option value="Excel">Excel Sheet</option>
				  </select>
        </div>

        <div class="eachOption-Line">
				  <label for="sortBy">Sort By</label>
				  <select id="sortBy" name="sortSubject">
  					<option value="productName" selected>Name</option>
  					<option value="price">Price</option>
				  </select>

          <select id="orderBy" name="orderSubject">
            <option value="asc" selected>Asc</option>
            <option value="desc">Desc</option>
          </select>
        </div>


				<div id="priceFilter" class="eachOption-Line">
				  <label for="amount">Price Range</label>

				  <div id="slider-range">
          </div>
				</div>
			</div>

      <div class="formfield-spacious exportsubmitbutton">
        <input class="form-submit" type="submit" readonly onclick="event.preventDefault(); previewExportData();" value="Preview">
        <input class="form-submit" type="submit" readonly onclick="exportData();" value="Export">
        <input class="form-submit" type="submit" name="resetfilterbutton" value="Reset Filter" onclick="event.preventDefault(); resetExportFilter();">
        <input class="form-submit" type="submit" name="backbutton" value="Back to Dashboard" onclick="event.preventDefault(); window.location='/CRUDApp/dashboard.cfm';">
      </div>
		</form>
	</div>
</cfoutput>