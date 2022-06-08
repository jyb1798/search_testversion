import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/accountController.getAccounts';
import getContacts from '@salesforce/apex/accountController.getContacts';

export default class Tpms extends LightningElement {
    key;
    keyword;
    @track accounts;
    @track contacts;

    updateKey(event){
        this.key = event.target.value;
    }

    updateKeyWord(event){
        this.keyword = event.target.value;
    }


    handleSearch(){
        getAccounts({searchkey: this.key, searchkeyword: this.keyword})
        .then(result=>{
            this.accounts = result;
            console.log(result);
        })
        .catch(error=>{
            this.accounts = null;
        });
        getContacts({searchkey: this.key})
        .then(result=>{
            this.contacts = result;
        })
        .catch(error=>{
            this.contact = null;
        });
    }

    filterRange(result, searchkey, searchkeyword){
        console.log(result);
        const res = result.filter(item => (searchkey <= item && item <= searchkeyword));
        console.log(res);
        return res;
      }

    cols=[
        {label: '규격번호', fieldName: 'NumberofLocations__c', type: 'number'},
        {label: '규격명', fieldName: 'Name', type: 'text'},
        {label: '규격종류',  fieldName: 'Title', type: 'text'},
        {label: '작성일', fieldName: 'LastTransferDate', type: 'date'},
        {label: '상태', fieldName: 'Industry', type: 'Picklist'}
    ]

    colums=[
        {label: '규격서번호',  fieldName: 'Phone', type: 'phone'},
        {label: '제품포장규격명', fieldName: 'Name', type: 'text'},
        {label: '생산처', fieldName: 'Email', type: 'text'},
        {label: '최종수정일', fieldName: 'Birthdate', type: 'date'},
        {label: '상태', fieldName: 'CleanStatus', type: 'Picklist'}
    ]


}