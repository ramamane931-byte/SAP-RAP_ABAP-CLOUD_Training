@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZTBL_TRAVEL_M_01'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_TBL_TRAVEL_M_01
  provider contract transactional_query
  as projection on ZR_TBL_TRAVEL_M_01
  association [1..1] to ZR_TBL_TRAVEL_M_01 as _BaseEntity on $projection.TravelUUID = _BaseEntity.TravelUUID
{
  key TravelUUID,
  TravelID,
  AgencyID,
  CustomerID,
  BeginDate,
  EndDate,
  @Semantics: {
    amount.currencyCode: 'CurrencyCode'
  }
  BookingFee,
  @Semantics: {
    amount.currencyCode: 'CurrencyCode'
  }
  TotalPrice,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  CurrencyCode,
  Description,
  OverallStatus,

  @Semantics: {
    user.createdBy: true
  }
  CreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatedAt,
  @Semantics: {
    user.lastChangedBy: true
  }
  LastChangedBy,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
