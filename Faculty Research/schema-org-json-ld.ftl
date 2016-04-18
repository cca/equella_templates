<#-- get all relevant metadata -->
<#assign publication_type = xml.get('mods/genreWrapper/genre')>
<#assign title = xml.get('mods/titleInfo/title')>
<#assign authors = xml.list('mods/name/namePart')>
<#-- date published -->
<#assign date = xml.get('mods/relatedItem/part/date')>
<#assign publication_title = xml.get('mods/relatedItem/title')>
<#--
NOTE: EQUELLA complains that "attribute must be last part of XPath"
which means we can't use paths like part/detail[@type=volume]/number
so instead we have these convoluted loops over XML subtrees
for volume & issue number, which are differentiated by a "type" attribute
-->
<#assign detail_subtrees = xml.getAllSubtrees('mods/relatedItem/part/detail')>
<#list detail_subtrees as subtree>
    <#assign type = subtree.get('/@type')>
    <#if type == 'volume'>
        <#assign volume = subtree.get('number')>
    <#elseif type == 'number'>
        <#assign issue = subtree.get('number')>
    </#if>
</#list>
<#-- standard numbers also identified by a "type" attribute -->
<#assign standard_no_subtrees = xml.getAllSubtrees('mods/relatedItem/identifier')>
<#list standard_no_subtrees as subtree>
    <#assign type = subtree.get('/@type')>
    <#if type == 'issn'>
        <#assign issn = subtree.get('/')>
    <#elseif type == 'isbn'>
        <#assign isbn = subtree.get('/')>
    </#if>
</#list>
<#assign abstract = xml.get('mods/abstract')>
<#assign firstpage = xml.get('mods/relatedItem/part/extent/start')>
<#assign lastpage = xml.get('mods/relatedItem/part/extent/end')>

<script type="application/ld+json">
<#-- NOTE: cannot have trailing comma in JSON
so whenever there is an if condition, ensure something comes
after it without a comma (e.g. "title": "${title}" because we always have that) -->
<#if publication_type == 'journal article'>
<#-- using https://schema.org/ScholarlyArticle -->
{
  "@context": "http://schema.org",
  "@graph": [
    <#if issue?has_content>
    {
      "@id": "#issue${issue}",
      "@type": "PublicationIssue",
      <#if date != ''>"datePublished": "${date}",</#if>
      "issueNumber": "${issue}",
      "isPartOf": {
          "@id": "#periodical"
      }
    },
    </#if>
    <#if volume?has_content>
    {
      "@id": "#volume${volume}",
      "@type": "PublicationVolume",
      <#if date != ''>"datePublished": "${date}",</#if>
      "volumeNumber": "${volume}",
      "isPartOf": {
          "@id": "#periodical"
      }
    },
    </#if>
    {
      "@id": "#periodical",
      "@type": "Periodical",
      <#if issn?has_content>"issn": "${issn}",</#if>
      "name": "${publication_title?js_string}"
    },
    {
      "@id": "#article",
      "@type": "ScholarlyArticle",
      "author": [
          <#list authors as author>
          {
              "@type": "Person",
              "name": "${author?js_string}"
          }<#if author_has_next>,</#if>
          </#list>
      ],
      "isPartOf": [
        <#if issue?has_content>
        {
          "@id": "#issue${issue}"
        },
        </#if>
        <#if volume?has_content>
        {
          "@id": "#volume${volume}"
        },
        </#if>
        {
          "@id": "#periodical"
        }
      ],
      <#if abstract != ''>"description": "${abstract?js_string}",</#if>
      <#if firstpage != ''>"pageEnd": "${firstpage}",</#if>
      <#if lastpage != ''>"pageStart": "${lastpage}",</#if>
      "name": "${title}"
    }
  ]
}
<#elseif publication_type == 'book chapter'>
<#-- doing a hybrid of
https://schema.org/Book
& https://bib.schema.org/Chapter
-->
{
  "@context":  "http://schema.org/",
  "@id": "#record",
  "@type": "Book",
  "additionalType": "Chapter",
  <#if abstract != ''>"description": "${abstract?js_string}",</#if>
  <#if isbn?has_content>"isbn": "${isbn}",</#if>
  <#if date != ''>"datePublished": "${date}",</#if>
  "author": [
      <#list authors as author>
      {
          "@type": "Person",
          "name": "${author?js_string}"
      }<#if author_has_next>,</#if>
      </#list>
  ],
  <#if firstpage != ''>"pageStart": "${firstpage}",</#if>
  <#if lastpage != ''>"pageEnd": "${lastpage}",</#if>
  "name": "${title?js_string}"
}
</#if>
</script>
