
REPODIR="/home/mjb/src/git/REVIEWS/MANNING-GoWebProgramming-mjbright"

buildNApps() {
    CHAPTER=$1;     shift
    CHAPTER_DIR=$1; shift

    # Set GOPATH for this chapter:
    echo "settng GOPATH for $CHAPTER:"
    export GOPATH=$REPODIR/$CHAPTER_DIR:$GOPATH

    APPs=$(ls -1 $CHAPTER_DIR/src/)
    for APP in $APPs;do
        # Install the binary application:
        echo "Installing the binary application: $APP"
        go install $APP
    done
}

build1App() {
    CHAPTER=$1;     shift
    CHAPTER_DIR=$1; shift
    APP=$1;         shift

    # Set GOPATH for this chapter:
    echo "settng GOPATH for $CHAPTER:"
    export GOPATH=$REPODIR/$CHAPTER_DIR:$GOPATH

    # Install the binary application:
    echo "Installing the binary application: $APP"
    go install $APP
}

run1App() {
    CHAPTER=$1;     shift
    CHAPTER_DIR=$1; shift
    APP=$1;         shift

    echo "Running the binary application: $APP"
    ./$CHAPTER_DIR/bin/$APP
}

buildChapter1() {

    # Set GOPATH for this chapter:
    echo "settng GOPATH for $CHAPTER:"
    export GOPATH=$REPODIR/$CHAPTER_DIR:$GOPATH

    # Install the binary application:
    echo "Installing the binary application: $APP"
    go install $APP

    echo "Running the binary application: $APP"
    ./$CHAPTER_DIR/bin/$APP
}

buildChapter2() {
    CHAPTER=Chapter_2
    CHAPTER_DIR=Chapter_2_Go_ChitChat
    APP=chitchat

    # Set GOPATH for this chapter:
    echo "settng GOPATH for $CHAPTER:"
    export GOPATH=$REPODIR/$CHAPTER_DIR:$GOPATH

    # Install the binary application:
    echo "Installing the binary application: $APP"
    go install $APP

    echo "Running the binary application: $APP"
    ./$CHAPTER_DIR/bin/$APP
}

while [ ! -z "$1" ];do
    case $1 in
        #1) buildChapter1;;
        #2) buildChapter2;;
        1) build1App Chapter_1 Chapter_1_Go_And_Web_Applications first_webapp;
           run1App   Chapter_1 Chapter_1_Go_And_Web_Applications first_webapp;;

        2)
           go get github.com/lib/pq;
           build1App Chapter_2 Chapter_2_Go_ChitChat chitchat;
           cd Chapter_2_Go_ChitChat/src/chitchat/;
           ../../bin/chitchat;
           ;;

        3)
           go get github.com/julienschmidt/httprouter;
           buildNApps Chapter_3 Chapter_3_Handling_Requests
           ;;

        4) buildNApps Chapter_4 Chapter_4_Processing_Requests;;
        5) buildNApps Chapter_5 Chapter_5_Displaying_Content;;

        6)
           go get github.com/jinzhu/gorm;
           go get github.com/jmoiron/sqlx;
           buildNApps Chapter_6 Chapter_6_Storing_Data;;

        *) echo "$0: Error unknown chapter <$1>" >&2; exit 1;;
    esac

    shift
done

