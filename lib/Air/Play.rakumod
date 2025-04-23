unit class Air::Play;

#use Air::Play::Site00-Nano;
#use Air::Play::Site01-Simple;
#use Air::Play::Site02-Sections;
#use Air::Play::Site03-Pages;
#use Air::Play::Site04-HarcStack;
#use Air::Play::Site05-PagesFunc;
#use Air::Play::Site06-Semantic;
#use Air::Play::Site07-BaseExamples;
#use Air::Play::Site08-SearchTable;
#use Air::Play::Site09-Todos;
#use Air::Play::Site10-Counter;
use Air::Play::Site11-Form;

sub routes is export {
    SITE.routes
}
