CKEDITOR.editorConfig = function( config ) {
    config.language = 'en';
    config.uiColor = '#ffffff';
	config.skin = 'office2013,./office2013/';
    config.toolbar = 'toolbarLight';
    /* Filebrowser routes */
    // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
    config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
    config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

    // The location of a script that handles file uploads in the Flash dialog.
    config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
    config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

    // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
    config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads in the Image dialog.
    config.filebrowserImageUploadUrl = "/ckeditor/pictures";

    // The location of a script that handles file uploads.
    config.filebrowserUploadUrl = "/ckeditor/attachment_files";

    // Rails CSRF token
    config.filebrowserParams = function(){
        var csrf_token = $('meta[name=csrf-token]').attr('content'),
                csrf_param = $('meta[name=csrf-param]').attr('content'),
                params = new Object();

        if (csrf_param !== undefined && csrf_token !== undefined) {
            params[csrf_param] = csrf_token;
        }

        return params;
    };


    config.toolbar_toolbarLight =
    [
        ['Cut','Copy','Paste','-','Scayt'],
        ['Undo','Redo'],
        ['Image','Link','Unlink', 'Maximize'],
        ['Format','Bold','Italic','Strike','NumberedList','BulletedList'],

    ];

};