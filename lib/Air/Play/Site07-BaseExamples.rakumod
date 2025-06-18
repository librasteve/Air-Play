use Air::Functional :BASE;
use Air::Base;
use Air::Component;


my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);


#my $Tab1 = tab [
#    h3 'Tab 1';
#];
#
#my $Tab2 = tab [
#    h3 'Tab 2';
#];

sub SITE is export {
    site #:theme-color<blue>,
        index #:REFRESH(5),
            main
                div [
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

                    h3 'Tabs';
#                    tabs [:$Tab1, :$Tab2];
                    hr;
                ]
}

