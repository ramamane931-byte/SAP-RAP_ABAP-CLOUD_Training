@EndUserText.label: 'Travel BO projection view'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZC_ROOT_TRVL_M_6
  as projection on zi_root_trvl_m_6 as Travel
{
  key TravelUUID,
      @Search.defaultSearchElement: true
      TravelID,
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Agency', element: 'AgencyID'} }]
      @ObjectModel.text.element: ['AgencyName']
      @Search.defaultSearchElement: true
      AgencyID,
      _Agency.Name              as AgencyName,
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer', element: 'CustomerID'} }]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      CustomerID,
      _Customer.LastName        as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency'} }]
      CurrencyCode,
      Description,

      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH', element: 'TravelStatus'}, useForValidation: true }]
      @ObjectModel.text.element: ['TravelStatusText']
      @Search.defaultSearchElement: true
      TravelStatus,
      _OverallStatus._Text.Text as TravelStatusText : localized,
      OverallStatusCriticality,

      //  contentDispositionPreference: #ATTACHMENT //// THIS ANNOTATION ALLOWED TO DOWNLOAD ATTACHED FILE
      //  contentDispositionPreference: #INLINE //// THIS ANNOTATION ALLOWED TO OPEN FILE IN A BROWSER
      //  acceptableMimeTypes: [ 'application/pdf' ] //// THIS ANNOTATION ALLOWED ONLY '.pdf' FILE FORMAT ATTACHMENTS
      @Semantics.largeObject:{ mimeType: 'Mimetype',
                               fileName: 'Filename',
            contentDispositionPreference: #ATTACHMENT,
            acceptableMimeTypes: [ 'text/plain', 'application/pdf' ]
      }
      Attachment,

      @Semantics.mimeType: true
      Mimetype,
      Filename,

      LastChangedAt,
      LocalLastChangedAt,

      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC_BOOKING_M_6,
      _Currency,
      _Customer
}
