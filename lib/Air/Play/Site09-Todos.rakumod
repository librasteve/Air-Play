use Air::Functional :BASE;
use Air::Base;
use Air::Scumponent;

use Red:api<2>;
red-defaults “SQLite”;

role HxTodo {
    method hx-create(--> Hash()) {
        :hx-post("todo"),
        :hx-target<table>,
        :hx-swap<beforeend>,
    }
    method hx-delete(--> Hash()) {
        :hx-delete("todo/$.id"),
        :hx-confirm<Are you sure?>,
        :hx-target<closest tr>,
        :hx-swap<delete>,
    }
    method hx-toggle(--> Hash()) {
        :hx-get("todo/$.id/toggle"),
        :hx-target<closest tr>,
        :hx-swap<outerHTML>,
    }
}

model Todo does Scumponent {
    also does HxTodo;

    has UInt   $.id   is serial;
    has Bool   $.checked is rw is column = False;
    has Str    $.text is column is required;

    method LOAD(Str() $id)  { Todo.^load: $id }
    method CREATE(*%text)   { Todo.^create: |%text }
    method DELETE           { $.^delete }

    method toggle is controller {
        $!checked = !$!checked;
        $.^save;
        respond self;
    }

    multi method HTML {
        tr
            td( input :type<checkbox>, |$.hx-toggle, :$!checked ),
            td( $!checked ?? del $!text !! $!text),
            td( button :type<submit>, |$.hx-delete, :style<width:50px>, '-'),
    }
}

Todo.^create-table;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

my @todos = do for <one two> -> $text { Todo.^create: :$text };

#note Todo.^load(1).HTML;

sub SITE is export {
    site :components(@todos),
        index
            main [
                h3 'Todos';
                table @todos;
                form  |Todo.hx-create, [
                    input  :name<text>;
                    button :type<submit>, '+';
                ];
            ]
}
