use Air::Functional :BASE;
use Air::Base;
use Air::Component;
use Air::Farm;
use Cro::WebApp::Form;

my &index = &page.assuming( #:REFRESH(5),
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

#| https://cro.raku.org/docs/reference/cro-webapp-form
class Contact does Farm {
    has Str    $.name is required;
    has Str    $.street;
    has Str    $.city;
    has Str    $.state;
    has Str    $.zip      is validated(/^<[A..Za..z0..9\s]>+$/, 'Only alphanumerics are allowed');
    has Str    $.country  is placeholder('USA');

    has Bool   $.is-company;
    has Str    $.company;
    has Str    $.url      is url;

    has Str    $.phone    is tel;
    has Str    $.email    is email is required;
    has Str    $.password is password;

    has Int    $.rating   will select { 1..5 };
    has Str    $.comment  is multiline(:5rows, :60cols) is maxlength(1000);
    has        $.date     is date;

    has Int    $.hidden   is hidden;

    method validate-form {
        if $!is-company && ! $!company {
            self.add-validation-error("Please provide name of company");
        }
        if $!company && ! $!is-company {
            self.add-validation-error("Please check the Is company box");
        }
    }

    method doit is action {
        note 43;
        {
            note 44;
#            my $formtmp = Q|<&form(.form)>|;
#
#            form-data -> Contact $form {
#                if $form.is-valid {
#                    note "Got form data: $form.raku()";
#                    content 'text/plain', 'Thanks for your review!';
#                }
#                else {
#                    template-inline $formtmp, { :$form }
#                }
#            }
        }
    }
}

my $contact = Contact.empty;
#my $contact = Contact.new;

#note $contact.HTML-RENDER-DATA;
#note $contact.GENERATE-NAME;


sub SITE is export {
    site :components[$contact], #:theme-color<red>,
        index
            main [
                h2 'Contact Form';
                $contact;
            ]
}

sub routes is export {
    SITE.routes
}


#class Counter does Component does Tag {
#    has Int $.value = 0;
#
#    method increment is controller {
#        $!value++;
#        respond self
#    }
#
#    method hx-increment(--> Hash()) {
#        :hx-get("$.url-id/increment"),
#        :hx-target("#$.id"),
#        :hx-swap<outerHTML>,
#        :hx-trigger<submit>,
#    }
#
#    multi method HTML {
#        input :$.id, :$.name, :$!value
#    }
#}