# Portlets

These are not templates used in Collection Definition > Display but to display "portlets" on the dashboard, they can be edited and deleted on the [/access/portaladmin.do](https://vault.cca.edu/access/portaladmin.do) page.

While we should avoid absolute URL references elsewhere (no "https://vault.cca.edu" on the front of everything), in the portlets it is probably necessary to use absolute URLs. Many URLs reference assets stored inside VAULT itself so if we move the code to our development instance, the URLs will point to nonexistent resources.

Note that portlets can also have CSS files loaded in their settings.

## Display Order

The display order of portlets is user configurable; portlets can be dragged around. We hide the HTML that implements this to prevent users from messing up their home page too much. But putting the portlets in a particular order is difficult; they appear in the order they were created. So if we want to add a _new_ portlet at the top of the dashboard, we have to first _delete all existing portlets_, create the new one, and then recreate the old ones. Yes, it's a mess.
