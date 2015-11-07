<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign portfolioWaiverWrapper = xml.getAllSubtrees('local/portfolioWaiverWrapper')>
<#assign local = xml.getAllSubtrees('local')>

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

    <#list portfolioWaiverWrapper as portfolioWaiverWrapper>
        <#assign apIbCredits = portfolioWaiverWrapper.list('apIbCredits')>
        <#assign transferCredits = portfolioWaiverWrapper.get('transferCredits')>
        <#assign transferCreditNote = portfolioWaiverWrapper.get('transferCreditNote')>
        <#assign ccaPrecollege = portfolioWaiverWrapper.get('transferCredits')>

        <dd><strong>CCA Pre-College program attended?</strong> ${ccaPrecollege}</dd>
        <#if apIbCredits?size != 0>
            <dd><strong>AP or IB credits earned:</strong>
            <#list apIbCredits as apIbCredit>
                ${apIbCredit}<#if apIbCredit_has_next>, </#if>
            </#list>
            </dd>
        </#if>
        <dd><strong>Any credits transferred:</strong> ${transferCredits}</dd>
        <dd><strong>Transferred course credits and scores:</strong><br><pre>${transferCreditNote}</pre></dd>

    </#list>
</#if>
