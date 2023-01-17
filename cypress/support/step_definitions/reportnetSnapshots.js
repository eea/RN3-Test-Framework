
import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

const setDialog = option => {
  cy.get('button:contains(Yes):visible').click()
  cy.wait(2000)
};

Then("I can save a copy with description {string}", (description) => {
    cy.get("#createSnapshotDescription").type(description);
    cy.get('[class^=SnapshotSliderBar_create] >button').click({force:true});
    setDialog("Yes");
});
  
Then("I can {string} a dataset copy", (action) => {
  if(action === 'delete'){
    cy.get('[class*=SnapshotItem_listActions] > .warning > .p-button-text:first').click({force:true});
    cy.wait(10000)
  } else {
    cy.get('[class^=SnapshotItem_listActions] >button').first().click({force:true});
    cy.wait(10000)
  }  
  setDialog("Yes");
});

When("The snapshot list has {} record(s)", (snapshots) => {
  cy.get("[class*=SnapshotItem_listItemData]").should("have.length", snapshots);
  cy.wait(2000)
});