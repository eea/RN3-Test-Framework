// ***********************************************************
// This example plugins/index.js can be used to load plugins
//
// You can change the location of this file or turn off loading
// the plugins file with the 'pluginsFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/plugins-guide
// ***********************************************************

// This function is called when a project is opened or re-opened (e.g. due to
// the project's config changing)
//const path = require('path');
//const fs = require('fs');

const cucumber = require('cypress-cucumber-preprocessor').default
// const downloadDirectory = path.join(__dirname, '..', 'downloads');

// const findDoc = (DOCfilename) => {
//   const DOCFileName = `${downloadDirectory}/${DOCfilename}`;
//   const contents = fs.existsSync(DOCFileName);
//   return contents;
// };

// const hasDOC = (DOCfilename, ms) => {
//   const delay = 10;
//   return new Promise((resolve, reject) => {
//     if (ms < 0) {
//       return reject(
//         new Error(`Could not find Doc ${downloadDirectory}/${DOCfilename}`)
//       );
//     }
//     const found = findDoc(DOCfilename);
//     if (found) {
//       return resolve(true);
//     }
//     setTimeout(() => {
//       hasDOC(DOCfilename, ms - delay).then(resolve, reject);
//     }, 10);
//   });
// };

module.exports = (on, config) => {

  on('file:preprocessor', cucumber())

  // on('before:browser:launch', (browser, options) => {
  //   if (browser.family === 'chromium') {
  //     options.preferences.default['download'] = {
  //       default_directory: downloadDirectory,
  //     };
  //     return options;
  //   }
  //   if (browser.family === 'firefox') {
  //     options.preferences['browser.download.dir'] = downloadDirectory;
  //     options.preferences['browser.download.folderList'] = 2;
  //     options.preferences['browser.helperApps.neverAsk.saveToDisk'] =
  //       'text/csv';
  //     return options;
  //   }
  // });

  // on('task', {
  //   isExistDOC(DOCfilename, ms = 4000) {
  //     console.log(
  //       `looking for DOC file in ${downloadDirectory}`,
  //       DOCfilename,
  //       ms
  //     );
  //     return hasDOC(DOCfilename, ms);
  //   },
  // });

  //return config;
};
