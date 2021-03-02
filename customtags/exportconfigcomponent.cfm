
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
        $( "#minAmount" ).val( "$" + ui.values[ 0 ]);
        $( "#maxAmount" ).val( "$" + ui.values[ 1 ] );
      }
    });

    $( "#minAmount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ));
    $( "#maxAmount" ).val( "$" + $( "#slider-range" ).slider( "values", 1 ));
  } );
</script>

<cfoutput>
	<div class="formcontainer" style="height:50%">

		<h1 class="heading">Export Tool</h1>

		<form class="form-content">
			<div>
				<label for="exportMode">Export as</label>
				<select id="exportMode" name="exportOptions">
  					<option value="PDF" selected>PDF</option>
  					<option value="Excel">Excel Sheet</option>
				</select>

				<label for="sortBy">Sort By</label>
				<select id="sortBy" name="sortSubject">
  					<option value="productName" selected>Name</option>
  					<option value="price">Price</option>
				</select>

				<select id="orderBy" name="orderSubject">
  					<option value="asc" selected>Asc</option>
  					<option value="desc">Desc</option>
				</select>


				<div id="priceFilter">
				<p>
  					<label for="amount">Price range:</label>
  					<input type="text" id="minAmount" readonly style="border:0; font-weight:bold;">
  					<input type="text" id="maxAmount" readonly style="border:0; font-weight:bold;">
				</p>
				<div id="slider-range"></div>
				</div>
			</div>

			<button onclick="event.preventDefault(); exportData();">Export</button>
		</form>
	</div>
</cfoutput>