FROM ubuntu
RUN apt update
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install git -y  
