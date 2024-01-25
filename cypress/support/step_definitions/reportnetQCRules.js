import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Then("I can {string} the field constraint rule with fields",(action, fields) => {
    if(action === 'edit') {
        cy.get('[class*=BodyCell_actionTemplate] > :nth-child(3) > .p-button-text:last').click({force:true})
    } else if(action=='duplicate') {

        cy.get('.BodyCell_actionTemplate__1LLYg > :nth-child(3) > .p-button-text').click({force:true})
         
    }else{
        cy.contains('Create field constraint').click(); 
    }
    cy.wait(2000)
    const dataFields = fields.rawTable[0];
  
    cy.get('[id*=createValidation__table]').click({force:true})
    cy.wait(1000)
    action !== 'edit' && cy.get('.p-dropdown-item:visible').contains(dataFields[0]).click({force:true})
    cy.wait(5000)
    action !== 'edit' && cy.get('[id*=createValidation__field]').click({force:true})
    cy.wait(5000)
    action !== 'edit' && cy.get('.p-dropdown-item:visible').contains(dataFields[1]).click({force:true})
    cy.wait(5000)
    cy.get('[id*=createValidation__shortCode]').clear().type(dataFields[2])
    cy.get('[id*=createValidation__name]').clear().type(dataFields[3])
    cy.get('[id*=createValidation__description]').clear().type(dataFields[4])
    cy.get('[id*=createValidation__errorMessage]').clear().type(dataFields[5], {parseSpecialCharSequences:false})
    cy.get('[id*=createValidation__errorType]').type(dataFields[6]).click({force:true})
  
})

When("I can {string} a {string} with a {string} with fields", (action, type, subtype, fields) => {
    cy.contains("Expression").click({force:true})
    if(action === 'Create') {
        cy.get('.p-dropdown-label:contains(Select type):visible').click({force:true})
        cy.contains(type).click({force:true})
    }
    if(type==='SQL sentence') {
        cy.wait(5000)
        fields.rawTable.map((data,i) => {
            cy.get('#SQLsentenceTextarea').type(data[0]).click({force:true})
        })
    } else {
        action === 'Update' && cy.get("#createValidation__addExpresion").click({force:true})
        fields.rawTable.map((data,i) => {
            (action === 'Update' || i>=1) && cy.get(".p-dropdown:contains(Union):last").type(data[1]).click({force:true})
            cy.get(".p-dropdown-label:contains(Operator type):visible:last").type(data[2]).click({force:true})
            cy.get(".p-dropdown-label:contains(Operator):last").click({force:true})
            cy.get('li:contains('+data[3]+'):last').click({force:true})
            cy.get("[class*=ValidationExpression_expression] > > .p-inputtext:last").type(data[4])
            i < fields.rawTable.length-1 && cy.get("#createValidation__addExpresion").click({force:true})
        })
        cy.get('ul > > > > .p-checkbox-box:first').click()
        cy.get('ul > > > > .p-checkbox-box:last').click()
        subtype === "group" && cy.get('button:contains(Group)').click({force:true})
        cy.wait(1000)
    }
    if(action === "Create"){
        cy.get("#createValidation__create").click({force:true})
    }else {
        cy.get('button:contains('+action+')').click({force:true})
    }
})

When("I can update the expression with new number",()=>{
    cy.contains("Expression").click({force:true})
    cy.get("#createValidation__create").click({force:true})

})
 


When ("I can click the next page button",()=>{
    cy.get('.p-paginator-pages > :nth-child(2)').click({force:true})
    cy.wait(2000)
})

When("the code rule {string} is {string} on the list of rules", (code, property) =>{
    cy.wait(3000)
    cy.get('.p-dialog-content').scrollTo('bottomLeft')
    cy.get('.p-datatable-wrapper').scrollTo('left')
    cy.contains(code).should(property)
})

When("I can delete the rule {string}",(codeRule) => {
    cy.get('[class*=QCList_deleteRowButton] > .p-button-text:last').click({force:true})
    cy.get('.p-button-text:contains(Yes):visible').click({force:true})
    cy.wait(2000)
})

When("the new qc rule {string} is {string}", (codeRule, type) => {
    const property = type ==="correct" ? 'check' : ''
    cy.get('.p-dialog-content').scrollTo('bottomLeft')
    cy.get('.p-datatable-wrapper').scrollTo('left')
    cy.get('[class*=p-datatable-row]:contains('+codeRule+')>td> [class*=QCList_checkedValueColumn]:last> svg[data-icon="'+property+'"] ')
})

Then("the qcRules list has {int} items",(total) => {
    cy.get('.p-dialog-content').scrollTo('bottomLeft')
    cy.get(".p-datatable-row:visible").should("have.length", total);
})

