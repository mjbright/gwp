
REPODIR="/home/mjb/src/git/REVIEWS/MANNING-GoWebProgramming-mjbright"

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
        1) build1App Chapter_1 Chapter_1_Go_And_Web_Applications first_webapp;;
        2) build1App Chapter_2 Chapter_2_Go_ChitChat chitchat;
           cd Chapter_2_Go_ChitChat/src/chitchat/;
           ../../bin/chitchat;
           ;;
        3) build1App Chapter_3 Chapter_3_Handling_Requests xxx;;
        4) build1App Chapter_4 Chapter_4_Processing_Requests xxx;;
        5) build1App Chapter_5 Chapter_5_Displaying_Content xxx;;
        6) build1App Chapter_6 Chapter_6_Storing_Data xxx;;

        *) echo "$0: Error unknown chapter <$1>" >&2; exit 1;;
    esac

    shift
done


