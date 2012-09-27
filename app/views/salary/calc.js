
$('#calc-result-days-worked').text('<%=@days_worked%>');
$('#calc-result-regular-salary').text('<%=number_to_currency(@salary)%>');
$('#calc-result-daily-rate').text('<%=number_to_currency(@daily_rate)%>');
$('#calc-result-salary').text('<%=@this_months_salary%>');
$('#calc-result-holiday-pay').text('<%=@holiday_pay%>');
$('#calc-result').show();
var holidays_worked = "";
//<% @result[:holidays_worked].each do |h| %>
holidays_worked += "<li><%=h.description%></li>";
//<% end %>
$('#calc-result-holidays-worked').html(holidays_worked);