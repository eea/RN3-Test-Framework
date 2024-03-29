import { Given, When, Then, Before, After } from "@badeball/cypress-cucumber-preprocessor";


const setDialog = option => {
  cy.contains(option)
    .click({ force: true });
};

const monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];

const sortPositions = ["", "Name", "Description", "Legal Instrument", "Obligation", "Id obligation", "",
  "Status", "Delivery date range", "Creation date range"];

const getMonth = () => {
  const today = new Date();
  return today.getMonth() + ''
}

const getDay = () => {
  const today = new Date();
  return today.getDate() + ''
}

const lastDayOfMonth = () => {
  const today = new Date();
  const date = new Date(today.getFullYear(), today.getMonth(), 0);
  return today.getDate()
}
let bddGeneratedValues = new Map();
Before(() => {
  console.log("start execution");
});

After(() => {
  cy.get(".fa-power-off:first").click({ force: true });
  setDialog("Yes");
  console.log("end execution");
})

//Given(
//  "I'm logged at Reportnet page as user {string} and password {string}",
// (user, password) => {
//  cy.viewport("iphone-7")
//cy.visit(Cypress.env("default"));
//homePage.clickonLoginLink();
//cy.contains('Login').click()
//cy.get("input[type=text]").type(user);
//cy.get("input[type=password]").type(password);
//cy.get("#kc-login").click();
//cy.wait(2000)
//}
//);

Given(
  "I'm logged at Reportnet page as {string}",
  (user) => {
    cy.visit('/');
    //homePage.clickonLoginLink();
    cy.contains('Login').click()
    cy.get("input[type=text]").type(Cypress.env(user).username);
    cy.get("input[type=password]").type(Cypress.env(user).password);
    cy.get("#kc-login").click();
    cy.wait(2000)
  }
);


Given(
  "I'm logged at production Reportnet page as {string}",
  (user) => {
    cy.visit('/');
    //homePage.clickonLoginLink();
    cy.contains('Login').click()
    cy.get("input[type=text]").type(Cypress.env(user).username);
    cy.get("#whoamiContainerId button[name='whoamiSubmit']").click({force:true})
    cy.get("input[name=password]").type(Cypress.env(user).password);
    cy.get("#loginForm input[type='submit']").click({force:true})
    cy.wait(5000)
  }
);

Given("I'm in Reportnet page", () => {
  cy.visit('/');
  //cy.visit('https://rn3test.eionet.europa.eu/');  //=>TEST
})

When("I {string} see the publicly dataflow {string}", (visibility, name) => {
  cy.wait(500)
  if (visibility === 'can') {
    bddGeneratedValues.get(name)
    cy.contains(bddGeneratedValues.get(name))
  } else {
    cy.get(`[class*=PublicFrontpage_currentDataflows] > :nth-child(2) > div:contains(${dataflow})`).should('be', 'not.visible')
  }
})


When("I can see for dataflow {string} the instrument {string}, status {string}", (name, instrument, status) => {
  bddGeneratedValues.get(name)
  cy.get(`[class*=PublicDataflows_content] > div:contains(${bddGeneratedValues.get(name)})`)
  cy.get(`[class*=PublicDataflows_content] > div:contains(${instrument})`)
  cy.get(`[class*=PublicDataflows_content] > div:contains(${status})`)
})


When("The user logout", () => {
  cy.wait(500)
  cy.get(".fa-power-off:last").click({ force: true });
  cy.wait(500)
  setDialog("Yes")
})

When("I navigate to {string}", page => {
  cy.request(page);
});

When("I can see the dataflows page", () => {
  cy.contains("h2", "Dataflows");
});

When("I can click on {string}", element => {
  cy.wait(1500);
  cy.contains(element).click({ force: true })
  cy.wait(1500);
})

When("I can click on tab {string}", element => {
  cy.wait(2000);
  cy.contains(element).click({ force: true })
  cy.wait(1000);
})

When("The dataflow {string} doesn't exist", (dataflow) => {
  cy.contains(dataflow).should('be.not.exist')
})

Then("The reporting Dataflow {string} doesn't exist", (name) => {
  bddGeneratedValues.get(name)
  cy.contains(bddGeneratedValues.get(name)).should('be.not.exist')
});


When("I can click on element {string}", element => {
  cy.wait(1000);
  cy.get('p:contains(' + element + '):first').parent().click()
  cy.wait(1000)
});

When("I can click on the button with text {string}", (element) => {
  cy.wait(4000)
  cy.get('button').contains(element).click()
  cy.wait(1000)
});

When("I can check on the checkbox ignore case", element => {
  cy.wait(4000)
  cy.get('#ignoreCaseInLinks_check').click()
  cy.wait(1000)
});

When("I click on the tab {string}", element => {
  cy.wait(4000)
  cy.get('span:contains(' + element + ')').first().parent().click({ force: true })
  cy.wait(1000)
});

