(function ($) {
    var link_clicked = false;

    $.fn.horizon = function (options, i) {
        $('.navbar-brand').hide();
        $.extend($.fn.horizon.defaults, options);

        $.fn.horizon.defaults.sections = this;
        $.fn.horizon.defaults.limit = this.length;
        $.fn.horizon.defaults.i = 0;
        var section = $(this[$.fn.horizon.defaults.i]);

        toggleActiveLink(section);

        $(document).on('click', 'a.page-link[href^="#"]', function (event) {
            link_clicked = true;
            var hash = $(this).attr('href');
            if (-1 < hash.indexOf('#')) {
                scrollToId(hash.split('#')[1], $.fn.horizon.defaults.scrollDuration);
            }
            event.preventDefault();
        });

        $(document).on('click', '.sidenav a[href^="#"]', function (event) {
            href = $(this).attr('href');
            $('html, body').stop().animate({
                scrollTop: $(href).offset().top - 80
            }, 800, 'swing')
            event.preventDefault();
        });
        
        return this;
    };

    $.fn.horizon.defaults = {
        scrollTimeout: null,
        scrollEndDelay: 250,
        scrollDuration: 800,
        i: 0,
        limit: 0,
        docWidth: 0,
        sections: null,
        swipe: true,
        fnCallback: function (section) {
            toggleActiveLink(section);
        }
    };

    function scrollToId(id, speed) {
        var i = -1;
        $.fn.horizon.defaults.sections.each(function (index, element) {
            if (id === $(this).attr('id')) {
                i = index;
            }
        });

        if (0 <= i) {
            scrollTo(i, $.fn.horizon.defaults.scrollDuration);
        }
    }

    // HTML animate does not work in webkit. BODY does not work in opera.
    // For animate, we must do both.
    function scrollTo (index, speed) {
        if (index > ($.fn.horizon.defaults.limit - 1) || index < 0) {
            return;
        }

        $.fn.horizon.defaults.i = index;
        var section = $($.fn.horizon.defaults.sections[index]);

        $('html, body').stop().animate({
            scrollTop: section.offset().top
        }, speed, 'swing', $.fn.horizon.defaults.fnCallback(section));
    };

    function toggleActiveLink(section) {
        $('a[href="#' + section.attr('id') + '"]').parents('li').addClass('active');
        $('a[href!="#' + section.attr('id') + '"]').parents('li').removeClass('active');
        $('.page[id!="' + section.attr('id') + '"]').slideUp(1200, 'swing');
        if (link_clicked) {
            section.slideDown(1200, 'swing');
        }
        if (section.attr('id') == 'intro-section') {
            $('.navbar').removeClass('bg-navy-blue');
            $('.navbar-brand').hide(800);
        }
        else {
            $('.navbar').addClass('bg-navy-blue');
            $('.navbar-brand').show(800);
        }
        if (section.attr('id') == 'documentation-section') {
            $('body').css('overflow-y', 'auto');
        }
        else {
            $('body').removeClass('overflow-y', 'hidden');
        }
    };
})
(jQuery);
