function showError(message) {
    $('.error').append('<div class="alert alert-danger">' + message + '<a class="close" data-dismiss="alert">×</a></div>');
    $('input[type="password"]').val('');
}

$(function(){
    $(document).on('submit', '.signup-form', function(event) {
        event.preventDefault();
        $('.error').html(''); 
        $.post( $(this).prop('action'), $(this).serialize(), function( data ) {
            if(data.error) {
                showError(data.error);        
            }
        });
    });
})