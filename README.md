
# Hello World Script 

![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/YagoBiermann/hello-world-script?style=flat-square)     ![GitHub commit activity](https://img.shields.io/github/commit-activity/y/YagoBiermann/hello-world-script?style=flat-square) ![powershell: v5.1 (shields.io)](https://img.shields.io/badge/powershell-v5.1-blue?style=flat-square&logo=appveyor) ![status: in development (shields.io)](https://img.shields.io/badge/status-in%20development-orange?style=flat-square&logo=appveyor) ![GitHub](https://img.shields.io/github/license/YagoBiermann/hello-world-script?style=flat-square)
___
> **Script that draw "Hello World" in GitHub contributions.** 
![Imgur](https://i.imgur.com/EMsrdhC.png)
___
## Go to specific section
[Overview](#overview) / [Known issues and future features](#Known-issues-and-future-features) / [Installation guide](#installation-guide) / [License](#license)


# Overview 
- ### What is this project?
This is a script made in powershell that will draw "hello world" in github contributions throughout 2021. ~~if it works~~

- ### And how it works?
Basically, it does automatic commits when the current day reach out a date in the json file. For each commit it write a number into *commits.txt* that represents each of times the script made a commit.

- ### Got it! but...How it's going to impact the world and how relevant this is for our community?
Good question little boy! unfortunately it does not change the millions tons of carbon dioxide that's emitted daily in the atmosphere and not find automatically all the vulnerabilities of security on your website. I just did it because everytime i saw this table of contributions i thought to myself *"this is a really good place to do a pixel art"*, and i never see anybody doing it before.

# Known issues and future features
### issues

 - If the computer or network is off the script is unable to do his job
 - If you make commits out of the dates in json file your drawing will be harmed

### fetures
 - [ ] Create a version to linux
 - [ ] Develop a web page to create custom arts
 - [ ] ~~Find out a vulnerability that allow to commit everything in one time, without waiting for an entire year~~ i'm just kidding :trollface:

# Installation guide
### *Important!*
*it was only tested on Windows 10 with powershell 5.1*
##
### Step one
- First of all, create an empty repository on your github account
- **Do not fork or clone the project, download as zip instead.** **[Download here](https://github.com/YagoBiermann/hello-world-script/archive/v1.0.zip)**
- After downloaded as zip, extract the files and open git bash inside the directory
### Step two
// type the commands in your git bash terminal, where have the '< >' you must replace with your own configuration name

    git init; git add .; git commit -m "first commit"
    git branch -M main
    git remote add origin https://github.com/<YourName>/<YourRepo>
    git push -u origin main

### Step three
- Now you need to configure a scheduled task on Windows 10 to run the script everyday in a specific time
- For this, press **Windows key + R** and type it **taskschd.msc**

![open taskschd.msc](https://i.imgur.com/vxqRqeN.png)

- On top right corner, select **create basic task**

![create basic task](https://i.imgur.com/AbZNHIX.png)

- Type the name and description

![HelloWorld-Script](https://i.imgur.com/MxJZKMX.png)

- in the trigger tab, select **daily**, then change the hour to one that your pc is on

![task trigger](https://i.imgur.com/41zYcox.png)

- In the next tab, select **Start a program** and enter the follow:
- *Program/Script:* **powershell.exe**
- *Add arguments:* **"-ExecutionPolicy Bypass -File C:\\path\\to\\directory\\main.ps1"**
- *Start in:* **C:\\path\\to\\directory\\**
**important**: Don't put double quotes in field *Start in*

![start a program](https://i.imgur.com/KAcBOUG.png)
- and finally finish the program
> if everything goes as expected Windows going to run the script everyday at the time you chose.
> So, the script will check if the date on your system is the same of your json file, if it is, the script will make the commit and push to your remote repository
# License
Do whatever you want! **MIT License**
