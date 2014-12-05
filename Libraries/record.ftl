<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign collection = xml.getAllSubtrees('mods/relatedItem')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign physdescNote = xml.getAllSubtrees('mods/physicalDescriptionNote')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign originInfo = xml.getAllSubtrees('mods/originInfo')>
<#assign date = xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper')>
<#assign dateOther = xml.getAllSubtrees('mods/origininfo/dateOtherWrapper')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign genreWrapper = xml.getAllSubtrees('mods/genreWrapper')>
<#assign locationp = xml.getAllSubtrees('mods/location')>
<#assign part = xml.getAllSubtrees('mods/part')>
<#assign noteWrapper = xml.getAllSubtrees('mods/noteWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign archivesWrapper = xml.getAllSubtrees('local/archivesWrapper')>

<dl>
<#list titleInfo as titleInfo>
    <#assign title = titleInfo.get('title')>
    <#assign usage = titleInfo.get('@usage')>
    <#assign subTitle = titleInfo.get('subTitle')>
    <#assign partNumber = titleInfo.get('partNumber')>
    <#if usage =="primary">
        <h2 id="title">${title}
            <#if subTitle=="">
            <#else>: ${subTitle}</#if>
        </h2>
    <#else>
        <#if usage=="secondary">
            <#assign secondtitle = title>
        <#else>
            <#if usage=="">
                <h2 id="title">${title}
                <#if subTitle=="">
                    <#else>: ${subTitle}</#if>
                    </h2>
                </#if>
            </#if>
        </#if>
        <#if titleInfo_index !=0>
                <div id="secondtitle">Other title: ${secondtitle}
                <#if subTitle=="">
                    <#else>: ${subTitle}
                </#if>
                </div>
            </#if>
</#list>

<dt class="hide">Collection</dt>
<#list collection as collection>
    <#assign collectionTitle = collection.get('title')>
    <#assign collectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CrelatedItem%3E%3Ctitle%3E${collectionTitle}%3C%2Ftitle%3E%3C%2FrelatedItem%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P9f4a3509-8c49-6db9-de96-bb168bf80752&q=&sort=rank&dr=AFTER" />
    <dd class="collection"><a href="${collectionUrl}">${collectionTitle}</a></dd>
</#list>

<div id="images" class="clearfix">
<#list itemAttachments as itemAttachment>
    <#assign thumb = itemAttachment.get('thumbnail')>
    <#assign full = itemAttachment.get('file')>
    <#assign uuid = itemAttachment.get('uuid')>
    <#if full?ends_with(".tif")><#else>
    <div id='image-single'>
        <a href="/file/${itemUuid}/${itemversion}/${full}">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/>
        </a>
        <#list part as partAttachment>
            <#assign parttitle = partAttachment.get('title')>
            <#assign partextent = partAttachment.get('extent')>
            <#assign partnumber = partAttachment.get('number')>
            <#if partnumber == uuid>
                <#if parttitle != "" || partextent != "">
                    <p class='caption'>
                    <#if parttitle != ""><em>${parttitle} </em><br /> </#if>
                    <#if partextent != ""> ${partextent}</#if>
                    </p>
                </#if>
            </#if>
        </#list>
    </div>
    </#if>
</#list>
</div>

<#list name as name>
    <#assign namePart = name.get('namePart')>
    <#assign namePartDate = name.get('namePartDate')>
    <#assign role = name.get('role/roleTerm')>
    <#if name_index == 0 && (namePart !="" || namePartDate != "")>
        <dt>Creator(s)</dt>
    </#if>

    <dd>${namePart}
            <#if namePartDate != "" && (role=="")>
                (${namePartDate})
            </#if>
            <#if role!="" && (namePartDate=="")>
                (${role})
            </#if>
            <#if role!="" && namePartDate!="">
                (${namePartDate}) - ${role}
            </#if>

        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign affiliation = subName.get('affiliation')>
            <#assign gradDate = subName.get('gradDate')>
            <#assign department = subName.get('department')>
            <#assign major = subName.get('major')>
            <#assign constituent = subName.get('constituent')>
            <#assign description = subName.get('description')>
            <span id="namestuff">
                <#if affiliation=="" || affiliation=="CCAC" || affiliation=="CSAC" || affiliation=="CCA">
                <#else>
                ${affiliation} - </#if>
                <#if constituent != "">
                    ${constituent}
                </#if>
                <#if department != "">
                    - ${department}
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

