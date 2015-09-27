
REPODIR="/home/mjb/src/git/REVIEWS/MANNING-GoWebProgramming-mjbright"

CHAPTER=Chapter_1
CHAPTER_DIR=Chapter_1_Go_And_Web_Applications
APP=first_webapp

# Set GOPATH for this chapter:
echo "settng GOPATH for $CHAPTER:"
export GOPATH=$REPODIR/$CHAPTER_DIR:$GOPATH

# Install the binary application:
echo "Installing the binary application: $APP"
go install $APP

echo "Running the binary application: $APP"
./Chapter_1_Go_And_Web_Applications/bin/$APP


