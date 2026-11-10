let
    // 1. Load CSV from disk
    Source = Csv.Document(
        File.Contents("rideBookings.csv"),
        [Delimiter=",", Columns=21, Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    
    // 2. Promote Headers
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // 3. Clean quotes from IDs
    CleanedIDs = Table.TransformColumns(PromotedHeaders, {
        {"Booking ID", each if _ <> null then Text.Replace(Text.From(_), """", "") else null, type text},
        {"Customer ID", each if _ <> null then Text.Replace(Text.From(_), """", "") else null, type text}
    }),
    
    // 4. Replace literal string "null" with actual database null
    ReplacedNullStrings = Table.ReplaceValue(
        CleanedIDs, 
        "null", 
        null, 
        Replacer.ReplaceValue, 
        Table.ColumnNames(CleanedIDs)
    ),
    
    // 5. Replace nulls in Reason and Text columns with clean descriptive labels
    CleanedReasons = Table.ReplaceValue(ReplacedNullStrings, null, "Not Applicable", Replacer.ReplaceValue, {
        "Reason for cancelling by Customer",
        "Driver Cancellation Reason",
        "Incomplete Rides Reason"
    }),
    
    CleanedPayment = Table.ReplaceValue(CleanedReasons, null, "Unpaid / Cancelled", Replacer.ReplaceValue, {"Payment Method"}),
    
    // 6. Replace nulls with 0 for binary flag columns
    ReplacedFlags = Table.ReplaceValue(CleanedPayment, null, 0, Replacer.ReplaceValue, {
        "Cancelled Rides by Customer",
        "Cancelled Rides by Driver",
        "Incomplete Rides"
    }),
    
    // 7. Cast all columns to proper types
    ChangedDataTypes = Table.TransformColumnTypes(ReplacedFlags, {
        {"Date", type date},
        {"Time", type time},
        {"Booking ID", type text},
        {"Booking Status", type text},
        {"Customer ID", type text},
        {"Vehicle Type", type text},
        {"Pickup Location", type text},
        {"Drop Location", type text},
        {"Avg VTAT", type number},
        {"Avg CTAT", type number},
        {"Cancelled Rides by Customer", Int64.Type},
        {"Reason for cancelling by Customer", type text},
        {"Cancelled Rides by Driver", Int64.Type},
        {"Driver Cancellation Reason", type text},
        {"Incomplete Rides", Int64.Type},
        {"Incomplete Rides Reason", type text},
        {"Booking Value", type number},
        {"Ride Distance", type number},
        {"Driver Ratings", type number},
        {"Customer Rating", type number},
        {"Payment Method", type text}
    }),
    
    // 8. Add Business Helper Columns
    AddedHour = Table.AddColumn(ChangedDataTypes, "Hour", each Time.Hour([Time]), Int64.Type),
    
    AddedTimeSlot = Table.AddColumn(AddedHour, "Time Slot", each 
        if [Hour] >= 6 and [Hour] < 11 then "Morning Peak (6 AM - 11 AM)"
        else if [Hour] >= 11 and [Hour] < 17 then "Mid-Day (11 AM - 5 PM)"
        else if [Hour] >= 17 and [Hour] < 22 then "Evening Peak (5 PM - 10 PM)"
        else "Night (10 PM - 6 AM)", 
        type text
    ),
    
    AddedDayName = Table.AddColumn(AddedTimeSlot, "Day Name", each Date.DayOfWeekName([Date]), type text),
    AddedDayOfWeek = Table.AddColumn(AddedDayName, "Day of Week", each Date.DayOfWeek([Date], Day.Monday) + 1, Int64.Type),
    AddedDayType = Table.AddColumn(AddedDayOfWeek, "Day Type", each if [Day of Week] >= 6 then "Weekend" else "Weekday", type text),
    
    AddedDistanceBin = Table.AddColumn(AddedDayType, "Distance Category", each 
        if [Ride Distance] = null then "Unfulfilled Ride"
        else if [Ride Distance] < 5 then "Short (< 5 km)"
        else if [Ride Distance] <= 15 then "Medium (5 - 15 km)"
        else if [Ride Distance] <= 30 then "Long (15 - 30 km)"
        else "Very Long (> 30 km)", 
        type text
    )
in
    AddedDistanceBin
