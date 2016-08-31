require 'rails_helper'

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      extra: {
        raw_info: {
          uid: "1234",
          name: "Garrett Smestad",
          screen_name: "GSmes"
        }
      },
      credentials: {
        oauth_token: "pizza",
        oauth_token_secret: "secretpizza"
      }
      })
  end

RSpec.feature "user logs in with github account" do
  scenario "user will see request to authorize access using github" do
    stub_omniauth

    visit "/"

    click_on "Login with GitHub"
    #stub out login
    expect(current_path).to eq(root_path)
    expect(page.status_code).to eq(200)
    expect(page).to have_content("Garrett Smestad")
    expect(page).to have_link("Logout")
  end
end
