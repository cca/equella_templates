<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign local = xml.getAllSubtrees('local')>
<#assign communications = xml.getAllSubtrees('local/communicationsWrapper')>

<dl>
<#list titleInfo as titleInfo>
    <#assign title = titleInfo.get('title')>
    <h2 id="title">${title}</h2>
</#list>

<#assign topic = xml.getAllSubtrees('mods/subject/topic')>
<#list subject as subject>
    <#assign topics = subject.list('topic')>
    <#if (topics?size > 0)>
        <dd class="subject">Subject(s):
        <#list topics as topic>
        <#-- @todo check that this link works -->
        <#assign topicUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Ctopic%3E${topic}%3C%2Ftopic%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
            <#if topic != "">
                <a href="${topicUrl}">${topic}</a><#if topic_has_next>; </#if>
            </#if>
        </#list>
        </dd>
    </#if>
</#list>

<#-- is there ever an instance where there are multiple local subtrees? -->
<#list local as local>
<#assign departments = xml.list('local/department')>
    <#if (departments?size > 0) >
        <dd class="subject">Department/Program(s):
        <#list departments as department>
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%3E%3CdepictedDept%3E${department}%3C%2FdepictedDept%3E%3C%2FdepictedWrapper%3E%3C%2FcommunicationsWrapper%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
            <#if department != "">
                <a href="${departmentUrl}">${department}</a><#if department_has_next>; </#if>
            </#if>
        </#list>
        </dd>
    </#if>
</#list>

<#assign division = xml.getAllSubtrees('local/division')>
<#list local as local>
    <#assign divisions = local.list('division')>
    <#if (divisions?size > 0)>
        <dd class="subject">Division(s):
        <#list divisions as division>
            <#if division != "">
            <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%2F%3E%3C%2FcommunicationsWrapper%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
                <a href="${divisionUrl}">${division}</a><#if division_has_next>; </#if>
            </#if>
        </#list>
        </dd>
    </#if>
</#list>

<div style="clear:both;"></div>
<#list origininfo as origininfo>
    <#assign date = origininfo.get('dateCreatedWrapper/dateCreated')>
    <#assign semester = origininfo.get('semesterCreated')>
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%2F%3E%3C%2FcommunicationsWrapper%3E%3C%2Flocal%3E%3Cmods%3E%3Corigininfo%3E%3CsemesterCreated%3E${semester}%3C%2FsemesterCreated%3E%3C%2Forigininfo%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
    <#if date != ""><dd class="subject">Date: ${date}</dd></#if>
    <#if semester != ""><dd class="subject">Semester: <a href="${semesterUrl}">${semester}</a></dd></#if>
</#list>

<#list modslevel as mods>
    <#assign abstract = mods.get('abstract')>
    <#if abstract != "">
    <dd class="subject">Description: ${abstract}</dd></#if>
</#list>
<div style="clear:both;"></div>

<#-- style #1:
a) wider columns
b) stretched thumbnails
c) centered images -->
<#-- <style>
div.image-photoSeniorPacket {
    min-width: 170px;
    max-width: 170px;
    text-align: center;
}
.image-photoSeniorPacket img {
    height: 90px;
    width: 120px;
}
</style> -->

