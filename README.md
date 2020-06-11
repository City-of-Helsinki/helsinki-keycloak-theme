# helsinki-keycloak-theme
Helsinki theme for Keycloaks IAM

**Requirements**  
- npm
- node

**Commands**  
| Name | Description |
|:-|:-|
| `npm run build` | Builds css files from scss sources |
| `npm run clean` | Removes files generated during build |
| `npm run make-pack` | Builds the project and packs the `/helsinki` folder into a `.tar.gz` file. The archive will be saved into project root with the name `helsinki.tag.gz`. |
| `npm run export-translations` | Transforms message files into a csv format and saves them in project root in format `<module name>_<language>.csv`. |
| `npm run update-translations` | Fetches current translations from a Google sheet source, parses them into `.properties` files and saves them under the correct module. |
| `npm run lint` | Lints project with eslint. You can use `npm run lint -- --fix` to fix fixable errors. |

To test this theme 1. Set up your local environment and then 2. build the theme.

**Table of Contents**
1. [Setting up a local environment](#setting-up-a-local-environment)
1. [Building the theme](#building-the-theme)
1. [Translations](#translations)
1. [Linting](#linting)

## Setting up a local environment

**1. Clone this repository**  
```
git clone https://github.com/City-of-Helsinki/helsinki-keycloak-theme.git
```

**2. Obtain a local keycloak instance**  

Find instructions here:
https://www.keycloak.org/docs/latest/getting_started/

Please also create an account for yourself.

**3. Create a new realm**  

For instance with the name of `locale-dev`

**4. Change login settings for your new realm**  

New Realm > Realm Settings > Login

| Setting | Value |
|:-|:-|
| User registration | true |
| Email as username  | true |
| Edit username | false |
| Forgot password | true |
| Remember me | false |
| Verify email | false |
| Login with email | true |
| Require SSL | external request |

New Realm > Realm Settings > Email

_Example settings for gmail with only the set settings as listed_
| Setting | Value |
|:-|:-|
| Host | smtp.gmail.com |
| Port  | 465 |
| From Display Name | local-dev-keycloak |
| From | local-dev-keycloak@somemail.com |
| Enable SSL | true |
| Enable Authentication | true |
| Username | your-gmail-username |
| Password | your-gmail-password |


**5. Disable caching for themes**  

`<Keycloak folder>/standalone/configuration/standalone.xml`

```diff
<theme>
-    <staticMaxAge>2592000</staticMaxAge>
+    <staticMaxAge>-1</staticMaxAge>
-    <cacheThemes>true</cacheThemes>
+    <cacheThemes>false</cacheThemes>
-    <cacheTemplates>true</cacheTemplates>
+    <cacheTemplates>false</cacheTemplates>
```

**6. Symlink helsinki theme into theme folder**  

When you are in `<Keycloak folder>/themes`

```bash
ln -s ~/path/to/helsinki-keycloak-theme/helsinki
```

**7. Use helsinki theme**  

New Realm > Realm Settings > Theme

| Setting | Value |
|:-|:-|
| Login Theme | helsinki |

## Building the theme

First, install `npm` dependencies

```bash
npm install
```

Then, build the project 

```bash
npm run build
```

## Translations

This project uses a centralized translation management approach. Google spreadsheet is used as the tool for sharing and editing translations. All translations can be found from within a single Google spreadsheet that's accessible to developers, translators and other relevant roles. You can find this sheet's id from script configs.

The spreadsheet is owned by an account that is managed by Helsinki City Executive Office's open source development group (Kanslian AOK, KAOK). If you need access to this file, please contact some of the key developer oriented people from KAOK. You will need your own Google account.

**Example**  
_Here's the recommended way for adding new translations_

1. Notice a need for a new translation
2. Open Google Spreadsheet
3. Find the sheet for module you are editing (i.e. login, email, ...)
4. Add a new row in a place that's logically sound (currently translations are grouped based on purpose)
5. Initially fill the correct translations you know (leave the rest for translators)
6. Go back to the `helsinki-keycloak-theme` project
7. Run `npm run update-translations`
8. The new translations should now be imported to the project!

When a translator goes over the spreadsheet and adds or corrects existing translations, just run `npm run update-translations` again to pull the new changes.

**More context**  
The translations spreadsheet has two types of sheets: (1) module level sheets and (2) language level sheets.

Module level sheets' names correspond to keycloak module names. In other words, the sheets "login" or "email" are module level sheets. These sheets are the actual translation sources. You should add and edit translations on these sheets.

Language level sheets are named in the following fashion: `<module_name>_<language_code>`. So, the English language sheet for the login module is named like so: `login_en`. These sheets exist as an integration layer. They simply reproduce the content of the module sheet while separating each language to its own sheet. You should not edit these sheets directly.

This setup conforms to a pattern that was used in for instance with [City-of-Helsinki/open-city-profile-ui](https://github.com/City-of-Helsinki/open-city-profile-ui).

**Cons**  
If you work on this theme alongside someone else, the translation spreadsheet may be edited from two different development branches at the same time. This may result in "dead" translations being pulled when making updates from the separate branches. Resolve these instances in the way you think is best.

## Linting

This project uses the recommended settings from `eslint` and `prettier` for linting. There are two `eslint` configs: root config and a separate config for scripts. The root `eslint` config targets the browser environment whereas the script config targets node.

It's recommended to configure your development environment in a way where errors are fixed on save. This can be achieved, for instance, with the help of plugins or configurations.
