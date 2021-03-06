//= require jquery.min
//= require jquery.dataTables.min
//= require jquery.dataTables.bs2
//= require bootstrap-alert
//= require_self

jQuery(function(){

    /*
     * DataTables
     */
    var kkTable = $('table').dataTable({
        "sPaginationType":  "full_numbers",
		"sDom":             "<'row'<'span4'l><'span4'f>r>t<'row'<'span4'i><'span4'p>>",
		"sPaginationType":  "bootstrap",
		"oLanguage": {
			"sLengthMenu":  "_MENU_ items per page"
		},
        "aaSorting":        [],
        "aoColumns": [
            null,
            null,
            null,
            { "bSortable": false }
        ]
    });

    $(".alert").alert()

});
