express      = require 'express'
app          =  express()
server       = require('http').createServer app
io           = require('socket.io').listen server 
routes       = require('./routes')
user         = require('./routes/user')
path         = require('path')
stylus       = require 'stylus'
nib          = require('nib')
marked       = require('marked')
cons         = require('consolidate')


# all environments
app.set 'port', process.env.PORT or 3000
app.engine '.html', cons.jade
app.set 'views', __dirname + '/static/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser('Conoces a Venito Camelas?')
app.use express.session()
app.use app.router
compile = (str, path) ->
  stylus(str).set("filename", path).use nib()

app.use stylus.middleware(
  src: __dirname + "/public"
  compile: compile
)
app.use express.static(__dirname + "/public")
	
# development only
if 'development' is app.get('env')
	app.use express.errorHandler()  

app.get '/', routes.template
app.get '/users', user.list

server.listen app.get('port')
console.log 'The server of My App Initializer:\n => localhost:3000'




