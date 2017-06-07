# Portlets

These are not templates used in Collection Definition > Display but to display "portlets" on the dashboard, they can be edited and deleted on the [/access/portaladmin.do](https://vault.cca.edu/access/portaladmin.do) page.

Since many assets used in the portals (images, items, scripts, etc.) reference items only on the live server, it's not really possible for us to dump the same portlet code into dev for testing. We can test portlets by displaying developmental ones only to ourselves and can hiding the live portlets by wrapping them in:

```html
<#if ! user.hasRole('ROLE_SYSTEM_ADMINISTRATOR')>
<!-- portlet code… -->
</#if>
```

## Scripts & Styles

You can load CSS and JS files separately from the main Freemarker template in the portaladmin settings. To load CSS, go to the **Freemarker / HTML** tab & use the **CSS file** field at the bottom. To load JS, go to the **Client-side on-ready script** tab & use the **Javascript file** field at the bottom.

I'm uncertain if files load in the order they're listed on these pages. It's also unclear if you can control the listed order.

## Display Order

The display order of portlets is user configurable; portlets can be dragged around. We hide the HTML that implements this to prevent users from messing up their home page too much. But putting the portlets in a particular order is difficult; they appear in the order they were created. So if we want to add a _new_ portlet at the top of the dashboard, we have to first _delete all existing portlets_, create the new one, & then recreate the old ones. Yes, it's a mess.

In some places, we work around this with scripts that clone portlet DOM elements and use them to reposition, see "quick-search.js" for instance. This approach is also imperfect.
