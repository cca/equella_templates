// primarily for Google Scholar inclusion
// see pp. 8-9 of EQUELLA Discoverability Guide

// light abstraction over meta.add() API method
function map (field, xpath) {
    var text = String(xml.get(xpath))
    if (text !== '') {
        return meta.add(field, text)
    }
}

// these first 3 metadata fields are _required_
map('citation_title', 'mods/titleInfo/title')

// citation_author can be used multiple times so we loop over all nodes
var authors = xml.list('mods/name/namePart').listIterator()
while (authors.hasNext()) {
    meta.add('citation_author', authors.next())
}

// date formatting, "2015-10-15" => "2015/10/15", for the Googles
var date = xml.get('mods/relatedItem/part/date').replace('-', '/')
meta.add('citation_publication_date', date)

// all fields below this point are _optional_

// date added to repository, not authorship date
var datecreated = xml.get('item/datecreated').split('T')[0].replace('-','/')
meta.add('citation_online_date', datecreated)
map('citation_journal_title', 'mods/relatedItem/part/title')

// NOTE: EQUELLA complains that "attribute must be last part of XPath"
// which means we can't use paths like part/detail[@type=volume]/number
// so instead we have these convoluted loops over XML subtrees
// for volume & issue number, which are differentiated by a "type" attribute
var detail_subtrees = xml.getAllSubtrees('mods/relatedItem/part/detail')
for (var i in detail_subtrees) {
    var subtree = detail_subtrees[i]
    var type = String(subtree.get('/@type'))

    if (type === 'volume') {
        meta.add('citation_volume', subtree.get('number'))
    } else if (type === 'number') {
        meta.add('citation_issue', subtree.get('number'))
    }
}

// standard numbers also identified by a "type" attribute
var standard_no_subtrees = xml.getAllSubtrees('mods/relatedItem/identifier')
for (var i in standard_no_subtrees) {
    var subtree = standard_no_subtrees[i]
    var type = String(subtree.get('/@type'))

    if (type === 'issn') {
        meta.add('citation_issn', subtree.get('/'))
    } else if (type === 'isbn') {
        meta.add('citation_isbn', subtree.get('/'))
    }
}

map('citation_firstpage', 'mods/relatedItem/part/extent/start')
map('citation_lastpage', 'mods/relatedItem/part/extent/end')

// a bit tricker because we need to test for PDF's extistence
var attachments = xml.list('item/attachments/attachment/file').listIterator()
var url = ['https://vault.cca.edu/file/', item.getUuid(), '/', item.getVersion(), '/'].join('')
while (attachments.hasNext()) {
    var filename = attachments.next()
    if (filename.match(/\.pdf$/i)) {
        meta.add('citation_pdf_url', url + filename)
        break
    }
}
