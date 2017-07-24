alias rdb='bundle exec rake db:drop db:create db:migrate db:seed cache:flush'
alias rdbt='bundle exec rake db:drop db:create db:migrate db:seed RAILS_ENV=test'
