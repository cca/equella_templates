# Portlets

These are not templates used in Collection Definition > Display but to display "portlets" on the dashboard, they can be edited and deleted on the [/access/portaladmin.do](https://vault.cca.edu/access/portaladmin.do) page.

Since many assets used in the portals (images, items, scripts, etc.) reference items only on the live server, it's not easy for us to dump the same portlet code into dev for testing. We can test portlets by displaying developmental ones only to ourselves. Hide the live portlets by wrapping them in:

```html
<#if ! user.hasRole('ROLE_SYSTEM_ADMINISTRATOR')>
<!-- portlet code… -->
</#if>
```

## Home page gallery

We use dashboard-gallery.ftl as our primary portlet for both authenticated and public users. It is mostly static links to VAULT assets but it shows a search link only to logged in users.

We used to show different galleries to authenticated and public users; a version of the current dashboard gallery was shown to unauthenticated users while CCA affiliates received the "cca-home.ftl" portlet. That portlet used pseudo-random search results to create dynamic galleries, but we discontinued it due to performance concerns.

## Scripts & Styles

You can load CSS and JS files separately from the main Freemarker template in the portaladmin settings. To load CSS, go to the **Freemarker / HTML** tab & use the **CSS file** field at the bottom. To load JS, go to the **Client-side on-ready script** tab & use the **Javascript file** field at the bottom.

I'm uncertain if files load in the order they're listed on these pages. It's also unclear if you can control the listed order.

Run `npm run build` to compile static assets. The compiled JS and CSS files from this directory are meant to be published to items in VAULT's Web Assets collection where they can be referenced inside the Freemarker templates.

## Display Order

The display order of portlets is user configurable; portlets can be dragged around. We hide the HTML that implements this to prevent users from messing up their home page too much. But putting the portlets in a particular order is difficult; they appear in the order they were created. So if we want to add a _new_ portlet at the top of the dashboard, we have to first _delete all existing portlets_, create the new one, & then recreate the old ones. Yes, it's a mess.

In some places, we work around this with scripts that clone portlet DOM elements and use them to reposition, see "quick-search.js" for instance. This approach is also imperfect.
