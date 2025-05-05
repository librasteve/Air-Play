use Air::Functional :BASE;
use Air::Base;
use Air::Form;

use Cro::WebApp::Form;

my &index = &page.assuming( #:REFRESH(5),
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

#| https://cro.raku.org/docs/reference/cro-webapp-form
class Contact does Form {
    has Str    $.name     is validated(%va<text>)  is required;
    has Str    $.street   is validated(%va<text>);
    has Str    $.city     is validated(%va<text>);
    has Str    $.state    is validated(%va<text>);
    has Str    $.zip      is validated(%va<postcode>);
    has Str    $.country  is validated(%va<words>) is placeholder('USA');

    has Bool   $.is-company;
    has Str    $.company  is validated(%va<text>);
    has Str    $.url      is validated(%va<url>)   is url ;
    has Str    $.phone    is validated(%va<tel>)   is tel;
    has Str    $.email    is validated(%va<email>) is email is required;
    has Str    $.password is validated(%va<password>) is password;

    has Int    $.rating   will select { 1..5 };
    has Str    $.comment  is validated(%va<notes>)
                              is multiline(:5rows, :60cols) is maxlength(1000);
    has        $.date     is date
                              is help("Leave blank for today's date");
    has Str    $.hidden   is hidden;

    method do-form-attrs{
        self.form-attrs: {:submit-button-text('Save Contact Info')};
    }

    method validate-form {
        if $!is-company && ! $!company {
            self.add-validation-error("Please fill in the Company field");
        }
        if $!company && ! $!is-company {
            self.add-validation-error("Please check the Is company box");
        }
        given $!date {
            when '' { $!date = Date.new: now    }
            default { $!date = Date.new: $!date }
        }
    }

    method form-routes {
        self.init;

        self.controller: -> Contact $form {
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

my $contact = Contact.empty;

sub SITE is export {
    site :components[$contact], #:theme-color<red>,
        index
            main [
                h2 'Contact Form';
                $contact;
            ]
}
