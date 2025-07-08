process count_words {
    input:
        path words_file
    output:
        path "out.txt"
    script:
    // groovy code here
    """
    cat "$words_file" \
    | tr -s ' ' '\n' \
    | tr -d '[:punct:]' \
    | tr '[:upper:]' '[:lower:]' \
    | sort \
    | uniq -c \
    | sort -n \
    | tail -1 \
    | tr -s ' ' \
    | cut -d ' ' -f 3
    """
}

workflow {
    def files = channel.fromPath(params.in)
    count_words(files)
}