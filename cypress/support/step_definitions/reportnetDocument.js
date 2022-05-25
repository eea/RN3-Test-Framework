
Then(/^I can download the document$/, () => {
     //const expectedFileName = 'test.csv';
     cy.get('[data-icon="file-csv"]:last').click();
     //cy.wait(3000)
     //cy.task('isExistDOC', expectedFileName).should('equal', true);
  });
  
  And("I {string} the document {string} with description {string} and language {string} marked as {string}",
    (action,file, description, language, isPublic) => {
      cy.get("#descriptionDocumentFileUpload").clear().focus().type(description);
      //cy.get("select[name=lang]").select(language);
      cy.get('[id=selectLanguage]').click();
      cy.wait(500)
      cy.get(`.p-dropdown-items>:contains(${language})`).click()
      //cy.contains(language).click();

      if(isPublic === 'public')
      cy.get('#isPublic').click();
       
      const fileName = file;
      cy.fixture(fileName).then(fileContent => {
        cy.get("input[type=file]:first").upload({
          fileContent,
          fileName,
          mimeType: "text/plain"
        });
      });
     action === 'upload' ? cy.get("span.pi-plus").click() : cy.contains("Save").click()
     cy.wait(2000)
    }
  );


  And("I see the {string} input with error",(input) => {
      cy.get(`[id=${input}]`).should('have.css', 'border-color','rgb(218, 33, 49)')
  })

  And("I upload the webform from file {string}", (file) => {  
    const fileName = file;
    cy.fixture(fileName).then(fileContent => {
      cy.get("input[type=file]:first").upload({
        fileContent,
        fileName,
        mimeType: "text/plain"
      });
    });
   cy.get("[data-for=confirmBtn]:contains(Create)").click()
   cy.wait(2000)
  }
);