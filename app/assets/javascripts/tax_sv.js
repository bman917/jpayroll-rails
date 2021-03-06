/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var today = new Date();
var currentYear = today.getFullYear();
var datePickerID = '#days_worked';


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
}

function getSelectedMonthElement() {
    return $('select#month_number option:selected');
}

function displayHolidays(monthNo) {
    var monthSelect = getSelectedMonthElement();
    monthNo = monthSelect.attr('value');

    var result = $.ajax({
        type: "GET",
        cache: false,
        url: "/holidays/month/" + monthNo,
        dataType: 'json',
        beforeSend: function() {
            $('div.holidays_box').spin()
        },
        complete: function(){
            $('div.holidays_box').spin(false)
        },
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

/*
 * =================================================
 * Start Date Picker Methods
 * =================================================
 */
function getSelected() {
    var dates = $(datePickerID).multiDatesPicker('getDates');
    $('#selected_dates').attr('value', JSON.stringify(dates));
}

function clearAll() {
    $('#simpliest-usage').multiDatesPicker('resetDates', 'picked');

}

function selectAll() {

    clearAll();

    var month = getSelectedMonthElement().text();

    var imonth = Date.parse(month).getMonth();
    var days = Date.getDaysInMonth(currentYear,imonth);

    var workingDays = [];
    for(var i=1; i< days+1; i++) {
        var d = new Date(currentYear,imonth,i);
        if (d.isWeekday()) {
            workingDays.push(d);
        }
    }
    $(datePickerID).multiDatesPicker('addDates', workingDays);
}
/*
  * Update the date picker to the selected month from the form
  */
function updateDatePickerMonth() {
    var monthNo = getSelectedMonthElement().attr('value');
    clearAll();
    $(datePickerID).datepicker('setDate', monthNo+'/1/'+currentYear);
    selectAll();
}
function updateMonth(month) {
   $('#month_number').val(month);
   $(datePickerID).datepicker('setDate', month+'/1/'+currentYear);
}


/*
 * =================================================
 * Start Document Ready
 * =================================================
 */
$(document).ready(function() {

    /*
     *Initialize the multi-date picker
     */
    $(datePickerID).multiDatesPicker({
        defaultDate: '1/1/' + currentYear,
        showOn: "button",
        buttonImage: "/images/calendar.gif",
        buttomImageOnly: true,
        showButtonPanel: true        
    });
    selectAll();
    

    /*
     * Bind change event so that selecting a payment schedule will
     * also change the Income label.
     */
    $('#schedule').change(function() {
        $('#income_label').text($('#schedule option:selected').text() + " Income");
    });

    /*
     * Bing change event so that selecting a mont will also update the
     * list of holidays
     */
    $('#month_number').change(displayHolidays);
    //TODO: Solve performance problem before enablining this
    //$('#month_number').change(updateDatePickerMonth);

    $('#submit_button').click(getSelected);

    displayHolidays(1);
});
 

