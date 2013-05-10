
/*
 * GET home page.
 */

exports.template = function(req, res){
  res.render('layout', { title: 'My App Initializer' });
};