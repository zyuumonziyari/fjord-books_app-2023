class MessagesController < ApplicationController
    def create
        report = Report.find(params[:report_id])
        message = report.messages.build(message_params)
        message.user_id = current_user.id
        if message.save
        else
            puts "kabigon"
        end
      end

    def destroy
      Message.find(params[:id]).destroy
      puts "kabigon"
    end

private
    def message_params
      params.require(:message).permit(:content)
    end
end
