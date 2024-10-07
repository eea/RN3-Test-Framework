import { Given, When, Then, After } from "@badeball/cypress-cucumber-preprocessor";


  
  After(() => {
       console.log("end execution");
  })

Given("I'm logged at Reportnet api as {string}", (user) => {
    cy.request ({
        method: "POST",
        url: "https://sandbox-api.reportnet.europa.eu/user/generateToken",
        qs:{"username":"test.custodian2",
    "password":"1234"}
   }).then((response)=>{
        
        cy.log(response.body.accessToken);
        Cypress.env('accessToken',response.body.accessToken);
   })
}
  );

  Then( "I can create a new reporting dataflow with name {string}", (name) =>{
    const dynamicallyGeneratedName = Math.random().toString(36).substring(2, 7);
  const typeValue = name + dynamicallyGeneratedName;
    cy.request({
        method: "POST",
        url: "https://sandbox-api.reportnet.europa.eu/dataflow",
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
        body: {name: typeValue, description: "desc", obligation: {obligationId: 673}, releasable: true}
        
    }).then((response)=>{
        cy.log (JSON.stringify(response.body))
        Cypress.env('dataflowID',response.body);
    })
}
);
    Then ("I can create a new schema with name {string}", (name)=>{
        cy.request({
            method: "POST",
            url: "https://sandbox-api.reportnet.europa.eu/dataschema/createEmptyDatasetSchema",
           
            headers: {
                Authorization: 'Bearer '+ Cypress.env('accessToken')
            },
            qs: {
                "dataflowId": Cypress.env('dataflowID'),
                "datasetSchemaName": 'DS'
            },
            Accept: 'application/json',
            
            
        }).then((response)=>{
            cy.log (JSON.stringify(response.body))
            
        })
    });
Then('I can get DataSchemaID', ()=>{
    const url1= 'https://sandbox-api.reportnet.europa.eu/dataflow/v1/'+Cypress.env('dataflowID')
    cy.request({
        method: "GET",
        url: url1,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
    }).then((response)=>{
        cy.log (JSON.stringify(response.body.designDatasets[0].id))
        Cypress.env('dataschemaID',response.body.designDatasets[0].id);
            })
});
Then ('I can create a Table', ()=>{
    const url1= 'https://sandbox-api.reportnet.europa.eu/dataschema/'+Cypress.env('dataschemaID')+'/tableSchema'
    cy.wait(10000);
        cy.request({
        method: "POST",
        url: url1,
        failOnStatusCode: false,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
        body: {
            nameTableSchema: "table1",
             notEmpty: true
            },
    }).then((response)=>{
        cy.log (JSON.stringify(response.body.idTableSchema))
        Cypress.env('idTableSchema',response.body.idTableSchema); 
    })
});
   
Then('I can get the idRecordSchema', ()=>{
    const url1= 'https://sandbox-api.reportnet.europa.eu/dataschema/v1/datasetId/'+Cypress.env('dataschemaID')
        cy.request({
        method: "GET",
        url: url1,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
        
    }).then((response)=>{
        cy.log (JSON.stringify(response.body.tableSchemas[0].recordSchema.idRecordSchema))
         Cypress.env('idRecordSchema',response.body.tableSchemas[0].recordSchema.idRecordSchema);
            })
        })

    Then ('I can add Field1 into the table',()=>{
        const url2= 'https://sandbox-api.reportnet.europa.eu/dataschema/'+Cypress.env('dataschemaID')+'/fieldSchema'
        cy.wait(4000);
        cy.request({
        method: "POST",
        url: url2,
        failOnStatusCode: false,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
        body: {
            codelistItems:[],
            description: "desc",
            idRecord: Cypress.env('idRecordSchema'),
            maxSize: "0",
            name: "Field1",
            pk: true,
            readOnly: false,
            referencedField: null,
            required: true,
            type: "NUMBER_INTEGER",
            validExtensions: []

        }
        
        
    })
            
        }),
        Then ('I can add Field2 into the table',()=>{
        const url3= 'https://sandbox-api.reportnet.europa.eu/dataschema/'+Cypress.env('dataschemaID')+'/fieldSchema'
        cy.wait(4000);
        cy.request({
        method: "POST",
        url: url3,
        failOnStatusCode: false,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
        body: {
            codelistItems:[],
            description: "desc",
            idRecord: Cypress.env('idRecordSchema'),
            maxSize: "0",
            name: "Field2",
            pk: false,
            readOnly: false,
            referencedField: null,
            required: false,
            type: "TEXT",
            validExtensions: []

        },
        Accept: 'application/json',
        
    })
            
    
}),