When("I can {string} a row constraint with fields",(action, fields) => {
    const dataFields = fields.rawTable[0];
    cy.get('[id*=createValidation__table]:visible').click({force:true})
    cy.get('.p-dropdown-item:visible').contains(dataFields[0]).click({force:true})
    cy.get('[id*=createValidation__shortCode]:visible').clear().type(dataFields[1])
    cy.get('[id*=createValidation__name]:visible').clear().type(dataFields[2])
    cy.get('[id*=createValidation__description]:visible').clear().type(dataFields[3])
    cy.get('[id*=createValidation__errorMessage]:visible').clear().type(dataFields[4], {parseSpecialCharSequences:false})
    cy.get('[id*=createValidation__errorType]:visible').type(dataFields[5]).click({force:true})
})

When("I can {string} a expression with fields", (action, fields) =>{
    cy.contains("Expression").click({force:true})
    cy.get('.p-dropdown-label:visible:contains(Select type)').click()
    cy.contains('Field comparison').click()
    fields.rawTable.map((data,i) => {
        cy.get("[id*=fieldComparison__field1]").click()
        cy.contains(data[0]).click({force:true})
        cy.get(".p-dropdown-label:contains(Operator type):visible:last").type(data[1]).click({force:true})
        cy.get('li:contains('+data[2]+'):last').click({force:true})
        cy.get('li:contains('+data[3]+'):last').click({force:true})
        cy.get("[id*=fieldComparison__field2]").click({forc:true})
        cy.get(`.p-dropdown-item:contains(${data[4]}):last`).click({force:true})
        cy.get("#createValidation__create").click({force:true})
    })
})

When("I can {string} a table relation {string} with fields", (action,type, fields) => {
    cy.get('a[role=tab]').contains(/Table relations|Expression/g).click({force:true})
    if(action === 'Create' || action === 'Evaluate' || action === 'Run') {
        cy.wait(5000)
        cy.get('.p-dropdown-label:contains(Select type):visible').click({force:true})
        cy.get(`.p-input-overlay-visible > .p-dropdown-items-wrapper > .p-dropdown-items > :contains(${type})`).click({force:true})
    }
    if(type === 'SQL sentence') {
        cy.wait(5000)
        fields.rawTable.map((data,i) => {
            cy.get('#sqlSentenceText').type(data[0]).click({force:true})
        })
    } else {
        fields.rawTable.map((data,i) => {
            cy.get('.p-dropdown-label:visible:contains(Select schema)').type(data[0]).click({force:true})
            cy.get('.p-dropdown-label:visible:contains(Select table)').type(data[1]).click({force:true})
            cy.get('.p-dropdown-label:visible:contains(Select field):first').type(data[2]).click({force:true})
            cy.get('.p-dropdown-label:visible:contains(Select field):last').type(data[3]).click({force:true})
        })
    }
    if(action === 'Create')
    {
    cy.get("#createValidation__create").click({force:true})
    }
    else if (action === 'Evaluate')
    {
      cy.get('[class*=SqlSentence_validateButton] > .p-button-text').click({force:true})
      cy.wait(2000)
      cy.get('[class*=SqlSentence_sqlSentenceCostWrapper]')
      cy.wait(2000)
      cy.get("#createValidation__create").click({force:true})
    }
    else if (action === 'Run')
    {
      cy.get('[class*=SqlSentence_runButton] > .p-button-text').click({force:true})
      cy.wait(2000)
      cy.get('[class*=SqlSentence_noDataMessage]')
      cy.wait(2000)
      cy.get('.p-dialog-titlebar > .p-dialog-titlebar-icons > .p-dialog-titlebar-icon > .p-dialog-titlebar-close-icon:last').click({force:true})
      cy.wait(2000)
      cy.get("#createValidation__create").click({force:true})
    }
})


When("the code rule {string} with message {string} is visible on the list of validations",(code, message) => {
    cy.get(`.p-datatable-wrapper > table>.p-datatable-tbody>tr:contains(${code}):contains(${message})`)
})

When("I can view the historic changes of the rule {string}", (rule) => {
    cy.get('[class*=BodyCell_actionTemplate] > :nth-child(4) > .p-button-text:last').click({force:true})

})

When("I can see the history with following fields",(fields) => {
    const data = fields.rawTable[0]
    cy.get(`.p-datatable-row:contains(${data[0]})`)
    data[1] === 'true' && cy.get(`.p-datatable-row:contains(test.custodian) > :nth-child(3) svg[data-icon=check]`)
    data[2] === 'true' && cy.get(`.p-datatable-row:contains(test.custodian) > :nth-child(4) svg[data-icon=check]`)
    data[3] === 'true' && cy.get(`.p-datatable-row:contains(test.custodian) > :nth-child(5) svg[data-icon=check]`)
})

