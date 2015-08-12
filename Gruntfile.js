/* global module,require */
module.exports = function (grunt) {
    'use strict';
    // load all grunt tasks
    require('load-grunt-tasks')(grunt);

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
              style: 'compressed',
              sourcemap: 'none'
            },
            files: {
                'dist/dashboard-non-cca.min.css': 'Portlets/dashboard-non-cca.scss',
                'dist/dashboard-cca.min.css': 'Portlets/dashboard-cca.scss'
            }
          }
        },
        uglify: {
            dist: {
                files: {
                    'dist/non-cca-home.min.js': [
                        'Portlets/quick-search.js'
                        , 'Portlets/non-cca-home.js'
                        , 'Portlets/tour.js'
                    ],
                    'dist/cca-home.min.js': [
                        'Portlets/quick-search.js'
                        , 'Portlets/cca-home.js'
                        , 'Portlets/tour.js'
                    ]
                }
            },
            options: {
                compress: {
                    drop_console: true,
                    warnings: true
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
      }
    });

    grunt.registerTask('build', [
        'clean',
        'sass',
        'uglify'
    ]);

    grunt.registerTask('default', [
        'build'
    ]);
};