When("the {string} {string} is {string}", (type, button, property) => {
  cy.wait(2000)
  if (type === 'action') {
    cy.contains(button).and(property)
  } else if (type === 'fieldsDesigner') {
    property === 'checked' && cy.get(`[class*=FieldsDesigner_switchDiv] > :contains(${button}) .p-checkbox-box`).should('have.attr', 'aria-checked', 'true')
    property === 'disabled' && cy.get(`[class*=FieldsDesigner_switchDiv] > :contains(${button}) .p-checkbox-box`).should('have.class', 'p-disabled')
  } else if (type === 'left menu') {
    cy.get(`[class*=dataflowList-left-side]:contains(${button})>a`).should(property)
  } else {
    cy.get('button:contains(' + button + '):visible').should(property)
  }

  if (type !== 'left menu') {
    property === "be.enabled" && cy.contains(button).click({ force: true });
    property === "be.visible" && cy.contains(button).click({ force: true });
  } else {
    property === "be.visible" && cy.get(`[class*=dataflowList-left-side]:contains(${button})>a`).click({ force: true });
  }
  if (button === "Validate" && property === 'be.enabled') {
    setDialog("Yes")
  }
  cy.wait(1000)
});

When('the {string} is {string}', (visibility_status)=>{
  if (visibility_status=="visible")
  {
    cy.get('[data-for="validationsStatus"]').should('be.visible')
  }
  else if(visibility_status=="not visible")
  {
    cy.get('[data-for="validationsStatus"]').should('not.be.visible')
  }
})

When("the button {string} is {string}", (button, property) => {
  let loc = property === 'visible' ? '[class*=BigButton_schemaDataset]' : '[class*=BigButton_bigButtonDisabled]'
  cy.get(`[class*=BigButtonList_datasetItem]> :contains(${button})> ${loc} `)
})

When("publicly available check is {string}", prop => {
  cy.get(`[class*=DatasetDesigner_datasetConfigurationButtons]> :contains(Available)> > .p-checkbox-box`).should('not.be.disabled')

})

When("I can toggle publicly available check", () => {
  cy.get(`[class*=DatasetDesigner_datasetConfigurationButtons]> :contains(Available)> > .p-checkbox-box`).click()
  cy.wait(2000);

})


When("I import a {string} file {string}", (filetype, file) => {
  const fileName = file;
  const fileType = filetype;
    cy.fixture(fileName, { encoding: null }).as('myFixture')
    cy.get('input[type="file"]').selectFile('@myFixture', 
      {
      mimeType: 'application/' + fileType + '',
      force: true
    }
      )
  cy.wait(2000)
  cy.contains("Upload").click()
  cy.wait(2000)
});

When("I import a dataset schema {string} file {string}", (filetype, file) => {
  const fileName = file;
  const fileType = filetype;
    cy.fixture(fileName, { encoding: null }).as('myFixture')
    cy.get('input[type="file"]').selectFile('@myFixture', 
      {
      mimeType: 'application/' + fileType + '',
      force: true
    }
      )
  cy.wait(2000)
  cy.contains("Upload").click()
  cy.get('.p-dialog-title').contains('Confirm new dataset schema creation')
  cy.get('.p-button-text:contains(Yes)').click({force:true})
});

  //And("I import a {string} file {string}", (filetype, file) => {
    //const fileName = file;
    //const fileType = filetype;
    //cy.fixture(fileName).then(fileContent => {
      //cy.get('input[type="file"]').attachFile(fileName, 
        //{
       // mimeType: 'application/' + fileType + ''
       // })
    //});
    //cy.wait(2000)
    //cy.contains("Upload").click()
    //cy.wait(2000)
  //});
  

When("I import a file {string}", file => {
  const fileName = file;
  //cy.fixture(fileName).then(contents => {
    cy.fixture(fileName, { encoding: null }).as('myFixture')
    cy.get('input[type="file"]').selectFile('@myFixture',{
      fileName,
      mimeType: "text/plain",
      force: true
    })
  cy.wait(2000)
  cy.contains("Upload").click({force: true })
  cy.wait(2000)
});

When("I delete the table data", () => {
  cy.contains("button", "Delete dataset data").click({ force: true });
  setDialog("Yes")
});

When("I see the message: {string}", message => {
  cy.wait(1500)
  //cy.contains(message,{timeout:15000})
  cy.wait(1000)
});

When("I can see the message: {string}", message => {
  cy.wait(500)
  cy.contains(message)
  cy.wait(1000)
});

When("I see the message for pinned dataflow {string}", (name) => {
  bddGeneratedValues.get(name)
  cy.wait(1500)
  cy.contains(message)
  cy.contains("You have pinned the dataflow" , bddGeneratedValues.get(name))
});

When("I click on the notification {string} link", message => {
  cy.contains(message)
    .find("a[href]")
    .click()
});

Then("the dataset table {string} has {} record(s)", (table, records) => {
  // cy.wait(2000)
  // cy.get('.p-button-text:contains(Refresh):visible').click({force:true})
  cy.wait(2000)
  cy.get('span:contains(' + table + ')').click({ force: true })
  cy.wait(1000)
  cy.get(".p-datatable-scrollable-body-table >tbody>tr").should("have.length", records);
  //cy.get('.p-datatable-scrollable-body-table').should("have.length", records);
  cy.wait(2000)
});

Then("the table {string} has {} record(s)", (table, records) => {
  cy.get('span:contains(' + table + ')').first().parent().click()
  cy.get("tbody>tr").should("have.length", records);
  if (table.startsWith("Historic")) {
    cy.contains("Close").click()
  }
});

Then("I can click on the link to be redirected to another page", () => {
  cy.get('a > .svg-inline--fa > path').click()
});

 Then("the public table {string} has {} record(s)", (table, records) => {
   cy.get('[class*=PublicDataflowInformation_container] > :contains(' + table + ')>>>>tbody>tr').should("have.length", records);
 });

