class ProfilesBackoffice::WelcomeController < ProfilesBackofficeController
  def index
    @profile_statistic = ProfileStatistic.find_or_create_by(profile: current_profile)
  end
end