<#list date as date>
    <#assign dateCreated = date.get('dateCreated')>
    <#assign datequalifier = date.get('@qualifier')>
    <#assign dateStart = date.get('pointStart')>
    <#assign dateEnd = date.get('pointEnd')>
    <#if dateCreated != "" || dateStart != "">
       <dt>Date(s)</dt>
    </#if>
    <dd class="date clearfix">
    <#if dateCreated != "">
       Date created: ${dateCreated}
    </#if>
    <#if datequalifier != "">
         (${datequalifier})
    </#if>
    </dd>
    <#if dateStart != "" || dateEnd != "">
        <dd>
        <#if dateStart != "">
            Date range: ${dateStart}
        </#if>
        <#if dateStart != "" && dateEnd != "">
            -
        </#if>
        <#if dateEnd != "">
            ${dateEnd}
        </#if>
        </dd>
    </#if>
</#list>
<br />

<#list dateOther as dateOther>
    <#assign dateother = dateOther.get('dateOther')>
    <#assign dateothertype = dateOther.get('dateOther/@type')>
    <#assign dateOtherqualifier = dateOther.get('dateOther/@qualifier')>
    <#if datecreated == "">
        <dt>Date(s)</dt>
    </#if>
    <#if dateother != "">
        <dd class="date">${dateothertype} date: ${dateother}
            <#if dateOtherqualifier != ""> (${dateOtherqualifier})</#if>
        </dd>
    </#if>
</#list>

<#list physdesc as physdesc>
    <#assign formBroad = physdesc.get('formBroad')>
    <#assign formSpecific = physdesc.get('formSpecific')>
    <#assign extent = physdesc.get('extent')>
    <#if formBroad !="" || formSpecific != "">
        <#if physdesc_index == 0><dt>Work type &amp; Measurements</dt></#if>
        <#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P4993606e-e026-2c1a-7995-9e8bf088744a&q=&sort=rank&dr=AFTER" />
        <dd><a href="${formBroadUrl}">${formBroad?cap_first}</a>
        <#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P4993606e-e026-2c1a-7995-9e8bf088744a&q=&sort=rank&dr=AFTER" />
        <#if formSpecific != "">
            — <a href="${formSpecificUrl}">${formSpecific}</a>
        </#if></dd>
    </#if>
    <#if extent != "">
        <dd>${extent}</dd>
    </#if>
        <#list physdescNote as physdescNote>
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

<#list modslevel as mods>
    <#assign abstract = mods.get('abstract')>
    <#assign toc = mods.get('tableOfContents')>
    <#if abstract != "">
        <#if mods_index == 0>
            <dt>Description</dt>
        </#if>
    </#if>
        <#if abstract!= ""><dd class="abstract">${abstract}</dd></#if>
    <#if toc!= "">
    <dt>Table of Contents</dt>
    <dd>${toc}</dd></#if>
</#list>
<#list noteWrapper as noteWrapper>
        <#assign note = noteWrapper.get('note')>
        <#assign noteType = noteWrapper.get('note/@type')>
<#if note != "">
    <#if noteWrapper_index == 0><dt>Notes</dt></#if>
</#if>
    <#if note != "" && noteType != "">
        <dd>${noteType?cap_first}:
        ${note}
        </dd>
    <#elseif noteType == "" && note != "">
        <dd>${note}</dd>
    </#if>
</#list>

<div class="clearfix">
<#list originInfo as originInfo>
    <#assign publisher = originInfo.get('publisher')>
    <#assign place = originInfo.get('place')>
    <#assign edition = originInfo.get('edition')>
    <#if (publisher != "" || edition != "" || place != "")>
        <#if originInfo_index == 0>
            <dt>Publisher</dt>
        </#if>
        <dd class="subject">${publisher}</dd>
        <#if edition!= "">
            <dd class="subject">Edition: ${edition}</dd>
        </#if>
        <#if place!= "">
            <dd class="subject">Pub location: ${place}</dd>
        </#if>
    </#if>
</#list>
</div>

