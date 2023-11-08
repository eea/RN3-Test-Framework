import { When, Then } from "@badeball/cypress-cucumber-preprocessor";

When ('I get the dataset ID from the url',()=>{
    cy.url().then(url => {
      let id = url.split('/')[6].split('?')[0];
      cy.wrap(id).as('id')
    })
  })

 Then ('I type the dataset ID in the control status window',()=>{
      cy.get('@id').then(datasetId => {
        cy.get(`[id='datasetId']`).type(datasetId)
        cy.wait(1000)})})

When ('I get the provider Id from the url',()=>{
    cy.url().then(url => {
      let id = url.split('/')[6]
      cy.wrap(id).as('proid')
    })
  })

  When ('I type the provider Id',()=>{
      cy.get('@proid').then(dataProviderId => {
        cy.get(`[id='dataProviderId']`).type(dataProviderId)
        cy.wait(1000)
     })
  })

When("the button Control status is visible", () => {
    cy.get('[data-for="controlStatus"]').should('be.visible')
  })

When('I click on the Control status button', ()=>{
    cy.get('[data-for="controlStatus"]').click({force:true})
    cy.wait(1000)
  })

When('I click on the Find dataset button', ()=>{
  cy.get('.p-button-text.p-c').contains('Find dataset').click({force:true})
  cy.wait(1000)
})

When('I click on the delete button', ()=>{
  cy.get('.p-button .pi-trash').click({force:true})
  cy.wait(1000)
  cy.get('.p-button-text.p-c').contains('Yes').click({force:true})
  cy.wait(1000)
})

When('I click on the datasetId field', ()=>{
    cy.get('#datasetId').click({force:true})
})

When('I click on the dataProviderId field', ()=>{
    cy.get('#dataProviderId').click({force:true})
})

When("I see the message SUCCESS RELEASE TO DATA COLLECTION",() => {
    cy.wait(40000)
    cy.contains('SUCCESS')
    cy.wait(10000)
  });