fs_field = '';
function fs_action(){
  $(fs_field).focus();
  $(fs_field).select();
};
function focus_select(e){
  fs_field = e;
  fs_action();
  $('input').change(function(){
    $('#jq_revert').removeAttr('disabled');
  });
  $('#jq_revert').click(function(){
    $('#jq_revert').attr('disabled', true);
    fs_action();
  });
  $(document).keydown(function(e) {
    if (e.keyCode == 27) do_cancel();
  });
  };
function do_cancel(){
  location.href = cancel_path;
};
