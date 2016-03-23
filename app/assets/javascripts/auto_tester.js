/**
 * Created by conan on 3/22/16.
 */

$(document).ready(function() {
    $('#test-btn').click(function() {
        var download_start = new Date().getTime();
        var download_end = null;
        var upload_start = null;
        var upload_end = null;
        $.ajax('/test.apk', {
            success: function(data) {
                download_end = new Date().getTime();
                var formData = new FormData();
                formData.append('apk[file]', data, 'test.apk');
                upload_start = new Date().getTime();
                $.ajax({
                        url:'/apks',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        dataType: 'json',
                        success: function(response) {
                            upload_end = new Date().getTime();

                            var download_time = (download_end - download_start)/1000.0;
                            $('#test_download_time').val(download_time);
                            console.log(download_time);

                            var upload_time = (upload_end - upload_start)/1000.0;
                            $('#test_upload_time').val(upload_time);
                            console.log(upload_time);

                            $('#test_apk_id').val(response.apk);
                            console.log(response.apk);
                        },
                        error: function() {}
                    }
                );

            },
            error: function() {

            }
        });

    });
});