<#list subject as subject>
    <#assign topic = subject.get('topic')>
    <#assign geographic = subject.get('geographic')>
    <#assign name = subject.get('name')>
    <#assign temporal = subject.get('temporal')>
    <#assign topicCONA = subject.get('topicCONA')>
    <#if subject_index == 0 && (topic !="" || geographic !="" || name !="" || temporal !="" || topicCONA !="")>
        <dt>Subject(s)</dt>
    </#if>
    <#if topic != "">
        <dd class="subject">Topic: ${topic}</dd>
    </#if>
    <#if geographic != "">
        <dd class="subject">Geographic: ${geographic}</dd>
    </#if>
    <#assign temporalUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Ctemporal%3E${temporal}%3C%2Ftemporal%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P9f4a3509-8c49-6db9-de96-bb168bf80752&q=&sort=rank&dr=AFTER" />
    <#assign topicCONAUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3CtopicCONA%3E${topicCONA}%3C%2FtopicCONA%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P9f4a3509-8c49-6db9-de96-bb168bf80752&q=&sort=rank&dr=AFTER" />
    <#assign nameUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Cname%3E${name}%3C%2Fname%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P4993606e-e026-2c1a-7995-9e8bf088744a&q=&sort=name&dr=AFTER" />
    <#if name != "">
        <dd class="subject">Name: <a href="${nameUrl}">${name}</a></dd>
    </#if>
    <#if temporal != "">
        <dd class="subject">Time period: <a href="${temporalUrl}">${temporal}</a></dd>
    </#if>
    <#if topicCONA != "">
        <dd class="subject">Depicted subject: <a href="${topicCONAUrl}">${topicCONA}</a></dd>
    </#if>
</#list>
<div class="clearfix" >
    <#list modslevel as mods>
        <#assign photoClassification = mods.get('photoClassification')>
        <#assign photoClassificationUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphotoClassification%3E${photoClassification}%3C%2FphotoClassification%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P9f4a3509-8c49-6db9-de96-bb168bf80752&q=&sort=rank&dr=AFTER" />
        <#if photoClassification != "">
            <dd class="subject">CCA/C subject: <a href="${photoClassificationUrl}">${photoClassification}</a></dd>
        </#if>
    </#list>
</div>

<#list genreWrapper as genreWrapper>
    <#assign genre = genreWrapper.get('genre')>
    <#if genre != "">
        <#if genreWrapper_index == 0>
            <dt>Genre</dt>
        </#if>
        <dd>${genre}</dd>
    </#if>
</#list>

<#list relateditem as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign note = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#if (title != "" || location != "" || note != "")>
        <#if relateditem_index == 0>
            <dt>Related item</dt>
        </#if>
        <dd>
            <#if @type == "isReferencedBy">Referenced by:</#if>
            <#if @type == "otherVersion">Other version:</#if>
            <#if @type == "series">Series:</#if>
            <em>${title}</em>
        </dd>
        <#if location != "">
            <dd>Location: ${location}</dd>
        </#if>
        <#if note != ""><dd>Note: ${note}</dd></#if>
    </#if>
</#list>

<#list archivesWrapper as archivesWrapper>
    <#assign series = archivesWrapper.get('series')>
    <#assign subseries = archivesWrapper.get('subseries')>
    <#if series != "">
        <#if archivesWrapper_index == 0><dt>Archives Series &amp; Subseries</dt></#if>
        <#if series != ""><dd>Series: ${series}</dd></#if>
        <#if subseries != ""><dd>Subseries: ${subseries}</dd></#if>
    </#if>
</#list>

<#if xml.get('mods/location') != "">
    <dt class="loc">Location</dt>
    <#list locationp as locationp>
        <#assign physicalLocation = locationp.get('physicalLocation')>
        <#assign copyInformation = locationp.getAllSubtrees('copyInformation')>
        <#list copyInformation as copyInformation>
            <#assign sublocation = copyInformation.get('sublocation')>
            <#assign sublocationDetail = copyInformation.get('sublocationDetail')>
            <#assign shelfLocator = copyInformation.get('shelfLocator')>
            <#if sublocation != "" || sublocationDetail != "" || shelfLocator != "" || physicalLocation != "">
                <dd class="loc">
                    <#if physicalLocation != "">${physicalLocation}</#if>
                    <#if sublocation != "">— ${sublocation}</#if>
                    <#if sublocationDetail != "">— ${sublocationDetail}</#if>
                    <#if shelfLocator != "">— ${shelfLocator}</#if>
                </dd>
            </#if>
        </#list>
    </#list>
</#if>
