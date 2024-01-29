

# a imagem do tomcat a ser usada
FROM tomcat:8.5.50-jdk8-openjdk


# a variável WAR_FILE vai receber o caminho para o arquivo .war  da aplicação
# no host, arquivo que será copiado para o container
ARG WAR_FILE

# a variável CONTEXT recebe o nome do arquivo .war que será levado para o 
# container 
ARG CONTEXT

# copiar pasta ou arquivo do host para o container
# nesse caso, copiar o arquivo da aplicação tasks.war criada na pasta 
# "<workspace_pipeline_jenkins>/frontend/target/" para a pasta do container
# "/usr/local/tomcat/webapps/", onde o tomcat faz o deploy da aplicação
COPY ${WAR_FILE} /usr/local/tomcat/webapps/${CONTEXT}.war









