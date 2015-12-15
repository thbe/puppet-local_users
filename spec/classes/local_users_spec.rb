require 'spec_helper'
describe 'local_users' do

  context 'with defaults for all parameters' do
    it { should contain_class('local_users') }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      #it { is_expected.to contain_class('icinga::package') }
      #it { is_expected.to contain_class('icinga::package::client') }
      #it { is_expected.to contain_class('icinga::config') }
      #it { is_expected.to contain_class('icinga::config::client') }
      #it { is_expected.to contain_class('icinga::service') }
      #it { is_expected.to contain_class('icinga::service::client') }
      #it { is_expected.to contain_package('nrpe') }
      #it { is_expected.to contain_package('nagios-plugins') }
      #it { is_expected.to contain_package('nagios-plugins-perl') }
      #it { is_expected.to contain_package('nagios-plugins-all') }
      #it { is_expected.to contain_file('/etc/nagios/nrpe.cfg') }
      #it { is_expected.to contain_file('/etc/nrpe.d/base.cfg') }

      case facts[:osfamily]
      when 'RedHat'
        if facts[:lsbmajdistrelease] = '5'
          it { is_expected.to contain_warning('The current operating system is not supported!') }
        end
      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
