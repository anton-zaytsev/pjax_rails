module Pjax
  extend ActiveSupport::Concern

  included do
    layout ->(c) { pjax_request? ? 'application-pjax' : 'application' }
  end

  private
  def redirect_pjax_to(action, url = nil)
    new_url = url_for(url ? url : { action: action })

    render js: <<-EJS
        if (!window.history || !window.history.pushState) {
          window.location.href = '#{render_to_string("#{action}.html.erb").to_json}';
        } else {
          $('[data-pjax-container]').html('');
          $(document).trigger('end.pjax');

          var title = $.trim($('[data-pjax-container]').find('title').remove().text());
          if (title) document.title = title;
          window.history.pushState({}, document.title, '#{new_url}');
        }
    EJS
  end

  def pjax_request?
    env['HTTP_X_PJAX'].present?
  end
end
