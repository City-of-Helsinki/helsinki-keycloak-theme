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

To test this theme 1. Set up your local environment and then 2. build the theme.

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

## For future developers

The theme currently applies overrides to the HDS lib in order to reflect styles that are used in a newer iteration of the visual guidelines. These are located in the `sass/hds-overrides.scss` file and in `sass/theme.scss` files. Please do your best to remove these overrides when you are able.