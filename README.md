# ios-assignment
Referernce https://www.geeksforgeeks.org/pattern-searching-using-suffix-tree/
** SearchDefaultImplement
Is preprare data with dictionay
=> seach with key value.

======
Another Idea to prepare data
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
