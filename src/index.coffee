express = require "express"
io = require "socket.io"
assets = require "connect-assets"

# Create application
exports.app = app = express.createServer()
exports.io = io

# Define port
exports.port = port = process.env.PORT or process.env.VMC_APP_PORT or 3000

config = require "./config"
app.configure 'production', 'development', 'testing', ->
  config.setEnvironment app.settings.env
  
mongoose.connect config.settings.db

#### View initialization
# Connect assets
app.use assets()
# Set the public folder as static assets
app.use express.static(process.cwd() + '/public')

# Set view engine
app.set 'view engine', 'jade'

# Parser middleware
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()

#### Finalization
# Initialize routes
routes = require './routes'
routes(app)

# Initialize socket functions
sockets = require './sockets'
sockets(io)
