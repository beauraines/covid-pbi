// FIPS
let
    Source = Csv.Document(Web.Contents("https://www2.census.gov/geo/docs/reference/codes/files/national_county.txt"),[Delimiter=",", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", Int64.Type}, {"Column3", Int64.Type}, {"Column4", type text}, {"Column5", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "State"}, {"Column2", "State Code"}, {"Column3", "County Code"}, {"Column4", "County"}, {"Column5", "Class Code"}})
in
    #"Renamed Columns"