Then("the table Documents has {} record(s)", (records) => {
  cy.get('.PublicDataflowInformation_dataTableWrapper__XQCgZ:last tbody tr').should("have.length", records);
});

Then(
  "I {string} update the cell with the text {string} to the text {string} in a {string}",
  (prop, cell, text, type) => {
    if (prop === 'can') {
      cy.get(`.p-datatable-scrollable-body-table > > > :nth-child(4) > div:contains(${cell}):first`).click();
      cy.focused().clear().type(text + "{enter}");
    } else {
      if (type === "dataset") {
        cy.get('[class*=ActionsColumn_actionTemplate] > > .p-button-text:visible:first').click({ force: true })
        cy.get('input:visible').should('be.disabled')
      } else {
        cy.get(`.p-datatable-tbody >>> :contains(${cell}):visible`).dblclick()
        cy.get(`input[value=${cell}]:visible`).should('not.exist')
      }
    }
  }
);

When("I delete the dataset table row {int}", row => {
  cy.wait(2000)
  cy.get(".p-datatable-scrollable-body-table >tbody>tr")
    .eq(row - 1)
    .find(".pi-trash")
    .click({ force: true });
  cy.wait(1000)
  setDialog("Yes");
  cy.wait(2000)
});

When("I {string} the row {int}", (action, row) => {
  const type = action === 'delete' ? '.pi-trash' : '.pi-pencil'
  cy.get("tbody>tr:last")
    .eq(row - 1)
    .find(type)
    .click({ force: true });
  action === 'delete' && setDialog("Yes");
  cy.wait(1000)
});

When("I reload the page", () => {
  cy.wait(1000)
  cy.reload();
});

When("I wait for notification", () => {
  cy.wait(10000);
})

When("I am in {string} dataset", location => {
  cy.contains("h1", location);
});

When("I paste the data from file {string}", function (file) {
  cy.fixture(file).as("contents");
  cy.get('[class*=InfoTable_infoTablePaste]').then(
    //cy.get("#pr_id_1_content_0 > div > div:nth-child(4) > div").then(
    $destination => {
      const pasteEvent = Object.assign(
        new Event("paste", { bubbles: true, cancelable: true }),
        {
          clipboardData: {
            getData: (type) => this.contents
          }
        }
      );
      $destination[0].dispatchEvent(pasteEvent);
    }
  );
  setDialog("Save");
  cy.wait(1000)
  //cy.reload();
});

Then("I can {string} a dataflow with name {string} and description {string} and obligation {string} with {string}", (action, name, description, obligation, filtered, filters) => {
  const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
  bddGeneratedValues.set(name, typeValue);
  console.log(bddGeneratedValues);
  cy.get("#dataflowName").clear().type(typeValue);
  cy.get("#dataflowDescription").clear().type(description);
  cy.get('[class*=ManageDataflowForm_search] > .p-button').click({ force: true })
  if (filtered === "filters") {
    filters.rawTable.map((data) => {
      data[0] !== "" && cy.get('[id=countries]:first').click({ force: true })
        &&
        cy.get('input[placeholder="Country"]').focus().type(data[0]) &&
        cy.wait(3000) &&
        cy.get('.p-dropdown-item:contains(' + data[0] + ')').click({ force: true })
      data[1] !== "" && cy.get('[id=issues]:first').click({ force: true })
        && cy.contains(data[1]).click({ force: true })
      data[2] !== "" && cy.get('[id=organizations]:first').click({ force: true })
        && cy.contains(data[2]).click({ force: true })
      //date
      data[4] !== "" && cy.get('[id=searchInput]:first').focus().type(data[4], { force: true })
      cy.get('[class*=Filters_reportingObligations] > [class*=Filters_buttonWrapper] > [class*=Filters_filterButton] > .p-button > .p-button-text').click()
      cy.wait(3000)
      cy.get('[class*=checkbox] > .p-checkbox-box').first().click({ force: true })
      cy.wait(2000)
    })
  }
  cy.get('.p-datatable-row:contains(' + obligation + ') .p-checkbox').click({ force: true })
  cy.get('button:contains(OK):visible').click({ force: true })
  cy.get('.p-button-text:contains(' + action + ')').click({ force: true })
  cy.wait(5000);
});

Then("I can {string} a dataflow with name {string}", (action, name) => {
  const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
  bddGeneratedValues.set(name, typeValue);
  console.log(bddGeneratedValues);
  cy.get("#dataflowName").clear().type(typeValue);
  cy.get('.p-button-text:contains(' + action + ')').click({ force: true })
  cy.wait(5000);
});




Then("I can {string} a business dataflow with name {string} and description {string} and obligation {string} and company {string} with fmeUser {string}", (action, name, description, obligation, company, fmeUser) => {
  cy.get("#dataflowName").clear().type(name);
  cy.get("#dataflowDescription").clear().type(description);
  cy.get('[class*=ManageBusinessDataflow_search] > .p-button').click({ force: true })
  cy.get('.p-datatable-row:contains(' + obligation + ') .p-checkbox').click({ force: true })
  cy.get('button:contains(OK):visible').click({ force: true })
  cy.get('[class*=ManageBusinessDataflow_groupOfCompaniesWrapper] > .p-dropdown-label').click({ force: true })
  cy.contains(company).click({ force: true })
  cy.get('[class*=ManageBusinessDataflow_fmeUsersWrapper] > .p-dropdown-label').click({ force: true })
  cy.contains(fmeUser).click({ force: true })
  cy.get('.p-button-text:contains(' + action + ')').click({ force: true })
  cy.wait(5000);
});