<dt>Image List</dt>
<div id='images' class="js-masonry" data-masonry-options='{ "columnWidth": 130, "itemSelector": ".image-photoSeniorPacket" }'>
<#list itemAttachments as itemAttachment>
    <#assign thumb = itemAttachment.get('thumbnail')>
    <#assign full = itemAttachment.get('file')>
    <#assign uuid = itemAttachment.get('uuid')>
    <#assign size = itemAttachment.get('size')>

    <div class='image-photoSeniorPacket'>
        <#assign imgUrl = "/file/${itemUuid}/${itemversion}/${full}">
        <#assign thumbUrl = "/thumbs/${itemUuid}/${itemversion}/${uuid}">
        <#-- attachment > 10mb? set a class on it
        so we don't do fancybox down at the bottom -->
        <#if (size?has_content && size?number > 10000000)>
            <#-- Masonry layout needs width/height attrs to know how to
            rearrange them
            onclick attr is how EQUELLA does its pop-ups -->
            <a href="${imgUrl}" onclick="popup('/items/${itemUuid}/${itemversion}/${full}?.vi=toimg',null,'80%','80%');return false;" class="largeFile"><img src="${thumbUrl}" width="88" height="66"/></a>
        <#else>
            <a href="${imgUrl}"><img src="${thumbUrl}" width="88" height="66"/></a>
        </#if>

        <#list communications as communications>
            <#assign file = communications.get('file')>
            <#assign note = communications.get('note')>
            <#if file == uuid>
                <#list communications.getAllSubtrees('depictedWrapper') as depicted>
                    <#assign depictedPerson = depicted.get('depictedPerson')>
                    <#assign depictedConstituents = depicted.get('depictedConstituents')>
                    <#assign depictedDept = depicted.get('depictedDept')>
                    <#assign depictedPersonUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%3E%3CdepictedPerson%3E${depictedPerson}%3C%2FdepictedPerson%3E%3C%2FdepictedWrapper%3E%3C%2FcommunicationsWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
                    <#assign depictedConstituentsUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%3E%3CdepictedConstituents%3E${depictedConstituents}%3C%2FdepictedConstituents%3E%3C%2FdepictedWrapper%3E%3C%2FcommunicationsWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
                    <#assign depictedDeptUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%3E%3CdepictedDept%3E${depictedDept}%3C%2FdepictedDept%3E%3C%2FdepictedWrapper%3E%3C%2FcommunicationsWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
                    <p class='commImagelist'>
                    <#-- depictedPerson exists & is followed by something -->
                    <#if depictedPerson != "" && (depictedConstituents != "" || depictedDept != "")>
                        <a href="${depictedPersonUrl}">${depictedPerson}</a> -
                    <#-- depictedPerson exists but nothing follows it -->
                    <#elseif depictedPerson != "">
                        <a href="${depictedPersonUrl}">${depictedPerson}</a>
                    </#if>
                    <#-- depictedConstitutents exists & is followed by smth -->
                    <#if depictedConstituents != "" && depictedDept != "">
                        <em><a href="${depictedConstituentsUrl}">${depictedConstituents}</a></em> -
                    <#elseif depictedConstituents != "">
                        <em><a href="${depictedConstituentsUrl}">${depictedConstituents}</a></em>
                    </#if>
                    <#if depictedDept != "">
                         <em><a href="${depictedDeptUrl}">${depictedDept}</a></em>
                    </#if>
                    </p>
                </#list>
                <#list communications.getAllSubtrees('tagWrapper') as tagWrap>
                    <#assign tags = tagWrap.get('tags')>
                    <#if tags != "">
                        <p class='commImagelist'>
                            ${tags}
                        </p>
                    </#if>
                </#list>
                <#if note != "">
                    <p class='commImagelist'>${note}</p>
                </#if>
            </#if>
        </#list>
    </div>
</#list>
</div>

<div style="clear:both;"></div>

<#list name as name>
    <#assign namePart = name.get('namePart')>
        <dt>Photographer</dt>
    <#if namePart == ""><dd>Unknown photographer</dd><#else>
        <#assign nameUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
        <dd><a href="${nameUrl}">${namePart}</a>
    </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign affiliation = subName.get('affiliation')>
            <#assign department = subName.get('department')>
            <#assign constituent = subName.get('constituent')>
            <#assign departmentUrl = "" />
            <#assign constituentUrl = "" />
            <#if department != "">
                 - ${department}
            </#if>
            <#if constituent != "">
                 - ${constituent}
            </#if>
            <#if affiliation != "">
                 - ${affiliation}
            </#if>
        </#list>
    </dd>
</#list>

<#list relateditem as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign note = relateditem.get('note')>
    <#assign titleUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Crelateditem%3E%3Ctitle%3E${title}%3C%2Ftitle%3E%3C%2Frelateditem%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER'>
    <#if title != "">
        <dt>Related publication</dt>
        <dd>Image was published in <em>${title}</em></dd>
    </#if>
    <#if note != "">
        <dd>Note: ${note}</dd>
    </#if>
</#list>
</dl>

<#-- modal boxes for images
EQUELLA already comes with jQuery.fancybox script
see http://fancybox.net -->
<script>
jQuery('.image-photoSeniorPacket a img').parent().not('.largeFile').fancybox();
</script>

<#-- style #2
a) narrow columns
b) Masonry layout -->
<style>
div.image-photoSeniorPacket {
    margin-bottom: 10px;
    min-height: 80px;
}
</style>
<script src="//cdn.jsdelivr.net/masonry/3.1.5/masonry.min.js"></script>
