# Dr. Shortener: URL Shortener Tool

### Authors
* [Daniela Vignau (A01021698)](https://github.com/dvigleo)
* [Héctor Reyes (A01339607)](https://github.com/hreyesm)

## Project Description
The aim of this project is to create a Racket executable script that takes any URL as an argument and then generates and stores a shortened version of it. A command-line interface is provided such that when a user enters a previously shortened URL, the script will trigger a browser window whose content is associated with its corresponding long URL.

Dr. Shortener attempts to emulate the basic functionality of existing URL shortening software such as Bitly, TinyURL, among others. Such a tool can be quite useful when dealing with long, hard-to-remember URLs. Consider, for example, the following URL for the “Pairs, Lists, and Racket Syntax” section in the Racket documentation:

<p align=center>https://docs.racket-lang.org/guidePairs__Lists__and_Racket_Syntax.html</p>
 
With Dr. Shortener, the above URL can be shortened to the following six-character URL (excluding headers):

<p align=center>https://dr.sh/dQNH23</p>

Please note that the generated URL is only usable within the scope of the script. It will not open a browser tab when introduced in a search bar directly, but only as a command-line argument.

## Installation (Linux)

### Requirements

* [Racket](https://download.racket-lang.org/all-versions.html) (7.8 or above)
* Racket packages:
    * [koyo](https://pkgs.racket-lang.org/package/koyo-lib)
    * [net-lib](https://pkgs.racket-lang.org/package/net-lib)

### Step-by-step Instructions
1. Download and install Racket
2. Locate the terminal in any desired directory
3. Clone the project's repository by entering the following command:
```
git clone https://github.com/hreyesm/dr-shortener.git
```
4. Move to the repository directory in the terminal
5. Install koyo library with all of its dependencies by entering the following command:
```
raco pkg install koyo
```
6. Likewise, install net-lib library:
```
raco pkg install net-lib
```
7. Make sure the interpreter path location is correct by entering the following command and copying and pasting the path after the shebang (#!):
```
which racket
```

## Usage

Enter one of the following commands for help on executing the program:
```c
./dr-shortener -h
./dr-shortener --help
```
Run the program by entering either a `-o`/`--open` flag followed by a shortened URL to open its corresponding webpage or a `-n`/`--new` flag followed by a long URL to create a new shortened URL.
```c
./dr-shortener -n https://download.racket-lang.org/all-versions.html
./dr-shortener -o https://dr.sh/0a5afa
```

### Potential Errors

#### Bad Syntax: Expected pair but given ()
1. Erase the current "database.csv" file
2. Create a new CSV file with the name "database.csv"

## Project Overview
The project uses a CSV file to store the key-value pairs of a long URL and a short URL. It makes use of lists (in the form of pairs) to represent and manipulate the pairs generated in the program and reads through the file in a recursive manner.

### Main Methods
* **(open-url short):** Takes a short URL in the form of a string as a parameter and verifies if the input string exists in the database.csv file. If it exists,  it immediately opens the default browser with the corresponding original long URL. Otherwise, it prints in the console that the URL was not found.
* **(new-url long):** Takes a long URL in the form of a string as a parameter and verifies if the input string exists in the dr-shortener.csv file. If it does not exist, it generates a short url and stores the new key-value pair in the file. Otherwise, it prompts the user to select one of the two options displayed: 1) Overwriting the existing short URL, or 2) Create a new key-value pair.
* **(overwrite-pair line):** Takes as an input the line to overwrite, which includes the key-value pair. The function is triggered if the user chooses option 1 when creating a new-url, as previously mentioned. It then searches the file for the value associated with a key to be overwritten and performs the operation by simply overwriting the value. It prints the new short URL associated with the original URL. 
* **(store-new-pair pair):** Takes as an input a list with two elements corresponding to the key-value pair to insert to the file. It prints the newly generated key-value pair in the console.
* **(generate-short):** Generates a random alphanumeric string of length 6 and appends the header "https://dr.sh/" to the string.

## References
* Warren, J. (2018). Making a Racket Command Line Program. Retrieved on November 5 2020, from: https://jackwarren.info/posts/guides/racket/racket-command-line/
* Exercises solved using Racket during semester August-December 2020, in the class Programming Languages (TC2006.1) taught by Dr. Gilberto Echevería Furió
