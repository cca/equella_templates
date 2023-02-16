/* global module,require */
module.exports = function (grunt) {
    'use strict';
    // load all grunt tasks
    require('load-grunt-tasks')(grunt)

    grunt.initConfig({
        clean: {
            dist: {
                files: [{
                    dot: true,
                    src: [
                        'dist'
                    ]
                }]
            }
        },
        sass: {
          dist: {
            options: {
              'no-source-map': true,
              style: 'compressed'
            },
            files: {
                'dist/dashboard-non-cca.min.css': 'Portlets/dashboard-non-cca.scss'
            }
          }
        },
        uglify: {
            dist: {
                files: {
                    'dist/non-cca-home.min.js': [
                        'Portlets/quick-search.js'
                        , 'Portlets/non-cca-home.js'
                    ]
                }
            },
            options: {
                compress: {
                    drop_console: true
                },
                mangle: {
                    toplevel: true
                },
                nameCache: '.uglify-name-cache'
            }
        },
        watch: {
          dist: {
            files: ['Portlets/*.{css,js,scss}'],
            tasks: ['build']
          }
        },
        jshint: {
          all: ['Portlets/*.js'],
          options: {
              asi: true,
              laxcomma: true
          }
        }
    })

    grunt.registerTask('build', [
        'clean',
        'sass',
        'uglify'
    ])

    grunt.registerTask('default', [
        'build'
    ])
}
