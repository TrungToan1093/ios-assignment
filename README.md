# ios-assignment
Flow of control
I/ PREPARE DATA
1. Fetch data from json local file, reponse data: [CityModel] 
 class: FetchDataService
2. Prepare data:
   .Sort data alphabetical
   .Prepare data with SuffixReferenceService (class: SuffixReferenceService.swift)
(**)The logic of prepare data from SuffixReferenceService:
-Group data form list CityModel via City's name, Country's name.
 input: [CityModel]
 output: [String: [CityModel]]
 
-HandlerRelatedCitydData form each item of City's group and Country's.
input: key: String, cities: [CityModel], related: inout [String: SearchCityModel],
output: [String: SearchCityModel]
Using relaredModel for searching  with name,
Using relaredCountryModel for searching with country
idea of SuffixReferenceService
Referernce https://www.geeksforgeeks.org/pattern-searching-using-suffix-tree/
**SuffixReferenceService
[ABC, ABCD, ACD, BCD, BDE]
=> "A": [ABC, ABCD, ACD]
      => "AB": [ABC, ABCD]
               => "ABC": [ABC, ABCD]
                        => "ABCD": [ABCD]
      => "AC": [ACD]      
   "B": [BCD, BDE]
      => "BC": [BCD]
              => "BCD" [BCD]
      => "BD": [BDE]
              => "BCD"
"JSON expect"

[ { "A" : { 
 "KEY" : "A"
 "VALUE":  ["ABC", "ABCD", "ACD"]
 "RELATED" : [ { "AB" : {  "KEY" : "AB", "VALUE": [ABC, ABCD] , "RELATED"}]
}
}]
SearchCityModel {
KEY: String
VALUE: [CityModel]
RELATED: [String: SearchCityModel]
}

II/ Search flow. (SearchSufixImplement.swift)
When user type/paste into searchTextfield.
Ex: "ABC"
var currentSearchCityModel : [String: SearchCityModel]
var resultSearch: SearchCityModel?
FLow:
resultSearch = currentSearchCityModel["A"]
resultSearch = resultSearch.related["AB"]
resultSearch = resultSearch.related["AB"]

data to display is: resultSearch.value

III/ UI Flow
1/Show init viewcontroller include activityView and "Please wait..." label. After 5 seconds prepare data.
2/ After data was prepared. Show test button to go to CitiesViewController.
3/Type search.
  Select item to go to MapviewController
