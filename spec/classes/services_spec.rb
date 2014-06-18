require 'spec_helper'

describe 'circus::services' do
  it 'enables and keeps circus running' do
    should contain_service('circus').with({
      :ensure     => 'running',
      :enable     => true,
      :hasrestart => true
    })
  end
end
