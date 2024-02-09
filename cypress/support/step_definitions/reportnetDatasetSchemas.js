import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

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
    cy.get('[class*=BigButton_bigButton] > > ul>li').contains('New empty dataset schema').click({force:true})
    cy.get("input[name=datasetSchemaName]").clear().type(name);
    cy.get('button:contains(Create)').click({force:true})
    cy.wait(4000)
  } else if(action === 'rename') {
    cy.contains('DS-Test').dblclick()
    cy.wait(500)
    cy.get('input:visible').clear().type(name + "{enter}")
    cy.wait(500)
  } else if(action === 'delete') {
    cy.get('.pi-caret-down:last').click()
    cy.get('[class*=BigButton_bigButton] > > >>li').contains('Delete').click({force:true})
    setDialog("Yes")
  } else if(action === 'clone') {
    cy.get('[class*=BigButton_bigButton] > > ul>li').contains('Clone all schemas from dataflow').click({force:true})
    cy.get('[class*=p-datatable-row]:contains('+name+')>td>[class*=TableViewSchemas_checkColum] > .p-checkbox ').click({force:true})
    cy.get('button:contains(Clone selected dataflow)').click({force:true})
  } else if(action === 'import') {
    cy.get('[class*=BigButton_bigButton] > > ul>li').contains('Import schema').click({force:true})
    //cy.get('.p-dialog-title').contains('Confirm new dataset schema creation')
    //cy.get('.p-button-text:contains(Yes)').click({force:true})
  }
})

Then("I can create a dataset schema public available with name {string}", (name)  => {
    cy.get('[class*=BigButton_bigButton] > > ul>li').contains('New empty dataset schema').click({force:true})
    cy.get("input[name=datasetSchemaName]").clear().type(name);
    cy.get('button:contains(Create)').click({force:true})
    cy.wait(4000)
})

Then ("Confirm new dataset schema creation is visible", ()=>{
  cy.get('.p-dialog-title').contains('Confirm new dataset schema creation')
  cy.get('.p-button-text:contains(Yes)').click({force:true})
  cy.wait(1000)
})

Then ("Available in public view is checked", ()=>{
  cy.get('#available_in_public_view input').should('be.checked')
  //cy.get(`[class*=DatasetDesigner_datasetConfigurationButtons]> :contains(Available)> > .p-checkbox-box`).should('be.checked')

})

  
Then("I can fill a dataset schema with name {string}, description {string} and with following fields",(name, description, fields) => {
  cy.wait(4000)
  cy.get('.p-tabview-title:last').click({force:true})
  cy.wait(1000)
  cy.get('input:visible[placeholder="Table name"]').clear().type(name + "{enter}",{force:true})
  cy.wait(1000)
  cy.contains(name.replace('*/+','')).click({force:true})
  cy.wait(2000)
  cy.get('textarea[placeholder="Table description"]').type(description,{force:true})
  fields.rawTable.map(fields => {
    cy.wait(3000)
    cy.get('input:visible:last').should('have.attr', 'placeholder', 'Field name').type(fields[0],{force:true})
    cy.wait(10000)
    if(fields[4]==="true") {
      cy.get('[class*=FieldDesigner_draggableFieldDiv] [role="checkbox"]:first').click()
    }
    if(fields[5]==="true") {
      cy.get('[class*=FieldDesigner_draggableFieldDiv] [role="checkbox"]:last').click()
    }
    cy.wait(4000)
    cy.get('#_description').should('have.attr', 'placeholder', 'Field description').type(fields[1])
    cy.wait(4000)
    cy.get('[class^=FieldDesigner] > .p-dropdown:last').click({force:true})
    cy.wait(4000)
    cy.get('li:visible>div>span').contains(fields[2]).click({force:true})
    cy.wait(3000)
    if(fields[2] === 'Single select' || fields[2] ==='Multiple select') {
      let options = fields[3].replaceAll("{enter}", "; ");
      fillFields(fields[3])
      setDialog("Save")
      cy.get(`[class*=FieldDesigner_codelistButton]:contains(${options})`)
    } else if(fields[2] === 'Attachment') {
      fillFields(fields[3])
      cy.get('[class*=AttachmentEditor_maxSizeWrapper] > :nth-child(3)').dblclick({force:true})
       setDialog("Save")
    }
    cy.wait(2000)
  })
})

Then("I can edit the field {string} type", (field)=>{
  cy.get('[draggable="true"][style="cursor: default;"] > :nth-child(7) > .FieldDesigner_dropDownLabel__1FTrZ > .p-dropdown > .p-dropdown-label').click({force:true})
  cy.get('li:visible>div>span').contains(field).click({force:true})
  cy.wait(1000)
   })

