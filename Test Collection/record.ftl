<h2 id="title">${xml.get('mods/titleInfo/title')}</h2>

<dt>
<#list xml.getAllSubtrees('mods/name') as name>
    <#list name.list('namePart') as part>
        <dd>${part}</dd>
    </#list>
</#list>
</dt>

<#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign division = xml.get('local/division')>
    <#assign department = courseInfo.get('department')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign courseName = courseInfo.get('courseName')>
    <#assign course = courseInfo.get('course')>
    <#assign section = courseInfo.get('section')>
    <dt class="subHeading">
        <#if semester != "">
            ${semester}
        </#if>
        <#if division != "">
            | ${division}
        </#if>
        <#if department != "">
            | ${department}
        </#if>
    </dt><br/>
    <dt class="subHeading">
        <#if faculty != "">
            ${faculty}
        </#if>
        <#if courseName != "">
            | ${courseName}
        </#if>
        <#if course != "">
            | ${course}
        </#if>
        <#if section != "">
            | ${section}
        </#if>
    </dt><br>
</#list>

<div>
${xml.get('mods/abstract')}
</div>
