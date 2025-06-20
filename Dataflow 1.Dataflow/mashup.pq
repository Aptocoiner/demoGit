[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "57406052-43d6-4755-8fdd-d8cbf1fc4bc5"]}[Data]{[lakehouseId = "b3922cf3-5cec-4c35-8a29-ec9d68d527a2"]}[Data];
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Sheet1_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Sheet1 = let
  Source = Excel.Workbook(Web.Contents("https://www.dropbox.com/scl/fi/sau488ml0rbemhxbopsux/employee_data.xlsx?rlkey=bc8wzhind5g08xxa6f8zlp0eb&st=7l9kjy4s&dl=1"), null, true),
  #"Navigation 1" = Source{[Item = "Sheet1", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"ID", Int64.Type}, {"Name", type text}, {"Loc", type text}, {"Role", type text}, {"Position", type text}, {"Salary", Int64.Type}})
in
  #"Changed column type";
shared Sheet1_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "57406052-43d6-4755-8fdd-d8cbf1fc4bc5"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "b3922cf3-5cec-4c35-8a29-ec9d68d527a2"]}[Data],
  TableNavigation = Navigation_2{[Id = "Sheet1", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
