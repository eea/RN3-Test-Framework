import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Then("I can {string} a Data provider with Representative of {string} and account {string} and Data provider {string}", (action, representative, account, provider) => {
    if(action === "add") {
      cy.get("[class^=ManageLeadReporters_selectWrapper] .p-dropdown-trigger").click();
      cy.contains(representative).click()
      cy.wait(1000);
    } 
    if(action === 'addToCountry') {
      cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
    } else {
      if(action === "add") {
        cy.get("[class^=p-datatable-row").children().eq(1).children().eq(1).select(provider)
        cy.contains('Lead reporter').click()
        cy.wait(1000)
        cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
        
      } else if (action === 'addLast') {
        cy.get("[class^=p-datatable-row").last().children().eq(1).children().eq(1).select(provider)
        cy.contains('Lead reporter').click()
        cy.wait(1000)
        cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
      }
      else if (action === 'addMore')
      {
        cy.get("[class^=p-datatable-row").last().children().eq(1).children().eq(1).select(provider)
        cy.contains('Lead reporter').click()
        cy.wait(1000)
        cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
      }
    }
    if(action === "edit") {
      cy.get("[class^=p-datatable-row").children().eq(1).children().eq(1).select(provider)
      cy.get("input:visible:last").clear().type(account+'{enter}');
    }
    if(action === 'delete') {
      cy.get('.pi-trash:visible:first').click({force:true});
      cy.get('.p-button-danger:visible').click({force:true})
    }
    cy.wait(1000);
    cy.get('button:contains(Close):visible').click({force:true})
  });

  Then("I can {string} a Data provider in a BDR with account {string} and Data provider {string}", (action, account, provider) => {
    if(action === 'addToCountry') {
      cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
    } else if(action === "add") {
        cy.get("[class^=p-datatable-row").children().eq(1).children().eq(1).select(provider)
        cy.contains('Lead reporter').click()
        cy.wait(1000)
        cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
        
      } else if (action === 'addLast') {
        cy.get("[class^=RepresentativesList_selectDataProvider]:last").select(provider)
        cy.contains('Lead reporter').click()
        cy.wait(1000)
        cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
      }
      else if (action === 'addMore')
      {
        cy.get("[class^=p-datatable-row").last().children().eq(1).children().eq(1).select(provider)
        cy.contains('Lead reporter').click()
        cy.wait(1000)
        cy.get("input:visible[placeholder='New lead reporter e-mail...']:last").type(account+'{enter}');
      }
    if(action === "edit") {
      cy.get("[class^=RepresentativesList_selectDataProvider]:first").select(provider)
      cy.get("input:visible:first").clear().type(account+'{enter}');
    }
    if(action === 'delete') {
      cy.get('.pi-trash:visible:first').click({force:true});
      cy.get('.p-button-danger:visible').click({force:true})
    }
    cy.wait(1000);
    cy.get('button:contains(Close):visible').click({force:true})
  });

  When("I can add datasets for new Representatives",() => {
    cy.get('button:contains(Create):visible').click({force:true})
    cy.wait(1000)
  })

When("I can {string} Lead reporters",(action) => {
    cy.get('#buttonExportImport > .p-button-text').click()
    cy.wait(1000)
    cy.get('[data-for="'+action+' lead reporters"] > .p-menuitem-link > span').click({force: true})
    cy.wait(2000)
  })

When("I can {string} a editor {string} with permissions {string}",(action, editor, permission) => {
  if(action === 'Add'){
    cy.wait(1000)
    cy.contains('button','Add').click({force:true})
    cy.get("[id=rolesDropdown]").click();
    cy.get(`.p-dropdown-items`).contains(new RegExp(permission)).click();
    cy.get("[id=accountInput]").type(editor+'{enter}');
    cy.get(".p-button > .p-button-text:contains(Save)").click({force:true})
    cy.wait(5000)
  } else {
    cy.get('.p-datatable-tbody > tr:contains(test.observer) >>>[class*=ActionsColumn_deleteRowButton] > .p-button-text').click({force:true})
    cy.get(".p-button > .p-button-text:contains(Yes)").click({force:true})
    cy.wait(7000)
  }
})

Then("I can see a tag next to the invalid lead reporter email", () => {
  cy.get(':nth-child(2) > :nth-child(3) > :nth-child(1) > .svg-inline--fa')
  cy.wait(2000)
})


Then("I can see a tag next to the invalid reporter email", () => {
  cy.get(':nth-child(1) > :nth-child(1) > [class*=ShareRights_accountWrapper] > .svg-inline--fa')
  cy.wait(2000)
})

When("I can see the representative {string} {string}", (country, email) => {
  cy.get(`tr:contains(${country})`)
  cy.get(`tr:contains(${country})>>> input:first`).should('have.attr','value',email)
})

When("I can see the specified record in the table", (fields) => {
  cy.wait(2000)
  fields.rawTable.map((data) => {
    cy.get(`.p-datatable-tbody>tr:contains(${data[0]}):contains(${data[1]})`)
  })
})

When("I can see the specified records in the table", (fields) => {
  cy.wait(2000)
  fields.rawTable.map((data) => {
    cy.get(`.p-datatable-tbody>tr:contains(${data[0]}):contains(${data[1]}):contains(${data[2]})`)
  })
})

When("I can check enable automatic delete reporter data and snaphots", () => {
  cy.wait(1000)
  cy.get(".p-dialog:contains(Automatic delete)>> .p-checkbox").click({force:true})
  cy.contains("Save").click();
})

When("I can add a national coordinator with email {string} for country {string}", (email, country) => {
  cy.get('[class *= ManageNationalCoordinators_buttonsDialogFooter] > .p-button-primary > .p-button-text').click({force:true})
  cy.wait(2000)
  cy.get('#name').type(email)
  cy.wait(2000)
  cy.get('#groupOfCountries > .p-dropdown-label').children().click()
  cy.get('.p-input-overlay-visible > .p-dropdown-items-wrapper > .p-dropdown-items >').contains(country).click()
  cy.get('.p-dialog-footer > div > [data-for="confirmTooltipId"] > .p-button > .p-button-text').click({force:true})
  cy.wait(6000)
  cy.get('.p-dialog-content').contains(email).siblings().contains(country)
})

When("I can not filter by {string}", (filter) => {
  if(filter === "role") {
    cy.get('#userRole_dropdown').should('not.exist')
    cy.wait(4000)
  }
})

When("I can see the list of validations and a refresh button", () => {
  cy.get("[class*=ValidationsStatuses_dialogContent]").should('be.visible')
  cy.contains("Refresh").click({force:true})
})

When("I can see the status for the {string} dataset", (dataset) => {
  cy.get(`[class*=BigButtonList_datasetItem]>:contains(${dataset})>>.fa-check-circle`).click({force:true})
  cy.contains("Final feedback")
})


