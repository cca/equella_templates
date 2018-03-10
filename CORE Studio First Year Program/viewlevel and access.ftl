<dd class="rights">
<#list xml.getAllSubtrees('mods') as mods>
    <#assign accessCondition = mods.get('accessCondition')>

    <#switch accessCondition>
        <#case "CC BY 4.0">
            <#assign url = 'https://creativecommons.org/licenses/by/4.0/'>
            <p class="caption"><a rel="license" href="${url}">
                <img src="https://licensebuttons.net/l/by/4.0/88x31.png" alt="${accessCondition} license">
            </a></p>
            <p class="caption">This work is protected by a <a href="${url}">CC Attribution</a> license. You may distribute, remix, tweak, and build upon the work(s) as long as you credit the original student author.
            </p>
            <#break>
        <#case "CC BY-SA 4.0">
            <#assign url = 'https://creativecommons.org/licenses/by-sa/4.0/'>
            <p class="caption"><a rel="license" href="${url}">
                <img src="https://licensebuttons.net/l/by-sa/4.0/88x31.png" alt="${accessCondition} license">
            </a></p>
            <p class="caption">This work is protected by a <a href="${url}">CC Attribution ShareAlike</a> license. You may distribute, remix, tweak, and build upon the work(s) as long as you credit the original student author and use the same license for any new creations.
            </p>
            <#break>
        <#case "CC BY-ND 4.0">
            <#assign url = 'https://creativecommons.org/licenses/by-nd/4.0/'>
            <p class="caption"><a rel="license" href="${url}">
                <img src="https://licensebuttons.net/l/by-nd/4.0/88x31.png" alt="${accessCondition} license">
            </a></p>
            <p class="caption">This work is protected by a <a href="${url}">CC Attribution No Derivatives</a> license. You may distribute the works as long as they are passed along unchanged and in whole, with credit to the original student author.
            </p>
            <#break>
        <#case "CC BY-NC 4.0">
            <#assign url = 'https://creativecommons.org/licenses/by-nc/4.0/'>
            <p class="caption"><a rel="license" href="${url}">
                <img src="https://licensebuttons.net/l/by-nc/4.0/88x31.png" alt="${accessCondition} license">
            </a></p>
            <p class="caption">This work is protected by a <a href="${url}">CC Attribution Non-Commercial</a> license. You may distribute, remix, tweak, and build upon the work(s) non-commercially as long as you credit the original student author.
            </p>
            <#break>
        <#case "CC BY-NC-SA 4.0">
            <#assign url = 'https://creativecommons.org/licenses/by-nc-sa/4.0/'>
            <p class="caption"><a rel="license" href="${url}">
                <img src="https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png" alt="${accessCondition} license">
            </a></p>
            <p class="caption">This work is protected by a <a href="${url}">CC Attribution Non-Commercial ShareAlike</a> license. You may remix, tweak, and build upon the work(s) non-commercially as long as you credit the original student author and use the same license for any new creations.
            </p>
            <#break>
        <#case "CC BY-NC-ND 4.0">
            <#assign url = 'https://creativecommons.org/licenses/by-nc-nd/4.0/'>
            <p class="caption"><a rel="license" href="${url}">
                <img src="https://licensebuttons.net/l/by-nc-nd/4.0/88x31.png" alt="${accessCondition} license">
            </a></p>
            <p class="caption">This work is protected by a <a href="${url}">CC Attribution Non-Commercial No Derivatives license</a>. You may share the work(s) as long as you credit the original student author, but you cannot change the work(s) or use them for monetary gain.
            </p>
            <#break>
        <#default>
            <#list xml.getAllSubtrees('local') as local>
                <#assign viewLevel = local.get('viewLevel')>
                <#if viewLevel != "">
                    <p class="caption">
                        This item is <strong>${viewLevel}.</strong>
                    </p>
                </#if>
            </#list>
            ${accessCondition}
    </#switch>
</#list>
</dd>
</dl>
