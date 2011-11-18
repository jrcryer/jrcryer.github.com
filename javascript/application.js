$(document).ready(function() {
    $('nav a').click(function(evt) {
        var $anchor = $(this);
        
        $('html,body').animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 750);
        return false;
    });
});
