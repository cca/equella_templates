<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>
<#assign archivesWrappers = xml.getAllSubtrees('local/archivesWrapper')>
<#assign collections = xml.getAllSubtrees('mods/relatedItem')>
<#assign dateOtherWrappers = xml.getAllSubtrees('mods/origininfo/dateOtherWrapper')>
<#assign dates = xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper')>
<#assign genreWrappers = xml.getAllSubtrees('mods/genreWrapper')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign locations = xml.getAllSubtrees('mods/location')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign names = xml.getAllSubtrees('mods/name')>
<#assign noteWrappers = xml.getAllSubtrees('mods/noteWrapper')>
<#assign originInfos = xml.getAllSubtrees('mods/originInfo')>
<#assign parts = xml.getAllSubtrees('mods/part')>
<#assign physdescNotes = xml.getAllSubtrees('mods/physicalDescriptionNote')>
<#assign physdescs = xml.getAllSubtrees('mods/physicalDescription')>
<#assign powerSearch = 'P9f4a3509-8c49-6db9-de96-bb168bf80752'>
<#assign relateditems = xml.getAllSubtrees('mods/relateditem')>
<#assign subjects = xml.getAllSubtrees('mods/subject')>
<#assign titleInfos = xml.getAllSubtrees('mods/titleInfo')>
<#-- find out if user is in a library-related group -->
<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>
<#assign tiffAccess = false>
<#assign groups = ['Communications', 'Library Contributors', 'Library Administrator', 'Library Workstudy', 'System Administrators']>
<#list groups as group>
    <#if userIsMemberOf(group)>
        <#assign tiffAccess = true>
        <#break>
    </#if>
</#list>

<dl>
<#assign titled = false>
<#list titleInfos as titleInfo>
    <#assign title = titleInfo.get('title')>
    <#assign usage = titleInfo.get('@usage')>
    <#assign subTitle = titleInfo.get('subTitle')>
    <#assign partNumber = titleInfo.get('partNumber')>
    <#if (usage == "primary" || usage == "") && ! titled>
        <#assign titled = true>
        <h2 id="title">${title}
            <#if subTitle != "">: ${subTitle}</#if>
        </h2>
    </#if>
    <#if usage == "secondary">
        <div id="secondtitle">Other title: ${title}
            <#if subTitle != "">: ${subTitle}</#if>
        </div>
    </#if>
</#list>

<dt class="hide">Collection</dt>
<#list collections as collection>
    <#assign collectionTitle = collection.get('title')>
    <#assign collectionUrl = "/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CrelatedItem%3E%3Ctitle%3E${collectionTitle}%3C%2Ftitle%3E%3C%2FrelatedItem%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    <dd class="collection"><a href="${collectionUrl}">${collectionTitle}</a></dd>
</#list>

<#if collectionTitle = "Art Collection">
	<#list attachments.list() as att>
        <#-- work around null mime type exception -->
        <#assign mimeType = mime.getMimeTypeForFilename(att.getFilename())!"">
        <#if att.getType() == "FILE" && mimeType != "" && mimeType.getType()?starts_with("image/")>
            <img src="${utils.getItemUrl(currentItem) + att.getFilename()}" width="450" />
        </#if>
	</#list>
</#if>

<#if collectionTitle != "Art Collection">
<ul class="clearfix">
<#assign hasTiff = false>
<#list itemAttachments as itemAttachment>
    <#assign full = itemAttachment.get('file')>
    <#assign uuid = itemAttachment.get('uuid')>
    <#assign type = itemAttachment.get('@type')>
    <#-- show TIFF images only to Communications, Libraries, or shared visitors (whose ID is an email address) -->
    <#if ( full?matches('(.tiff?)$', 'i')?size == 0 || tiffAccess || user.getID()?contains('@') )>
        <#list parts as part>
            <#assign parttitle = part.get('title')>
            <#assign partextent = part.get('extent')>
            <#-- there can be multiple attachments per part
            each one's UUID is in mods/part/number -->
            <#assign partnumbers = part.list('number')>
            <#-- partdetail is used to hide speaker release forms
            or other confidential attachments -->
            <#assign partdetail = part.get('detail')>
            <#list partnumbers as partnumber>
                <#if partnumber == uuid && (partdetail != 'yes' || tiffAccess || userIsMemberOf('Faculty Governance') || userIsMemberOf('College Administrators'))>
                    <#-- <attachment type="remote"> means it's a URL and the <file> child element
                    is a URL instead of a filename -->
                    <#if type == 'remote'>
                        <#-- Panopto embed e.g. for commencement videos -->
                        <#if full?contains('ccarts.hosted.panopto.com/Panopto/Pages/Viewer')>
                            <iframe style="height:294.7px; width:524px;" src="${full?replace('Viewer', 'Embed')}&autoplay=false&offerviewer=true&showtitle=false&showbrand=false&captions=false&interactivity=none" height="405" width="720" allowfullscreen></iframe>
                        <#else>
                            <li class="image-with-metadata shorter">
                                <a href="${full}" rel="group">
                                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/>
                                </a>
                            </li>
                        </#if>
                    <#else>
                        <li class="image-with-metadata shorter">
                            <a href="/file/${itemUuid}/${itemversion}/${full?url}" rel="group">
                                <#if full?lower_case?ends_with('.pdf')>
                                    <img src="/file/ad812d22-e473-493f-9f15-9538a8830da6/1/pdf.png">
                                <#else>
                                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/>
                                </#if>
                            </a>
                            <#if parttitle != "" || partextent != "" || partdetail == 'yes'>
                                <p class="metadata">
                                <#if parttitle != ""><em>${parttitle}</em><br></#if>
                                <#if partextent != ""> ${partextent}<br></#if>
                                <#if partdetail == 'yes'><strong>Confidential document</strong>, please consider this before sharing.</#if>
                                </p>
                            </#if>
                        </li>
                    </#if>
                </#if>
            </#list>
        </#list>
    <#else>
        <#assign hasTiff = true>
    </#if>
