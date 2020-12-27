namespace :dev do

  PASSWORD_DEFAULT = 139045
  DEFAULT_FILE_PATHS = File.join(Rails.root, 'lib', 'tmp')

  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Drop DB...") { %x(rails db:drop) }
      show_spinner("Create DB...") { %x(rails db:create) }
      show_spinner("Migrate DB...") { %x(rails db:migrate) }
      show_spinner("Create Administrator Master...") { %x(rails dev:add_default_admin) }
      show_spinner("Create More Administrator...") { %x(rails dev:add_more_admin) }
      show_spinner("Create User Master...") { %x(rails dev:add_default_profile) }
      show_spinner("Create Subject for Questions...") { %x(rails dev:add_subjects ) }
      show_spinner("Create Questions and Answer...") { %x(rails dev:add_questions_answer) }
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

    desc "Create Subject for Questions"
    task add_subjects: :environment do
      file_name = 'subjects.txt' 
      file_path = File.join(DEFAULT_FILE_PATHS, file_name) #define caminho até arquivo txt
      
      File.open(file_path, 'r').each do |row| #percorre cada linha do arquivo para salvar no banco
        Subject.create!(description: row.strip) #método strip retira qualquer espaço ou simbolo eventualmente criado
      end
    end

    desc "Create Questions and Answer"
    task add_questions_answer: :environment do
      Subject.all.each do |subject| 
        rand(10..15).times do |i| #Cria pelo menos de 10 a 15 Questões por assunto
          params = create_questions_params(subject)
          answers_array = params[:question][:answers_attributes]

          add_answers(answers_array) #adiciona resposta as questões
          elect_true_answer(answers_array) #seta uma resposta como true
          
          Question.create!(params[:question])
        end
      end
    end

    private
      def show_spinner(msg_start, msg_end = "Concluído!")
        spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
        spinner.auto_spin
        yield
        spinner.success("(#{msg_end})")
      end

      def create_questions_params(subject = Subject.all.sample) #Caso o usuário não passe o assunto, ele sorteia algum já criado
        {
          question: {
            description: "#{Faker::Lorem.paragraph}. #{Faker::Lorem.question}",
            subject: subject,
            answers_attributes: []
          }
        }
      end 

      def create_answer_params(correct = false)
        { description: Faker::Lorem.sentence, correct: correct }
      end

      def add_answers(answers_array = [])
        5.times do |c|
          answers_array.push(create_answer_params)
        end 
      end 

      def elect_true_answer(answers_array = [])
        answers_array[rand(6)] = create_answer_params(true)
      end 


end
