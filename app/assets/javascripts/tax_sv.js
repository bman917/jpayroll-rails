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
}

/*
 * Bind change event so that selecting a payment schedule will
 * also change the Income label.
 */
 $(document).ready(function() {
  $('#schedule').change(function() {
    $('#income_label').text($('#schedule option:selected').text() + " Income");
  });
 });