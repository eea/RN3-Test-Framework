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

    Then("I can filter in Jobs monitoring window by {string} with {string}", (field, filter) => {
        if (field === 'jobId' || field === 'dataflowId' || field === "providerId" || field === "datasetId" || field === "creatorUsername_input") {
          cy.get(`[id='${field}_input']`).type(filter)
        }
        else if (field === 'Status') {
          cy.get('#jobStatus').click().children().contains(filter).click({force: true})
          cy.wait(3000)
        }
        else if (field === 'Type') {
          cy.get('#jobType').click().children().contains(filter).click()
          cy.wait(3000)}
      cy.wait(1000)
      //cy.get('.p-dialog-content .Filters_filterButton__1OEWb').click({ force: true })
      cy.get('.Filters_lineItems__2Nj0X > .Filters_buttonWrapper__sgK_8 > .Filters_filterButton__1OEWb > .p-button > .p-button-text').click({ force: true })
      
      cy.wait(5000)
    })

    Then('I click on the History tab', ()=>{
      cy.get('.Dialog_tabMenu__1xTXc > .p-tabmenu > .p-tabmenu-nav > [aria-expanded="0"] > .p-menuitem-link').click({force:true})
      cy.wait(1000)
    })

    Then("I can see the message on the page {string}",(message) => { 
      cy.get(`[class*=JobsStatuses_noDataContent__1G_kt]:contains(${message})`)
    })