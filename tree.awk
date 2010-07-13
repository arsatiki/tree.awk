BEGIN {
	print "digraph {"
}

{
	node = "NODE_" NR;
	print node "[label=\"" $0 "\"];";
}

END { print " } "}