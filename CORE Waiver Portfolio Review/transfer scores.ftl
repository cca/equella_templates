<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign portfolioWaiverWrapper = xml.getAllSubtrees('local/portfolioWaiverWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<#attempt>

    <#function userIsMemberOf groupName>
      <#list user.getGroups() as group>
        <#if group.getName() == groupName>
          <#return true>
        </#if>
      </#list>
      <#return false>
    </#function>
<#-- Administrator only information-->

    <#if userIsMemberOf("First Year Portfolio Waiver Reviewers")>

    <h5 style="color: #936; text-align:center;">Information below displays ONLY to First Year Portfolio Waiver Coordinators and College Administrators.</h5>

        <#assign apIbCredits = xml.getAllSubtrees('local/portfolioWaiverWrapper/apIbCredits')>
        <#list portfolioWaiverWrapper as portfolioWaiverWrapper>
            <#assign apIbCreditsX = portfolioWaiverWrapper.get('apIbCredits')>
            <#assign apIbCreditNote = portfolioWaiverWrapper.get('apIbCreditNote')>
            <#assign transferCredits = portfolioWaiverWrapper.get('transferCredits')>
            <#assign transferCreditNote = portfolioWaiverWrapper.get('transferCreditNote')>
            <#assign ccaPrecollege = portfolioWaiverWrapper.get('transferCredits')>
            <#assign ccaPrecollegeNote = portfolioWaiverWrapper.get('ccaPrecollegeNote')>
            <#assign notes = portfolioWaiverWrapper.get('notes')>

            <#if apIbCreditsX != "">
                <dd><strong>AP or IB credits earned:</strong>
                <#list apIbCredits as apIbCredits>
                    ${apIbCredits}<#if apIbCredits_has_next>, </#if>
                </#list>
                </dd>
            </#if>
        <dd><strong>AP and/or IB courses and scores:</strong> ${apIbCreditNote}</dd>
        <dd><strong>Any credits transferred:</strong> ${transferCredits}</dd>
        <dd><strong>Transferred course credits and scores:</strong> ${transferCreditNote}</dd>
        <dd><strong>CCA Pre-College program attended?</strong> ${ccaPrecollege}</dd>
        <dd><strong>CCA Pre-College program courses and grades:</strong> ${ccaPrecollegeNote}</dd>
        </#list>
    </#if>

<#recover>

<dt>Confidential information could not display</dt>

</#attempt>
