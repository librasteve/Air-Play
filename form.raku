#!/usr/bin/env raku
my $start = now;

use lib "../lib";

use Cro::HTTP::Log::File;
use Cro::HTTP::Router;
use Cro::HTTP::Server;

use Cro::WebApp::Template;
use Cro::WebApp::Form;

use Air::Play::Site11-Form;

#use Air::Form;
#role Form does Cro::WebApp::Form does Air::Form {};
#
##| https://cro.raku.org/docs/reference/cro-webapp-form
#class Contact does Form {
#    has Str    $.name     is required;
#    has Str    $.street;
#    has Str    $.city;
#    has Str    $.state;
#    has Str    $.zip      is validated(/^<[A..Za..z0..9\s]>+$/, 'Only alphanumerics are allowed');
#    has Str    $.country  is placeholder('USA');
#
#    has Bool   $.is-company;
#    has Str    $.company;
#    has Str    $.url      is url;
#
#    has Str    $.phone    is tel;
#    has Str    $.email    is email is required;
#    has Str    $.password is password;
#
#    has Int    $.rating   will select { 1..5 };
#    has Str    $.comment  is multiline(:5rows, :60cols) is maxlength(1000);
#    has        $.date     is date;
#
#    has Int    $.hidden   is hidden;
#
#    method validate-form {
#        if $!is-company && ! $!company {
#            self.add-validation-error("Please provide name of company");
#        }
#        if $!company && ! $!is-company {
#            self.add-validation-error("Please check the Is company box");
#        }
#    }
#}

#my $formtmp = q|<&form(.form)>|;
#
#sub routes() is export {
#    route {
#        # Render an empty form first
#        get -> {
#            template-inline $formtmp, { form => Contact.empty }
#        }
#
#        # When it is submitted, validate it, and render it again with validation
#        # errors if there are problems. Otherwise, accept the review.
#        post -> {
#            form-data -> Contact $form {
#                if $form.is-valid {
#                    note "Got form data: $form.raku()";
#                    content 'text/plain', 'Thanks for your review!';
#                }
#                else {
#                    template-inline $formtmp, { :$form }
#                }
#            }
#        }
#    }
#}


my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => "0.0.0.0",
    port => 3000,
    application => routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ],
);
$http.start;
my $elapsed = (now - $start).round(0.01);
say "Build time $elapsed sec";
say "Listening at http://0.0.0.0:3000";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
