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
                'dist/dashboard-student-work.min.css': 'Portlets/dashboard-student-work.scss'
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