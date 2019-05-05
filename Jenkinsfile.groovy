node {
    stage("checkout"){
        git "https://github.com/avielb/ansible-helper.git"
    }
    stage("test"){
        echo "./ansible-helper.sh sdfsdf"
    }
}
