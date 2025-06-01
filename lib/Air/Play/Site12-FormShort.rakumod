
# form
use Air::Form;

class Contact does Form {
    has Str    $.first-names is validated(%va<names>);
    has Str    $.last-name   is validated(%va<name>)   is required;
    has Str    $.email       is validated(%va<email>)  is required is email;
    has Str    $.city        is validated(%va<text>);

    method form-routes {
        self.init;

        self.submit: -> Contact $form {
            if $form.is-valid {
                note "Got form data: $form.form-data()";
                self.finish: 'Contact info received!'
            }
            else {
                self.retry: $form
            }
        }
    }
}

my $contact-form = Contact.empty;

# site

use Air::Functional :BASE;
use Air::Base;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',

    nav => nav(
        logo    => safe('<a href="/">h<b>&Aring;</b>rc</a>'),
        widgets => [lightdark],
    ),

    footer      => footer p ['Aloft on ', b 'åir'],
);

sub SITE is export {
    site :components[$contact-form],
        index
            main
                content [
                    h2 'Contact Form';
                    $contact-form;
                ];
}
