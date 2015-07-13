<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign repos = xml.list('mods/relatedItem/location')>

<div class="item-title-and-desc">
	<h2 class="item-title-unselectable" data-itemuuid="${itemUuid}" data-itemversion="${itemversion}">
			${xml.get('mods/titleInfo/title')}
	</h2>
</div>

<div>
	<pre>${xml.get('mods/abstract')}</pre>
</div>

<h3>Relative URLs to Files</h3>
<dd>
    <form action="SELF" method="GET">
        <label for="root" class="checkbox">
            <input width="auto" type="checkbox" name="root" id="root" class="js-root">
            &nbsp;Prefix URLs with VAULT's Root?
        </label>
</dd>
<br>
<dd class="js-urls">
    <#list attachments as attachment>
        <#assign file = attachment.get('file')>
        <input class="input-block-level" type="text" name="url"
            value="/file/${itemUuid}/${itemversion}/${file}">
        <br>
    </#list>
    </form>
</dd>

<#if repos?size != 0>
	<h3>GitHub Repositories</h3>
	<dd><ul>
	<#list repos as repo>
		<li><a href="${repo}" target="_blank">${repo}</a></li>
	</#list>
	</ul></dd><br>
</#if>

<script>
// when checkbox is checked, prepend site's domain to URL inputs
$('.js-root').change(function () {
    var checked = $(this).is(':checked')
    $('.js-urls input').each(function(){
        var input = $(this)
        var url = input.val()
        input.val(checked ? location.origin + url : url.replace(location.origin, ''))
    })
})
</script>
