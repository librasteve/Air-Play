use Air::Functional :BASE;
use Air::Base;
use Air::Component;

my $htmx = external :href<https://htmx.org>;
my $air  = external :href<https://github.com/librasteve/Air>;
my $red  = external :href<https://github.com/FCO/Red>;
my $cro  = external :href<https://cro.raku.org>;
my $raku = external :href<https://raku.org>;
my $talk = external :href<https://discord.gg/VzYpdQ6>;

my &index = &page.assuming( #:REFRESH(5),
    title => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',

    nav => nav(
        logo    => safe('<a href="/">h<b>&Aring;</b>rc</a>'),
        items   => [:$htmx,:$air,:$red,:$cro,:$raku,:$talk],
        widgets => [lightdark],
    ),

    footer => footer(
        p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Remembered by <a href="https://fco.github.io/Red/" target="_blank">red</a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
    |),
);

my @tools = [Analytics.new: :provider(Umami), :key<35777f61-5123-4bb8-afb1-aced487af36e>,];

sub SITE is export {

site :theme-color<azure>, :bold-color<maroon>, :@tools,
 index
  main
   safe Q:to/END/;
    <h2>The hArc Stack</h2>
    <p>Combining HTMX with raku Air, Red and Cro so that you can <em>just build websites the right way™</em>.</p>
    <figure>
    <img src="/img/Site10-Counter.png" alt="hArc stack example code" style="width: 100%; max-width: 1024px; height: auto;">
    <figcaption>hArc example code shown in IntelliJ IDE with raku plugin 2.0.</figcaption>
    </figure>
    <p>hArc stands for "HTMX, Air, Red, Cro" - the <a href="https://raku.land/zef:librasteve/Air">Air raku module</a> is the "glue" that makes the stack. There's also the <a href="https://raku.land/zef:librasteve/Air::Play">Air::Play module</a> for website examples and Getting Started instruction.</p>
    <hr>

    <h2>HTMX: Server Side</h2>
    <p>HTMX provides server side website code with the dynamic and attractive UX of a reactive JavaScript SPA. It extends HTML with attributes like:</p>

    <ul>
        <li><code>hx-get="/data"</code> → Fetches data via GET.</li>
        <li><code>hx-post="/submit"</code> → Submits a form via POST.</li>
        <li><code>hx-target="#result"</code> → Updates a specific part of the page.</li>
        <li><code>hx-swap="outerHTML"</code> → Controls how content is replaced.</li>
    </ul>

    <p>It's a lightweight, declarative way to enhance interactivity while keeping your application state and server code simple.</p>

    <hr>

    <h2>Air: Code Clarity</h2>
    <p>Air aims to be the purest possible expression of HTMX, ensuring that hArc websites are built with a focus on content and layout rather than embedded markup. By embracing a functional coding style for composition, Air improves code clarity. It consists of a set of libraries that generate HTML and serve it via Cro, that results in concise, legible, and maintainable web applications.</p>

    <hr>

    <h2>Red: Data Model</h2>
    <p>Red is a powerful ORM (Object-Relational Mapper) for raku that provides an intuitive way to interact with databases. It supports various database backends and enables developers to model their data using raku’s expressive type system. Red simplifies database operations with a declarative syntax, making it easy to define schemas, query data, and perform complex transactions while maintaining the flexibility and safety of raku’s type system.</p>

    <hr>

    <h2>Cro: Web Services</h2>
    <p>Cro is raku’s ecosystem for building web services, offering a modular framework for creating HTTP applications, APIs, and real-time services. It provides a powerful and extensible pipeline-based architecture, making it easy to build scalable and maintainable applications. Cro’s built-in support for WebSockets, middleware, and async processing ensures that hArc applications can handle real-time interactions efficiently.</p>
    <hr>

    <h2>Raku: Language Toolkit</h2>
    <p>With support for functional, object-oriented, and reactive programming paradigms, raku is a  language toolkit for developers to build concise and maintainable websites. A powerful concurrency model, grammars, and metaprogramming capabilities make it well-suited for more advanced web applications. This gradually-typed scripting language makes easy things easy and hard things possible.</p>

    <p>~librasteve</p>

    END
}
