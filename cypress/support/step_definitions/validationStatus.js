const {  And, Then } = require("cypress-cucumber-preprocessor/steps");

And('the validations status button is {string}', (visibility_status)=>{
    if (visibility_status=="visible")
    {
      cy.get('[data-for="validationsStatus"]').should('be.visible')
    }
    else if(visibility_status=="not visible")
    {
      cy.get('[data-for="validationsStatus"]').should('not.be.visible')
    }
  })
  
  Then('I click on the validations status button', ()=>{
    cy.get('[data-for="validationsStatus"]').click()
  })
  
  And ('the validations status window is {string}', (display_status)=>{
    if (display_status=="displayed")
    {
      cy.get('[class="p-dialog-title"]').should('be.visible')
    }
    else if(display_status=="not displayed")
    {
        cy.get('[class="p-dialog-title"]').should('not.be.visible')}
    })
  
  
And('dataset column has clickable links', ()=>
    {
    cy.get('.p-datatable-wrapper tbody tr:nth-child(1) td:nth-child(2) a')
        .should('have.attr','href')
    })


Then ('the validations status button is not visible',()=>
  {
    cy.get('[class="p-dialog-title"]').should('not.exist')
  })