CKEDITOR.editorConfig = function( config ) {
    config.language = 'en';
    config.uiColor = '#ffffff';
	config.skin = 'office2013,./office2013/';
    config.toolbar = 'toolbarLight';


    config.toolbar_toolbarLight =
    [
        ['Cut','Copy','Paste','-','Scayt'],
        ['Undo','Redo'],
        ['Image','Link','Unlink', 'Maximize'],
        ['Format','Bold','Italic','Strike','NumberedList','BulletedList'],

    ];

};