When("I can {string} a reference dataflow with name {string} and description {string}", (action, name, description) => {
  cy.get("input[placeholder='Dataflow name']").clear().type(name);
  cy.get("textarea[placeholder='Dataflow description']").clear().type(description);
  cy.get('.p-button-text:contains(' + action + ')').click({ force: true })
  cy.wait(5000);
});

Then("I can delete the dataflow {string}", (name) => {
  cy.wait(3000)
  bddGeneratedValues.get(name)
  cy.contains("Delete this dataflow").click({ force: true });
  cy.get("input:visible").type(bddGeneratedValues.get(name), { force: true });
  cy.wait(1000)
  cy.get('.p-button-danger:visible').click()
})


Then("I can click on the option {string}", (name) => {
  cy.contains(name).click()
})

Then("I can see the {string} on {string}", (data, dataflow) => {
  cy.wait(2000)
  cy.get('[class*=containerLink]:contains(' + dataflow + ')').contains(data)
})

Then("the dataflow list has {int} items", (total) => {
  cy.get("[class*=containerLink]").should("have.length", total);
})

Then("I can clear dataflow filters", () => {
  cy.get('[class*=Filters_resetButton]').children().click({ force: true })
})

Then("I can filter by {string} with {string}", (field,filter) => {
  //bddGeneratedValues.get(name)
  if (field === 'name' || field === 'description' || field === "legalInstrument" || field === "obligationTitle" || field === "dataflowName") {
    cy.get(`[id='${field}_input']`).type(filter)
  } else if (field === 'expirationDate') {
    cy.get(`[id='${field}_input']`).click({ force: true })
    cy.get('.p-datepicker-month').select(getMonth(), { force: true })
    cy.get('td>span:visible').contains(new RegExp("^" + getDay() + "$")).should('not.have.class', 'p-datepicker-other-month').click()
    cy.get('td>span:visible').contains(new RegExp("^" + lastDayOfMonth() + "$")).click()
    //cy.get('td>span:visible:contains('+new RegExp('^' + 5 + '$')+')')//contains('+getDay()+'):last').click()
    //cy.get('td>span:visible:contains('+lastDayOfMonth()+'):last').click()
  } else if (field === "searchInput") {
    cy.get(`input[id=${field}]`).type(filter)
  }
  else if (field === 'Status') {
    cy.get('#status_dropdown').click().children().contains(filter).click()
    cy.wait(3000)
  }
  else if (field === 'Role') {
    cy.get('#userRole_dropdown').click().children().contains(filter).click()
    cy.wait(3000)
  }
  else {
    cy.get(`div[id=${field}]`).click({ force: true })
    cy.contains(new RegExp("^" + filter + "$", "g")).click({ force: true })
  }
  cy.wait(1000)
  cy.get('[class*=Filters_filterButton]').children().click({ force: true })
  cy.wait(2000)
})


Then("I can filter obligation dataflow by {string} with {string}", (field,name) => {
  bddGeneratedValues.get(name)
  if (field === 'name' || field === 'description' || field === "legalInstrument" || field === "obligationTitle" || field === "dataflowName") {
    cy.get(`[id='${field}_input']`).type(bddGeneratedValues.get(name))
  } else if (field === 'expirationDate') {
    cy.get(`[id='${field}_input']`).click({ force: true })
    cy.get('.p-datepicker-month').select(getMonth(), { force: true })
    cy.get('td>span:visible').contains(new RegExp("^" + getDay() + "$")).should('not.have.class', 'p-datepicker-other-month').click()
    cy.get('td>span:visible').contains(new RegExp("^" + lastDayOfMonth() + "$")).click()
    //cy.get('td>span:visible:contains('+new RegExp('^' + 5 + '$')+')')//contains('+getDay()+'):last').click()
    //cy.get('td>span:visible:contains('+lastDayOfMonth()+'):last').click()
  } else if (field === "searchInput") {
    cy.get(`input[id=${field}]`).type(filter)
  }
  else if (field === 'Status') {
    cy.get('#status_dropdown').click().children().contains(filter).click()
    cy.wait(3000)
  }
  else if (field === 'Role') {
    cy.get('#userRole_dropdown').click().children().contains(filter).click()
    cy.wait(3000)
  }
  else {
    cy.get(`div[id=${field}]`).click({ force: true })
    cy.contains(new RegExp("^" + filter + "$", "g")).click({ force: true })
  }
  cy.wait(1000)
  cy.get('[class*=Filters_filterButton]').children().click({ force: true })
  cy.wait(2000)
})





Then("I can filter QCs by {string} with {string}", (field, filter) => {
  if (field === "searchInput") {
    cy.get(`input[id=${field}]`).type(filter)
  }
  else {
    cy.get(`div[id=${field}]`).click({ force: true })
    cy.contains(new RegExp("^" + filter + "$", "g")).click({ force: true })
  }
  cy.wait(3000)
})

When("I sort the dataflow list by {string}", (field) => {
  cy.wait(2000)
  cy.get('[class*=Filters_dataflowsFilters]').get(':nth-child(' + sortPositions.indexOf(field) + ') > .p-button > .pi').first().click({ force: true })
})

