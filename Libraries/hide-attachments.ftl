<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- if non-library staff, we remove the attachments section at bottom of pg -->
<#if ! userIsMemberOf('System Administrators') && ! userIsMemberOf('Libraries') && ! userIsMemberOf('Library Contributors') && ! userIsMemberOf('Library Workstudy') && ! userIsMemberOf('Library Administrator')>
    <script>
    $(function{}($('#sc_attachments_div, #sc_attachments_extras, .area h3:last-of-type').remove()))
    </script>
    <style>
    #sc_attachments_div,
    #sc_attachments_extras,
    .area h3:last-of-type {
        display: none;
    }
    </style>
</#if>
