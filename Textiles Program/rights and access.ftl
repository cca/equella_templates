<div style="clear:both;"></div>
	<#assign viewLevel = xml.get('local/viewLevel')>
	<#assign viewLevelUrl = "">
	<#if viewLevel != "">
		<dd class="rights">This item is ${viewLevel}.
	</#if>

	<#assign accessCondition = xml.get('mods/accessCondition')>
	<#if accessCondition != "">
		<br>${accessCondition}.</dd>
	</#if>
<div style="clear:both;"></div>
