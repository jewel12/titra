$(document).ready(function(){
    $('.translation').each(function() {
        var translation_tag = $(this);
        var summary = translation_tag.find('p.summary');
        var summary_summary = translation_tag.find('span.summary_summary');

        summary.hide();

        translation_tag.click( function(){
            summary.toggle();
            summary_summary.toggle();
        } );
    });
});
