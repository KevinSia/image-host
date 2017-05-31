describe "the signin process", :type => :feature do
  before :all do
    x = User.create(full_name: 'testy mctestface', email: 'user@example.com', password: 'password')
  end

  it "signs me in" do
    visit '/'
    within("#modal-sign-in") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
      click_button 'Sign in'
    end
    expect(page).to have_content 'Login successful'
  end
end
