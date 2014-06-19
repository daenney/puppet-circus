require 'spec_helper'

describe 'circus::install' do
  context 'default' do
    let :pre_condition do
      ["class circus {
       $package_circus              = 'circus'
       $package_ensure              = 'installed'
       $package_circus_provider     = 'pip'
       $package_circus_dependencies = []
      }",
      "include circus" ]
    end
    it { should contain_class('circus::install') }
    it { should contain_package('circus').with({
      :ensure   => 'installed',
      :provider => 'pip',
      :notify   => ['Class[Circus::Configure]', 'Class[Circus::Services]']
    })}
  end

  context "package_circus_dependencies=['python-dev']" do
    let :pre_condition do
      ["class circus {
       $package_circus              = 'circus'
       $package_ensure              = 'installed'
       $package_circus_provider     = 'pip'
       $package_circus_dependencies = ['python-dev']
      }",
      "include circus" ]
    end
    it { should contain_class('circus::install') }
    it { should contain_package('circus').with({
      :ensure   => 'installed',
      :provider => 'pip',
      :notify   => ['Class[Circus::Configure]', 'Class[Circus::Services]']
    })}
    it { should contain_package('python-dev').with({
      :ensure   => 'installed',
      :before   => 'Package[circus]',
      :notify   => 'Class[Circus::Services]'
    })}
  end
end