When("I filter the dataflow list by {string} with {string}", (field, name) => {
  bddGeneratedValues.get(name)
  cy.wait(2000)
  if (field === 'name') {
    cy.get(`[id='${field}_input']`).type(bddGeneratedValues.get(name))
    cy.get('.p-button-text.p-c').contains('Filter').click({force:true})}
  })

When("The first dataflow is {string} and the last dataflow is {string}", (first, last) => {
  cy.get('[class*=containerLink]:first:contains(' + first + ')')
  cy.get('[class*=containerLink]:last:contains(' + last + ')')
})

When("the first dataset is {string} and last is {string}", (first, last) => {
  cy.get(`[class*=BigButtonList_datasetItem]> :nth-child(3):contains(${first})`)
  cy.get(`[class*=BigButtonList_datasetItem]> :nth-child(6):contains(${last})`)
})

//And("I can {string} the dataflow {string}", (pin, dataflow) => {
  
  //cy.get('[class*=containerLink]:first:contains(' + dataflow + ')').trigger('mouseover')
  //cy.get('[class*=DataflowsItem_pinContainer]:first').click()
//})

When("I can pin the dataflow {string}", (name) => {
  bddGeneratedValues.get(name)
  //cy.get('[class*=containerLink]').contains(bddGeneratedValues.get(name))
  cy.get(`[class*=containerLink]:contains(${bddGeneratedValues.get(name)}) ~ div`).click()
  //cy.get('[class*=containerLink]:first:contains(' + dataflow + ')').trigger('mouseover')
  //cy.get('[class*=DataflowsItem_pinContainer]:first').click()
})

When ("I can {string} the dataflow {string}",(pin, dataflow) => {
  cy.get('[class*=containerLink]:first:contains('+dataflow+')').trigger('mouseover')
  cy.get('[class*=DataflowsItem_pinContainer]:first').click()
})


When("I can pin the generated dataflow {string}", (name) => {
  bddGeneratedValues.get(name)
  //cy.get('[class*=containerLink]').contains(bddGeneratedValues.get(name))
  cy.get(`[class*=containerLink]:contains(${bddGeneratedValues.get(name)}) ~ div`).click()
  //cy.get('[class*=containerLink]:first:contains(' + dataflow + ')').trigger('mouseover')
  //cy.get('[class*=DataflowsItem_pinContainer]:first').click()
})

When("I change to {string} mode", (mode) => {
  cy.wait(3000)
  cy.get(`[class*=TabularSwitch_tabBar] > :contains(${mode})`).click({ force: true })
  cy.get(1000)
})

When("I can add a record", (fields) => {
  cy.wait(1000)
  cy.contains("Add record").click()
  cy.wait(1500)
  fields.rawTable.map((data) => {
    if (data[1] === 'link') {
      cy.get('[class*=p-dialog-content]>>>input:visible:first').type(data[0])
      cy.wait(500)
      cy.get('label:contains(-- None --)').click({ force: true })
      cy.get('li:contains(' + data[2] + '):visible:last').click({ force: true })
    } else if (data[1] === 'point') {
      cy.get('[class*=p-dialog-content]>>>:nth-child(1) > :nth-child(1) > .p-inputtext:first').type(data[0].toString(), { force: true })
    } else {
      cy.get('[class*=p-dialog-content]>>>input[value=""]:visible:first').type(data[0].toString(), { force: true })
      cy.wait(500)
      for (let i = 1; i <= data.length - 1; i++) {
        data[i] && cy.get('[class*=p-dialog-content]>>>input[value=""]:visible:first').type(data[i].toString(), { force: true })
      }
    }
    setDialog("Save")
    cy.wait(2000)
  })
})


When("I can add coordinates to the geometry", (fields) => {
  cy.wait(2000)
  cy.contains("Add record").click()
  fields.rawTable.map((data) => {
    cy.get('#coordinates_lat').type(data[0].toString(), { force: true })
    cy.get('#coordinates_long').type(data[1].toString(), { force: true })
    setDialog("Save")
    cy.wait(2000)
  })
})

When("I can see the field {} has {} error", (field, errors) => {
  cy.get('.p-datatable-tbody .pi-exclamation-triangle').should('have.length', errors)
})

When("I can see the information from ROD3 with obligation {string} and instrument {string}", (obligation, instrument) => {
  cy.contains(obligation)
  cy.contains(instrument)
})

When("I can create data collections with a technical acceptance step for the reporter submissions and {string}", (show) => {
  const today = new Date();
  cy.get('.p-datepicker-month').select(monthNames[today.getMonth()])
  cy.get('.p-datepicker-year').select(today.getFullYear() + '')
  cy.get('span:contains(' + (lastDayOfMonth()) + '):last').click()
  show === 'no public' && cy.get('#show_public_info_checkbox').click()
  cy.get('.p-button-text:contains(Create)').click({ force: true })
  cy.get('[class*=BigButtonList_radioButtonDiv]:contains(Yes) :nth-child(2) > .p-radiobutton').click()
  cy.get('.p-button-text:contains(Yes)').click()
  cy.wait(1000)
})

When("I click on table {string}", (table) => {
  cy.get('span:contains(' + table + ')').first().parent().click()
})

When("I mark the table as a {string}", (type) => {
  let loc = ''
  if (type === 'prefilled') {
    loc = ':nth-child(2) > > .p-checkbox-box'
  } else if (type === 'read only') {
    loc = ':nth-child(1) > > .p-checkbox-box'
  } else if (type === 'not mandatory table') {
    loc = ':nth-child(4) > > .p-checkbox-box'
  } else {
    loc = ':nth-child(3) > > .p-checkbox-box'
  }
  cy.get('[class*=FieldsDesigner_switchDiv] >' + loc).click({ force: true })
  cy.wait(2000)
})

