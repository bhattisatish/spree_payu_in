# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_payu_in'
  s.version     = '0.0.1'
  s.summary     = 'PayU.in payment method for spreecommerce'
  s.description = 'spree_payu_in adds payu.in payment method to spree commerce'

  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Satish Bhat'
  s.email     = 'bhattisatish@gmail.com'
  s.homepage  = 'https://github.com/bhattisatish/spree_payu_in'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 0.70.1'

  #s.add_development_dependency 'capybara', '1.0.1'
  #s.add_development_dependency 'factory_girl', '~> 2.6.4'
  #s.add_development_dependency 'ffaker'
  #s.add_development_dependency 'rspec-rails',  '~> 2.9'
  #s.add_development_dependency 'sqlite3'
end
