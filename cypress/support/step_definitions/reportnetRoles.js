import { And } from "cypress-cucumber-preprocessor/steps";

Then("I can {string} a Data provider with Representative of {string} and account {string} and Data provider {string}", (action, representative, account, provider) => {
    if(action === "add") {
      cy.get("[class^=RepresentativesList_selectWrapper] .p-dropdown-trigger").click();
      cy.contains(representative).click()
      cy.wait(1000);
    } 
    if(action === "add" || action === "addMore") {
      cy.get("[class^=RepresentativesList_selectDataProvider]:last").select(provider)
      cy.get("#emptyInput").type(account+'{enter}');
    }
    if(action === "edit") {
      cy.get("[class^=RepresentativesList_selectDataProvider]:first").select(provider)
      cy.get("input:visible:first").clear().type(account+'{enter}');
    }
    if(action === 'delete') {
      cy.get('.pi-trash:visible:first').click({force:true});
      cy.get('.p-button-danger:visible').click({force:true})
    }
    cy.wait(1000);
    cy.get('button:contains(Close):visible').click({force:true})
  });

  And("I can add datasets for new Representatives",() => {
    cy.get('button:contains(Create):visible').click({force:true})
    cy.wait(1000)
  })

And("I can {string} a new editor {string} with permissions {string}",(action, editor, permission) => {
  cy.get("select:contains(Select)").select(permission)
  cy.get("#emptyInput").type(editor+'{enter}');
  cy.contains("Permissions").click();
  cy.get("#emptyInput:visible", {timeout:30000})
  cy.get(".p-button > .p-button-text:contains(Close)").click({force:true})
})
