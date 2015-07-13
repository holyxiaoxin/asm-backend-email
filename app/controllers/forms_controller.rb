class FormsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    # Deliver the forms email
    # @form = {
    #   job_title: params[:job_title]
    # }
    # Notifier.send_email(@form).deliver

    require 'sendgrid-ruby'
    client = SendGrid::Client.new(api_user: ENV["SENDGRID_USERNAME"], api_key: ENV["SENDGRID_PASSWORD"])

    html =
      "<!DOCTYPE html>
      <html>
      <head>
        <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
      </head>
      <body>

      <h3>Name: #{params[:name]}</h3>
      <h3>Job Title: #{params[:job_title]}</h3>
      <h3>Organization: #{params[:organization]}</h3>
      <h3>Address: #{params[:address]}</h3>
      <h3>City: #{params[:city]}</h3>
      <h3>State Province: #{params[:state_province]}</h3>
      <h3>Country: #{params[:country]}</h3>
      <h3>Zip Postal: #{params[:zip_postal]}</h3>
      <h3>Email: #{params[:email]}</h3>
      <h3>Phone: #{params[:phone]}</h3>

      <p>End of feedback!</p>
      </body>
      </html>"

    email = SendGrid::Mail.new do |m|
      m.to      = 'jesswongsg@gmail.com'
      m.from    = 'test@asm.com'
      m.subject = 'Form feedback from ASM website.'
      m.html    = html
    end

    client.send(email)
    render json: { status: 'ok' }, status: :ok
  end
end
