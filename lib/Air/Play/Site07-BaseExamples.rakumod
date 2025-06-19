use Air::Functional :BASE;
use Air::Base;
use Air::Component;


my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

sub SITE is export {
    site :register[Tabs.new], #:theme-color<blue>,
        index #:REFRESH(5),
            main
                div [
                    h3 'Tabs';
                    tabs [
                        Tab1 => tab section figure blockquote "tada";
                        Tab2 => tab section figure blockquote "yoda";
                    ];
                    hr;

                    h3 'Table';
                    table [[1,2],[3,4]], :thead[<Left Right>,];

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

                    h3 'Grid';
                    grid [span $_ for 1..17];
                    hr;

                    h3 'Flexbox';
                    flexbox [span $_ for 1..34];
                ]
}

