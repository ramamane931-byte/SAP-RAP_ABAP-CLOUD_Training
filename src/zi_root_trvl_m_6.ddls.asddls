@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Travel BO view'
define root view entity zi_root_trvl_m_6
  as select from ztbl_trvl_m_6 as Travel

  composition [0..*] of zi_booking_m_6           as _Booking

  association [0..1] to /DMO/I_Agency            as _Agency        on $projection.AgencyID = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer          as _Customer      on $projection.CustomerID = _Customer.CustomerID
  association [0..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.TravelStatus = _OverallStatus.OverallStatus
  association [0..1] to I_Currency               as _Currency      on $projection.CurrencyCode = _Currency.Currency
{
  key travel_uuid           as TravelUUID,
      travel_id             as TravelID,
      agency_id             as AgencyID,
      customer_id           as CustomerID,
      begin_date            as BeginDate,
      end_date              as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee           as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price           as TotalPrice,
      currency_code         as CurrencyCode,
      description           as Description,
      overall_status        as TravelStatus,

      case overall_status
        when 'O'  then 2    -- 'open'       | 2: yellow colour
        when 'A'  then 3    -- 'accepted'   | 3: green colour
        when 'X'  then 1    -- 'rejected'   | 1: red colour
                  else 0    -- 'nothing'    | 0: unknown
      end                   as OverallStatusCriticality,

      @Semantics.largeObject:{
      mimeType: 'Mimetype',
      fileName: 'Filename',
      contentDispositionPreference: #INLINE //// THIS ANNOTATION ALLOWED TO DOWNLOAD ATTACHED FILE
      //      contentDispositionPreference: #ATTACHMENT, //// THIS ANNOTATION ALLOWED TO DOWNLOAD ATTACHED FILE
      //      acceptableMimeTypes: [ 'application/pdf' ] //// THIS ANNOTATION ALLOWED ONLY '.pdf' FILE FORMAT ATTACHMENTS
      //      acceptableMimeTypes: ['image/png', 'image/jpeg'], //// THIS ANNOTATION ALLOWED ONLY '.png / .jpeg' FILE FORMAT ATTACHMENTS
      }
      attachment            as Attachment,
      @EndUserText.label: 'File Type'
      mimetype              as Mimetype,
      @EndUserText.label: 'File Name'
      filename              as Filename,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /* associations */
      _Booking,

      _Agency,
      _Customer,
      _Currency,
      _OverallStatus

}