Then("I can close the QC page and go to the dataflow page", () => {
  cy.get('.DatasetDesigner_closeButton__25-dx > .p-button-text').click({force:true})
  cy.wait(1000)
  cy.get(':nth-child(5) > .p-menuitem-link > .p-menuitem-text').click({force:true})

})

Then("I can quickly edit and {string} QC", (action)=>{
  cy.wait(1000)
  cy.get('.BodyCell_actionTemplate__1LLYg > :nth-child(3) > .p-button-text').click({force:true})
  cy.get('#createValidation__active > .p-checkbox-box').click({force:true})
  cy.get('button:contains('+action+')').click({force:true})
})

Then("I can select a {string} {string} with label field {string} and linked field {string} and master field {string} and ignore case {string} for dataflow {string}", (type, table, label, linked, master, ignore, dataflow) => {
  cy.wait(2000)
  if(type==="Link"){
  cy.get("[aria-label='"+table+"']").click()
  label && cy.get('.p-dialog-content .p-dropdown').eq(0).click() && cy.get(`.p-input-overlay-visible:contains(${label})`).click()
  linked && cy.get('.p-dialog-content .p-dropdown').eq(1).click() && cy.get(`.p-input-overlay-visible:contains(${linked})`).click()
  master && cy.get('.p-dialog-content .p-dropdown').eq(2).click() && cy.get(`.p-input-overlay-visible:contains(${master})`).click()
    if(ignore==="true") {
      cy.get('#ignoreCaseInLinks_check').click() 
    }
  } 
  else {
  cy.get('[class*=LinkSelector_referenceDataflowsDropdownWrapper]> .p-dropdown').click()
  cy.contains(dataflow).click()
  cy.get("[aria-label='"+table+"']").click()
}
  setDialog("Save")
  cy.wait(2000)
  })

Then("I can create a unique constraint with table {string} and field {string}", (table, field) => {
  cy.get('[aria-label="' + table + '"]').click()
  cy.get('.p-listbox-item:last').click()
  cy.get('button:contains(Create):visible:last').click({force:true})
})

Then("the unique constraint {string} is {string} on the list", (unique, property) => {
  cy.wait(2000)
  cy.get('.p-datatable-tbody:contains('+unique+')').should(property)
})

Then("I can change on {string} the type of field {string} on table {string} to {string}", (dataset, field, table, type) => {
  cy.get(`p:contains(${dataset}):first`).parent().click()
  cy.get(`.p-tabview-title:contains(${table})`).click()
  cy.get(`[class*=FieldDesigner_draggableFieldDiv]:contains(${field}) >>> .p-dropdown:contains(Link)`).click()
  cy.get('li:visible>div>span').contains(type).click({force:true})
})

Then("I can see the fields and configurations {string}", (readonly, data) => {
  data.rawTable.map(field => {
    cy.get(`.p-tabview-title:contains(${field[0]})`).click()
    readonly==='true' ? cy.get(`#${field[1]}`).should('be.disabled') : cy.get(`#${field[1]}`) 
    cy.get(`[class*=FieldDesigner_]:contains(${field[2]})`)
    cy.get(`[class*=FieldDesigner_draggableFieldDiv] >>> .p-dropdown:contains(${field[3]})`)
    if(field[4] === 'required') {
      cy.get(`[class*=FieldDesigner_draggableFieldDiv]:contains(${field[2]})  >>> [class*=FieldDesigner] > .p-checkbox-box:first`).should('have.attr','aria-checked', 'true')
    } else if(field[4] === 'Read only table') {
      cy.get('[class*=FieldsDesigner_switchDiv] > :nth-child(1) > > .p-checkbox-box').should('have.attr','aria-checked', 'true')
    } else if(field[4] === 'Prefilled') {
      cy.get('[class*=FieldsDesigner_switchDiv] > :nth-child(2) > > .p-checkbox-box').should('have.attr','aria-checked', 'true')
    } else if(field[4] === 'Fixed number of records') {
      cy.get('[class*=FieldsDesigner_switchDiv] > :nth-child(3) > > .p-checkbox-box').should('have.attr','aria-checked', 'true')
    }
  })
})

Then("the cell with {string} {string} is disabled", (field, text) => {
  field === 'name' && cy.get(`#${text}`).should('be.disabled')
  field === 'description' && cy.contains(text).should('be.disabled')
  field === 'type' && cy.get(`[class*=FieldDesigner_draggableFieldDiv] >>> .p-dropdown:contains(${text})>>input`).should('be.disabled')
})

Then("I delete dataset data {string} tables", (type) => {
  if(type === 'with prefilled') {
    cy.get('#arePrefilledTablesDeleted > .p-checkbox-box').click()
  } 
  cy.contains('Yes').click();
})

Then("the table {string} does not exists" ,(table) => {
  cy.contains(table).should('be.not.visible')
})
