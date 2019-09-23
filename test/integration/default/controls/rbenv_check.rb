control 'golang_check' do

  describe command("rbenv versions") do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /2\.3\.\d+$/}
    its('stdout') { should match /2\.5\.\d+$/}
    its('stdout') { should match /2\.6\.\d+$/}
  end

end
