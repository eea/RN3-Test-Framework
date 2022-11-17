import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Then("I can see the Release status dashboard and Validation dashboards", () => {
    cy.contains("Validation dashboards")
    cy.contains("Release status dashboard")
    //cy.get('.chartjs-render-monitor').should('be.visible').should("have.length", 2);
});