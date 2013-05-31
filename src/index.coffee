express = require "express"
assets = require "connect-assets"
mongoose = require "mongoose"
http = require "http"

# Create application
app = express()
server = http.createServer app
io = require("socket.io").listen server

# Define port
server.port = port = process.env.PORT or process.env.VMC_APP_PORT or 3000

config = require "./config"
app.configure 'production', 'development', 'testing', ->
  config.setEnvironment app.settings.env
  
mongoose.connect config.settings.db

# Set view engine
app.set 'view engine', 'jade'

# Parser middleware
#app.use express.bodyParser()
#app.use express.methodOverride()
#app.use express.cookieParser()

#### Finalization
# Initialize routes
#routes = require './routes'
#routes(app)

#### View initialization
# Set the public folder as static assets
app.use express.static(process.cwd() + '/public')

# Initialize socket functions
controllers = require './controllers'
controllers(io)

module.exports = server