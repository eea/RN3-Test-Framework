const { After, And } = require("cypress-cucumber-preprocessor/steps");

const setDialog = option => {
   cy.contains(option)
    .click({force:true});
};

const getMonth = () => {
  const today = new Date();
  return today.getMonth()+''
}

const getDay = () => {
  const today = new Date();
  return today.getDate()+''
}

const lastDayOfMonth = () => {
  const today = new Date();
  const date = new Date(today.getFullYear(), today.getMonth()+1, 0);
  return date.getDate()
}

 After(() => {
    cy.get(".fa-power-off:last").click({force:true});
 });

Given(
  "I'm logged at Reportnet page as user {string} and password {string}",
  (user, password) => {
    cy.visit(Cypress.env("default"));
    cy.contains('Login').click()
    cy.get("input[type=text]").type(user);
    cy.get("input[type=password]").type(password);
    //cy.get("#kc-login").click();
    cy.get("button").click();
  }
);

And("The user logout", () => {
  cy.get(".fa-power-off:last").click({force:true});
})

And("I navigate to {string}", page => {
  cy.request(page);
});

And("I can see the dataflows page", () => {
  cy.contains("h2", "Dataflows");
});

And("I can click on {string}", element =>  {
  cy.wait(500);
  cy.contains(element).click({force:true})
  cy.wait(1000);
});
And("I can click on element {string}", element =>  {
  cy.wait(1000);
  cy.get('p:contains('+element+'):first').parent().click()
  cy.wait(1000)
});

And("I can click on the tab {string}", element =>  {
  cy.wait(3000)
  cy.get('span:contains('+element+')').first().parent().click({force:true})
  cy.wait(1000)
});

And("the {string} {string} is {string}", (type, button, property) => {
  cy.wait(2000)
  if(type === 'action') {
    cy.contains(button).and(property)
  } else {
    cy.get('button:contains('+button+'):visible').should(property)
  }
  property === "be.enabled" && cy.contains(button).click({force:true});
  property === "be.visible" && cy.contains(button).click({force:true});
  cy.wait(1000)
});


And("I import a file {string} to dataset", file => {
  const fileName = file;
  cy.fixture(fileName).then(fileContent => {
    cy.get("input[type=file]:first").upload({
      fileContent,
      fileName,
      mimeType: "text/plain"
    });
  });
  cy.contains("Upload").click();
});

And("I delete the table data", () => {
  cy.contains("button", "Delete dataset data").click({ force: true });
  setDialog("Yes")
});

And("I see the message: {string}", message => {
  cy.wait(2000)
  cy.contains(message)
});

And("I click on the notification {string} link", message => {
  cy.contains(message)
    .find("a[href]")
    .click()
});

Then("the dataset table {string} has {} record(s)", (table, records) => {
  // cy.wait(2000)
  // cy.get('.p-button-text:contains(Refresh):visible').click({force:true})
  cy.wait(2000)
  cy.get('span:contains('+table+')').click({force:true})
  cy.wait(1000)
  cy.get(".p-datatable-scrollable-body-table >tbody>tr:visible").should("have.length", records);
  cy.wait(2000)
});

Then("the table {string} has {} record(s)", (table, records) => {
  cy.get('span:contains('+table+')').first().parent().click()
  cy.get("tbody>tr:last").should("have.length", records);
});

Then(
  "I can update the cell with the text {string} to the text {string}",
  (cell, text) => {
    cy.contains("div", cell).click();
    cy.focused()
      .clear()
      .type('123' + "{enter}");
  }
);

When("I delete the dataset table row {int}", row => {
  cy.get(".p-datatable-scrollable-body-table >tbody>tr")
    .eq(row - 1)
    .find(".pi-trash")
    .click({force:true});
  cy.wait(1000)
  setDialog("Yes");
});

When("I {string} the row {int}", (action, row) => {
  const type = action === 'delete' ? '.pi-trash' : '.pi-pencil'
  cy.get("tbody>tr:last")
    .eq(row - 1)
    .find(type)
    .click({force:true});
  action === 'delete' && setDialog("Yes");
});

And("I reload the page", () => {
  cy.wait(1000)
  cy.reload();
});

And("I wait for notification", () => {
  cy.wait(10000);
})

And("I am in {string} dataset", location => {
  cy.contains("h1", location);
});

And("I paste the data from file {string}", function(file) {
  cy.fixture(file).as("fileContent");
  cy.get('[class*=InfoTable_infoTablePaste]').then(
  //cy.get("#pr_id_1_content_0 > div > div:nth-child(4) > div").then(
    $destination => {
      const pasteEvent = Object.assign(
        new Event("paste", { bubbles: true, cancelable: true }),
        {
          clipboardData: {
            getData: (type) => this.fileContent
          }
        }
      );
      $destination[0].dispatchEvent(pasteEvent);
    }
  );
  setDialog("Save");
  cy.reload();
});

Then("I can {string} a dataflow with name {string} and description {string} and obligation {string} with {string}", (action, name, description, obligation,filtered, filters) => {
  cy.get("input[name=name]").clear().type(name);
  cy.get("textarea[name=description]").clear().type(description);
  cy.get('[class*=DataflowManagementForm_search] > .p-button').click({force:true})

  if(filtered === "filters"){
    filters.rawTable.map((data) => {
      cy.get('[id=countries]:first').click({force:true})
      data[0]!=="" && 
      cy.get('input[placeholder="Country"]').focus().type(data[0]) && 
      cy.wait(1000) &&
      cy.get('.p-dropdown-item:contains('+data[0]+')').click({force:true})
      cy.get('[id=issues]:first').click({force:true})
      data[1]!=="" && cy.contains(data[1]).click({force:true})
      cy.get('[id=organizations]:first').click({force:true})
      data[2]!=="" &&  cy.contains(data[2]).click({force:true})
      //date
      data[4]!=="" && cy.get('[id=searchInput]:first').focus().type(data[4], {force:true})
      cy.get('.pi-filter').click({force:true})

    })
  }
  cy.get('.p-datatable-row:contains('+obligation+') .p-checkbox').click({force:true})
  cy.get('button:contains(OK):visible').click({force:true})
  cy.get('.p-button-text:contains('+action+')').click({force:true})
  cy.wait(2000);
});

