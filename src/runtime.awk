BEGIN {
    ORS = ""
    print "structure CRuntime = struct\n\
    val prelude = \""
}

{
    gsub(/\"/, "\\\"");
    # The following might be necessary for Windows users performing newline
    # conversion
    gsub(/\r/, "");
    printf "%s\\n", $0
}

END {
    print "\";\nend"
}
