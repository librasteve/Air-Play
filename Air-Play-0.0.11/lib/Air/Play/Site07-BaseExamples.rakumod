use Air::Functional :BASE;
use Air::Base;
use Air::Component;


my &index = &page.assuming( #:REFRESH(1),
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

sub SITE is export {
    site #:theme-color<blue>,
        index :REFRESH(5),
            main
                div [
                    h3 'Table';
                    table [[1,2],[3,4]], :thead[<Left Right>,];

                    h3 'Grid';
                    grid 1..17;

                    h3 'Button';
                    div :role<group>,
                    [
                        button 'Button';
                        button 'Secondary', :class<secondary>;
                        button 'Contrast',  :class<contrast>;
                        button 'Outline',   :class<secondary outline>;
                        button 'Disabled',  :class<outline> :disabled;
                    ];

                    hr;
                ]
}

