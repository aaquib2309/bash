########################################################################################
# Author :- Aaquib Jawed                                                               #
# Function :- This script will deploy all udiseplus modules on 261 production server   #
# Usage :- Run the command /home/deployment-script/udiseplus.sh                        #
########################################################################################

#!/bin/bash
echo -e "\e[33mThe deployment of udiseplus modules are going to start on 261.\e[0m"
sleep 5

# Variable Defined
ip="root@10.217.159.251"                                                 # IP defined

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
        rm -rf /home/apache-tomcat-9.0.67/{temp,work,logs}/*
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
    rm -rf /home/udiseprofile/*
    scp -r "$ip:/home/udiseprofile/*" "/home/udiseprofile/" &>/dev/null 
}

# Function for Teacher_251
teacher_251()
{
    rm -rf /home/udiseteacher/*
    scp -r "$ip:/home/udiseteacher/*" "/home/udiseteacher/" &>/dev/null  
}

# Fuction for Report_251
report_251()
{
    rm -rf /home/udisereport/*
    scp -r "$ip:/home/udisereport/*" "/home/udisereport/" &>/dev/null
}

# Main Menu
echo "Choose an Option"
echo "================"
echo "1. Deploy PROFILE War"
echo "2. Deploy TEACHER War"
echo "3. Deploy REPORT War"
echo "4. Deploy UD War"
echo "5. Deploy Taxonomy"
echo "6. Restart TOMCAT"
echo "7. Deploy both PROFILE and TEACHER War"
echo "8. Deploy both TEACHER and REPORT War"
echo "9. Deploy both PROFILE and REPORT War"
echo "10. Deploy all PROFILE, TEACHER and REPORT war"

# Defining variable as 'option' to store your choice.
read -p "Enter your choice between (1-10): " option
case $option in

# Profile deployment
1)  echo -e "\e[34mDeploying PROFILE War on 261.\e[0m"
        stop
            sleep 15
                profile_251
            sleep 3
        start
    echo -e "\e[35mPROFILE Deployed on 261.\e[0m"
    ;;

# Teacher deployment
2)  echo -e "\e[34mDeploying TEACHER War on 261.\e[0m"
        stop
            sleep 15
                teacher_251
            sleep 3
        start
    echo -e "\e[35mTEACHER Deployed on 261.\e[0m"
    ;;

# Report deployment
3)  echo -e "\e[34mDeploying REPORT War on 261.\e[0m"
        stop
            sleep 15
                report_251
            sleep 3
        start
    echo -e "\e[35mREPORT Deployed on 261.\e[0m"
    ;;

# UD deployment
4)  echo -e "\e[34mDeploying UD War on 261.\e[0m"
        stop
            sleep 15
                rm -rf /home/UD/*
                scp -r "$ip:/home/UD/*" "/home/UD/" &>/dev/null 
            sleep 3
        start
    echo -e "\e[35mUD Deployed on 261.\e[0m"
    ;;

# Deploy Taxonomy.
5) echo -e "\e[34mDeploying TAXONOMY on 261.\e[0m"
        stop
            sleep 15
                rm -rf /home/udise-home/*
                scp -r "$ip:/home/udise-home/*" "/home/udise-home/" &>/dev/null
            sleep 3
        start
    echo -e "\e[35mTAXONOMY Deployed on 261.\e[0m"
    ;;

# Tomcat restart
6)  echo -e "\e[34mRestarting TOMCAT on 261.\e[0m"
        stop
            sleep 15
        start
    ;;

# Profile & Teacher deployment at the same time
7)  echo -e "\e[34mDeploying PROFILE and TEACHER War on 261.\e[0m"
        stop
            sleep 15
                profile_251
    echo -e "\e[35mPROFILE Deployed on 261.\e[0m"
            sleep 3
                teacher_251
        start
    echo -e "\e[35mTEACHER Deployed on 261.\e[0m"
    ;;

# Teacher & Report deployment at the same time
8)  echo -e "\e[34mDeploying TEACHER and REPORT War on 261.\e[0m"
        stop
            sleep 15
                teacher_251
    echo -e "\e[35mTEACHER Deployed on 261.\e[0m"
            sleep 3
                report_251
        start
    echo -e "\e[35mREPORT Deployed on 261.\e[0m"
    ;;

# Profile & Report deployment at the same time
9)  echo -e "\e[34mDeploying PROFILE and REPORT War on 261.\e[0m"
        stop
            sleep 15
                profile_251
    echo -e "\e[35mPROFILE Deployed on 261.\e[0m"
            sleep 3
                report_251
        start
    echo -e "\e[35mREPORT Deployed on 261.\e[0m"
    ;;

# Profile, Teacher and Report all module deployment at the same time.
10)  echo -e "\e[34mDeploying all PROFILE, TEACHER and REPORT on 261.\e[0m"
        stop
            sleep 15
                profile_251
    echo -e "\e[35mPROFILE Deployed on 261.\e[0m"
            sleep 3
                teacher_251
    echo -e "\e[35mTEACHER Deployed on 261.\e[0m"
            sleep 3
                report_251
        start
    echo -e "\e[35mREPORT Deployed on 261.\e[0m"
    ;;
esac

echo -e "\e[33mThe deployment completed on all prod server.\e[0m"
