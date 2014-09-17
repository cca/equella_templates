<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>

<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <#assign viewLevelUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CviewLevel%3E${viewLevel}%3C%2FviewLevel%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=name&dr=AFTER" />
    <#if viewLevel != "">
        <dd class="rights">This item is <a href="${viewLevelUrl}">${viewLevel}.</a>
    </#if>
</#list>

<#list modslevel as mods>
    <#assign accessCondition = mods.get('accessCondition')>
    <#if accessCondition != "">
        <br>${accessCondition}</br></dd>
    </#if>
</#list>