</#list>
</ul>
    <#if hasTiff>
        <p>This item has TIFF images that are only available to CCA Libraries staff. If you would like access to them, reach out to <a href="mailto:vault@cca.edu?subject=VAULT%20TIFF%20Access%20Request&body=${'https://vault.cca.edu/items/'?url + itemUuid + '%2F' + itemversion + '%2F'}">vault@cca.edu</a>. Please include a link to the item in your message.</p>
    </#if>
</#if>

<#list names as name>
    <#assign namePart = name.get('namePart')>
    <#assign nameUrl = '/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E%22${escapeAmp(namePart)}%22%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
    <#assign namePartDate = name.get('namePartDate')>
    <#assign role = name.get('role/roleTerm')>
    <#if name_index == 0 && (namePart != "" || namePartDate != "")>
        <dt>Creator(s)</dt>
    </#if>

    <dd><a href="${nameUrl}">${namePart}</a>
    <#if namePartDate != "" && (role == "")>
        (${namePartDate})
    </#if>
    <#if role != "" && (namePartDate == "")>
        (${role})
    </#if>
    <#if role != "" && namePartDate != "">
        (${namePartDate}) - ${role}
    </#if>

    <#list name.getAllSubtrees('subNameWrapper') as subName>
        <#assign affiliation = subName.get('affiliation')>
        <#assign gradDate = subName.get('gradDate')>
        <#assign departments = subName.list('department')>
        <#assign major = subName.get('major')>
        <#assign constituent = subName.get('constituent')>
        <#assign description = subName.get('description')>
        <span id="namestuff">
            <#if affiliation != "" && affiliation != "CCAC" && affiliation != "CSAC" && affiliation != "CCA">
                ${affiliation}
            </#if>
            <#if constituent != "">
                ${constituent}
            </#if>
            <#if departments?size != 0>
                - <#list departments as dept>
                ${dept}<#if dept_has_next>, </#if>
                </#list>
            </#if>
            <#if major != "">
                - ${major}
            </#if>
            <#if gradDate != "">
                - ${gradDate}
            </#if>
            <#if description != "">
                - ${description}
            </#if>
        </span>
    </#list>
    </dd>
</#list>

<#list dates as date>
    <#assign dateCreated = date.get('dateCreated')>
    <#assign datequalifier = date.get('@qualifier')>
    <#assign dateStart = date.get('pointStart')>
    <#assign dateEnd = date.get('pointEnd')>

    <#if dateCreated != "" || dateStart != "">
       <dt>Date(s)</dt>
    </#if>

    <#if dateCreated != "">
        <dd class="date">
        <#-- NOTE: if you want nicely formatted dates with month names
        the _month value only_ needs to be wrapped in a .js-date tag -->
        Date created: <span class="js-date">${dateCreated}</span>
        <#if datequalifier != "">
             (${datequalifier})
        </#if>
    </dd>
    </#if>

    <#if dateStart != "" || dateEnd != "">
        <dd class="date">
        <#if dateStart != "">
            Date range: <span class="js-date">${dateStart}</span>
        </#if>
        <#if dateStart != "" && dateEnd != "">
            -
        </#if>
        <#if dateEnd != "">
            <span class="js-date">${dateEnd}</span>
        </#if>
    </dd>
    </#if>
</#list>

