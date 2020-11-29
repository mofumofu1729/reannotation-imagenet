module Common
  extend ActiveSupport::Concern

  def check_sign_in
     if current_user.nil?
       redirect_to "/users/sign_in"
       return
     end

     if current_user.team_user.nil?
       redirect_to "/static_pages/index"
       return
     end
  end

  def check_competition_running
    running_competition = Competition.
                            where(finished: nil).
                            where('starts_at > ?', Time.current).
                            order('starts_at').
                            first

    if running_competition.nil? or
      (running_competition.starts_at < Time.current or
       running_competition.ends_at >= Time.current)
      redirect_to "/entrance_page/index"
    end
  end
end