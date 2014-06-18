require 'spec_helper'
describe 'circus' do

  context 'with defaults for all parameters' do
    it { should contain_class('circus') }
    it { should contain_class('circus::install').with_before('Class[Circus::Configure]')}
    it { should contain_class('circus::configure').with_before('Class[Circus::Services]')}
    it { should contain_class('circus::services').with_before('Class[Circus]')}
  end


  describe 'validating' do
    context 'package_ensure=invalid' do
      let :params do { :package_ensure => 'invalid' } end
      it 'fails' do
        should compile.and_raise_error(/must be one of/)
      end
    end

    context 'package_circus=[]' do
      let :params do { :package_circus => [] } end
      it 'fails' do
        should compile.and_raise_error(/is not a string/)
      end
    end

    context 'package_circus_provider=[]' do
      let :params do { :package_circus_provider => [] } end
      it 'fails' do
        should compile.and_raise_error(/is not a string/)
      end
    end

    context 'package_circus_dependencies={}' do
      let :params do { :package_circus_dependencies => {} } end
      it 'fails' do
        should compile.and_raise_error(/is not an Array/)
      end
    end

    context 'service_circus_provider=[]' do
      let :params do { :service_circus_provider => [] } end
      it 'fails' do
        should compile.and_raise_error(/must be one of/)
      end
    end

    context 'conf_prefix=[]' do
      let :params do { :conf_prefix => [] } end
      it 'fails' do
        should compile.and_raise_error(/is not an absolute path/)
      end
    end

    context 'log_prefix=[]' do
      let :params do { :log_prefix => [] } end
      it 'fails' do
        should compile.and_raise_error(/is not an absolute path/)
      end
    end

    context 'logrotate_dir=[]' do
      let :params do { :logrotate_dir => [] } end
      it 'fails' do
        should compile.and_raise_error(/is not an absolute path/)
      end
    end
  end
end