<#list dateOtherWrappers as dateOtherWrapper>
    <#assign dateOther = dateOtherWrapper.get('dateOther')>
    <#assign dateOtherStart = dateOtherWrapper.get('pointStart')>
    <#assign dateOtherEnd = dateOtherWrapper.get('pointEnd')>
    <#-- to figure out if we have anything, concatenate all the child text nodes -->
    <#assign dateOtherText = dateOther + dateOtherStart + dateOtherEnd>
    <#assign dateOtherType = dateOtherWrapper.get('dateOther/@type')>
    <#assign dateOtherqualifier = dateOtherWrapper.get('dateOther/@qualifier')>

    <#-- note that this refers to the _other_ date assigned above
    to prevent us from printing the "date(s)" label twice -->
    <#if xml.get('mods/origininfo/dateCreatedWrapper/dateCreated') == '' && dateOtherText != ''>
        <dt>Date(s)</dt>
    </#if>
    <#-- two types: 1) singleton "date other" -->
    <#if dateOther != ''>
        <dd class="date">${dateOtherType?cap_first} date: <span class="js-date">${dateOther}</span>
            <#if dateOtherqualifier != ""> (${dateOtherqualifier})</#if>
        </dd>
    </#if>
    <#-- 2) start/end date with a type, includes Capp St items -->
    <#if dateOtherStart != '' || dateOtherEnd != ''>
        <dd class="date">
            ${dateOtherType?cap_first} date(s): <span class="js-date">${dateOtherStart}</span>
            <#if dateOtherEnd != ''> - <span class="js-date">${dateOtherEnd}</span></#if>
        </dd>
    </#if>
</#list>

<#list physdescs as physdesc>
    <#assign formBroad = physdesc.get('formBroad')>
    <#assign formSpecific = physdesc.get('formSpecific')>
    <#assign extent = physdesc.get('extent')>
    <#if formBroad != "" || formSpecific != "">
        <#if physdesc_index == 0><dt>Work type &amp; Measurements</dt></#if>
        <#assign formBroadUrl = "/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
        <dd><a href="${formBroadUrl}">${formBroad?cap_first}</a>
        <#assign formSpecificUrl = "/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
        <#if formSpecific != "">
            — <a href="${formSpecificUrl}">${formSpecific}</a>
        </#if></dd>
    </#if>
    <#if extent != "">
        <dd>${extent}</dd>
    </#if>
    <#list physdescNotes as physdescNote>
        <#assign physNote = physdescNote.get('note')>
        <#assign physnoteType = physdescNote.get('note/@type')>
        <#if physNote != "">
            <dd>${physnoteType?cap_first}: ${physNote}</dd>
        </#if>
    </#list>
</#list>

<#if partNumber != "">
    <dd>Number: ${partNumber}</dd>
</#if>

<#assign abstract = xml.get('mods/abstract')>
<#assign toc = xml.get('mods/tableOfContents')>
<#if abstract != "">
    <dt>Description</dt>
    <dd class="abstract">${abstract}</dd>
</#if>
<#if toc!= "">
    <dt>Table of Contents</dt>
    <dd>${toc}</dd>
</#if>

<#list noteWrappers as noteWrapper>
    <#assign note = noteWrapper.get('note')>
    <#assign noteType = noteWrapper.get('note/@type')>
    <#if note != "">
        <#if noteWrapper_index == 0><dt>Notes</dt></#if>
        <#if noteType != "">
            <dd>${noteType?cap_first}:
            ${note}
            </dd>
        <#elseif noteType == "">
            <dd>${note}</dd>
        </#if>
    </#if>
</#list>

<div class="clearfix">
<#list originInfos as originInfo>
    <#assign publisher = originInfo.get('publisher')>
    <#assign place = originInfo.get('place')>
    <#assign edition = originInfo.get('edition')>
    <#if (publisher != "" || edition != "" || place != "")>
        <#if originInfo_index == 0>
            <dt>Publisher</dt>
        </#if>
        <dd class="subject">${publisher}</dd>
        <#if edition != ''>
            <dd class="subject">Edition: ${edition}</dd>
        </#if>
        <#if place != ''>
            <dd class="subject">Pub location: ${place}</dd>
        </#if>
    </#if>
</#list>
</div>

<#-- don't show header if we have an empty <subject/> node -->
<#assign allSubjectText = ''>
<#list subjects as subject>
    <#assign allSubjectText += subject.get('*')>
</#list>

<#if subjects?size != 0 && allSubjectText != ''>
    <dt>Subject(s)</dt>
</#if>

