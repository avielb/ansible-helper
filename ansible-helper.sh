#!/bin/bash

if [ -z $WORKSPACE ]; then
    WORKSPACE=`pwd`
fi

if [ -z $EDITOR ]; then
    EDITOR="vim"
    export EDITOR
fi
function create_role() {
    echo "mkdir $WORKSPACE/roles/$1"
    echo "mkdir $WORKSPACE/roles/$1/tasks"
    echo "touch $WORKSPACE/roles/$1/tasks/main.yml"
    echo "mkdir $WORKSPACE/roles/$1/handlers"
    echo "touch $WORKSPACE/roles/$1/handlers/main.yml"
    echo "mkdir $WORKSPACE/roles/$1/templates"
    echo "mkdir $WORKSPACE/roles/$1/files"
    echo "mkdir $WORKSPACE/roles/$1/vars"
    echo "touch $WORKSPACE/roles/$1/vars/main.yml"
    echo "mkdir $WORKSPACE/roles/$1/defaults"
    echo "mkdir $WORKSPACE/roles/$1/vars"
    echo "$EDITOR   $WORKSPACE/roles/$1/tasks/main.yml"
}

function delete_role(){
    echo "rm -rf $WORKSPACE/roles/$1"
}

function list_roles(){
    echo "ls $WORKSPACE/roles"
}

function edit_role(){
    echo "$EDITOR $WORKSPACE/roles/$1/tasks/main.yml"
}

function display_banner() {
    echo "Ansible Helper"
    echo -e "--------------"
    echo -e "Set WORKSPACE env variable so that all the files will be created there\n"
    echo -e "usage: ./ansible-helper.sh <command> [argument]"
    echo -e "commands:"
    echo -e "\t--delete-role|-d <role_name>"
    echo -e "\t--edit-role|-e <role_name>"
    echo -e "\t--create-role|-c <role_name>"
    echo -e "\t--list-role|-l"
    echo -e "\t--module-info|-i"
    echo -e "\t--help"
    echo -e "\t--version"
}

function get_help() {

    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "http://docs.ansible.com/ansible/$1_module.html"
}

filename=default
while (( $# > 0 ))
do
    opt="$1"
    arg1="$2"
    shift

    case $opt in
    --delete-role|-d)
        if [[ $arg1 =~ ^[a-zA-Z_]+$ ]]; then
            delete_role $arg1 
        else
            echo "ansible-helper $opt : Role name could be only small letters, capital letters and '_'"
            exit 1
        fi
        exit 0
        ;;
    --edit-role|-e)
        if [[ $arg1 =~ ^[a-zA-Z_]+$ ]]; then
            edit_role $arg1 
        else
            echo "ansible-helper $opt : Role name could be only small letters, capital letters and '_'"
            exit 1
        fi
        exit 0
        ;;
    --create-role|-c)
        if [[ $arg1 =~ ^[a-zA-Z_]+$ ]]; then
            create_role $arg1 
        else
            echo "ansible-helper $opt : Role name could be only small letters, capital letters and '_'"
            exit 1
        fi
        exit 0
        ;;
    --list-role|-l)
        list_roles
        exit 0
        ;;
    --module-info|-i)
        if [[ $arg1 =~ ^[a-zA-Z_0-9]+$ ]]; then
            get_help $arg1 
        else
            echo "ansible-helper $opt : module name could be only small letters, capital letters and '_'"
            exit 1
        fi
        exit 0
        ;;
    --help)
        display_banner 
        exit 0
        ;;
    --version)
        echo "$0 version 1.0.0"
        exit 0
        ;;
    --file)  # Example with an operand
        filename="$1"
        shift
        ;;
    *)
        display_banner
        break;
        ;;
   esac

done
