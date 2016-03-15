<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- ID is for Student Contributor Role -->
<#if user.doesntHaveRole("89ea364f-066e-1a3f-f70e-4b29f08e8448")>

    <h4 class="alert text-center">Information below does not display to students.</h4>

    <#list xml.getAllSubtrees('local/portfolioWaiverWrapper') as portfolioWaiverWrapper>
        <#assign apIbCredits = portfolioWaiverWrapper.list('apIbCredits')>
        <#assign ccaPrecollegeNote = portfolioWaiverWrapper.get('ccaPrecollegeNote')>

        <dd>
            <strong>College Courses (including CCA Pre-College):</strong><br>
            <#if ccaPrecollegeNote != ''>
                <pre>${ccaPrecollegeNote}</pre>
            <#else>
                (none)
            </#if>
        </dd>

        <#if apIbCredits?size != 0>
            <dd><strong><abbr title="Advanced Placement">AP</abbr> or <abbr title="International Baccalaureate">IB</abbr> credits earned:</strong>
            <#list apIbCredits as apIbCredit>
                ${apIbCredit}<#if apIbCredit_has_next>, </#if>
            </#list>
            </dd>
        </#if>

    </#list>
</#if>
