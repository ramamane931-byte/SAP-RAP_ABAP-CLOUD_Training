@EndUserText.label: 'Booking BO projection view'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true

define view entity ZC_BOOKING_M_6
  as projection on zi_booking_m_6 as Booking
{
  key BookingUUID,
      TravelUUID,
      @Search.defaultSearchElement: true
      BookingID,
      BookingDate,
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID'  } }]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      CustomerID,
      _Customer.LastName as CustomerName,
      //       @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Carrier', element: 'AirlineID' }}]
      @Consumption.valueHelpDefinition: [{entity: {name: 'zi_fe_carr_000274', element: 'AirlineID' }}]
      @ObjectModel.text.element: ['CarrierName']
      CarrierID,
      _Carrier.Name      as CarrierName,
      _Carrier_icon.AirlinePicURL as CarrierIcon,
       
      @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
                                           additionalBinding: [ { localElement: 'CarrierID',    element: 'AirlineID' },
                                                                { localElement: 'FlightDate',   element: 'FlightDate',   usage: #RESULT},
                                                                { localElement: 'FlightPrice',  element: 'Price',        usage: #RESULT },
                                                                { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT } ] } ]
      ConnectionID,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      CurrencyCode,
      LocalLastChangedAt,

      /* associations */
      _Travel : redirected to parent ZC_ROOT_TRVL_M_6,
      _Customer,
      _Carrier,
      _Carrier_icon,
      
      _Connection,
      _Flight
}
