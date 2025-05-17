#use Cromponent;
use Air::Functional :BASE;
use Air::Base;
use Air::Scumponent;

use Red:api<2>;

role HxTodo {
	method hx-create(--> Hash()) {
		:hx-post("todo"),
		:hx-target<table>,
		:hx-swap<beforeend>,
	}
	method hx-delete(--> Hash()) {
		:hx-delete("todo"),
		:hx-confirm<Are you sure?>,
		:hx-target<closest tr>,
		:hx-swap<delete>,
	}
	method hx-toggle(--> Hash()) {
		:hx-get("todo/toggle"),
		:hx-target<closest tr>,
		:hx-swap<outerHTML>,
	}
}

model Todo does Scumponent {
	also does HxTodo;

	has UInt   $.id   is serial;
	has Bool() $.checked is rw is column = False;
	has Str()  $.text is column is required;

	method LOAD(Str() $id)  { Todo.^load: $id }
	method CREATE(*%text)   { Todo.^create: |%text }
	method DELETE           { $.^delete }

	method toggle is accessible {
		$!checked = !$!checked;
		$.^save;
		respond self;
	}

	multi method HTML {
		tr
			td( input :type<checkbox>, |$.hx-toggle, :$!checked ),
			td( $!checked ?? del $!text !! $!text),
			td( button :type<submit>, |$.hx-delete, :style<width:50px>, '-'),
	}

	method RENDER {
		qq:to/END/;
			<tr id="todo-<.id>">
				<td>
					<label class="todo-toggle">
						<input
							type="checkbox"
							<?.checked> checked </?>
							hx-get="./todo/<.id>/toggle"
							hx-target="closest tr"
							hx-swap="outerHTML"
						>
						<span class="custom-checkbox">
						</span>
					</label>
				</td>
				<td>
					<?.checked>
						<del><.text></del>
					</?>
					<!>
						<.text>
					</!>
				</td>
				<td>
					<button
						hx-delete="./todo/<.id>"
						hx-confirm="Are you sure?"
						hx-target="closest tr"
						hx-swap="delete"
					>
						-
					</button>
				</td>
			</tr>
		END
	}
}

sub EXPORT() {
	Todo.^exports
}
