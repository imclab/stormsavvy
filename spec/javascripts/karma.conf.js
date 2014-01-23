module.exports = function(config) {
  config.set({
    basePath: '../..',

    frameworks: ['jasmine'],

    autoWatch: true,

    preprocessors: {
      '**/*.coffee': 'coffee'
    },

    files: [
      'app/assets/javascripts/angular.js',
      'app/assets/javascripts/angular-*.js',
      'app/assets/javascripts/angular-mocks.js',
      'app/assets/javascripts/main.js.coffee',
      'app/assets/javascripts/application.js',
      'app/assets/javascripts/controllers/*',
      'app/assets/javascripts/controllers/main/*',
      'app/assets/javascripts/directives/*',
      'app/assets/javascripts/filters/*',
      'app/assets/javascripts/services/*',
      'spec/javascripts/*_spec.js.coffee'
    ]
  });
};
