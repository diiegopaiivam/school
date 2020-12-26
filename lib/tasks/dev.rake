namespace :dev do

  PASSWORD_DEFAULT = 139045

  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop DB...") { %x(rails db:drop) }
      show_spinner("Create DB...") { %x(rails db:create) }
      show_spinner("Migrate DB...") { %x(rails db:migrate) }
      show_spinner("Create Administrator Master...") { %x(rails dev:add_default_admin) }
      show_spinner("Create More Administrator...") { %x(rails dev:add_more_admin) }
      show_spinner("Create User Master...") { %x(rails dev:add_default_profile) }
    else 
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

    desc "Create Administrator Master"
    task add_default_admin: :environment do
      Admin.create!(
        email: 'admin@admin.com.br',
        password: PASSWORD_DEFAULT,
        password_confirmation: PASSWORD_DEFAULT
      )
    end

    desc "Create More Administrator"
    task add_more_admin: :environment do
      10.times do |i|
        Admin.create!(
          email: Faker::Internet.email,
          password: PASSWORD_DEFAULT,
          password_confirmation: PASSWORD_DEFAULT
        )
      end 
    end

    desc "Create User Master"
    task add_default_profile: :environment do
      Profile.create!(
        email: 'user@user.com.br',
        password: PASSWORD_DEFAULT,
        password_confirmation: PASSWORD_DEFAULT
      )
    end

    private
      def show_spinner(msg_start, msg_end = "Concluído!")
        spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
        spinner.auto_spin
        yield
        spinner.success("(#{msg_end})")
      end
end
