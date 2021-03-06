module ApplicationHelper
    def js_notify(message, type)
        html = ""
        html << "<div data-notify='container' class='col-xs-11 col-sm-3 alert alert-{0}' role='alert'>"
        html <<     "<button type='button' aria-hidden='true' class='btn close' data-notify='dismiss'>×</button>"
        html <<     "<span data-notify='icon'></span>"
        html <<     "<span data-notify='title'>{1}</span>"
        html <<     "<span data-notify='message'>{2}</span>"
        html <<     "<div class='progress' data-notify='progressbar'>"
        html <<         "<div class='progress-bar progress-bar-{0}' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 0%;'></div>"
        html <<     "</div>"
        html <<     "<a href='{3}' target='{4}' data-notify='url'></a>"
        html << "</div>"

        javascript_tag "$.notify(\"#{message}\",{type: \"#{type}\",template: \"#{html.html_safe}\",z_index: 99999});"
    end 
end
