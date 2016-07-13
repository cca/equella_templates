<#assign lectureSeriesWrapper = xml.getAllSubtrees('local/lectureSeriesWrapper')>
<#-- if Guest user, hide attachments
this is the Guest ("Public User") ID in here
whereas users _who aren't signed in_ show up as ID "guest" -->
<#assign uid = user.getID()>
<#if uid == 'ed48d1dd-6b07-4e8b-ab80-049bc04496f9' || uid == 'guest'>
    <#-- hide attachments box -->
    <style>
    #sc_attachments_div,
    #sc_attachments_extras {
        display: none;
    }
    </style>
    <#-- hide header (can't target with CSS as it has no class or ID)
    runs on document load (the 2nd line: "$(function(){…})")
    uses jQuery ":contains" selector to find tag by its text -->
    <script>
    (function($){
        $(function(){
            $('h3:contains("Links to resources")').remove();
        });
    }(jQuery));
    </script>
</#if>
<!-- ${user.getID()} -->
<dl>
<dt>${xml.get('mods/titleInfo/title')}</dt>
<br>

<dd class="big">Speakers:
<#list xml.list('mods/name/namePart') as name>
	<#assign nameUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${name}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Paaa268f2-21b8-4499-9651-af0e298a604d&q="><a href="${nameUrl}">${name}</a><#if name_has_next>, </#if>
</#list>
</dd>

<dd class="big">Lecture Series:
<#list lectureSeriesWrapper as lectureSeries>
	<#assign series = lectureSeries.get('series')>
	<#if series != "">
		<#assign seriesUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3ClectureSeriesWrapper%3E%3Cseries%3E${series}%3C%2Fseries%3E%3C%2FlectureSeriesWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Paaa268f2-21b8-4499-9651-af0e298a604d&q="><a href="${seriesUrl}">${series}</a><#if lectureSeries_has_next>, </#if>
	</#if>
</#list>
</dd>

<dd class="big">Year:
<#list xml.getAllSubtrees('mods/origininfo/dateOtherWrapper') as yearOther>
	<#assign year = yearOther.get('dateOther')>
	<#if year != "">
		<#assign yearUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Corigininfo%3E%3CdateOtherWrapper%3E%3CdateOther%3E${year}%3C%2FdateOther%3E%3C%2FdateOtherWrapper%3E%3C%2Forigininfo%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Paaa268f2-21b8-4499-9651-af0e298a604d&q="><a href="${yearUrl}">${year}</a>
	</#if>
</#list>
</dd>

<#list xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper') as date>
    <#assign dateCreated = date.get('dateCreated')>
	<dd class="date" style="font-size: 14px;">
    	Date:
    	<#if dateCreated == "">
            unknown date
    	<#elseif dateCreated != "">
    		${dateCreated}
    	</#if>
	</dd>
</#list>

<div style="clear:both;"></div>

<#list xml.getAllSubtrees('mods/location') as locationp>
	<#assign physicalLocation = locationp.get('physicalLocation')>
	<#if physicalLocation != "">
		<#assign physicalLocationUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Clocation%3E%3CphysicalLocation%3E${physicalLocation}%3C%2FphysicalLocation%3E%3C%2Flocation%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Paaa268f2-21b8-4499-9651-af0e298a604d&q=">
		<dd class="big">
		    Location: <a href="${physicalLocationUrl}">${physicalLocation}</a>
		</dd>
	</#if>
</#list>

<#list lectureSeriesWrapper as lectureSeries>
	<#assign releaseType = lectureSeries.get('releaseType')>
	<#assign releaseForm = lectureSeries.get('releaseForm')>
	<#assign haveRelease = lectureSeries.get('haveRelease')>
	<dd class="big">
    	<#if haveRelease == "">
            <i>No release form on file</i>
    	<#elseif haveRelease != "">
    		<#assign releaseTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3ClectureSeriesWrapper%3E%3CreleaseType%3E${releaseType}%3C%2FreleaseType%3E%3C%2FlectureSeriesWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Paaa268f2-21b8-4499-9651-af0e298a604d&q=">
    		Permitted release: <a href="${releaseTypeUrl}">${releaseType}</a>
    	</#if>
	</dd>
</#list>

<#assign abstract = xml.get('mods/abstract')>
<#if abstract != "">
	<dd class="big">Description: ${abstract}</dd>
</#if>

<#list xml.getAllSubtrees('mods/relateditem') as relatedItem>
	<#assign catalogLink = relatedItem.get('location')>
	<#if catalogLink != "">
		<#-- link is already a URL, no further processing needed -->
		<dd class="big">Library catalog record: <a href="${catalogLink}">${catalogLink}</a></dd>
	</#if>
</#list>

</dl>
