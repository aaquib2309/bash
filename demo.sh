#################################################################
# Author :- Aaquib Jawed                                        #
# Function :- This script can deploy all countries modules      #
# Usage :- Run the command /home/deployment/script/udiseplus.sh #
#################################################################

#!/bin/bash
echo -e "\e[33mThe deployment of udiseplus modules are going to start.\e[0m"
sleep 5

# Defining variable for the properties base path.
BASE_PROFILE="/home/deployment/script/properties/profile"
BASE_TEACHER="/home/deployment/script/properties/teacher"
BASE_REPORT="/home/deployment/script/properties/report"
BASE_UD="/home/deployment/script/properties/ud"
BASE_ARCHIVE="/home/deployment/script/properties/archive"

# Defining variable for war classes path.
PROFILE_CLASS="/home/udiseprofile/WEB-INF/classes/"
TEACHER_CLASS="/home/udiseteacher/WEB-INF/classes/"
REPORT_CLASS="/home/udisereport/WEB-INF/classes/"
UD_CLASS="/home/UDISE-Code/WEB-INF/classes/"
ARCHIVE_CLASS="/home/archive/WEB-INF/classes/"

# Stoping tomcat and cleaning logs etc.
pid=$(systemctl status tomcat9 | awk 'NR==6 {print $3}')
systemctl stop tomcat9 &>/dev/null
echo -e "\e[36mTomcat9 PID\e[0m: $pid"
echo -e "\e[31mTomcat9 is going down.\e[0m"

if netstat -tlnp | grep "$pid"
then
    echo -e "\e[36m$pid is listening, killing it.\e[0m"
    kill -9 "$pid"
else
    echo -e "\e[36m$pid is not listening, Proceeding for deployment.\e[0m"
fi

