   
   
</div>
</div>
   
   <br><br><br><br>
    <footer style="background-color: #000000; color: #ffffff">
    <div class="row">
         <div class="col-sm-3" style="text-align: center;">
            <img src="<c:url value="/mainresources/assets/img/logob.png"/>" style="width: 66px; height: 66px;">
         </div>
         <div class="col-sm-6" style="text-align: center;">
             <h5>Copyright &copy; 2O19</h5>
             <h5>Guardian Owl</h5>
         </div>
         <div class="col-sm-3" style="text-align: center;">
            <img src="<c:url value="/mainresources/assets/img/logob.png"/>" style="width: 66px; height: 66px;">
         </div>
    </div>
	</footer>
</body>

<script src="<c:url value="/mainresources/jquery/jquery-1.10.2.js"/>" type="text/javascript"></script>
<script src="<c:url value="/mainresources/assets/js/jquery-ui-1.10.4.custom.min.js"/>" type="text/javascript"></script>

<script src="<c:url value="/mainresources/bootstrap3/js/bootstrap.js"/>" type="text/javascript"></script>
<script src="<c:url value="/mainresources/assets/js/gsdk-checkbox.js"/>"></script>
<script src="<c:url value="/mainresources/assets/js/gsdk-radio.js"/>"></script>
<script src="<c:url value="/mainresources/assets/js/gsdk-bootstrapswitch.js"/>"></script>
<script src="<c:url value="/mainresources/assets/js/get-shit-done.js"/>"></script>
<script src="<c:url value="/mainresources/assets/js/custom.js"/>"></script>


<script>
$(".btn-logout").on("click", function(e){
	e.preventDefault();
	$("form").submit();
});
</script>

<script type="text/javascript">

$('.btn-tooltip').tooltip();
$('.label-tooltip').tooltip();
$('.pick-class-label').click(function(){
      var new_class = $(this).attr('new-class');
      var old_class = $('#display-buttons').attr('data-class');
      var display_div = $('#display-buttons');
      if(display_div.length) {
      var display_buttons = display_div.find('.btn');
      display_buttons.removeClass(old_class);
      display_buttons.addClass(new_class);
      display_div.attr('data-class', new_class);
      }
});
$( "#slider-range" ).slider({
range: true,
min: 0,
max: 500,
values: [ 75, 300 ],
});
$( "#slider-default" ).slider({
   value: 70,
   orientation: "horizontal",
   range: "min",
   animate: true
});
$('.carousel').carousel({
   interval: 4000
});


</script>