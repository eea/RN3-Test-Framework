And("I add a webkink with description {string} and url {string}", (description, url) => {
    cy.get("input[name=description]").type(description);
    cy.wait(500)
    cy.get("input[name=url]").type(url);
    cy.get("span.pi-plus:last").click();
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