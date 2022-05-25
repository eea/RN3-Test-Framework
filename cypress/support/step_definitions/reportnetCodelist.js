Then("I can {string} the category {string} with description {string}",(action, category,description) => {
    if(action === 'delete') {
      cy.get('.pi-trash:last').click({force:true})
      setDialog("Yes")
    } else {
      action === 'add' && cy.contains("New category").click();
      action === 'edit' && cy.get('.pi-pencil:last').click({force:true})
      cy.get('#shortCodeInput').clear().type(category)
      cy.get('#descriptionInput').clear().type(description)
      setDialog("Save")
    }
  });

Then("I can {string} the codelist with name {string}, version {string} and description {string}",(action,name,version,description) => {
    cy.wait(1000)
    cy.get('.pi-plus:last').click({force:true})
    cy.get('#nameInput').type(name)
    cy.get('#versionInput').type(version)
    cy.get('#descriptionInput').type(description)
    setDialog("Save")
  })
  
  Then("I can {string} items to codelist with category {string} and code name {string}",(action, category, code) => {
  
  cy.get('[class^=Category_categoryExpandable]>span').invoke('text').should('contain', category).get('svg').click()
  
  
  })