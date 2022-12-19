#print working directory
echo "Print working directory"
pwd

#go to root folder
echo "Go to root folder"
cd

# code to code folder or create it if it does not exist
echo "Potentially run mkdir code if it does not exist"
if [[ -d "code" ]]; then
    echo "code folder exists, entering it"
    cd "code"
else
    mkdir "code"
    cd "code"
fi

#list files in folder
echo "List files in folder"
ls

#create a folder named code and go to it
echo "Create a folder named code and go to it"
if [[ -d "code" ]]; then
    echo "code folder exists, entering it"
    cd "code"
else
    mkdir "code"
    cd "code"
    
fi

#create a folder named command_line_tutorial and go to it
echo "Create a folder named command_line_tutorial and go to it"
if [[ -d "command_line_tutorial" ]]; then
    echo "command_line_tutorial folder exists, entering it"
    cd "command_line_tutorial"
else
    echo "command_line_tutorial folder does not exist, creating it"
    mkdir "command_line_tutorial"
    cd "command_line_tutorial"
fi

#create a file called myfile.txt
echo "Create a file called myfile.txt"
touch "myfile.txt"

#write 'Hello World!' in myfile.txt
echo "Write 'Hello World!' in myfile.txt"
echo 'Hello World!' >> myfile.txt

# create 100 files named myfile1.txt, myfile2.txt, myfile3.txt, etc. and write a line in each of them
echo "Create 100 files named myfile1.txt, myfile2.txt, myfile3.txt, etc. and write a line in each of them"
for i in {1..100}; do echo "This is file number $i" > myfile$i.txt; done


#Add a line to the above created file
echo "Add a line to the above created file"
echo 'This is added to the file because of >>, otherwise > overwrites' >> myfile.txt

#count the number of files in the folder
echo "Count the number of files in the folder"
ls | wc -l

# grep all files that are in 90-100 range
echo "Grep all files that are in 90-100 range"
ls | grep "myfile[9][0-9].txt"

#copy myfile.txt into a file named myfilecopy.txt
echo "Copy myfile.txt into a file named myfilecopy.txt"
cp myfile.txt myfilecopy.txt

#remove all files that start with myfile
echo "Remove all files that start with myfile"
rm myfile*

#go to folder parent 
echo "Go to folder parent"
cd ..

#remove folder created for this tutorial
echo "Remove folder created for this tutorial"
rmdir command_line_tutorial