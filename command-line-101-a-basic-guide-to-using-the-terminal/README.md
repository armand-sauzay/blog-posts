# Command Line 101
Get started using your terminal and get one step closer to being an experienced developer.

This article lives on: 
- [Meduim](https://medium.com/@armand-sauzay/a-simple-guide-to-using-the-command-line-aka-terminal-e030dbf18afe)
- [Dev.to](https://dev.to/armandsauzay/command-line-101-a-basic-guide-to-using-the-terminal-4alo)

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/uxriuidm5qrd4bf1kznh.jpeg)
Photo by Max Duzij from Unsplash


All of the code for this tutorial can be found [here](https://github.com/armand-sauzay/blog-posts/tree/main/command-line-101-a-basic-guide-to-using-the-terminal/code).

---

Developers use the command line to navigate through file and perform operations. 

Once you get used to it, it is definitely the most efficient and reproducible way to access files and perform operations. Also, when you start virtual machines on the cloud, it becomes the only way of easily communicating with your instance. 

So, without further due, let's learn about the terminal and basic commands to get started!

In this article, we'll cover what is the command line, which commands we can use and we'll go through a simple tutorial to put those commands in practice.

---

**First, what is the command line?**

It is a plain and simple text interface for your computer. It takes commands which are then passed to the OS to run.
And which commands can we use?
The usual commands are given in the table below.

Let's now go through a small example on how to use those commands. We'll first explain commands 1 by 1 and then put them all together in a shell script that you can run.

## Step-by-step commands

1. Let's see where our terminal currently is:
    ```bash
    pwd
    ```

2. Navigate to the folder where you usually put your code (I usually have mine in a folder called `code` in your my folder)
    ```bash
    cd path/to/your/folder/of/code
    ```

    In my case for instance, I have got a `code` folder under `/Users/myusername` so I can do the following
    ```bash
    cd
    cd code
    ```

    Explanation:
        - `cd`: brings me back to my root folder
        - `cd code`: changes my working directory to code
        - An equivalent of this would be cd `~/code`

3. Go to/create a folder named command_line_tutorial and enter it
    ```bash
    echo "Create a folder named command_line_tutorial and go to it"
    if [[ -d "command_line_tutorial" ]]; then
        echo "command_line_tutorial folder exists, entering it"
        cd "command_line_tutorial"
    else
        echo "command_line_tutorial folder does not exist, creating it"
        mkdir "command_line_tutorial"
        cd "command_line_tutorial"
    fi
    ```
    Explanation:
    - `echo`: prints the string in the terminal
    - `if [[ -d "command_line_tutorial" ]]; then`: if the folder command_line_tutorial exists, then enter it
    - `else`: otherwise create it and enter it

4. Create a file called myfile.txt
    ```bash
    touch myfile.txt
    ```
    Explanation:
    - `touch`: creates a file

5. Write 'Hello World!' in the above created file
    ```bash
    echo 'Hello World!' >> myfile.txt
    ```
    Explanation:
    - `>>`: appends the string to the file


6. Add a line to the above created file
    ```bash
    echo 'This is added to the file because of >>, otherwise > overwrites' >> myfile.txt
    ```
    Explanation:
    - `>>`: appends the string to the file

7. Create 100 files named myfile1.txt, myfile2.txt, myfile3.txt, etc. and write a line in each of them
    ```bash
    for i in {1..100}; do echo "This is file number $i" > myfile$i.txt; done
    ```
    Explanation:
    - `for i in {1..100}; do`: for each number between 1 and 100, do the following
    - `echo "This is file number $i" > myfile$i.txt;`: create a file named myfile1.txt, myfile2.txt, myfile3.txt, etc. and write a line in each of them


8. Count the number of files in the folder
    ```bash
    ls | wc -l
    ```
    Explanation:
    - `ls`: list all files in the current folder
    - `|`: pipe the output of the previous command to the next command
    - `wc -l`: count the number of lines in the output of the previous command

9. grep all files that are in 90-100 range
    ```bash
    ls | grep "myfile[9][0-9].txt"
    ```
    Explanation:
    - `ls`: list all files in the current folder
    - `|`: pipe the output of the previous command to the next command
    - `grep "myfile[9][0-9].txt"`: grep all files that are in 90-100 range

10. copy myfile.txt into a file named myfilecopy.txt
    ```bash
    cp myfile.txt myfilecopy.txt
    ```
    Explanation:
    - `cp`: copy the file myfile.txt into myfilecopy.txt

11. remove all files that start with myfile
    ```bash
    rm myfile*
    ```
    Explanation:
    - `rm`: remove the file myfile.txt

12. go to folder parent 
    ```bash
    cd ..
    ```
    Explanation:
    - `cd ..`: go to the parent folder

13. remove folder created for this tutorial
    ```bash
    rmdir command_line_tutorial
    ```
    Explanation:
    - `rmdir`: remove the folder command_line_tutorial

## Let's put all these commands in a shell script
- you can delete command_line_tutorial and re run the following in order:
```bash
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

# create 100 files named myfile1.txt, myfile2.txt, myfile3.txt, etc. and write a line in each of them
echo "Create 100 files named myfile1.txt, myfile2.txt, myfile3.txt, etc. and write a line in each of them"
for i in {1..100}; do echo "This is file number $i" > myfile$i.txt; done

#write 'Hello World!' in myfile.txt
echo "Write 'Hello World!' in myfile.txt"
echo 'Hello World!' >> myfile.txt


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
```

I hope this was helpful. You now are a bash expert and can start using your terminal for automating your tasks going forward! 

## About me
Hey! 👋 I'm Armand Sauzay ([armandsauzay](https://twitter.com/armandsauzay)). You can find, follow or contact me on: 

- [Github](https://github.com/armand-sauzay) 
- [Twitter](https://twitter.com/armandsauzay)
- [LinkedIn](https://www.linkedin.com/in/armand-sauzay-80a70b160/)
- [Medium](https://medium.com/@armand-sauzay)
- [Dev.to](https://dev.to/armandsauzay)