Then('I can get APIkey from dataflow page', ()=>{
    const url1= 'https://sandbox-api.reportnet.europa.eu/user/createApiKey'
    cy.request({
        method: "POST",
        url: url1,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
        qs:{
            dataflowId:Cypress.env('dataflowID')
        }
    }).then((response)=>{
        cy.log (JSON.stringify(response.body))
        Cypress.env('APIKey',response.body);
            })
});
Then ('I can import data into the table',()=>{
    const url3= 'https://sandbox-api.reportnet.europa.eu/dataset/v1/'+Cypress.env('dataschemaID')+'/etlImport'
    const bearer ='Bearer '+ Cypress.env('accessToken')
    const API ='ApiKey ' + Cypress.env('APIKey')
    cy.wait(9000);
    cy.request({
    method: "POST",
    url: url3,
    
    // failOnStatusCode: false,
     headers: {
        Authorization: API ,
        
        'Content-Type': 'application/json'
    },
        qs: {
            "dataflowId": Cypress.env('dataflowID')
        },
        body: {
                    "tables": [
                        {
                    "records": [
                        {
                            "countryCode": "XX",
                            "fields": [
                                {
                                    "fieldName": "Field1",
                                    "value": 3
                                },
                                {
                                    "fieldName": "Field2",
                                    "value": "c"
                                }
                            ]
                        },
                        {
                            "countryCode": "XX",
                            "fields": [
                                {
                                    "fieldName": "Field1",
                                    "value": 4
                                },
                                {
                                    "fieldName": "Field2",
                                    "value": "d"
                                }
                            ]
                        },
                        {
                            "countryCode": "XX",
                            "fields": [
                                {
                                    "fieldName": "Field1",
                                    "value": 5
                                },
                                {
                                    "fieldName": "Field2",
                                    "value": "e"
                                }
                            ]
                        }
                    ],
                    "tableName": "table1"
                }
                    ]
            },   

        })
    })


Then ('I can import file into the table',()=>{
    const url3= 'https://sandbox-api.reportnet.europa.eu/dataset/v1/'+Cypress.env('dataschemaID')+'/importFileData'
    const API ='ApiKey ' + Cypress.env('APIKey')
    cy.fixture('table1.zip', 'binary').then((fileContent) => {
        
        const blob = Cypress.Blob.binaryStringToBlob(fileContent);
        const formData = new FormData();
        formData.append('file', blob, 'table1.zip');
        formData.append('delimiter', ',');
        formData.append('idTableSchema', Cypress.env('idTableSchema'));
    cy.wait(5000);
    cy.request({
    method: "POST",
    url: url3,
    // failOnStatusCode: false,
     headers: {
        Authorization: API,
        'Content-Type': 'multipart/form-data',
        
    },
    qs: {
        "dataflowId": Cypress.env('dataflowID')
    },
    body: formData,
    
    
}).then((response) => {
    
  })
    })
})
Then ('I can get idDataSetSchema for creating a new QC rule',()=>{
    const url1= 'https://sandbox-api.reportnet.europa.eu/datasetmetabase/'+Cypress.env('dataschemaID')
    cy.request({
        method: "GET",
        url: url1,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
    }).then((response)=>{
        
        cy.log (response.body.datasetSchema)
        Cypress.env('idDataSetSchema',response.body.datasetSchema);
    })
})
Then ('I can get referenceId for creating a new QC rule',()=>{
    const url1= 'https://sandbox-api.reportnet.europa.eu/rules/'+Cypress.env('idDataSetSchema')+'/dataflow/'+Cypress.env('dataflowID')
    cy.request({
        method: "GET",
        url: url1,
        headers: {
            Authorization: 'Bearer '+ Cypress.env('accessToken')
        },
    }).then((response)=>{
        
        cy.log (response.body.rules[1].referenceId)
        Cypress.env('referenceId',response.body.rules[1].referenceId);
        
    })
})
Then('I can add new QC rule for table field', ()=>{
    const url1= 'https://sandbox-api.reportnet.europa.eu/rules/createNewRule'
    const API ='ApiKey ' + Cypress.env('APIKey')
    const requestBody = {
        automatic: false,
        description: "desc",
        enabled: true,
        expressionText: "( Field1 >= 1 ) AND ( Field1 <= 10 )",
        referenceId: Cypress.env('referenceId'),
        ruleName: "test Name",
        shortCode: "qc1 Test",
        thenCondition: ["info", "ERROR"],
        type: "FIELD",
        whenCondition: {
          operator: "FIELD_AND",
          params: [
            { operator: "FIELD_GTEQ", params: ["VALUE", 1] },
            { operator: "FIELD_LTEQ", params: ["VALUE", 10] }
          ]
        }
      };
      cy.wait(10000);
    cy.request({
        method: "PUT",
        url: url1,
        qs:{
            datasetId:Cypress.env('dataschemaID')
        },
        headers: {
            'Authorization': 'Bearer '+ Cypress.env('accessToken'),
            'x-api-key': API,
            'Content-Type': 'application/json'
        },
       
        body: requestBody,
    })
})
Then ('I can validate data',()=>{
    cy.wait(1000);
    const url1= 'https://sandbox-api.reportnet.europa.eu/orchestrator/jobs/addValidationJob/'+Cypress.env('dataschemaID')
    const API ='ApiKey ' + Cypress.env('APIKey')
    cy.request({
        method: "PUT",
        url: url1,
       
        headers: {
            'Authorization': 'Bearer '+ Cypress.env('accessToken'),
            'x-api-key': API,
            
        },
    })

})

