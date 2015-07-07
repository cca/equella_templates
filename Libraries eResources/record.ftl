<#assign id = xml.get('item/@id')>
<#assign version = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign pages = xml.getAllSubtrees('mods/part/numberB')>
<#assign configID = xml.get('mods/identifier')>

<dl class="clearfix">
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#if pages?size != 0>
<#-- HTML5 flipbook, see turnjs.com (jQuery dependency) -->
<script src="/file/44702ca8-1340-4e92-8a3b-86cab800098c/1/turn.min.js"></script>
<style>
/* Basic turnjs sample */
.flipbook-viewport {
	overflow: hidden;
    /* 50px wider/taller than flipbook page */
	width: 450px;
	height: 650px;
}

.flipbook-viewport .container {
	position: absolute;
	top: 50%;
	left: 50%;
	margin:auto;
}

.flipbook-viewport .flipbook {
	width: 400px;
	height: 600px;
    /* = -.5 * height/width */
	left: -200px;
	top: -300px;
}

.flipbook-viewport .page {
    /* = half flipbook width */
	width:200px;
	height:600px;
	background-color: #fff;
	background-repeat: no-repeat;
	background-size: 100% 100%;
}

.flipbook .page {
	-webkit-box-shadow:0 0 10px rgba(0,0,0,0.2);
	-moz-box-shadow:0 0 10px rgba(0,0,0,0.2);
	-ms-box-shadow:0 0 10px rgba(0,0,0,0.2);
	-o-box-shadow:0 0 10px rgba(0,0,0,0.2);
	box-shadow:0 0 10px rgba(0,0,0,0.2);
}

.flipbook-viewport .page img {
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	margin: 0;
}

.flipbook-viewport .shadow {
	-webkit-transition: -webkit-box-shadow 0.5s;
	-moz-transition: -moz-box-shadow 0.5s;
	-o-transition: -webkit-box-shadow 0.5s;
	-ms-transition: -ms-box-shadow 0.5s;

	-webkit-box-shadow:0 0 10px #ccc;
	-moz-box-shadow:0 0 10px #ccc;
	-o-box-shadow:0 0 10px #ccc;
	-ms-box-shadow:0 0 10px #ccc;
	box-shadow:0 0 10px #ccc;
}
</style>
<div class="flipbook-viewport">
    <div class="container">
        <div class="flipbook">
        <#list pages as page><#list attachments as attachment>
            <#if attachment.get('uuid') == page.get('/')>
                <#assign file = attachment.get('file')>
                <div>
                    <img src="/file/${id}/${version}/${file}">
                </div>
            </#if>
        </#list></#list>
        </div>
    </div>
</div>
<script>
// Create the flipbook
function loadApp() {
    $('.flipbook').turn({
        width: 400,
        height: 600,
        elevation: 50,
        gradients: true,
        autoCenter: true
    })
}
$(document).ready(loadApp)
</script>
</#if>

<#list xml.getAllSubtrees('mods/relateditem') as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign issuuLink = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#if issuuLink == "">
        <div id="images">
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#-- @todo multiple of the same ID problem here -->
            <div id="image-single">
                <a href="/file/${id}/${version}/${full}">
                <img src="/thumbs/${id}/${version}/${uuid}"/></a>
                <#list xml.getAllSubtrees('mods/part') as part>
                    <#assign parttitle = part.get('title')>
                    <#assign partextent = part.get('extent')>
                    <#assign partnumber = part.get('number')>
                    <#if partnumber == uuid>
                        <#if parttitle != "" || partextent != "" || partnumber != "">
                            <p class='caption'>
                                <#if parttitle != ""><em>${parttitle} </em><br></#if>
                                <#if partextent != ""> ${partextent}</#if>
                            </p>
                        </#if>
                    </#if>
                </#list>
            </div>
        </#list>
        </div>
    <#elseif issuuLink != "">
        <div data-configid="${configID}" style="width: 525px; height: 525px;" class="issuuembed"></div>
        <script type="text/javascript" src="//e.issuu.com/embed.js" async="true"></script>
    </#if>

    <#if title != "" && location != "">
        <#if relateditem_index == 0>
            <dt>Related item</dt>
        </#if>
        <dd>
            <#if @type == "isReferencedBy">
                Referenced by:
            </#if>
            <em>
            <#if location != "" && location != "http://library.cca.edu/record=b">
                <a href="${location}">${title}</a>
            <#else>
                ${title}
            </#if>
            </em>
        </dd>
    </#if>
</#list>
</dl>
