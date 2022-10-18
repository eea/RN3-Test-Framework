const setDialog = option => {
    cy.contains(option)
      .click({ force: true });
  };
  
let bddGeneratedValues = new Map();

after(() => {
  bddGeneratedValues.clear();
})