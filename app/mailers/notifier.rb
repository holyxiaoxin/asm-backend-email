class Notifier < ActionMailer::Base
  default :from => 'forms@asm_website.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_email(form)
    @form = form
    mail( to: 'jr.loves.maths@gmail.com',
          subject: 'Form feedback from ASM website.' )
  end
end
