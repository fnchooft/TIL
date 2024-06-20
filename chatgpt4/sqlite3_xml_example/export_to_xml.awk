BEGIN {
    FS="|";
    print "<?xml version=\"1.0\"?>";
    print "<database>";
    if (schema != "") {
        print "  <schema>";
        print schema;
        print "  </schema>";
    }
}
NR==1 {
    print "  <table name=\"" table "\">";
    for (i=1; i<=NF; i++) {
        headers[i] = $i;
    }
}
NR>1 {
    print "    <row>";
    for (i=1; i<=NF; i++) {
        gsub(/&/, "&amp;", $i);
        gsub(/</, "&lt;", $i);
        gsub(/>/, "&gt;", $i);
        gsub(/"/, "&quot;", $i);
        gsub(/'/, "&apos;", $i);
        print "      <" headers[i] ">" $i "</" headers[i] ">";
    }
    print "    </row>";
}
END {
    print "  </table>";
    print "</database>";
}
