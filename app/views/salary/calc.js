
$('#calc-result-days-worked').text('<%=@days_worked%>');
$('#calc-result-regular-salary').text('<%=number_to_currency @salary%>');
$('#calc-result-daily-rate').text('<%=number_to_currency @daily_rate%>');
$('#calc-result-salary').text('<%=number_to_currency @this_months_salary%>');
$('#calc-result-holiday-pay').text('<%=number_to_currency @holiday_pay%>');
$('#calc-result').show();
var holidays_worked = "";
//<% @matched_holiday.each do |h| %>
holidays_worked += "<li><%=h.description%></li>";
//<% end %>
$('#calc-result-holidays-worked').html(holidays_worked);