# Checkpoint 24 - Continous Integration
### Checkpoint Instructions
#### Part 1: Docker Server
* sudo apt-get update
* sudo apt-get install -y docker.io docker-compose
* sudo service docker start
#### Part 2: Jenkins Server
* cd ~/webpage_ws
* bash start_jenkins.sh
* cat /home/user/jenkins__pid__url.txt
* Webpage address displayed in the file
* User: admin
* Password: Hamza

#### Part 3: Test
* Send the output of the following command: echo "$(jenkins_address)github-webhook/"
* Create a pull request to this repository https://github.com/Hamz115/ros2_ci.git