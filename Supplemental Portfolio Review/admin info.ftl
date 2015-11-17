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

        <#assign files = xml.list('/local/fileStagingWrappers/fileBstagingWrapper/fileB')>
        <#if files?size != 0>
            <dd><strong>Course Description Documents:</strong>
            <ul class="standard">
            <#list files as file>
                <#list itemAttachments as itemAttachment>
                    <#if file == itemAttachment.get('uuid')>
                        <li>
                            <#assign filename = itemAttachment.get('file')>
                            <a href="/file/${itemUuid}/${itemversion}/${filename}">
                                ${filename}
                            </a>
                        </li>
                    </#if>
                </#list>
            </#list>
            </ul>
            </dd>
        </#if>

    </#list>
</#if>
