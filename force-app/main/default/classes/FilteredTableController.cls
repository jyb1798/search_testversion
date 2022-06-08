public with sharing class FilteredTableController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(
        String caseNumber,
        String priority,
        String status,
        String accountName,
        String contactName,
    ) {
        String query;
        String condition = (String.isNotBlank(caseNumber)
            ? 'CaseNumber LIKE \'' + '%' + caseNumber + '%\''
            : '');

        condition += (String.isNotBlank(accountName)
            ? (String.isNotBlank(condition) ? +' AND ' : '') +
              ' Account.Name LIKE \'' +
              '%' +
              accountName +
              '%\''
            : '');

        condition += (String.isNotBlank(contactName)
            ? (String.isNotBlank(condition) ? +' AND ' : '') +
              ' Contact.Name LIKE \'' +
              '%' +
              contactName +
              '%\''
            : '');


        condition += (String.isNotBlank(status)
            ? (String.isNotBlank(condition) ? +' AND ' : '') +
              ' Status LIKE \'' +
              '%' +
              status +
              '%\''
            : '');

        condition += (String.isNotBlank(priority)
            ? (String.isNotBlank(condition) ? +' AND ' : '') +
              ' Priority LIKE \'' +
              '%' +
              Priority +
              '%\''
            : '');

        System.debug('condition ' + condition);
        if (String.isNotBlank(condition)) {
            query =
                'SELECT CaseNumber,Status, Account.Name,Contact.Name,Priority FROM Case WHERE ' +
                condition +
                ' ORDER BY CaseNumber';
        } else {
            query = 'SELECT CaseNumber,Status,Account.Name,Contact.Name,Priority FROM Case ORDER BY CaseNumber LIMIT 200';
        }

        List<Case> records = Database.query(query);
        return records;
    }
}