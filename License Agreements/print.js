(function() {
    if (window.print) {
        // show notice that page will print
        $('.no-print').show()
        // trigger print dialog after 3 seconds
        var printTimeout = setTimeout(function() {
            window.print()
        }, 3000)
    }
})()
