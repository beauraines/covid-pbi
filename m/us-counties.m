// us-counties
let
    Source = Csv.Document(Web.Contents("https://github.com/nytimes/covid-19-data/blob/master/us-counties.csv?raw=true"),[Delimiter=",", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"date", type date}, {"county", type text}, {"state", type text}, {"fips", Int64.Type}, {"cases", Int64.Type}, {"deaths", Int64.Type}}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Changed Type", "state", "state - Copy"),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Duplicated Column", "county", "county - Copy"),
    #"Merged Columns" = Table.CombineColumns(#"Duplicated Column1",{"state - Copy", "county - Copy"},Combiner.CombineTextByDelimiter("", QuoteStyle.None),"StateCounty")
in
    #"Merged Columns"
