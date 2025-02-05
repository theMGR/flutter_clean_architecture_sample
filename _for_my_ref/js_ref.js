let string = 'JavaScript';
let firstLetter = string[0];
console.log(firstLetter);
let lastIndex = string.length - 1;
console.log(lastIndex);
console.log(string[lastIndex]);

console.log(string.charAt(lastIndex));

console.log(string.charCodeAt(lastIndex));

string = '30';
console.log(string.concat("Days", "Of", "JavaScript"));
let country = 'Fin';
console.log(country.concat("land"));


string = 'Love is the best to in this world'
console.log(string.endsWith('world'))
console.log(string.endsWith('love'))

string = '30 Days Of JavaScript'
console.log(string.includes('Days'))
console.log(string.includes('days'))

string = '30 Days Of JavaScript'
console.log(string.indexOf('D'))        
console.log(string.indexOf('Days'))     
console.log(string.indexOf('days'))       
console.log(string.indexOf('a'))         
console.log(string.indexOf('JavaScript')) 
console.log(string.indexOf('Script'))
console.log(string.indexOf('script'))   

string = 'I love JavaScript. If you do not love JavaScript what else can you love.'
console.log(string.lastIndexOf('love'))      
console.log(string.lastIndexOf('you'))      
console.log(string.lastIndexOf('JavaScript'))

let firstName = 'Asabeneh'
console.log(firstName.length)

//
//match
//
// match: it takes a substring or regular expression pattern as an argument and it returns an array if there is match if not it returns null. Let us see how a regular expression pattern looks like. It starts with / sign and ends with / sign.
string = 'love'
let patternOne = /love/ // with out any flag
let patternTwo = /love/gi // g-means to search in the whole text, i - case insensitive
string = 'I love JavaScript. If you do not love JavaScript what else can you love.'
console.log(string.match('love')) //
/*
output

["love", index: 2, input: "I love JavaScript. If you do not love JavaScript what else can you love.", groups: undefined]
*/
let pattern = /love/gi
console.log(string.match(pattern)) // ["love", "love", "love"]
// Let us extract numbers from text using regular expression. This is not regular expression section, no panic.

let txt = 'In 2019, I run 30 Days of Python. Now, in 2020 I super exited to start this challenge'
let regEx = /\d/g // d with escape character means d not a normal d instead acts a digit
// + means one or more digit numbers, 
// if there is g after that it means global, search everywhere.
console.log(txt.match(regEx)) // ["2", "0", "1", "9", "3", "0", "2", "0", "2", "0"]
console.log(txt.match(/\d+/g)) // ["2019", "30", "2020"]



/////

string = 'love'
console.log(string.repeat(10))

string = '30 Days Of JavaScript'
console.log(string.replace('JavaScript', 'Python')) // 30 Days Of Python

string = 'I love JavaScript. If you do not love JavaScript what else can you love.'
console.log(string.search('love')) // 2

string = '30 Days Of JavaScript'
console.log(string.split())     // ["30 Days Of JavaScript"]
console.log(string.split(' '))  // ["30", "Days", "Of", "JavaScript"]
firstName = 'Asabeneh'
console.log(firstName.split())  // ["Asabeneh"]
console.log(firstName.split(''))  // ["A", "s", "a", "b", "e", "n", "e", "h"]
let countries = 'Finland, Sweden, Norway, Denmark, and Iceland'
console.log(countries.split(',')) // ["Finland", " Sweden", " Norway", " Denmark", " and Iceland"]
console.log(countries.split(', '))   //  ["Finland", "Sweden", "Norway", "Denmark", "and Iceland"]

string = 'Love is the best to in this world'
console.log(string.startsWith('Love')) // true
console.log(string.startsWith('love')) // false

string = 'JavaScript'
console.log(string.substr(4,6))    // Script

string = 'JavaScript'
console.log(string.substring(0,4))   // Java
console.log(string.substring(4,10))     // Script
console.log(string.substring(4)) // Script

string = 'JavasCript'
console.log(string.toLowerCase())     // javascript

string = 'JavaScript'
console.log(string.toUpperCase()) 

string = '   30 Days Of JavaScript   '
console.log(string)     // '   30 Days Of JavaScript   '
console.log(string.trim(' '))  // '30 Days Of JavaScript'
firstName = ' Asabeneh '
console.log(firstName) // ' Asabeneh '
console.log(firstName.trim())  // 'Asabeneh'

