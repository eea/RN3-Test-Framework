Then("I can see the dataset schema {string}", (fields) => {
    fields.split(',').map(f => {cy.contains(f)});
  });
  const setDialog = option => {
    //cy.get("span:visible")
     cy.contains(option)
      .click({force:true});
  };

  const fillFields = (fields) => {
    const codes = fields.split(',')
    codes.map((code) => {
      cy.get('.p-chips-input-token  > .p-inputtext').type(code + "{enter}",{force:true})
   })
  };

Then("I can {string} a dataset schema with name {string}", (action, name) => {
  if(action === "create") {
    cy.get('li:visible>a').contains('New empty dataset schema').click({force:true})
    cy.get("input[name=datasetSchemaName]").clear().type(name);
    cy.get('button:contains(Create)').click({force:true})
  } else if(action === 'rename') {
    cy.contains('DS-Test').dblclick()
    cy.wait(500)
    cy.get('input:visible').clear().type(name + "{enter}")
    cy.wait(500)
  } else if(action === 'delete') {
    cy.get('.pi-caret-down:last').click()
    cy.get('li:visible>a').contains('Delete').click({force:true})
    setDialog("Yes")
  } else if(action === 'clone') {
    cy.get('li:visible>a').contains('Clone all schemas from dataflow').click({force:true})
    cy.get('[class*=p-datatable-row]:contains('+name+')>td>[class*=TableViewSchemas_checkColum] > .p-checkbox ').click({force:true})
    cy.get('button:contains(Clone selected dataflow)').click({force:true})
  }
})
  
Then("I can fill a dataset schema with name {string}, description {string} and with following fields",(name, description, fields) => {
  cy.wait(2000)
  cy.get('.p-tabview-title:last').click({force:true})
  cy.get('input:visible[placeholder="Table name"]').clear().type(name + "{enter}",{force:true})
  cy.wait(1000)
  cy.contains(name).click({force:true})
  cy.get('textarea[placeholder="Table description"]').type(description,{force:true})
  fields.rawTable.map(fields => {
    cy.wait(1000)
    cy.get('input:visible:last').should('have.attr', 'placeholder', 'Field name').type(fields[0],{force:true})
    cy.wait(500)
    if(fields[4]==="true") {
      cy.get('[class*=FieldDesigner_checkPK]:last').click()
    }
    cy.get('.p-inputtextarea:last').type(fields[1])
    cy.wait(500)
    cy.get('[class^=FieldDesigner] > .p-dropdown:last').click({force:true})
    cy.get('li:visible>div>span').contains(fields[2]).click({force:true})
    cy.wait(500)
    if(fields[2] === 'Single select') {
      fillFields(fields[3])
      setDialog("Save")
    } else if(fields[2] === 'Attachment') {
      fillFields(fields[3])
      cy.get('[class*=AttachmentEditor_maxSizeWrapper] > :nth-child(3)').dblclick({force:true})
       setDialog("Save")
    }
    cy.wait(1000)
  })
})

And("I can define a field as a foreign key to table {string}", (table) => {
  cy.wait(1000)
  cy.get("[aria-label='"+table+"']").click()
  setDialog("Save")
  cy.wait(1000)
})

And("I can create a unique constraint with table {string} and field {string}", (table, field) => {
  cy.get('[aria-label="' + table + '"]').click()
  cy.get('.p-listbox-item:last').click()
  cy.get('[data-tip="true"] > .p-button > .p-button-text').click({force:true})
})

And("the unique constraint {string} is {string} on the list", (unique, property) => {
  cy.wait(2000)
  cy.get('.p-datatable-tbody:contains('+unique+')').should(property)
})
