fs_field = '';
function fs_action(){
    $('#revert').attr('disabled', true);
    $(fs_field).focus();
    $(fs_field).select();
};
function focus_select(e){
    fs_field = e;
    fs_action();
    $('input').change(function(){
	$('#revert').removeAttr('disabled');
    });
    $('#revert').click(function(){
	fs_action();
    });
    $(document).keydown(
	function(e) {
	    if (e.keyCode == 27) {
		$("#cancel").click().submit();
		e.preventDefault(); // ??? but really required
	    }
	}
    );
};
