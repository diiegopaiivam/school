module ProfilesBackofficeHelper
    def avatar_url
        avatar = current_profile.profile_user.avatar
        avatar.attached? ? avatar : '/images/img.jpg'
    end
end
