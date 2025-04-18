use Air::Functional :BASE;
use Air::Base;
use Air::Component;

my &index = &page.assuming( #:REFRESH(5),
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

class Counter does Component does Tag {
    has Int $.value = 0;

    method increment is controller {
        $!value++;
        respond self
    }

    method hx-increment(--> Hash()) {
        :hx-get("$.url-id/increment"),
        :hx-target("#$.id"),
        :hx-swap<outerHTML>,
        :hx-trigger<submit>,
    }

    multi method HTML {
        input :$.id, :$.name, :$!value
    }
}

my Counter $counter .= new;

sub SITE is export {
    site :components[$counter], #:theme-color<red>,
        index
            main
                form |$counter.hx-increment, [
                    h3 'Counter:';
                    $counter;
                    button :type<submit>, '+';
                ]
}
