########################################################################################
# Author :- Aaquib Jawed                                                               #
# Function :- This script will deploy all udiseplus modules on all 5 production server #
# Usage :- Run the command /home/deployment-script/udiseplus.sh                        #
########################################################################################

#!/bin/bash
echo -e "\e[33mThe deployment of udiseplus modules are going to start.\e[0m"
sleep 5

# Variable Defined
ip="10.217.159"                                                 # IP defined

profile_old="/home/udiseprofile-old/WEB-INF/classes"            # Profile properties backup
profile="/home/udiseprofile/WEB-INF/classes/"                   # Profile claas path

teacher_old="/home/udiseteacher-old/WEB-INF/classes"            # Teacher properties backup
teacher="/home/udiseteacher/WEB-INF/classes/"                   # Teacher claas path

report_old="/home/udisereport-old/WEB-INF/classes"              # Report properties backup
report="/home/udisereport/WEB-INF/classes/"                     # Report claas path

ud_old="/home/UD_old/WEB-INF/classes"                           # Ud properties backup
ud="/home/UD/WEB-INF/classes/"                                  # Ud claas path

####################
# Function Defined #
####################

# For Stoping Tomcat.
stop()
{
    pid=$(systemctl status tomcat9 | awk 'NR==6 {print $3}')
    systemctl stop tomcat9 &>/dev/null
    echo -e "\e[36mTomcat9 PID\e[0m: $pid"
    echo -e "\e[31mTomcat9 is going down.\e[0m"

    sleep 3

    if netstat -tlnp | grep "$pid"
    then
        echo -e "\e[36m$pid is listening, killing it.\e[0m"
        kill -9 "$pid"
    else
        echo -e "\e[36m$pid is not listening, Proceeding for deployment.\e[0m"
    fi
        rm -rf /home/apache-tomcat-9.0.50/{temp,work,logs}/*
        stop_status=$(systemctl status tomcat9 2>/dev/null | awk '/Active:/ {print $2, $9}')
        echo -e "\e[35mTomcat Status\e[0m: $stop_status"
}

# For Starting Tomcat.
start()
{
    echo -e "\e[32mTomcat9 is starting.\e[0m"
            systemctl start tomcat9 &>/dev/null
        sleep 5
            start_status=$(systemctl status tomcat9 2>/dev/null | awk '/Active:/ {print $2, $9}')
            echo -e "\e[35mTomcat Status\e[0m: $start_status"
    echo -e "\e[33mTomcat9 Started.\e[0m"
}

# Function for Profile_251
profile_251()
{
    rm -rf /home/udiseprofile-old/*
        mv /home/udiseprofile/* /home/udiseprofile-old/ &>/dev/null
        scp -r "$ip.247:/home/udiseprofile/*" "/home/udiseprofile/" &>/dev/null 
    cp "$profile_old/upload.properties" "$profile_old/jdbc.properties" "$profile"
}

# Function for Teacher_251
teacher_251()
{
    rm -rf /home/udiseteacher-old/*
        mv /home/udiseteacher/* /home/udiseteacher-old/ &>/dev/null
        scp -r "$ip.247:/home/udiseteacher/*" "/home/udiseteacher/" &>/dev/null 
    cp "$teacher_old/upload.properties" "$teacher_old/jdbc.properties" "$teacher"
}

# Fuction for Report_251
report_251()
{
    rm -rf /home/udisereport-old/*
        mv /home/udisereport/* /home/udisereport-old/ &>/dev/null
        scp -r "$ip.247:/home/udisereport/*" "/home/udisereport/" &>/dev/null 
    cp "$report_old/upload.properties" "$report_old/jdbc.properties" "$report"
}

# Main Menu
echo "Choose an Option"
echo "================"
echo "1. Deploy PROFILE War"
echo "2. Deploy TEACHER War"
echo "3. Deploy REPORT War"
echo "4. Deploy UD War"
echo "5. Restart TOMCAT for Taxonomy"
echo "6. Deploy both PROFILE and TEACHER War"
echo "7. Deploy both TEACHER and REPORT War"
echo "8. Deploy both PROFILE and REPORT War"
echo "9. Deploy all PROFILE, TEACHER and REPORT war"
echo "10. Revert PROFILE War"
echo "11. Rvert TEACHER War"
echo "12. Revert REPORT War"
echo "13. Revert UD War"
echo "14. Revert Taxonomy"

# Defining variable as 'option' to store your choice.
read -p "Enter your choice between (1-14): " option
case $option in

# Profile deployment
1)  echo -e "\e[34mDeploying PROFILE War on 251.\e[0m"
        stop
            sleep 15
                profile_251
            sleep 3
        start
    echo -e "\e[35mPROFILE Deployed on 251.\e[0m"
    ;;

# Teacher deployment
2)  echo -e "\e[34mDeploying TEACHER War on 251.\e[0m"
        stop
            sleep 15
                teacher_251
            sleep 3
        start
    echo -e "\e[35mTEACHER Deployed on 251.\e[0m"
    ;;

# Report deployment
3)  echo -e "\e[34mDeploying REPORT War on 251.\e[0m"
        stop
            sleep 15
                report_251
            sleep 3
        start
    echo -e "\e[35mREPORT Deployed on 251.\e[0m"
    ;;

# UD deployment
4)  echo -e "\e[34mDeploying UD War on 251.\e[0m"
        stop
            sleep 15
                rm -rf /home/UD_old/*
                    mv /home/UD/* /home/UD_old/ &>/dev/null
                    scp -r "$ip.247:/home/UDISE-Code/*" "/home/UD/" &>/dev/null 
                cp "$ud_old/upload.properties" "$ud_old/jdbc.properties" "$ud"
            sleep 3
        start
    echo -e "\e[35mUD Deployed on 251.\e[0m"
    ;;

# Tomcat restart
5)  echo -e "\e[34mRestarting TOMCAT on 251.\e[0m"
        stop
            sleep 15
        start
    ;;

# Profile & Teacher deployment at the same time
6)  echo -e "\e[34mDeploying PROFILE and TEACHER War on 251.\e[0m"
        stop
            sleep 15
                profile_251
    echo -e "\e[35mPROFILE Deployed on 251.\e[0m"
            sleep 3
                teacher_251
        start
    echo -e "\e[35mTEACHER Deployed on 251.\e[0m"
    ;;

# Teacher & Report deployment at the same time
7)  echo -e "\e[34mDeploying TEACHER and REPORT War on 251.\e[0m"
        stop
            sleep 15
                teacher_251
    echo -e "\e[35mTEACHER Deployed on 251.\e[0m"
            sleep 3
                report_251
        start
    echo -e "\e[35mREPORT Deployed on 251.\e[0m"
    ;;

# Profile & Report deployment at the same time
8)  echo -e "\e[34mDeploying PROFILE and REPORT War on 251.\e[0m"
        stop
            sleep 15
                profile_251
    echo -e "\e[35mPROFILE Deployed on 251.\e[0m"
            sleep 3
                report_251
        start
    echo -e "\e[35mREPORT Deployed on 251.\e[0m"
    ;;

# Profile, Teacher and Report all module deployment at the same time.
9)  echo -e "\e[34mDeploying all PROFILE, TEACHER and REPORT on 251.\e[0m"
        stop
            sleep 15
                profile_251
    echo -e "\e[35mPROFILE Deployed on 251.\e[0m"
            sleep 3
                teacher_251
    echo -e "\e[35mTEACHER Deployed on 251.\e[0m"
            sleep 3
                report_251
        start
    echo -e "\e[35mREPORT Deployed on 251.\e[0m"
    ;;

# Revert Profile War.
10) echo -e "\e[34mReverting PROFILE War on 251.\e[0m"
        stop
            sleep 15
                rm -rf /home/udiseprofile/*
                cp -r /home/udiseprofile-old/* /home/udiseprofile/
            sleep 3
        start
    echo -e "\e[35mPROFILE Reverted on 251.\e[0m"
    ;;

# Revert Teacher War.
11) echo -e "\e[34mReverting TEACHER War on 251.\e[0m"
        stop
            sleep 15
                rm -rf /home/udiseteacher/*
                cp -r /home/udiseteacher-old/* /home/udiseteacher/
            sleep 3
        start
    echo -e "\e[35mTEACHER Reverted on 251.\e[0m"
    ;;

# Revert Report War.
12) echo -e "\e[34mReverting REPORT War on 251.\e[0m"
        stop
            sleep 15
                rm -rf /home/udisereport/*
                cp -r /home/udisereport-old/* /home/udisereport/
            sleep 3
        start
    echo -e "\e[35mREPORT Reverted on 251.\e[0m"
    ;;

# Revert UD War.
13) echo -e "\e[34mReverting UD War on 251.\e[0m"
        stop
            sleep 15
                rm -rf /home/UD/*
                cp -r /home/UD_old/* /home/UD/
            sleep 3
        start
    echo -e "\e[35mUD Reverted on 251.\e[0m"
    ;;

# Revert Taxonomy.
14) echo -e "\e[34mReverting TAXONOMY on 251.\e[0m"
        stop
            sleep 15
                rm -rf /home/udise-home/*
                cp -r /home/udise-home-old/* /home/udise-home/
            sleep 3
        start
    echo -e "\e[35mTAXONOMY Reverted on 251.\e[0m"
    ;;

esac

echo -e "\e[33mThe deployment completed on 251 prod server.\e[0m"