When("new API-key is created", () => {
  cy.get('[class*=ApiKeyDialog_textarea]').should('not.be.empty')
})

When("I can confirm release to data collection with {string}", (restrict) => {
  if (restrict === 'restrict to public') {
    cy.get('.p-checkbox-box').click({ force: true })
  }
  cy.get('.p-button-text:contains(Yes)').click()
})

When("validate the dataflow {string}", (name) => {
  cy.wait(1000)
  cy.reload();
  cy.get("[class*=containerLink]").its('length').then((size) => {
    if (size === 2) {
      cy.contains(name).first().click({ force: true })
      cy.contains("Edit").click({ force: true });
      cy.contains("Delete this dataflow").click({ force: true });
      cy.get("input:visible").type(name, { force: true });
      cy.wait(1000)
      cy.get('.p-button-danger:visible').click()
    }
  })
})

When("The integration {string} is {string} on the list of external integrations", (name, property) => {
  cy.wait(2000)
  cy.get('[class*=p-datatable-row]:contains(' + name + ')').should(property)
})

When("I check replace data", () => {
  cy.get('[id=replaceCheckbox]:visible').click({ force: true })
})


When("I can {string} the new external integration {string}", (action, type, fields) => {

  if (action === "Create") {
    const dataFields = fields.rawTable[0];
    cy.get('[id*=integration__name]').clear().type(dataFields[0])
    cy.get('[id*=integration__description]').clear().type(dataFields[1])
    cy.get('[class*=ManageIntegrations_repository] > .p-dropdown').click({ force: true })
    cy.get('.p-dropdown-item:visible').contains(dataFields[2]).click({ force: true })
    cy.wait(3000)
    cy.get('[class*=ManageIntegrations_processName] > .p-dropdown').click({ force: true })
    cy.get('.p-dropdown-item:visible').contains(dataFields[3]).click({ force: true })
    cy.wait(1000)
    cy.get(':nth-child(3) > [class*=ManageIntegrations_field] > .p-dropdown').click({ force: true })
    cy.get('.p-dropdown-item:visible').contains(dataFields[4]).click({ force: true })
    cy.get('#integration__fileExtension').clear().type(dataFields[5])
    if (type === "import") {
      cy.get('[class*=ManageIntegrations_checkboxWrapper] > .p-checkbox > .p-checkbox-box').click()
    }
    else {
      cy.get('[id*=integration__parameterKey]').clear().type(dataFields[6])
      cy.get('[id*=integration__parameterValue]').clear().type(dataFields[7])
    }
    cy.get('[class*=ManageIntegrations_buttonWrapper]:contains(Add)').click({ force: true })
    if (type === "duplicated") {
      cy.get('button:contains(' + action + '):last').should('be.disabled')
    } else {
      cy.get('button:contains(' + action + '):last').click({ force: true })
    }
  } else {
    cy.get(`tr:contains(${type})>> [class*=ActionsColumn_actionTemplate] > .p-button > .pi`).click()
    const parameters = fields.rawTable[0];
    cy.get(`[class*=ManageIntegrations_list] > :contains(${parameters[0]}) >:contains(${parameters[1]})`)
  }

})



When("I can import previous data {string}", name => {
  cy.get('.p-menuitem-text:contains(' + name + ')').click({ force: true })
  cy.wait(2000)
  cy.get('.p-dialog-footer >> .p-button-text:contains(Import)').click({ force: true })
  cy.wait(3000)
})


When("I can export dataset data {string}", name => {
  cy.get('[data-for="' + name + '"] > .p-menuitem-link').click({ force: true })
})


When("I click in a button {string} inside {string} context menu", (button, name) => {
  cy.get('[class*=BigButtonList_datasetItem] > :contains(' + name + ') >>> [class*=DropdownButton_dropdown]').click({ force: true })
  cy.get('[class*=DropDownMenu_listItemEnabled]:contains(' + button + '):visible').click({ force: true })
  cy.wait(2000)
})

Then(
  "I can update the point cell {string} to EPSG {string} and see the new format {string}",
  (cell, type, newFormat) => {
    cy.contains("div", cell).click();
    cy.get(':nth-child(2) > .p-dropdown > .p-dropdown-label').click({ force: true })
    cy.contains(type).click({ force: true })
    cy.wait(500)
    cy.get('#pageContent').click()
    cy.contains("div", newFormat)
  }
);

When("I see the datasets with manual technical acceptance for dataflow {string}", (dataflow) => {
  cy.contains(`Datasets with manual technical acceptance for dataflow ${dataflow}`);
})

When("I can change the dataset {string} to status {string} and message {string}", (dataset, status, message) => {
  cy.get(`.p-datatable-tbody>tr:contains(${dataset}) .p-button-text:first`).click({ force: true })
  cy.wait(1000)
  cy.get(`[class*=ManageManualAcceptanceDataset_label]:contains(${status})`).click({ force: true })
  cy.get('textarea[placeholder="Please provide information on the status change"]').type(message, { force: true })
  cy.get('.p-button-text:visible:contains(Update)').click({ force: true })
})

When("I can see the dataset {string} with status {string}", (dataset, status) => {
  cy.get(`.p-datatable-tbody>tr:contains(${dataset}):contains(${status})`)
  setDialog("Close")
})

