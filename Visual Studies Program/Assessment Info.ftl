<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#-- Administrator only information-->
<#if userIsMemberOf("System Administrators") || userIsMemberOf("Library Administrator") || userIsMemberOf("College Administrators") || userIsMemberOf("Visual Studies Administrator") || userIsMemberOf("Visual Studies Faculty")>

    <#assign courseinfo = xml.get('local/courseInfo/courseinfo')>
    <#assign studentWorkUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3EAssignment+template%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Ccourseinfo%3E${escapeAmp(courseinfo)}%3C%2Fcourseinfo%3E%3C%2FcourseInfo%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <dd><strong>Assignment description</strong></dd>
    <dd><a href="${studentWorkUrl}" target="_blank">Click HERE to see the assignment description</a>.</dd>
    <dd><i>(This link only displays to Visual Studies faculty and college administrators.)</i></dd>
</#if>
