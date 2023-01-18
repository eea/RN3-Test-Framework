import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

When ('I get the dataset ID from the url',()=>{
    cy.url().then(url => {
      let id = url.split('/')[6].split('?')[0];
      cy.wrap(id).as('id')
    })
  })

  Then ('I type the dataset ID in the control status window',(field)=>{
    if (field === 'datasetId') {
      cy.get('@id').then(datasetId => {
        cy.get(`[id='${field}_input']`).type(datasetId)
        cy.wait(1000)
     });
    }
  })

  When ('I get the provider Id from the url',()=>{
    cy.url().then(url => {
      let id = url.split('/')[6]
      cy.wrap(id).as('id')
    })
  })

  When ('I type the provider Id',(field)=>{
    if (field === 'dataProviderId') {
      cy.get('@id').then(dataProviderId => {
        cy.get(`[id='${field}_input']`).type(dataProviderId)
        cy.wait(1000)
     });
    }
  })