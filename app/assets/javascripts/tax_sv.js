/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function loading() {
    $("#loading").show();
    $("#submit_button").attr('disabled', true);
    $('div.result').spin();
}

function finished_loading() {
    $("#loading").hide();
    $("#submit_button").attr('disabled', false);
    $('div.result').spin(false);
    $('#extra_income').attr('value', '0');
    $('#deductions').attr('value', '0');
    displayHolidays();
}

/*
 * Bind change event so that selecting a payment schedule will
 * also change the Income label.
 */
 $(document).ready(function() {
  $('#schedule').change(function() {
    $('#income_label').text($('#schedule option:selected').text() + " Income");
  });

 $('#month_no').change(displayHolidays);
 displayHolidays();

 });
 
 function displayHolidays() {
   var monthSelect = $('#month_no option:selected');
   var monthNo = monthSelect.attr('value');
   var result = $.ajax({
     type: "GET",
     cache: false,
     url: "holidays/month/" + monthNo,
     dataType: 'json',
     success: function (holidays) {

         $('div.holidays_box .month').text(monthSelect.text());
         $('#monthly_holidays_table tbody td').remove();
         
         var rows = "";
         $.each(holidays, function(index, holiday) {
             var d = new Date(holiday.date);
             rows += "<tr>"+"<td>"+holiday.description+"</td>"+
                            "<td>"+d.getDate()+"</td></tr>";
         });

         if (rows.length == 0) {
             rows += "<tr>"+"<td>None</td><td></td></tr>";
         }
         
         $('#monthly_holidays_table tbody').html(rows);
     }
   });
  }
