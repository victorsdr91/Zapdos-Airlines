function datepicker(){
    $(function () {
        var dates = $("#fromDate, #toDate").datepicker({
            dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            onSelect: function (selectedDate) {
                var option = this.id == "fromDate" ? "minDate" : "maxDate",
                        instance = $(this).data("datepicker"),
                        date = $.datepicker.parseDate(
                                instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
                dates.not(this).datepicker("option", option, date);
            }
        });
    });
}

function loadbirthdatepicker(){
    $(".birthdatepicker_adult").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        maxDate: -(14*365),
        minDate: -(110*365)
    });

    $(".birthdatepicker_child").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        minDate: -(14*365),
        maxDate: -(2*365)
    });

    $(".birthdatepicker_baby").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        minDate: -(2*365),
        maxDate: 0
    });
        
}

function completedFlightDate(){
     $("#fDate").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true
    });
}

function dateRange(){
     $("#iminDate").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
     });
    $("#imaxDate").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
    });
}


