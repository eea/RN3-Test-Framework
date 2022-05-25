import { And } from "cypress-cucumber-preprocessor/steps"


const uploadFile = (fileName, fileType = '', selector) => {
    cy.fixture(fileName).then(fileContent => {
        cy.get(selector).upload({
            fileContent: fileContent.toString(),
            fileName: fileName,
            mimeType: fileType
        });
    });
}

const defaultFormat = /^\d{4}-\d{2}-\d{2}$/
const endFormat = /^\d{2}-\d{2}-\d{4}$/

And("I can see the user profile page", (type) => {
    cy.get('.userSettingsBtn:first').click({force:true})
    // type==="true" && cy.get('.fa-user-cog').click()
})

And("I can change the visual {string} from {string} to {string}",(option, oldFormat, newFormat) => {   
    cy.wait(2000)
    if(option === 'theme') {
        cy.get('[class*=InputSwitch_inputswitch_dark_theme]:first').click() 
    }
    if(option === 'defaultRows'){
        cy.get(`#rowsPage`).click({force:true})
        cy.get(`#rowsPage > > > .p-dropdown-items > :contains(${newFormat})`).click({force:true})
    } 
    else {
        cy.contains(oldFormat).click({force:true})
        cy.contains(newFormat).click({force:true})
    }      
})

And("I can go to the list dataflows page",() => {
    cy.wait(1000)
    cy.get('.p-menuitem-link > .p-menuitem-text:contains(Dataflows)').click({force:true})
})

And("I can go to the dataflow page",() => {
    cy.wait(1000)
    cy.get(':nth-child(5) > .p-menuitem-link > .p-menuitem-text').click({force:true})
})

And("I can see the dateFormat on the {string} as {string}",(dataflow, format) => {
    const regEx = format === 'YYYY-MM-DD' ? defaultFormat : endFormat
    cy.get('[class*=containerLink]:contains('+dataflow+') [class*=dateBlock]').invoke('text').should('match', new RegExp(regEx));
})

And("I can see the theme is {string}", (theme) => {
    cy.wait(1000)
    const css = theme === "Light" ? '--accent-color:var(--informative-color)' : '--accent-color:var(--accent-color-dark-mode)'
    cy.get('body').should('have.attr', 'style').and('contains', css)
})

And("I can add a user {string}", (fileName) => {
    cy.get('[class*=UserImage_userDataIcon]').click({force:true})
    if(fileName === "") {
        cy.get(".p-button-text:contains(Select one)").click({force:true})
        cy.get('[class*=UserImage_gridItem]:visible:last').click({force:true})
    } else {
        cy.contains("Upload your image").click({force:true})
        uploadFile(fileName, 'image/png', 'input[type=file]:first')
    }
})