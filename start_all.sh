function new_tab() {
  TAB_NAME=$1
  COMMAND=$2
	osascript \
	-e "tell application \"Terminal\" " \
	-e "tell application \"System Events\" to keystroke \"t\" using {command down}" \
	-e "do script \"printf '\\\e]1;$TAB_NAME\\\a'; $COMMAND \" in front window " \
	-e "end tell" > /dev/null


	}


function deploy_api() {
   SERVICE_NAME=$1
   COMMAND=$2
osascript \
-e "tell application \"Terminal\" " \
-e "tell application \"System Events\" to keystroke \"t\" using {command down}" \
-e "do script \"$COMMAND \" in front window " \
-e "end tell" > /dev/null

}





#To start local postgres, ignnore as might not work
#pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

#To start local mysql, ignnore as might not work
#sudo -u gabraham -p {TOBEADDED} /usr/local/mysql/support-files/mysql.server start

#Method , "Service Name",  "Set of commands for that service to briung up"
new_tab "Mauth" "cd /Users/gabraham/medidata/mauth;  MAUTH_STORAGE=local bundle exec rails server -p 7000"

#Method , "Service Name",  "Set of commands for that service to briung up"
new_tab "Eureka" "cd /Users/gabraham/medidata/eureka; EUREKA_STORAGE=in_memory bundle exec rackup"

#Method , "Service Name",  "Set of commands for that service to briung up"
new_tab "iMedidata" "cd /Users/gabraham/medidata/imedidata; bundle exec rails s -p 3001"

#Method , "Service Name",  "Set of commands for that service to briung up"
new_tab "AuthMedidata" "cd /Users/gabraham/medidata/authmedidata; rails server"

new_tab "Subjects" "cd /Users/gabraham/medidata/subjects; git checkout develop; git pull ; bundle install ; bundle exec rails s -p 3000"

new_tab "Minotaur" "cd /Users/gabraham/medidata/minotaur; git checkout develop; git pull ; bundle install ; bundle exec rails s -p 3002"

new_tab "Subject_Data_Integration" "cd /Users/gabraham/medidata/subject_data_integration; git checkout develop; git pull ; bundle install ; bundle exec rails s -p 3003"

#new_tab "Redis" "cd /Users/gabraham/medidata/subject_data_integration; redis-server"

#new_tab "Sidekiq" "cd /Users/gabraham/medidata/subject_data_integration; bundle exec sidekiq"

#new_tab "Processor" "cd /Users/gabraham/medidata/subject_data_integration;  bundle exec rake processors:run['subject_data_processor']"

#new_tab "Archiver" "cd /Users/gabraham/medidata/subject_data_integration;  bundle exec rake processors:run['subject_data_archiver']"

#Method(deploying api docs) , "Service Name",  "Set of commands for that service to briung up"
deploy_api "Subjects" "cd /Users/gabraham/medidata/subjects; bundle exec rake eureka:deploy_api_docs['04_euresource.rb']"

deploy_api "iMedidata" "cd /Users/gabraham/medidata/imedidata; bundle exec rake eureka:deploy_api_docs['euresource.rb']"

deploy_api "Subjects_data_integration" "cd /Users/gabraham/medidata/subject_data_integration; bundle exec rake eureka:deploy_api_docs['04_euresource.rb']"