Then ('I can wait until the validation finished', () => {
    
      const baseUrl = 'https://sandbox-api.reportnet.europa.eu/orchestrator/jobs/';
      const API ='ApiKey ' + Cypress.env('APIKey')
      const pageSize = 1000;
      const sortedColumn = '';
      const datasetId = Cypress.env('dataschemaID')
      
      const url = `${baseUrl}?pageSize=${pageSize}&sortedColumn=${sortedColumn}&datasetId=${datasetId}`;

      const remainingJobs = 0;
  
      
      const callApi = () => {
        return cy.request({
            url: url,
            headers: {
                'Authorization': 'Bearer '+ Cypress.env('accessToken'),
                'x-api-key': API,
                
            },
          }).then(response => {
          
          if (response.body.remainingJobs === remainingJobs) {
            
            return;
          } else {
            
            return callApi();
          }
        });
      };
  
      
      callApi();
    });
    Then ('I can check that the validation result has {int} error', (number)=>{
        cy.wait(1000);
        const totalErrors=number
        const url1= 'https://sandbox-api.reportnet.europa.eu/validation/listGroupValidations/'+Cypress.env('dataschemaID')
        const API ='ApiKey ' + Cypress.env('APIKey')
        cy.request({
            method: "GET",
            url: url1,
            qs:{
                asc: 0,
                fieldValueFilter: '',
                headers: '',
                levelErrorsFilter: '',
                pageNum: 0,
                pageSize: 10,
                tableFilter: '',
                typeEntitiesFilter: ''

            },
            headers: {
                'Authorization': 'Bearer '+ Cypress.env('accessToken'),
                'x-api-key': API,
                
            },
        }).then(response=>{
            expect(response.body.totalErrors).to.eq(totalErrors)
        })
    })
  
    Then ('I can export data from the table',()=>{
        cy.wait(1000);
        
        const url1= 'https://sandbox-api.reportnet.europa.eu/dataset/exportFile'
        const url2='https://sandbox-api.reportnet.europa.eu/dataset/'+Cypress.env('dataschemaID')+'/downloadFile'
        const API ='ApiKey ' + Cypress.env('APIKey')
        const payload = {
            "fieldValue": "",
            "idRules": "",
            "levelError": []
        };
        cy.request({
            method: "POST",
            url: url1,

            qs: {  
                "datasetId": Cypress.env('dataschemaID'),  
                "tableSchemaId": Cypress.env('idTableSchema'),
                "mimeType": 'csv',
            },

           body: payload,
            headers: {
                'Authorization': 'Bearer '+ Cypress.env('accessToken'),
                'x-api-key': API,
                'Content-Type': 'application/json',
                
            },
        })
        cy.wait(2000)
        cy.request({
            method: "GET",
            url: url2,

            qs: {  
                "fileName": 'table1.csv'
            },

           
            headers: {
                'Authorization': 'Bearer '+ Cypress.env('accessToken'),
                'x-api-key': API,
                'Content-Type': 'application/json',
                
            },
        }).then((response)=>{
            cy.log (response.body)
        })
    
    })