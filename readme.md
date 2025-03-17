# VAULT Display Templates

These are the Freemarker templates used in the Display tab of VAULT collections.

Note: the set may not be complete and there's nothing stopping us from editing live templates without updating them here.

_All_ collections should have two common display sections, the "Sys Admin Links" (first one listed, for our troubleshooting convenience) here in the root of this project, and "viewLevel and access" (last display template before comments and attachments). Note the viewLevel section will be specific to each program since it uses a Power Search link.

## Contribution Wizard Controls

Note that these are all view templates used in the **Display** tab of EQUELLA's Collection Definition Editor. For the "advanced scripting controls" used alongside the form inputs which add HTML alerts for contributors and process data like course information, see the [equella_scripts](https://github.com/cca/equella_scripts) repo's "asc" folder.

## Grunt

Grunt tasks automate some tedious work. Once you have node and pnpm installed and on your path , run `pnpm install` to get dependencies then `npm run build` to build optimized web assets into the "dist" folder.

## Useful References

- [Freemarker Manual](http://freemarker.org/docs/)
- EQUELLA Script API reference (no public link, download inside server admin site)

## LICENSE

[Apache Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
