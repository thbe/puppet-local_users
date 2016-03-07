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

      let(:params) {
        {
          :manage_root => true,
          :root_password_hash => '!!',
          :users => {
            'john' => { 'comment' => 'John Doe', 'shell' => '/bin/bash',  'password' => '!!' },
            'jane' => { 'comment' => 'Jane Doe', 'home'  => '/home/jane', 'groups'   => 'wheel' }
          }
        }
      }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('local_users') }
      it { is_expected.to contain_class('local_users::params') }

      it { is_expected.to contain_file('/etc/login.defs').with_ensure('file') }

      it { is_expected.to contain_user('jane').with_ensure('present').with_groups('wheel') }
      it { is_expected.to contain_user('john').with_ensure('present').with_password('!!') }
      it { is_expected.to contain_user('root').with_ensure('present').with_password('!!') }

      case facts[:osfamily]
      when 'RedHat'
        it 'should generate valid content for login.defs' do
          content = catalogue.resource('file', '/etc/login.defs').send(:parameters)[:content]
          expect(content).to match('PASS_MAX_DAYS')
          expect(content).to match('USERDEL_CMD')
        end
      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
