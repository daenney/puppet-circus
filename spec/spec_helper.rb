require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  Puppet.settings[:strict_variables]=true
  Puppet.settings[:ordering]='random'
  if ENV['PUPPET_FUTURE_PARSER'] == 'yes'
    c.parser = 'future'
  end
end
