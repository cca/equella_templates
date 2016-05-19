<#assign accessCondition = xml.get('mods/accessCondition')>
<#if accessCondition != "">
    <dt class="hide">Rights</dt>
    <dd class="rights">${accessCondition}
        <#-- show CC icon -->
        <#if accessCondition?contains('CC-BY-NC')>
            <br><a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a>
        </#if>
    </dd>
</#if>
