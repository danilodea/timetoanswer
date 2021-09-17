module SiteHelper
    def msg_header_questions
        if (params[:controller] == "site/welcome" && params[:action] == "index")
            "Últimas perguntas cadastradas..."
        elsif (params[:controller] == "site/search" && params[:action] == "questions")
            "Resultados para o termo \"#{params[:term]}\"..."
        elsif (params[:controller] == "site/search" && params[:action] == "subject")
            #"Resultados para o Assunto: \"#{Subject.find_by_id(params[:subject_id]).description}\""
            "Resultados para o Assunto: \"#{params[:subject]}\""
        end
    end
end
