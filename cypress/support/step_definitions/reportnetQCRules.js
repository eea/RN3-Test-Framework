Then("I can {string} the Field Validation rule with fields",(action, fields) => {
    if(action === 'edit') {
        cy.get('[class*=ActionsColumn_editRowButton] > .p-button-text:last').click({force:true})
    } else {
        cy.contains('Create field constraint').click(); 
    }
    const dataFields = fields.rawTable[0];
  
    cy.get('[id*=createValidation__table]').click({force:true})
    cy.get('.p-dropdown-item:visible').contains(dataFields[0]).click({force:true})
  
    cy.get('[id*=createValidation__field]').click({force:true})
    cy.get('.p-dropdown-item:visible').contains(dataFields[1]).click({force:true})
  
    cy.get('[id*=createValidation__shortCode]').clear().type(dataFields[2])
    cy.get('[id*=createValidation__name]').clear().type(dataFields[3])
    cy.get('[id*=createValidation__description]').clear().type(dataFields[4])
    cy.get('[id*=createValidation__errorMessage]').clear().type(dataFields[5])
    cy.get('[id*=createValidation__errorType]').type(dataFields[6]).click({force:true})
  
})

And("I can {string} a {string} with fields", (action, type, fields) => {
    cy.contains("Expression").click({force:true})
    if(action === 'Update') {
        cy.get("#createValidation__addExpresion").click({force:true})
    }
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
    type === "group" && cy.get('button:contains(Group)').click({force:true})
    cy.wait(1000)

    if(action === "Create"){
        cy.get("#createValidation__create").click({force:true})
    }else {
        cy.get('button:contains('+action+')').click({force:true})
    }
})

And("the code rule {string} is {string} on the list of rules", (code, property) =>{
    cy.wait(2000)
    cy.get('.p-dialog-content').scrollTo('bottomLeft')
    cy.get('.p-datatable-wrapper').scrollTo('left')
    cy.contains(code).should(property)
})

And("I can delete the rule {string}",(codeRule) => {
    cy.get('[class*=ActionsColumn_deleteRowButton] > .p-button-text:last').click({force:true})
    cy.get('.p-button-text:contains(Yes):visible').click({force:true})
    cy.contains(codeRule).should('not.be.visible')
})

And("the new qc rule {string} is {string}", (codeRule, type) => {
    const property = type ==="correct" ? 'check' : ''
    cy.get('.p-dialog-content').scrollTo('bottomLeft')
    cy.get('.p-datatable-wrapper').scrollTo('left')
    cy.get('[class*=p-datatable-row]:contains('+codeRule+')>td> [class*=TabsValidations_checkedValueColumn]:last> svg[data-icon="'+property+'"] ')
})

Then("the qcRules list has {int} items",(total) => {
    cy.get(".p-datatable-row:visible").should("have.length", total);
})

And("I can {string} a row constraint with fields",(action, fields) => {
    const dataFields = fields.rawTable[0];
    cy.get('[id*=createValidation__table]:visible').click({force:true})
    cy.get('.p-dropdown-item:visible').contains(dataFields[0]).click({force:true})
    cy.get('[id*=createValidation__shortCode]:visible').clear().type(dataFields[1])
    cy.get('[id*=createValidation__name]:visible').clear().type(dataFields[2])
    cy.get('[id*=createValidation__description]:visible').clear().type(dataFields[3])
    cy.get('[id*=createValidation__errorMessage]:visible').clear().type(dataFields[4])
    cy.get('[id*=createValidation__errorType]:visible').type(dataFields[5]).click({force:true})
})

And("I can {string} a expression with fields", (action, fields) =>{
    cy.contains("Expression").click({force:true})
    cy.get('.p-dropdown-label:visible:contains(Select type)').click()
    cy.contains('Field comparison').click()
    fields.rawTable.map((data,i) => {
        cy.get("[id*=fieldComparison__field1]").contains(data[0]).click({force:true})
        cy.get(".p-dropdown-label:contains(Operator type):visible:last").type(data[1]).click({force:true})
        cy.get('li:contains('+data[2]+'):last').click({force:true})
        cy.get("[id*=fieldComparison__field2]").contains(data[3]).click({force:true})
        cy.get("#createValidation__create").click({force:true})
    })
})

And("I can {string} a table relation with fields", (action, fields) =>{
    cy.contains("Table relations").click({force:true})
    fields.rawTable.map((data,i) => {
        cy.get('.p-dropdown-label:visible:contains(Select schema)').type(data[0]).click({force:true})
        cy.get('.p-dropdown-label:visible:contains(Select table)').type(data[1]).click({force:true})
        cy.get('.p-dropdown-label:visible:contains(Select field):first').type(data[2]).click({force:true})
        cy.get('.p-dropdown-label:visible:contains(Select field):last').type(data[3]).click({force:true})
        cy.get("#createValidation__create").click({force:true})
    })
})
