import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Then(/^I can download the document$/, () => {
     //const expectedFileName = 'test.csv';
     cy.get('[data-icon="file-csv"]:last').click();
     //cy.wait(3000)
     //cy.task('isExistDOC', expectedFileName).should('equal', true);
  });
  
  When("I {string} the document {string} with description {string} and language {string} marked as {string}",
    (action, file, description, language, isPublic) => {
      cy.get("#descriptionDocumentFileUpload").type(description);
      //cy.get("select[name=lang]").select(language);
      cy.get('[id=selectLanguage]').click({force: true});
      cy.wait(500)
      cy.get('.p-dropdown-items>li:nth-child(6)').click({force: true});
      //cy.get(`.p-dropdown-items>:contains(${language})`).click({force: true})
      //cy.contains(language).click();

      if(isPublic === 'public')
      cy.get('#isPublic').click();
       
      const fileName = file;
      //cy.fixture(fileName).then(contents => {
        cy.fixture(fileName, { encoding: null }).as('myFixture')
        cy.get("input[type=file]:first").selectFile('@myFixture',{
          fileName,
          mimeType: "text/plain",
          force: true
        })
      cy.wait(2000)
      action === 'upload' ? cy.get("span.pi-plus").click({force: true}) : cy.contains("Save").click()
      cy.wait(2000)
    }
  );


  When("I see the {string} input with error",(input) => {
      cy.get(`[id=${input}]`).should('have.css', 'border-color','rgb(218, 33, 49)')
  })

  When("I upload the webform from file {string}", (file) => {  
    const fileName = file;
    //cy.fixture(fileName).then(contents => {
      cy.fixture(fileName, { encoding: null }).as('myFixture')
      //cy.get("input[type=file]:first").selectFile({
        cy.get('input[type="file"]').selectFile('@myFixture',{
        fileName,
        mimeType: "text/plain",
        force: true
      })
    cy.wait(2000)
    cy.get("[data-for=confirmBtn] button").click({force: true})

  }
);

When("I click on country {string}",(input) => {
  cy.get('.class= PublicCountries_titleWrap__1uGiC').contains(`[id=${input}]`).click({force:true})
})