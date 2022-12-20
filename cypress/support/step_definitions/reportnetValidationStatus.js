import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

When('the validations status button is {string}', (visibility_status)=>{
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
    cy.get('[data-for="validationsStatus"]').click({force:true})
    cy.wait(1000)
  })
  
  When('the validations status window is {string}', (display_status)=>{
    if (display_status=="displayed")
    {
      cy.get('[class="p-dialog-title"]').should('be.visible')
    }
    else if(display_status=="not displayed")
    {
        cy.get('[class="p-dialog-title"]').should('not.be.visible')}
    })
  
  
When('dataset column has clickable links', ()=>
    {
    cy.get('.p-datatable-wrapper tbody tr:nth-child(1) td:nth-child(2) a')
        .should('have.attr','href')
    })


Then ('the {string} button is not visible',()=>
  {
    cy.get('[class="p-dialog-title"]').should('not.exist')
  })

  When ('the link redirects to the reporting dataset', () =>{

    cy.get('.p-datatable-wrapper tbody tr:nth-child(1) td:nth-child(2) a').click()
    //cy.contains('Design').should('not.exist')
    cy.get('.TabularSwitch_tabLabel__3BOUp').should('not.exist')

  })

  When ('I get the dataflow ID from the url',()=>{
    cy.url().then(url => {
      let id = url.split('/')[4]
      cy.wrap(id).as('id')
    })
  })

  When ('I filter by dataflowId in the validation status window',(field)=>{
    if (field === 'dataflowId') {
      cy.get('@id').then(dataflowId => {
        cy.get(`[id='${field}_input']`).type(dataflowId)
        cy.wait(1000)
     });
    }
  })