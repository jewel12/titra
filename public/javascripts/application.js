$(document).ready(function(){
    $('.translation').each(function() {
        var translation_tag = $(this);
        var summary = translation_tag.find('p.summary');

        summary.hide();

        translation_tag.click( function(){summary.toggle();} );
    });
});
