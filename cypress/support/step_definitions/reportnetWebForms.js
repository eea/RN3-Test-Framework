import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

When("I select the {string} webform developed in the system", (webform) => {

    cy.contains("No webform").click({force:true})
    cy.contains(webform).click({force:true})
    cy.contains("Save").click()
    cy.wait(1000)
})

When ("I select the option {string}", (option) => {
    cy.get('[class*=DatasetDesigner_switchDiv] > :nth-child(3)> .p-radiobutton').click({force:true})
})

When ("I will see the webform configured", () => {
})

When("I click on Single PaM with id {string}" , (id) => {
    cy.wait(1000)
    cy.get(`[class*=Article13_tableListContentWrapper] > :nth-child(1):contains(${id})`).click({force:true})
    cy.wait(3000)
})

When("I will see the field {string} on {string}", (field, table) => {
    cy.get(`[class*=WebformView_webform__3VL] > > > > .p-button-text:contains(${table})`).click({force:true})
    cy.wait(1000)
    cy.contains(field)
})

When("I will see an icon in the field {string} in table {string} which are configured in the webform but not created in the model", (field, table) =>{
    cy.contains('The field ' + field + ' is not created in the design, please check it')
})

When("I will see an icon in the table {string} which are configured in the webform but not created in the model", (name) =>{
    cy.get('.p-toolbar-group-left :contains(' + name + '):visible>.pi').should("have.length", 1)
})

When("I can see the updated list of webforms {string}", (name) => {
    let dataflow = bddGeneratedValues.get(name)
    findInPage(dataflow)
   })
   
   function findInPage(dataflow) {
     let found = false;
   
     cy.get('.p-dialog-content .p-datatable-row').each(($row) => {   
       if ($row.find('td:first-child').text() == dataflow) {
         found = true;
         cy.log("found")
       }
     }).then(() => {
       if (found == false) {
         cy.log("not found")
         cy.get('.p-dialog-content .p-paginator-next').should('not.be.disabled')
         cy.get('.p-dialog-content .p-paginator-next').click()
         findInPage(dataflow)
       }
    })
   }
   