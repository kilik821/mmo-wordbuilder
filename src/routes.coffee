#### Routes
# Right now, returning jade rendered pages

module.exports = (app) ->
  app.get '/play', (req, res, next) ->
    res.render 'play'
  
  app.get '/', (req, res, next) ->
    res.render 'index'
