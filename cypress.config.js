const { defineConfig } = require("cypress");
const mochareport =  require('cypress-mochawesome-reporter/plugin');
const addCucumberPreprocessorPlugin = require('@badeball/cypress-cucumber-preprocessor').addCucumberPreprocessorPlugin;
const createBundler = require("@bahmutov/cypress-esbuild-preprocessor");
const createEsbuildPlugin = require("@badeball/cypress-cucumber-preprocessor/esbuild").createEsbuildPlugin;


module.exports = defineConfig({
reporter: 'cypress-mochawesome-reporter',
reporterOptions: {
    charts: true,
    reportPageTitle: 'custom-title',
    json: true,
    embeddedScreenshots: true,
    inlineAssets: true,
    saveAllAttempts: false,
    },

    fixturesFolder: 'cypress/fixtures',
    screenshotsFolder:  'cypress/reports/html/screenshots',
    video: false,
    projectId: 'rujz2d',
    defaultCommandTimeout: 50000,

    e2e: {

      baseUrl: 'https://sandbox.reportnet.europa.eu/',
      specPattern: "cypress/integration/*.feature", 
      async setupNodeEvents(on, config) {
        const bundler = createBundler({
        plugins: [createEsbuildPlugin(config)],
    });
         
          on("file:preprocessor", bundler);
          await addCucumberPreprocessorPlugin(on, config);
          mochareport(on);
          
          return config
        },   

      },

      env: {
        TAGS: 'not @ignore'
      },
      
    });

