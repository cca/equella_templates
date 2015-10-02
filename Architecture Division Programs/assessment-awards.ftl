<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#-- only display for faculty/staff, no need to specify Architecture here since they're the only ones able to see items anyways -->
<#if userIsMemberOf('Faculty') || userIsMemberOf('faculty') || userIsMemberOf('staff') || userIsMemberOf('Staff') || userIsMemberOf('System Administrators')>
    <style>
    ul.cida li {
        list-style-type: none;
    }
    </style>

    <#assign accreditation = xml.get('local/accreditation')>
    <#assign standards = xml.list('local/assessmentWrapper/standardWrapper/standardStaging')?sort>
    <#assign nominations = xml.list('local/nominatedFor')>
    <#assign awards = xml.list('local/award')>
    <#if awards?size != 0 || nominations?size != 0 || accreditation != "" || standards?size != 0>
        <br>
        <h4 class="alert text-center">Information below displays only to Architecture Division Faculty & College Administrators</h4>
    </#if>

    <#if nominations?size != 0>
        <dd><b>Nomination(s)</b>: <#list nominations as nomination>
            ${nomination}<#if nomination_has_next>, </#if>
        </#list></dd>
    </#if>

    <#if awards?size != 0>
        <dd><b>Award(s)</b>: <#list awards as award>
            ${award}<#if award_has_next>, </#if>
        </#list></dd>
    </#if>

    <#if accreditation != "">
        <dd><b>Used In</b>: ${accreditation}</dd>
    </#if>

    <#if standards?size != 0>
        <br>
        <h4>Associated Accreditation Standards</h4>
        <#-- "standard" here is an EQUELLA style for normal-looking <ul>s -->
        <ul class="cida standard">
        <#list standards as standard>
            <li>
                ${standard?replace('\\', '<ul class="cida"><li>')}
                <#-- close out subStandard sub-list -->
                </ul></li>
            </li>
        </#list>
        </ul>
    </#if>
</#if>
<#-- close dl opened in other display templates -->
</dl>
