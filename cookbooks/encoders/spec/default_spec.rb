require 'spec_helper'

describe 'myface::default' do
  let(:chef_run) do
    run = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')
    run.converge('myface::default')
  end

  it 'installs apache2' do
    expect(chef_run).to install_package('apache2')
  end

  it 'starts the apache2 service' do
    expect(chef_run).to start_service('apache2')
  end

  it 'sets apache2 to start on boot' do
    expect(chef_run).to set_service_to_start_on_boot 'apache2'
  end

  it 'creates the default template' do
    expect(chef_run).to create_file('/var/www/index.html')
  end

  it 'creates the site with the correct content' do
    template = chef_run.template('/var/www/index.html')
    expect(template.owner).to eq('root')
    expect(template.group).to eq('root')
  end
end
