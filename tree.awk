function push(s, v) { s[++s["top"]] = v; }
function peek(s) { return s[s["top"]]; }
function empty(s) { return !s["top"]; }
function pop(s) { return s[s["top"]--]; }

function emit(s) { print "\t" s ";"; }

BEGIN { print "digraph {"; }

NF == 0 { next; }
{ gsub(/\t/, "        "); }

{
	level = index($0, $1);
	
	while (!empty(levels) && peek(levels) >= level) {
		pop(nodes);
		pop(levels);
	} 
	
	push(levels, level);
	push(nodes, "NODE_" NR);
	
	labelstr = substr($0, peek(levels));
	emit(peek(nodes) "[label=\"" labelstr "\"]");
}

!empty(nodes) {
	child = pop(nodes);
	if (!empty(nodes))
		emit(peek(nodes) " -> " child);
	push(nodes, child);
}

END { print "}" }