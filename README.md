# Bash scripting assignments

## Instructions
1. Choose one of the assignment options as mentioned in the slides
2. Do the assignment and make the PR to this repos

## Assignment 1
Given a directory to code repos, print out a list of contributors name along with number of commits. If names of author are provided as arguments, return only commits for those.

Print out usage instruction if arguments are not given correctly.

Example:
```bash
./count-commits.sh ~/react-project
./count-commits.sh ~/react-project "Alex Max" "Mr. Bean"
```

The output shoul be something like:
```bash
1 Mr. A - 100
2 Mr. B - 200
3 Mr. C - 300
```

## Assignment 2
Given a directory of a React repos, count number of times a component with given name is used (the component name should be given as argument of the script & multiple names can be given)

Print out usage instruction if arguments are not given

Example:
```bash
./component-count.sh Button Header Footer
```

The output should be like:
```bash
1 Button - 10
2 Header - 2
3 Footer - 1
```

## Assignment 3
Given a name (or names) of a country, print out information about the country name, population, capital, and languages. The name should be argument of the script (hint: use jq for parsing json)

Print out usage instruction if arguments are not given.

Example:
```bash
./country.sh Vietnam Finland
```

The output should be like:
```bash
1 Name: Vietnam
2 Capital: Hanoi
3 Population: 92700000
4 Languages: Vietnamese
5
6 Name: Finland
7 Capital: Helsinki
8 Population: 5491817
9 Languages: Finnish, Swedish
```

## Extra assignment
Implement a student record management using Bash
* The script should show a list of options for user:
	- Show list of students
	- Add new students
	- Update students
	- Delete students
	- Show list of students for a course
	- Search for a students using ID, name or email
* Each student has following info:
	- A unique ID which is a number
	- First name, last name
	- Email address
	- Course name
* All the data should be saved to a file