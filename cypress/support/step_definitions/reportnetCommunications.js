import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Then("I select the country {string}",(name) => {
  cy.get(`.p-listbox-item:contains(${name})`).click({force:true})
});

Then("I can {string} the message {string}",(action, message) => {
  cy.wait(1000)
  if(action === 'send') {
    cy.get('#feedbackSender').type(message)
    cy.get('.p-button-text:contains(Send)').click()
  } else {
    cy.get(`[class*=ListMessages_scrollMessagesWrapper]>:contains(${message}):first>.svg-inline--fa`).click({multiple:true})
    cy.contains('Yes').click()
  }
  cy.wait(1000)
})
  
Then("I can see the message received {string}",(message) => { 
  cy.get(`[class*=Message_messageTextWrapper]:last:contains(${message})`)
})

When("I create a system notification with {string} message and {string} level and active {string}", (message, level, active) => {
  cy.get('#createSystemNotification > .p-button-text').click()
  cy.wait(3000)
  cy.get("#systemNotificationMessage").type(message);
  cy.get("#errorLevel > .p-dropdown-label:first").click({force:true})
  if(active == "disabled")
  {
  cy.get("#systemNotification_Enabled > .p-checkbox-box >").click({force:true})
  }
  cy.get("#createSystemNotificationCreateForm > .p-button-text").click();
  cy.wait(1000)
})

Then("I see the notification {string} in the system notifications list", (message) => { 
  cy.get('.p-datatable-row:last:contains('+message+')')
})

Then("I see the notification {string} in the notification received list", (message) => { 
  cy.get('.p-datatable-row:contains('+message+')')
})

Then("I can see a system notification {string} sent by an Admin", (message) => { 
  cy.get('.p-growl-item:contains('+message+')')
})

Then("I delete a system notification with {string} message", (message) => {
  cy.wait(2000)
  cy.get('[class*=p-datatable-tbody]').children().contains(message).siblings().find('[class*=SystemNotificationsList_actionsColumnButtons] > [class*=ActionsColumn_actionTemplate] > [class*=ActionsColumn_deleteRowButton] > .p-button-text').click({force:true})
  cy.wait(5000)
})