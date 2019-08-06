require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use PlayersController
use EmotionsController
use MemoriesController
use UsersController
run ApplicationController
