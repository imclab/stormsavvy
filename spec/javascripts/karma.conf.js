module.exports = function(config) {
  config.set({
    basePath: '../..',

    preprocessors: {
      '**/*.coffee': 'coffee'
    },

    frameworks: ['jasmine', 'ng-scenario'],

    autoWatch: true,

    colors: true,

    port: 9876,

    logLevel: config.LOG_DEBUG,

    browsers: ['Safari'],

    loggers: [{type: 'console'}],

    singlerun: false,

    plugins : [
      'karma-jasmine',
      'karma-ng-scenario',
      'karma-safari-launcher',
      'karma-coffee-preprocessor',
      'karma-junit-reporter'
    ],

    exclude: [
      'app/assets/javascripts/angular-loader.js',
    ],

    files: [
      'app/assets/javascripts/angular.js',
      'app/assets/javascripts/angular-mocks.js',
      'app/assets/javascripts/main.js.coffee',
      'app/assets/javascripts/controllers/main/mainSiteCtrl.js.coffee',
      'app/assets/javascripts/controllers/main/mainIndexCtrl.js.coffee',
      'spec/javascripts/controllers_spec.js.coffee'
    ]
  });
};
