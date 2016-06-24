set :application, "jobcorps"
set :repository, "http://www.brmurray.com/svn/jobcorps"
set :svn_username, "ausg"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
set :deploy_to, "/home/jobcorps/www/jobcorps"
set :user, "jobcorps"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :web, "jobcorps.ausg.org"
role :app, "jobcorps.ausg.org"
role :db,  "jobcorps.ausg.org", :primary => true