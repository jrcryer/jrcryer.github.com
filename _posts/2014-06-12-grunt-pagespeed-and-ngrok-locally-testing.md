---
layout: posts
current: posts
title: Grunt PageSpeed with Ngrok for local testing
description: A tutorial on how to use Grunt PageSpeed with Ngrok to run Insights against local environments
excerpt: A tutorial on how to use Grunt PageSpeed with Ngrok to run Insights against local environments
keyword: Performance, Grunt, PageSpeed, PSI
---

Since releasing the original version of grunt-pagespeed a common question / issue that has been raise is the lack of support for running the [Grunt](http://gruntjs.com/) task against 
local development environments.  Yesterday Paul Kinlan [tweeted](https://twitter.com/paul_kinlan/status/476736368811732992) a solution to using secure tunnels to local development environments.

As outlined in Paul's tweet the tool to solve this problem is [ngrok](https://ngrok.com).  Ngrok allows you to securely expose local development enviroments
to the internet and also allows you to monitor traffic the development environment recieves.  For the remainder this post, we'll explore
how ngrok and grunt-pagespeed can be integrated into your build process.

### Setting up ngrok

Ngrok is available as binary download from it's own site https://ngrok.com.  However, it is also available as a Node module.
To get started firstly include ngrok into your project.

```
npm install ngrok --save-dev

```

Next we need to setup Grunt and our Gruntfile, lets install Grunt firstly:

```
npm install -g grunt-cli
npm install --save-dev grunt
touch Gruntfile.js

```

We need to now add the Grunt plugins to the project:

```
npm install grunt-pagespeed --save-dev
npm install load-grunt-tasks --save-dev

```

Now that the project has all it's dependencies, lets focus on the Grunt configuration to automate the testing of our local developement environment.
For this example, we'll assume we have our application around running on http://localhost:8000.  Lets start with a very simple skelton Gruntfile.

```js
'use strict'

var ngrok = require('ngrok');

module.exports = function(grunt) {

  // Load grunt tasks
  require('load-grunt-tasks')(grunt);

};

```

In the above Gruntfile we load the ngrok node module and setup our Gruntfile to export our tasks.  Finally the load-grunt-tasks module executed to automatically load all our Grunt plugins.  Next we'll configure grunt-pagespeed:

```js
'use strict'

var ngrok = require('ngrok');

module.exports = function(grunt) {

  // Load grunt tasks
  require('load-grunt-tasks')(grunt);

  // Grunt configuration
  grunt.initConfig({
    pagespeed: {
      options: {
        nokey: true,
        locale: "en_GB",
        threshold: 40
      },
      local: {
        options: {
          strategy: "desktop"
        }
      },
      mobile: {
        options: {
          strategy: "mobile"
        }
      }
    }
  });
};

```

The above defines configuration for the pagespeed task and defines two Grunt targets, one that will run our local dev environment via the the Desktop strategy and another via the mobile strategy.
As you may have noticed, we haven't declared a URL in our above configuration.  To get the URL, we will use ngrok and then pass this back to our pagespeed targets.  The configuration 
for this custom task is shown below:

```js
'use strict'

var ngrok = require('ngrok');

module.exports = function(grunt) {

  // Load grunt tasks
  require('load-grunt-tasks')(grunt);

  // Grunt configuration
  grunt.initConfig({
    pagespeed: {
      options: {
        nokey: true,
        locale: "en_G  B",
        threshold: 40
      },
      local: {
        options: {
          strategy: "desktop"
        }
      },
      mobile: {
        options: {
          strategy: "mobile"
        }
      }
    }
  });

  // Register customer task for ngrok
  grunt.registerTask('psi-ngrok', 'Run pagespeed with ngrok', function() {
    var done = this.async();
    var port = 8000;

    ngrok.connect(port, function(err, url) {
      if (err !== null) {
        grunt.fail.fatal(err);
        return done();
      }
      grunt.config.set('pagespeed.options.url', url);
      grunt.task.run('pagespeed');
      done();
    });
  });

  // Register default tasks
  grunt.registerTask('default', ['psi-ngrok']);
};

```

In the above configuration, we introduce a new custom task known as `psi-ngrok`.  The next couple of lines declare the local port that will be mapped to ngrok.  As our application is running on port 8000 (e.g. http://localhost:8000), we set this to 8000.
Next we call `ngrok.connect`, passing our port in and a callback.  The callback defines two parameters, `err` and `url`.  The important parameter is `url` which provides us with the public URL that maps to our local development environment.

We check whether we have any errors conneeting to ngrok but updating our pagespeed task configuration by using `grunt.config.set` and passing the url in.  Finally we call the `pagespeed` task with `grunt.task.run`.

### That's a wrap...

Hopefully this will be a helpful starting point in your adventures to automate performance testing with Grunt and PageSpeed Insights against local environments.  I'd encourage you to explore the ngrok and Grunt configuration to handle more sophisticated scenarios.

I've setup a sample project for people to fork as a starting point: [https://github.com/jrcryer/grunt-pagespeed-ngrok](https://github.com/jrcryer/grunt-pagespeed-ngrok)
