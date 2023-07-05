function ajaxGethtml(urlC, funcExito, funcError) {
    $.ajax({
        url: urlC,
        type: "GET",
        data: {},
        contentType: "text/html; charset=utf-8",
        dataType: "html",
        success: funcExito,
        error: funcError
    });
}


function funcError(jqXHR, estatus, error) {
    var msg = '';
    if (jqXHR.status === 0) {
        msg = 'No está conectado, favor de verificar su conexión.';
    }
    else if (jqXHR.status === 404) {
        msg = 'Página no encontrada [404]';
    }
    else if (jqXHR.status === 500) {
        msg = 'Error no hay conexión al servidor [500]';
    }
    else if (jqXHR.status === 'parseerror') {
        msg = 'El parseo del JSON es erróneo.';
    }
    else if (jqXHR.status === 'timeout') {
        $('body').addClass('loaded');
    }
    else if (jqXHR.status === 'abort') {
        msg = 'La petición Ajax fue abortada.';
    }
    else {
        msg = 'Error no conocido. ';
        console.log(exception);
    }
    alert(msg);
}