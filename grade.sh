CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning!'

if [ -f "student-submission/ListExamples.java" ];
then
      echo "File found!"
else 
      echo "File ListExamples.java is not found!"
      exit 1
fi

# jars
cp -r lib grading-area/
# ListExamples
cp student-submission/ListExamples.java grading-area/
# TestListExamples
cp TestListExamples.java grading-area/

cd grading-area
javac -cp $CPATH *.java

if [[ $? -ne 0 ]]
then
       echo "Program failed to compile, see compile error above"
       exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt

lastLine= $(junit-output.txt | tail -n 2 | head -n 1)
test=$(awk -F'[, ]' '(print $3)')
failures=$(awk -F'[, ]' '(print $7)'

successes=$((tests - failures))

echo "Your score is $succeses / $tests"

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
