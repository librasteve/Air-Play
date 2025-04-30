use Air::Functional :BASE;
use Air::Base;
use Air::Form;
use Cro::WebApp::Form;

# header / footer
my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',

    nav => nav(
        logo    => safe('<a href="/">h<b>&Aring;</b>rc</a>'),
        widgets => [lightdark],
    ),

    footer      => footer p ['Aloft on ', b 'åir'],
);

#| form
class Contact does Form {
    has Str    $.first-names is validated(%va<names>)  is required;
    has Str    $.last-name   is validated(%va<name>)   is required;
    has Str    $.email       is validated(%va<email>)  is email;

    method form-routes {
        use Cro::HTTP::Router;

        self.prep;

        post -> Str $ where self.form-url, {
            form-data -> Contact $form {
                if $form.is-valid {
                    note "Got form data: $form.form-data()";
                    content 'text/plain', 'Contact info received!'
                }
                else {
                    self.retry: $form
                }
            }
        }
    }
}

my $contact-form = Contact.empty;

# site
sub SITE is export {
    site :components[$contact-form], :theme-color<blue>, :bold-color<green>,
        index
            main
                content [
                    h2 'Contact Form';
                    $contact-form;
                ];
}

