# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
set :output, "/home/angel/logs/webllorens/cron_log.log"

every 30.minutes do
  rake "pdfer:match_empty"
end

every 3.minutes do
	runner "IncidenciasMailer.delay.listado_incidencias"
end

set :output, {:error => '~/Escritorio/z.error.log', :standard => '~/Escritorio/z.standard.log'}

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
