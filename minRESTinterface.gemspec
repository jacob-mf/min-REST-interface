Gem::Specification.new do |s|
  s.name        = 'minRESTinterface'
  s.version     = '0.4.2'
  s.date        = '2017-04-07'
  s.summary     = "Sinatra simple REST interface"
  s.description = "A simple REST interface by Sinatra linked to a simple Article class"
  s.authors     = ["Luis JAcob Mariscal Fernández"]
  s.email       = 'jacob_mf@yahoo.es'
  s.files       = ["lib/minRESTinterface.rb"]
  s.homepage    = 'https://github.com/jacob-mf/min-REST-interface'
  s.licenses    = ['LGPL-3.0']
  s.post_install_message = 'Thanks for installing minRESTinterface gem'
  s.add_development_dependency 'racktest' , '~> 0.6'
  s.add_development_dependency 'test-unit',  '~> 3.1'
  s.add_development_dependency 'sinatra',  '~> 1.4'
  s.add_development_dependency 'rake',  '~> 10.4'
  s.add_development_dependency 'json',  '~> 1.7' 

end
