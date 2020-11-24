# Dr. Shortener: URL Shortener Tool

### Authors
* [Daniela Vignau (A01021698)](https://github.com/dvigleo)
* [Héctor Reyes (A01339607)](https://github.com/hreyesm)

## Project Description
The aim of this project is to create a Racket executable script that takes any URL as an argument and then generates and stores a shortened version of it. A command-line interface will be provided such that when a user enters a previously shortened URL, the script will trigger a browser window whose content is associated with its corresponding long URL.

Dr. Shortener attempts to emulate the basic functionality of existing URL shortening software such as Bitly, TinyURL, among others. Such a tool can be quite useful when dealing with long, hard-to-remember URLs. Consider, for example, the following URL for the “Pairs, Lists, and Racket Syntax” section in the Racket documentation:

```
https://docs.racket-lang.org/guidePairs__Lists__and_Racket_Syntax.html
```` 
 
With Dr. Shortener, the above URL can be shortened to the following six-character URL (excluding headers):

```
https://dr.sh/dQNH23
```

## Installation
* The following is a list of requirements needed for the project to * run
* A computer with either Linux or MacOS
* Racket v 7.8
* Racket packages:
    * koyo
    * net-lib
* Github repository: https://github.com/hreyesm/dr-shortener

### Requirements
### Step-by-step-instructions
1. Download and install Racket https://download.racket-lang.org/all-versions.html
2. Locate the terminal in any desired directory
3. Clone the project’s repository by inputting the following command
```
git clone https://github.com/hreyesm/dr-shortener.git
```
4. Move to the repository directory in the terminal
5. Install koyo library
```
raco pkg install koyo
```
And follow the instructions in the terminal
6. Likewise, install net-lib library
```
raco pkg install  net-lib
```
7. Type in the following command
```
chmod a+x greeting
```
8. Run one of the following commands to know how to execute the program
```
./dr-shortener -h

./dr-shortener --help
```
9. Run the program by inputting either a -o flag (to open a previously shortened URL) or with a -n flag to create a new shortened URL.
```
./dr-shortener -n https://download.racket-lang.org/all-versions.html
./dr-shortener -o https://dr.sh/0a5afa
```

## Project overview
The project uses a comma-separated values (CSV) file to store the key-value pairs of a long URL and a short URL. It makes use of lists (in the form of pairs) to represent and manipulate the pairs generated in the program and reads through the file in a recursive manner.
### Main program methods
```
(define (open-url short)...)
```
It is one of the main functions in the program. It takes a short URL in the form of a string as a parameter, it verifies if the input string exists in the dr-shortener.csv file. If it exists, then it immediately opens the default browser with the corresponding original long URL. Otherwise, it prints in the console that the URL was not found.

```
(define (new-url long)...)
```
It is the second main function in the program. It takes a long UR in the form of a string as a parameter. It verifies if the input string exists in the dr-shortener.csv file. If it does not exist, then it generates a short url and stores the new key-value pair in the file. If it does exist, then it prompts the user for an input and select one of the two options displayed: 1) Overwriting the existing short URL, or 2) Create a new key-value pair.

```
(define (overwrite-pair line)...)
```
The function takes as an input the line to overwrite, which includes the key-value pair. The function is triggered if the user chooses option 1 when creating a new-url (previously mentioned). It searches in the file, for the value associated with a key to be overwritten and performs the operation by simply overwriting the value. It prints the new short-URL associated with the original URL. 

```
(define (store-new-pair pair)...)
```
Takes as an input a list with two elements corresponding to the key-value pair to insert to the file. It prints the newly generated key-value pair in the console.

```
(define (generate-short)...)
```
It generates a 6-character long random string and appends the header to the string. The header is "https://dr.sh/".

## References
Warren, J. (2018). Making a Racket Command Line Program. Retrieved on November 5 2020, from: https://jackwarren.info/posts/guides/racket/racket-command-line/

Exercises solved using Racket during semester August-December 2020, in the class Programming Languages (TC2006.1) taught by Dr. Gilberto Echevería Furió
