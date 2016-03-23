/**
 * Created by conan on 3/22/16.
 */

var form_validator = function() {
    var testUid = $('#test_uid');
    var testISP = $('#test_isp');
    if (testUid.val().length < 1) {
        testUid.val('NA');
    }
    var good_to_go = true;
    if (testISP.val().length < 1) {
        $("label[for='test_isp']").addClass('required_highlight');
        good_to_go = false;
    } else {
        $("label[for='test_isp']").removeClass('required_highlight');
    }
    if (!$("input[name='test[has_gfw]']:checked").val()) {
        $("label[for='test_has_gfw']").addClass('required_highlight');
        good_to_go = false;
    } else {
        $("label[for='test_has_gfw']").removeClass('required_highlight');
    }
    return good_to_go;
};
var submit_form = function() {
    if (form_validator()) {
        $('#new_test').unbind('submit').submit();
    } else {
        return false;
    }
};

jQuery(document).ready(function() {
    $('#new_test').submit(function(event) {
        event.preventDefault();
        if (!form_validator()) {
            return false;
        }
        var download_start = null;
        var download_end = null;
        var upload_start = null;
        var upload_end = null;
        $('#test_download_time').val('Downloading...');
        download_start = new Date().getTime();
        $.ajax('/test.apk', {
            success: function(data) {
                download_end = new Date().getTime();
                var download_time = (download_end - download_start)/1000.0;
                $('#test_download_time').val(download_time);
                console.log(download_time);

                var formData = new FormData();
                var file = new File([data], "test.apk");
                formData.append('apk[file]', file);
                $('#test_upload_time').val('Uploading...');
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

                        setTimeout(submit_form, 1000);
                    },
                    error: function() {
                        $('#test_upload_time').val('FAIL');
                        $('#test_apk_id').val(0);

                        setTimeout(submit_form, 1000);
                    }
                });

            },
            error: function() {
                $('#test_download_time').val('FAIL');
                $('#test_upload_time').val('FAIL');
                $('#test_apk_id').val(0);

                setTimeout(submit_form, 1000);
            },
            async: false
        });
        event.preventDefault();
    });
});