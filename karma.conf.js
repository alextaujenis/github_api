module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine'],
    files: [
      'https://cdnjs.cloudflare.com/ajax/libs/jasmine-ajax/3.2.0/mock-ajax.min.js',
      'src/*.coffee',
      'spec/*.coffee'
    ],
    exclude: [],
    preprocessors: {
      '**/*.coffee': ['coffee']
    },
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome'],
    singleRun: false,
    concurrency: Infinity
  });
};
