express      = require 'express'
app          = express()
server       = require('http').createServer app
io           = require('socket.io').listen server 
routes       = require('./routes')
user         = require('./routes/user')
path         = require('path')
stylus       = require 'stylus'
nib          = require('nib')
marked       = require('marked')
cons         = require('consolidate')
mid          = require('middleware')
bodyParser   = require('body-parser')




# all environments
app.set 'port', process.env.PORT or 3000
app.engine '.html', cons.jade
app.set 'views', __dirname + '/static/views'
app.set 'view engine', 'jade'



compile = (str, path) ->
  stylus(str).set("filename", path).use nib()

app.use stylus.middleware(
  src: __dirname + "/public"
  compile: compile
)
app.use express.static(__dirname + "/public")
	


app.get '/', routes.template
app.get '/users', user.list

server.listen app.get('port')
console.log 'The server of My App Initializer:\n => localhost:3000'




