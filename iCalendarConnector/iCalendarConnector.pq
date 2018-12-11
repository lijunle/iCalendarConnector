// This file contains your Data Connector logic
section iCalendarConnector;

[DataSource.Kind="iCalendarConnector", Publish="iCalendarConnector.Publish"]
shared iCalendarConnector.Feed = Value.ReplaceType(iCalendarConnectorImpl, type function (url as Uri.Type) as any);

iCalendarConnectorImpl = (url as text) =>
    let
        Source = Table.FromValue({Text.FromBinary(Web.Contents(url))}),
        #"Splited by Delimiter" = Text.Split(Source[Value]{0} as text, "BEGIN:VEVENT"),
        #"Removed Header" = List.Skip(#"Splited by Delimiter",1),
        #"Converted to Table" = Table.FromList(#"Removed Header", Splitter.SplitByNothing()),
        #"Added Event Column" = Table.AddColumn(#"Converted to Table", "Event", each CreateEvent([Column1])),
        #"Removed Columns" = Table.RemoveColumns(#"Added Event Column",{"Column1"})
    in
        #"Removed Columns";

// Data Source Kind description
iCalendarConnector = [
    Authentication = [
        Implicit = []
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
iCalendarConnector.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = iCalendarConnector.Icons,
    SourceTypeImage = iCalendarConnector.Icons
];

iCalendarConnector.Icons = [
    Icon16 = { Extension.Contents("iCalendarConnector16.png"), Extension.Contents("iCalendarConnector20.png"), Extension.Contents("iCalendarConnector24.png"), Extension.Contents("iCalendarConnector32.png") },
    Icon32 = { Extension.Contents("iCalendarConnector32.png"), Extension.Contents("iCalendarConnector40.png"), Extension.Contents("iCalendarConnector48.png"), Extension.Contents("iCalendarConnector64.png") }
];

NormalizeEventText = (EventText as text) =>
    let
        EventLines = Lines.FromText(EventText),
        Normalized = List.Accumulate(EventLines, "", (state, current) =>
            if Text.StartsWith(current, " ") or Text.StartsWith(current, "#(tab)")
            then state & " " & Text.Range(current, 1)
            else state & "#(lf)" & current)
    in
        Normalized;

CreateEvent = (EventText as text) =>
    let
        #"Normalized Text" = NormalizeEventText(EventText),
        #"Splited to Lines" = Lines.FromText(#"Normalized Text"),
        #"Removed Invalid Lines" = List.Select(#"Splited to Lines", each Text.Trim(_) <> "" and not Text.StartsWith(_, "END:")),
        #"Converted to Table" = Table.FromList(#"Removed Invalid Lines", Splitter.SplitTextByEachDelimiter({":"}, QuoteStyle.Csv, false)),
        #"Renamed Name Column" = Table.RenameColumns(#"Converted to Table", {"Column1", "Name"}),
        #"Renamed Value Column" = Table.RenameColumns(#"Renamed Name Column", {"Column2", "Value"}),
        #"Converted to Record" = Record.FromTable(#"Renamed Value Column")
    in
        #"Converted to Record";