When("I can see the list of external {string} with the name {string}", (type, name) => {
  cy.get(`li:contains(${name})`)
})

When("I can click on the list element with the name {string}", (name) => {
  cy.get(`li:contains(${name})`).click()
  cy.wait(2000);
})

When("The first record is {string} and the last record is {string}", (first, last) => {
  cy.get('.p-datatable-row:first:contains(' + first + ')')
  cy.get('.p-datatable-row:last:contains(' + last + ')')
})

When("I click the check to {string} the reporting", (status) => {
  cy.get('.p-checkbox-box').click()
  setDialog("Save")
  cy.wait(1000)
})

When("I can see the information on {string} with {string} {string} {string}", (name, country, type, acceptance) => {
  bddGeneratedValues.get(name)
  cy.contains(bddGeneratedValues.get(name)).click()
  cy.contains(country)
  type === 'released' && cy.get(`tr:contains(${country})>>>>svg[data-icon=check]`)
  type === 'not released' && cy.get(`tr:contains(${country})> :nth-child(2):contains(-)`)
  type === 'technical acceptance' && cy.get(`tr:contains(${country})> :nth-child(3):contains(${acceptance})`)
  type === 'reference data' && cy.get(`[class*=PublicDataflowInformation_container] > :contains(Reference datasets)>>>>tbody>tr>>>svg[data-icon=file-archive]`)
})


When("I can see the list of dataflows for {string}", (fields,name) => {
  bddGeneratedValues.get(name)
  const data = fields.rawTable[0]
  cy.get('.p-column-title:contains(' + bddGeneratedValues.get(name) + ')').click({ force: true })
  cy.get(`tr:contains(${data[0]}):contains(${data[1]}):contains(${data[2]}):contains(${data[3]})`)
  data[4] === 'delivered' && cy.get(`tr:contains(${data[0]})>>>svg[data-icon=check]`)
})


When("I can add unique constraint on {string} with {string}", (table, field) => {
  cy.get('.p-dialog-footer .p-button-text:contains(Add unique constraint)').click({force:true});
  cy.get(`[aria-label=${table}]`).click({force:true});
  cy.get(`[aria-label=${field}]`).click({force:true});
  cy.get('.p-dialog-footer .p-button-text:contains(Create)').click();
})

When("the table Unique constraints has {} records", (records) => {
  cy.get("tbody>tr").should("have.length", records);
})

When("I set the design dataset as {string}", (type) => {
  cy.get(`[class*=DatasetDesigner_datasetConfigurationButtons]> :contains(${type}) > .p-checkbox`).click()
  cy.wait(500)
})

When("I can create reference datasets", () => {
  cy.wait(1000);
  cy.get("span[data-for='Create Reference datasets']").click({ force: true })
  //cy.get('p:contains(Create Reference datasets):first').parent().click()
  cy.wait(1000)
  cy.contains('Yes').click({force:true});
})

When("I can see a warning for the tables without PK", () => {
  cy.wait(1000);
  cy.get('.p-dialog-titlebar:contains(There are tables with no primary keys (PK))');
  cy.get('.p-button-text:contains(Yes)').click();
})

When("I filter by value {string}", (value) => {
  cy.get("[id^=value_filter_input]").type(value)
  cy.get(".p-float-label > > .pi-search").click()

})

Then("I {string} a dataflow with name {string}", (action, name) => {
  bddGeneratedValues.get(name)
  if (action === "can edit") {
    cy.contains('Edit').click({ force: true })
    cy.get("#dataflowName").clear().type(bddGeneratedValues.get(name))
    cy.get('.p-button-text:contains(Save)').click({ force: true })
    cy.wait(3000)
  }
  else if (action === "cannot edit") {
    cy.get('Edit').should('not.exist')
    cy.wait(2000)
  }
});

When("I {string} the reference dataset", (action) => {
  cy.get('#referenceDatasetUpdatableCheckbox > .p-checkbox-box').click()
  cy.contains('Save').click()
  cy.wait(1000)

})

When("I can change the Restrict from public view inside {string} context menu to {string}", (dataset, type) => {
  const currentClass = type === "true" ? 'fa-eye' : 'fa-eye-slash'
  cy.get('[class*=BigButtonList_datasetItem] > :contains(' + dataset + ') >> [class*=' + currentClass + ']').click({ force: true })
  cy.wait(500)
  cy.get('.p-checkbox-box').click();
  cy.contains('Save').click();
})

When("I {string} change to public in the visibility modal", (action) => {
  if (action === 'can not') {
    cy.get('[class*=Dataflow_restrictFromPublicNote]:contains(Released data has already been publicly available)')
    cy.contains("Cancel").click()
  } else {
    cy.get('.p-checkbox-box').click({ force: true })
    cy.contains('Save').click({ force: true })
  }
})

When("I can see the list of webforms", (fields) => {
  const data = fields.rawTable[0]
  cy.get(`tr:contains(${data[0]}):contains(${data[1]})`)
})



When("I can add a new webform {string} and {string}", (name, type) => {
  const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
  bddGeneratedValues.set(name, typeValue);
  cy.contains("Add").click({ force: true })
  cy.get("#name").clear().type(typeValue);
  cy.get("#type").click({ force: true });
  cy.get('.p-dropdown-items').contains(type).click({ force: true })
  //cy.contains('Create').click()
  //cy.contains('Yes').click()
  
})


