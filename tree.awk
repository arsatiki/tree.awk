function indentlevel() { return index($0, $1); }

function node() { return "NODE_" NR; }

function emit(s) { print "\t" s ";"; }

function set_sp(levels, sp, newlevel) {
	if (sp == 0)
		return 1;

	oldlevel = levels[sp];
	if (oldlevel < newlevel)
		return sp + 1;
		
	if (oldlevel == newlevel)
		return sp;

	return set_sp(levels, sp-1, newlevel);
}

BEGIN {
	sp = 0;

	print "digraph {"
}

NF > 0 {
	level = indentlevel();
	sp = set_sp(levels, sp, level);
	levels[sp] = level;
	nodes[sp] = node();

	labelstr = substr($0, levels[sp]);
	emit(nodes[sp] "[label=\"" labelstr "\"]");
}

sp > 1 {
	emit(nodes[sp-1] " -> " nodes[sp]);
}

END { print "}" }