Then("I can delete the dataflow {string}", (name) => {
  cy.wait(3000)
  cy.contains("Delete this dataflow").click({force:true});
  cy.get("input:visible").type(name, {force: true});
  cy.wait(1000)
  cy.get('.p-button-danger:visible').click()
})

Then("I can click on the option {string}", (name) => {
  cy.contains(name).click()
})

Then("I can see the {string} on {string}",(data, dataflow) =>{
  cy.wait(2000)
  cy.get('[class*=containerLink]:contains('+dataflow+')').contains(data)
})

Then("the dataflow list has {int} items",(total) => {
  cy.get("[class*=containerLink]").should("have.length", total);
})

Then ("I can clear {string} filters", (type) => {
  if( type === 'all') {
    cy.get('.pi-times:visible:last').click()
  } else {
    cy.get('.pi-times:visible:first').click()
  }
})

Then("I can filter by {string} with {string}",(field, filter) => {
  if (field === 'name' || field === 'description' || field === "legalInstrument" || field === "obligationTitle" || field === "searchInput") {
    cy.get('[id='+field+']').type(filter)
  } else if (field === 'expirationDate') {
    cy.get('[id='+field+']').click({force:true})
    cy.get('.p-datepicker-month').select(getMonth(),{force:true})
    cy.get('td>span:visible').contains(new RegExp("^" + getDay() + "$")).should('not.have.class', 'p-datepicker-other-month').click()
    cy.get('td>span:visible').contains(new RegExp("^" + lastDayOfMonth() + "$")).click()
    //cy.get('td>span:visible:contains('+new RegExp('^' + 5 + '$')+')')//contains('+getDay()+'):last').click()
    //cy.get('td>span:visible:contains('+lastDayOfMonth()+'):last').click()
  } else {
    cy.get('input[id='+field+']').click({force:true})
    cy.contains(new RegExp("^" + filter + "$", "g")).click({force:true})
  }
})

And("I sort the dataflow list by {string}", (field) => {
  cy.get('[id='+field+'_sort]').click()
})

And("The first dataflow is {string} and the last dataflow is {string}",(first, last) => {
  cy.get('[class*=containerLink]:first:contains('+first+')')
  cy.get('[class*=containerLink]:last:contains('+last+')')
})

And("I change to {string} mode", (mode) => {
  cy.get('[class*=DatasetDesigner_switchDiv] .p-inputswitch').click({force:true})
})

And("I can validate de fields",() =>{
  cy.get('.p-button-text:contains(Yes):visible').click()
})

And ("I can add a record", (fields) => {
  cy.contains("Add record").click()
  fields.rawTable.map((data) => {
    if(data[1] === 'link') {
      cy.get('label:contains(-- None --)').click({force:true})
      cy.get('li:contains('+data[0]+'):visible:last').click({force:true})
    } else {
      cy.get('.p-inputtext:visible:last').type(data[0].toString(),{force:true})
    }
    setDialog("Save")
    cy.wait(2000)
  })
})

And("I can see the field {} has {} error",(field, errors)=>{
  cy.get('.p-datatable-tbody > :nth-child(1) >>>> .pi-exclamation-triangle:visible').should('have.length', errors)
})

And("I can see the information from ROD3 with obligation {string} and instrument {string}",(obligation, instrument) => {
  cy.contains(obligation)
  cy.contains(instrument)
})

And("I can create data collections",() => {
  const today = new Date();
  cy.get('.p-datepicker-month').select(today.getMonth()+'')
  cy.get('.p-datepicker-year').select(today.getFullYear()+'')
  cy.get('span:contains('+(lastDayOfMonth())+'):last').click()
  cy.get('.p-button-text:contains(Create)').click({force:true})
  setDialog("Yes")
  cy.wait(1000)
})

And("I click on table {string}", (table) => {
  cy.get('span:contains('+table+')').first().parent().click()
})

And("I mark the table as a {string}",(type) => {
  const loc = type === 'prefilled' ? ':nth-child(2)> .p-checkbox > .p-checkbox-box' : '> .p-checkbox > .p-checkbox-box:first'
  cy.get('[class*=FieldsDesigner_switchDiv] >'+ loc).click({force:true})
})

And("new API-key is created", () => {
  cy.get('[class*=ApiKeyDialog_textarea]').should('not.be.empty')     
})

And("I can Release to data collection", () => {
  cy.wait(1000)
  cy.get('.ui-dialog-buttonpane > .p-button > .pi').click({force:true})
  cy.wait(1000)
  cy.get('.p-inputtext').type('New release' + "{enter}")
  cy.get('.p-button-text:contains(Yes)').click()
})

And("validate the dataflow {string}", (name) => {
   cy.wait(1000)
   cy.reload();
   cy.get("[class*=containerLink]").its('length').then((size) => {
     if(size === 2) {
      cy.contains(name).first().click({force:true})
      cy.contains("Edit").click({force:true});
      cy.contains("Delete this dataflow").click({force:true});
      cy.get("input:visible").type(name, {force: true});
      cy.wait(1000)
      cy.get('.p-button-danger:visible').click()
     }
  })
})

And("The integration {string} is {string} on the list of external integrations", (name, property) => {
  cy.wait(2000)
  cy.contains(name).should(property)
})