<#list subjects as subject>
    <#assign topic = subject.get('topic')>
    <#assign topicUrl = '/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Ctopic%3E${escapeAmp(topic)}%3C%2Ftopic%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
    <#assign geographic = subject.get('geographic')>
    <#assign geographicUrl = '/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Cgeographic%3E%22${geographic}%22%3C%2Fgeographic%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
    <#assign name = subject.get('name')>
    <#assign nameUrl = '/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Cname%3E%22${name}%22%3C%2Fname%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
    <#assign temporal = subject.get('temporal')>
    <#assign temporalUrl = '/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Ctemporal%3E${temporal}%3C%2Ftemporal%3E%3C%2Fsubject%3E%3CrelatedItem%3E%3Ctitle%3E${collectionTitle}%3C%2Ftitle%3E%3C%2FrelatedItem%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
    <#if topic != ''>
        <dd class="subject">Topic: <a href="${topicUrl}">${topic}</a></dd>
    </#if>
    <#if geographic != ''>
        <dd class="subject">Geographic: <a href="${geographicUrl}">${geographic}</a></dd>
    </#if>
    <#if name != ''>
        <dd class="subject">Name: <a href="${nameUrl}">${name}</a></dd>
    </#if>
    <#if temporal != "">
        <dd class="subject">Time period: <a href="${temporalUrl}">${temporal}</a></dd>
    </#if>
</#list>

<#assign photoClassification = xml.get('mods/photoClassification')>
<#assign photoClassificationUrl = "/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphotoClassification%3E${photoClassification}%3C%2FphotoClassification%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
<#if photoClassification != "">
    <div class="clearfix" >
        <dd class="subject">CCA/C subject: <a href="${photoClassificationUrl}">${photoClassification}</a></dd>
    </div>
</#if>

<#list genreWrappers as genreWrapper>
    <#assign genre = genreWrapper.get('genre')>
    <#if genre != "">
        <#if genreWrapper_index == 0>
            <dt>Genre</dt>
        </#if>
        <dd>${genre}</dd>
    </#if>
</#list>

<#list relateditems as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign note = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#if (title != "" || location != "" || note != "")>
        <#if relateditem_index == 0>
            <dt>Related item</dt>
        </#if>
        <#if title != "">
            <dd>
                <#if @type == "isReferencedBy">Referenced by:</#if>
                <#if @type == "otherVersion">Other version:</#if>
                <#if @type == "series">Series:</#if>
                <em>${title}</em>
            </dd>
        </#if>
        <#if location != "">
            <#if location?starts_with('http')>
                <dd>Location: <a href="${location}">${location}</a></dd>
            <#else>
                <dd>Location: ${location}</dd>
            </#if>
        </#if>
        <#if note != ""><dd>Note: ${note}</dd></#if>
    </#if>
</#list>

<#list archivesWrappers as archivesWrapper>
    <#assign series = archivesWrapper.get('series')>
    <#assign subseries = archivesWrapper.get('subseries')>
    <#if series != "">
        <#if archivesWrapper_index == 0><dt>Archives Series &amp; Subseries</dt></#if>
        <#if series != ""><dd>Series: ${series}</dd></#if>
        <#if subseries != ""><dd>Subseries: ${subseries}</dd></#if>
    </#if>
</#list>

<#if xml.exists('mods/location')>
    <dt>Location</dt>
    <#list locations as location>
        <#assign physicalLocation = location.get('physicalLocation')>
        <#if location.exists('copyInformation')>
            <#assign copyInformations = location.getAllSubtrees('copyInformation')>
            <#list copyInformations as copyInformation>
                <#assign sublocation = copyInformation.get('sublocation')>
                <#assign sublocationDetail = copyInformation.get('sublocationDetail')>
                <#assign shelfLocator = copyInformation.get('shelfLocator')>
                <#if sublocation != "" || sublocationDetail != "" || shelfLocator != "" || physicalLocation != "">
                    <dd>
                        <#if physicalLocation != "">${physicalLocation}</#if>
                        <#if sublocation != "">— ${sublocation}</#if>
                        <#if sublocationDetail != "">— ${sublocationDetail}</#if>
                        <#if shelfLocator != "">— ${shelfLocator}</#if>
                    </dd>
                </#if>
            </#list>
        <#else>
            <dd>${physicalLocation}</dd>
        </#if>
    </#list>
</#if>

<#if xml.get('local/theme') == 'minimal'>
    <br>
    <dd><strong class="text-error">This is a minimal record, to be completed later. Some fields may be missing.</strong></dd>
</#if>

<#-- to hide TIFFs, we remove the attachments section at bottom of pg -->
<#if !tiffAccess>
    <script>
    $(function(){$('#sc_attachments_div, #sc_attachments_extras, .area h3:last-of-type').remove()})
    </script>
    <style>
    #sc_attachments_div,
    #sc_attachments_extras,
    .area h3:last-of-type {
        display: none;
    }
    </style>
</#if>
