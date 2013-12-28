module.exports = (grunt) ->

  require('time-grunt')(grunt)
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    paths:
      images: "app/img"
      js: "app/js"
      css: "app/styles"
      sass: "app/_sass"

    imagemin:
      dist:
        options:
          optimizationLevel: 7
        files: [
          expand: true
          src: ['<%= paths.images %>/**/*']
        ]

    jshint:
      options:
        curly: true
        eqeqeq: true
        eqnull: true
        browser: true
        globals:
          jQuery: true
      files:
        src: [
          '<%= paths.js %>/*.js'
        ]

    recess:
      options:
        compile: false
        noIDs: false
        noJSPrefix: false
        noUniversalSelectors: false
      files:
          src: ['<%= paths.css %>/app.css']

    watch:
      css:
        files: ['<%= paths.sass %>/*.sass']
        tasks: ['sass']
        options:
          livereload: true
      js:
        files: ['<%= paths.js %>/*.js']
        tasks: ['js']
        options:
          livereload: true

  grunt.registerTask 'default', ['build']
