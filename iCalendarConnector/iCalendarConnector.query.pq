// Use this file to write queries to test your data connector
let
    Event = iCalendarConnector.Feed("http://ical.mac.com/ical/US32Holidays.ics"),
    Serialized = Table.AddColumn(Event, "Serialized", each Text.FromBinary(Json.FromValue([Event])))
in
    Serialized
