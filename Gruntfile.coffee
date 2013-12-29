module.exports = (grunt) ->

  require('time-grunt')(grunt)
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    paths:
      images: "img"
      js: "js"
      css: "css"
      sass: "_sass"

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          keepalive: true

    imagemin:
      dist:
        options:
          optimizationLevel: 7
        files: [
          expand: true
          src: ['<%= paths.images %>/**/*']
        ]

    jekyll:
      dist:
        options:
          bundleExec: true

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

    sass:
      options:
        style: "compressed"
      dist:
        files:
          '<%= paths.css %>/app.css' : '<%= paths.sass %>/app.scss'

    watch:
      jekyll:
        files: ['**/*.html']
        tasks: ['jekyll']
        options:
          livereload: true
      css:
        files: ['<%= paths.sass %>/**/*.scss']
        tasks: ['sass', 'jekyll']
        options:
          livereload: true
      js:
        files: ['<%= paths.js %>/*.js']
        tasks: ['js', 'jekyll']
        options:
          livereload: true

  grunt.registerTask 'default', ['connect']
