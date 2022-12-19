import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";


When('the Jobs Monitoring button is {string}', (visibility_status)=>{
    if (visibility_status=="visible")
    {
      cy.get('[data-for="jobsMonitoring"]').should('be.visible')
    }
    else if(visibility_status=="not visible")
    {
      cy.get('[data-for="jobsMonitoring"]').should('not.be.visible')
    }
  })

  Then('I click on the Jobs Monitoring button', ()=>{
    cy.get('[data-for="jobsMonitoring"]').click({force:true})
    cy.wait(1000)
  })

  When('the Jobs Monitoring window is {string}', (display_status)=>{
    if (display_status=="displayed")
    {
      cy.get('[class="p-dialog-title"]').contains("Jobs Monitoring").should('be.visible')
    }
    else if(display_status=="not displayed")
    {
        cy.get('[class="p-dialog-title"]').contains("Jobs Monitoring").should('not.be.visible')}
    })