When("I can see the step {string} is finished", (step) => {
  if (step === "Validate data") {
    cy.get("[class*=Step_stepActive]>[class*=Step_stepLabel]:contains('Validating data')")
    cy.get("[class*=Step_stepLabel]:contains('Validated data')")
  } else if (step === "Import data") {
    cy.get("[class*=Step_stepLabel]:contains('Imported data')")
  }
});

When("I click on close button", () => {
  cy.get('.p-button-text.p-c').contains("Close").click({ force: true })
})

When("I logout", () => {
  cy.get(".fa-power-off:first").click({ force: true });
  setDialog("Yes")
})

Then("representative should contain Countries", () => {
  cy.get('.ManageLeadReporters_dataProvidersDropdown__1CF6Z label span').contains("Countries")
})

When("representing field should include all {string}", file => {
  const fileName = file;
  cy.fixture(fileName).then(contents => {
    const testcountries = contents
    cy.get('.ManageLeadReporters_selectDataProvider__1roIt option').not(':first').each(($ele, i) => {
      expect($ele).to.have.text(testcountries.dropdownValues[i])
    })
  });
});

Then("I create a business dataflow with name {string} and description {string} and obligation {string} and company {string} with fmeUser {string}", (name, description, obligation, company, fmeUser) => {
  const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
  bddGeneratedValues.set(name, typeValue);
  console.log(bddGeneratedValues);
  cy.get("#dataflowName").clear().type(typeValue);
  cy.get("#dataflowDescription").clear().type(description);
  cy.get('[class*=ManageBusinessDataflow_search] > .p-button').click({ force: true })
  cy.get('.p-datatable-row:contains(' + obligation + ') .p-checkbox').click({ force: true })
  cy.get('button:contains(OK):visible').click({ force: true })
  cy.get('[class*=ManageBusinessDataflow_groupOfCompaniesWrapper] > .p-dropdown-label').click({ force: true })
  cy.contains(company).click({ force: true })
  cy.get('[class*=ManageBusinessDataflow_fmeUsersWrapper] > .p-dropdown-label').click({ force: true })
  cy.contains(fmeUser).click({ force: true })
  cy.get(".p-button-text:contains('Create')").click({ force: true })
  cy.wait(5000);
});

When("I click on {string}", (name) => {
  cy.wait(1000);
  bddGeneratedValues.get(name)
  cy.contains(bddGeneratedValues.get(name)).click({ force: true })
  cy.wait(1000);
});

When("I click on data collection {string}", (name) => {
  cy.wait(1000);
  bddGeneratedValues.get(name)
  cy.get('[class^=DataflowsItem-]').contains(bddGeneratedValues.get(name)).click({ force: true })
  cy.wait(1000);
});

When ("I can click on dataflow {string}", (name)=>{
  cy.wait(1000);
  cy.contains(name).click({ force: true })
  cy.wait(1000)

});

Then("I {string} a reporting dataflow with name {string} and description {string} and obligation {string} with {string}", (action, name, description, obligation, filtered, filters) => {
  const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
  bddGeneratedValues.set(name, typeValue);
  console.log(bddGeneratedValues);
  cy.get("#dataflowName").clear().type(typeValue);
  cy.get("#dataflowDescription").clear().type(description);
  cy.get('[class*=ManageDataflowForm_search] > .p-button').click({ force: true })
  cy.get('.p-datatable-row:contains(' + obligation + ') .p-checkbox').click({ force: true })
  cy.get('button:contains(OK):visible').click({ force: true })
  cy.get('.p-button-text:contains(' + action + ')').click({ force: true })
  cy.wait(5000)
})

When("I can see the updated list of webforms {string}", (name) => {
  let dataflow = bddGeneratedValues.get(name)
  findInPage(dataflow)
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
 })

Then("I {string} a citizen dataflow with name {string} and description {string} and obligation {string} with {string}", (action, name, description, obligation, filtered, filters) => {
  const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
  bddGeneratedValues.set(name, typeValue);
  console.log(bddGeneratedValues);
  cy.get("#dataflowName").clear().type(typeValue);
  cy.get("#dataflowDescription").clear().type(description);
  cy.get('[class*=ManageDataflowForm_search] > .p-button').click({ force: true })
  cy.get('.p-datatable-row:contains(' + obligation + ') .p-checkbox').click({ force: true })
  cy.get('button:contains(OK):visible').click({ force: true })
  cy.get('.p-button-text:contains(' + action + ')').click({ force: true })
  cy.wait(5000)
})



Then("I {string} a reference dataflow with name {string} and description {string}", (action, name, description) => {
  const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
  bddGeneratedValues.set(name, typeValue);
  console.log(bddGeneratedValues);
  cy.get("#dataflowName").clear().type(typeValue);
  cy.get("#dataflowDescription").clear().type(description);
  cy.get('.p-button-text:contains(' + action + ')').click({ force: true })
  cy.wait(5000)
})

Then("I click on the import dataset data button", () => {
  cy.get('.p-button-text.p-c').contains('Import dataset data').click()
  cy.get('.p-toolbar-group-left .p-menuitem-link').contains('ZIP (.csv for each table)').click({ force: true })
})

When("Import is locked is visible", () => {
  cy.get('.p-toolbar-group-left button:first-child .p-button-text').contains('Import in progress').should('be.visible')
  cy.wait(1000)
  //cy.get('.p-button-text.p-c').contains("Import is locked").should('be.visible')
})
