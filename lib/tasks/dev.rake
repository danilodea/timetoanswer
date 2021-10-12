namespace :dev do

  # DICAS
  # Resetar o autoincremento do campo chave id das tabelas:
  # ActiveRecord::Base.connection.execute("update sqlite_sequence set seq = 0 where name = 'subjects';")

  DEFAULT_PASSWORD = 123123
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento."
  task setup: :environment do
    if Rails.env.development?
      show_spinner("[1 de 8] Apagando DB...") { %x(rails db:drop:_unsafe) }
      show_spinner("[2 de 8] Criando DB...") { %x(rails db:create) } 
      show_spinner("[3 de 8] Migrando DB...") { %x(rails db:migrate) }
    end
    
    show_spinner("[4 de 8] Cadastrando o administrador padrão...") { %x(rails dev:add_default_admin) }
    show_spinner("[5 de 8] Cadastrando o administrador extras...") { %x(rails dev:add_extra_admins) }
    show_spinner("[6 de 8] Cadastrando o usuário padrão...") { %x(rails dev:add_default_user) }
    show_spinner("[7 de 8] Cadastrando assuntos padrões...") { %x(rails dev:add_subjects) }
    show_spinner("[8 de 8] Cadastrando perguntas e repostas...") { %x(rails dev:add_answers_and_questions) }
    #else
    #  puts "Você nao está em ambiente de desenvolvimento!"
    #end
  end

  desc "Adiciona o administrador padrão."
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com', 
      password: DEFAULT_PASSWORD, 
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona o administrador extras"
  task add_extra_admins: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email, 
        password: DEFAULT_PASSWORD, 
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona o usuário padrão."
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com', 
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona os assuntos padrões."
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Remover todos os assuntos padrões."
  task remove_subjects: :environment do
    Subject.all.destroy_all
    ActiveRecord::Base.connection.execute("update sqlite_sequence set seq = 0 where name = 'subjects';")    
  end

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        params = create_question_params(subject)
        answers_array = params[:question][:answers_attributes]

        create_answers(answers_array)
        select_true_answer(answers_array)

        Question.create!(params[:question])
      end
    end
  end

  desc "Resetar o contador dos Assuntos"
  task reset_subject_counter: :environment do
    show_spinner("Resetando o contador dos assuntos...") do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end 
    end
  end

  private

  def create_question_params(subject = Subject.all.sample)
    {
      question: {
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}", 
          subject: subject,
          answers_attributes: []
      }
    }
  end

  def create_answers(answers_array)
    rand(2..5).times do |j|
      answers_array.push({
        description: Faker::Lorem.sentence,
        correct: false
      })
    end
  end

  def select_true_answer(answers_array)
    selected_index = rand(answers_array.size)
    answers_array[selected_index][:correct] = true
  end

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end