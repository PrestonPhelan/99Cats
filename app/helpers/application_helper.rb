module ApplicationHelper
  def auth_token_input
    "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">"
  end
end