rm -rf /home/apache-tomcat-9.0.50/{temp,work,logs}/*
sleep 15
stop_status=$(systemctl status tomcat9 2>/dev/null | awk '/Active:/ {print $2, $9}')
echo -e "\e[35mTomcat Status\e[0m: $stop_status"

# Main Menu
echo "Choose an Option"
echo "================"
echo "1. Deploy PROFILE War"
echo "2. Deploy TEACHER War"
echo "3. Deploy REPORT War"
echo "4. Deploy UD War"
echo "5. Deploy Archive War"
echo "6. Restart TOMCAT"
echo "7. Deploy both PROFILE and TEACHER War"
echo "8. Deploy both TEACHER and REPORT War"
echo "9. Deploy both PROFILE and REPORT War"
echo "10. Deploy all PROFILE, TEACHER and REPORT war"

# Defining variable as 'option' to store your choice.
read -p "Enter your choice between (1-10): " option
case $option in

# Profile deployment
1)  echo -e "\e[34mDeploying PROFILE War.\e[0m"
    rm -rf /home/udiseprofile/*
    unzip -d /home/udiseprofile/ /home/vikas/udise_profile.war &>/dev/null
    cp "$BASE_PROFILE/upload.properties" "$PROFILE_CLASS"
    cp "$BASE_PROFILE/jdbc.properties" "$PROFILE_CLASS"
    ;;

# Teacher deployment
2)  echo -e "\e[34mDeploying TEACHER War.\e[0m"
    rm -rf /home/udiseteacher/*
    unzip -d /home/udiseteacher/ /home/vikas/NUDISE-Teacher.war &>/dev/null
    cp "$BASE_TEACHER/upload.properties" "$TEACHER_CLASS"
    cp "$BASE_TEACHER/jdbc.properties" "$TEACHER_CLASS"
    ;;

# Report deployment
3)  echo -e "\e[34mDeploying REPORT War.\e[0m"
    rm -rf /home/udisereport/*
    unzip -d /home/udisereport/ /home/vikas/NUDISE-REPORT.war &>/dev/null
    cp "$BASE_REPORT/upload.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/jdbc.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg.xml" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg2.xml" "$REPORT_CLASS"
    ;;

# UD deployment
4)  echo -e "\e[34mDeploying UD War.\e[0m"
    rm -rf /home/UDISE-Code/*
    unzip -d /home/UDISE-Code/ /home/mohit/UD.war &>/dev/null
    cp "$BASE_UD/upload.properties" "$UD_CLASS"
    cp "$BASE_UD/jdbc.properties" "$UD_CLASS"
    ;;

# Archive deployment
5)  echo -e "\e[34mDeploying ARCHIVE War.\e[0m"
    rm -rf /home/archive/*
    unzip -d /home/archive/ /home/vikas/NUDISE-Archive.war &>/dev/null
    cp "$BASE_ARCHIVE/upload.properties" "$ARCHIVE_CLASS"
    cp "$BASE_ARCHIVE/jdbc.properties" "$ARCHIVE_CLASS"
    ;;

# Tomcat restart
6)  echo -e "\e[34mRestarting TOMCAT.\e[0m"
    ;;

# Profile & Teacher deployment at the same time
7)  echo -e "\e[34mDeploying PROFILE and TEACHER War.\e[0m"
    rm -rf /home/udiseprofile/*
    unzip -d /home/udiseprofile/ /home/vikas/udise_profile.war &>/dev/null
    cp "$BASE_PROFILE/upload.properties" "$PROFILE_CLASS"
    cp "$BASE_PROFILE/jdbc.properties" "$PROFILE_CLASS"
    echo -e "\e[35mPROFILE Deployed.\e[0m"

    sleep 2

    rm -rf /home/udiseteacher/*
    unzip -d /home/udiseteacher/ /home/vikas/NUDISE-Teacher.war &>/dev/null
    cp "$BASE_TEACHER/upload.properties" "$TEACHER_CLASS"
    cp "$BASE_TEACHER/jdbc.properties" "$TEACHER_CLASS"
    echo -e "\e[35mTEACHER Deployed.\e[0m"
    ;;

# Teacher & Report deployment at the same time
8)  echo -e "\e[34mDeploying TEACHER and REPORT War.\e[0m"
    rm -rf /home/udiseteacher/*
    unzip -d /home/udiseteacher/ /home/vikas/NUDISE-Teacher.war &>/dev/null
    cp "$BASE_TEACHER/upload.properties" "$TEACHER_CLASS"
    cp "$BASE_TEACHER/jdbc.properties" "$TEACHER_CLASS"
    echo -e "\e[35mTEACHER Deployed.\e[0m"

    sleep 2

    rm -rf /home/udisereport/*
    unzip -d /home/udisereport/ /home/vikas/NUDISE-REPORT.war &>/dev/null
    cp "$BASE_REPORT/upload.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/jdbc.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg.xml" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg2.xml" "$REPORT_CLASS"
    echo -e "\e[35mREPORT Deployed.\e[0m"
    ;;

# Profile & Report deployment at the same time
9)  echo -e "\e[34mDeploying PROFILE and REPORT War.\e[0m"
    rm -rf /home/udiseprofile/*
    unzip -d /home/udiseprofile/ /home/vikas/udise_profile.war &>/dev/null
    cp "$BASE_PROFILE/upload.properties" "$PROFILE_CLASS"
    cp "$BASE_PROFILE/jdbc.properties" "$PROFILE_CLASS"
    echo -e "\e[35mPROFILE Deployed.\e[0m"

    sleep 2

    rm -rf /home/udisereport/*
    unzip -d /home/udisereport/ /home/vikas/NUDISE-REPORT.war &>/dev/null
    cp "$BASE_REPORT/upload.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/jdbc.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg.xml" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg2.xml" "$REPORT_CLASS"
    echo -e "\e[35mREPORT Deployed.\e[0m"
    ;;

# Profile, Teacher and Report all module deployment at the same time.
10)  echo -e "\e[34mDeploying all PROFILE, TEACHER and REPORT.\e[0m"
    rm -rf /home/udiseprofile/*
    unzip -d /home/udiseprofile/ /home/vikas/udise_profile.war &>/dev/null
    cp "$BASE_PROFILE/upload.properties" "$PROFILE_CLASS"
    cp "$BASE_PROFILE/jdbc.properties" "$PROFILE_CLASS"
    echo -e "\e[35mPROFILE Deployed.\e[0m"

    sleep 2

    rm -rf /home/udiseteacher/*
    unzip -d /home/udiseteacher/ /home/vikas/NUDISE-Teacher.war &>/dev/null
    cp "$BASE_TEACHER/upload.properties" "$TEACHER_CLASS"
    cp "$BASE_TEACHER/jdbc.properties" "$TEACHER_CLASS"
    echo -e "\e[35mTEACHER Deployed.\e[0m"

    sleep 2

    rm -rf /home/udisereport/*
    unzip -d /home/udisereport/ /home/vikas/NUDISE-REPORT.war &>/dev/null
    cp "$BASE_REPORT/upload.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/jdbc.properties" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg.xml" "$REPORT_CLASS"
    cp "$BASE_REPORT/hibernate.cfg2.xml" "$REPORT_CLASS"
    echo -e "\e[35mREPORT Deployed.\e[0m"
    ;;

esac
sleep 10

# Starting Tomcat
echo -e "\e[32mTomcat9 is starting.\e[0m"
systemctl start tomcat9 &>/dev/null
sleep 5

start_status=$(systemctl status tomcat9 2>/dev/null | awk '/Active:/ {print $2, $9}')
echo -e "\e[35mTomcat Status\e[0m: $start_status"

echo -e "\e[33mDeployment Completed please check the application.\e[0m"
