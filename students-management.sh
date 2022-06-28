#!/bin/bash

reNumber="^[0-9]+$"
OLDIFS=$IFS
DB_FILE=students.txt

function to_lower_case() {
    echo "$1" | tr "[:upper:]" "[:lower:]"
}

function confirm() {
    local answer
    while true; do
        read -p "$1 (y|n) " answer
        answer=$(to_lower_case $answer)
        case $answer in
            y | yes)
                answer=yes
                break
            ;;
            n | no)
                answer=no
                break
            ;;
        esac
    done
    echo $answer
}

function get_all_students() {
    cat $DB_FILE
}

function get_students_by_course() {
    local course
    course=$(to_lower_case $1)
    grep $course $DB_FILE
}

function search_students() {
    sed -n "/$1/{p;}" $DB_FILE
}

function create_student() {
    local firstname=$1 lastname=$2 email=$3 course=$4 lastline nextid id=0 rest
    if [[ -f $DB_FILE ]]; then
        lastline=$(tail -n 1 $DB_FILE)
        if [[ ! -z $lastline ]]; then
        read -r id rest <<< $lastline
        fi
    fi
    nextid=$((id + 1))
    echo $nextid $firstname $lastname $email $course >> $DB_FILE
    echo $nextid
}

function update_student() {
    local student array length update updated_student answer
    student=$(sed -n "/^$1[[:blank:]]/{p;q;}" $DB_FILE)
    [[ -z $student ]] && return 1
    read -a array <<< $student
    echo "Updating student (enter to preserve current value)..."
    length=${#array[@]}
    for (( i=1; i<length; i++ )); do
        echo "Current: ${array[$i]}"
        read -p "Update: " update
        [[ ! -z $update ]] && array[$i]=$update
    done
    answer=$(confirm "Confirm update?")
    if [[ $answer == yes ]]; then
        updated_student="${array[@]}"
        sed -i "/^${id}[[:blank:]]/c\\${updated_student}" $DB_FILE
        echo $updated_student
    fi
}

function delete_student() {
    local id=$1 answer
    answer=$(confirm "Confirm delete?")
    [[ $answer == yes ]] && sed -i "/^${id}[[:blank:]]/{d;}" $DB_FILE
}

while true; do
cat <<EOF
Students Record Management

  Options:
  1) Show list of students
  2) Add new student
  3) Update student
  4) Delete student
  5) Show list of students for a course
  6) Search for a students using ID, name or email
  0) Exit

EOF
    read -r -p "Select an option:" option
    case $option in
        1)  get_all_students
        ;;
        2)  read -p "Student info (firstname lastname email course): " firstname lastname email course
            create_student $firstname $lastname $email $course
        ;;
        3)  read -p "Student ID: " id
            update_student $id
            [[ $? == 1 ]] && echo "Not found"
        ;;
        4)  read -p "Student ID: " id
            delete_student $id
        ;;
        5)  read -p "Course name: " course
            get_students_by_course $course
        ;;
        6)  read -p "Search: " word
            search_students $word
        ;;
        0)  echo "Good bye"; exit
        ;;
        *)  echo "Invalid option ${option}"
        ;;
    esac
done