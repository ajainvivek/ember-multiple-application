# Ember Multiple Application

## Overview
This repository showcases structuring multiple ember-cli apps that share some common code (such as models, components, etc) from commons application.

This repository is extended from `workmanw` repo. The pattern is modified with inclusion of dependency management, switching across apps without CORS issue, resolving pattern some pattern caveats like live reload etc.

## Details

### Summary

The pattern demonstrated by this repo is essentially multiple concurrent ember-cli based applications. These applications make use of a "local ember-addon" mechanism. Each app exists independantly of the others, they just share common code. When developing you'll use multiple to servers (one per app). When building the script will trigger multiple `ember build` calls (one per app) and smash the builds together into a single dist (there is no conflict concern since the files will be fingerprinted). The common application acts as a guide to share components, services, mixins etc. Multiple apps interact with each other in a single port using static assets distributed hook. Apps talk to each with sharing context.

### Outline of configurations.
You can use this section if you want to duplicate this setup without having to clone this repo.

* "apps/common" hooks required dependencies via "commons.json".
* "apps/app1/package.json" and "apps/app2/package.json" include "lib/common" as a "ember-addon".
* "apps/common/package.json" has keywords for "ember-addon".
* "apps/common/app/styles/common.scss" imports all SASS files in the common directory.
  - "apps/app1/styles/app.scss" and "apps/app2/styles/app.scss" import "common.scss".
* **ALL** apps (app1 and app2) have the same `modulePrefix` set in "config/environment.js".
  - All ES2015 imports use "app" as the prefix, even in "common". Eg: `Import CommonAppMixin from "app/mixins/common";`
* Each app is configured with a different port (see: "apps/app1/.ember-cli" and "apps/app2/.ember-cli")

### Including dependency (commons.json)

{
  "name" : "app1",
  "path" : "common",
  "styles" : "scss",
  "commons" : {
    "components" : {
      "categories" : ["controls"],
      "controls" : {
        "modules" : ["ema-textfield", "something"]
      },
      "modules" : ["user-profile", "blog-post", "test"],
      "pod" : false
    }
  }
}

The above format can be extended to include models, services, mixins etc.


## Using repo

### Installing

  `./bin/install.sh`

### Running server

  `./bin/serve.sh app_name` [localhost:4200](http://localhost:4200)

Each server runs on a different port so you can launch multiple at the same time.

### Testing

  `./bin/test.sh`

  -- or --

  `./bin/server-app1.sh` and [localhost:4200/tests](http://localhost:4200/tests)

### Building

  `./bin/build.sh`

**Note:** you may need to tweak the build script to match your deployment needs. Right now each app will build to an "`app_name`.html" file (eg "app1.html").

### Adding another app
  * `cd apps && ember init app3`
  * `mkdir app3/lib && cd app3/lib.`
  * Edit "app3/package.json", adding the following (see app1/package.json as example):
  * Edit "app3/.ember-cli" and bump the port number
  * Include the new app to all the scripts

  ```"ember-addon": { "paths": [ "lib/common" ]}```

## Pattern Caveats
* Each app has it's own `bower.json`, `package.json` and `ember-cli-build.js` file.
  - This isn't necessarily a caveat, but it does mean if you add a dependency to the common addon, it will need to be added and imported to each app's config files.
* Multiple Servers
  - You will have to start multiple servers when developing on more that one app at a time.
* All apps must share the same name
  - As mentioned above, all apps must have the same `modulePrefix`.
