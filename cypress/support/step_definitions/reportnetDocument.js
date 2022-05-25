
Then(/^I can download the document$/, () => {
     //const expectedFileName = 'test.csv';
     cy.get('[data-icon="file-csv"]:last').click();
     //cy.wait(3000)
     //cy.task('isExistDOC', expectedFileName).should('equal', true);
  });
  
  And("I {string} the document {string} with description {string} and language {string}",
    (action,file, description, language) => {
      cy.get("input[name=description]").clear().focus().type(description);
      cy.get("select[name=lang]").select(language);
      const fileName = file;
      cy.fixture(fileName).then(fileContent => {
        cy.get("input[type=file]:first").upload({
          fileContent,
          fileName,
          mimeType: "text/plain"
        });
      });
     action === 'upload' ? cy.get("span.pi-plus").click() : cy.contains("Save").click()
    }
  );