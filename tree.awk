function indentlevel() {
	return index($0, $1);
}

function node() {
	return "NODE_" NR;
}

function emit(s) {
	print "\t" s ";";
}

function sp_direction(oldlevel, newlevel) {
	if (oldlevel < newlevel)
		return 1;
	if (oldlevel > newlevel)
		return -1;
	return 0;
}

BEGIN {
	sp = 0;

	print "digraph {"
}

{
	level = indentlevel();
	sp += sp_direction(levels[sp], level);
	levels[sp] = level;
	nodes[sp] = node();

	labelstr = substr($0, levels[sp]);
	emit(nodes[sp] "[label=\"" labelstr "\"]");
}

sp > 1 {
	emit(nodes[sp-1] " -> " nodes[sp]);
}

END { print "}" }