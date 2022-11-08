import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

When("I add a weblink with description {string} and url {string} marked as {string}", (description, url, isPublic) => {
    cy.get("input[name=description]").type(description);
    cy.wait(500)
    cy.get("input[name=url]").type(url);
    if(isPublic === 'public')
      cy.get('#isPublic').click();
    cy.get("span.pi-plus:last").click();
    cy.wait(2000)
  }
);

Then("I can update the weblink with the description {string} to the text {string}",
  (description, url) => {
    cy.get(".pi-pencil:last").click({force:true});
    cy.get("input[name=description]").clear().type(description);
    cy.wait(500)
    cy.get("input[name=url]").clear().type(url);
    cy.contains("button", "Edit").click({ force: true });
  }
);