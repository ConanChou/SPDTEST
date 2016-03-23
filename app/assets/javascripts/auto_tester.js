/**
 * Created by conan on 3/22/16.
 */
var submit_form = function() {$('#new_test')[0].submit();};
//var submit_form = function() {
//    return true;
//};

$(document).ready(function() {
    $('#test-btn').click(function(event) {
        event.preventDefault();
        var download_start = new Date().getTime();
        var download_end = null;
        var upload_start = null;
        var upload_end = null;
        $.ajax('/test.apk', {
            success: function(data) {
                download_end = new Date().getTime();
                var download_time = (download_end - download_start)/1000.0;
                $('#test_download_time').val(download_time);
                console.log(download_time);

                var formData = new FormData();
                var file = new File([data], "test.apk");
                formData.append('apk[file]', file);
                upload_start = new Date().getTime();
                $.ajax({
                    url:'/apks.json',
                    type: 'POST',
                    async: false,
                    data: formData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        upload_end = new Date().getTime();
                        var upload_time = (upload_end - upload_start)/1000.0;
                        $('#test_upload_time').val(upload_time);
                        console.log(upload_time);

                        $('#test_apk_id').val(response.apk);
                        console.log(response.apk);

                        setTimeout(submit_form, 3000);
                    },
                    error: function() {
                        $('#test_upload_time').val('FAIL');
                        $('#test_apk_id').val(0);

                        setTimeout(submit_form, 3000);
                    }
                });

            },
            error: function() {
                $('#test_download_time').val('FAIL');
                $('#test_upload_time').val('FAIL');
                $('#test_apk_id').val(0);

                setTimeout(submit_form, 3000);
            }
        });
    });
});