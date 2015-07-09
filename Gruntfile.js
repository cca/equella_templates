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
              'dist/dashboard-base.min.css': 'Portlets/dashboard-base.css'
            }
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
        'sass'
    ]);

    grunt.registerTask('default', [
        'build'
    ]);
};
