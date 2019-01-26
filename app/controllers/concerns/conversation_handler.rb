module ConversationHandler
  include ActiveSupport::Concern

  def create_conversation
    auditor = case current_user.type
              when "Admin"
                Auditor.find(conversation_params[:auditor_id])
              when "Auditor"
                current_user
              end

    conversation = Conversation.new(auditor: auditor, subject: conversation_params[:subject])

    if conversation.save
      redirect_to conversation_path(:show, conversation.id)
    else
      redirect_to dashboard_path(current_user)
    end
  end

  def conversation_index
    @conversation = Conversation.new

    @conversations = case current_user.type
                     when "Admin"
                       Conversation.all.order(created_at: :desc)
                     when "Auditor"
                       Conversation.where(auditor_id: current_user.id).order(created_at: :desc)
                     end

    render 'conversations/index'
  end

  def show_conversation
    @message = Message.new
    @conversation = Conversation.find(params[:id])
    @messages = Conversation.find(params[:id]).messages

    render 'conversations/show'
  end

  def create_message
    case current_user.type
    when "Admin"
      message = Message.create(message_params.merge(direction: false))
    when "Auditor"
      message = Message.create(message_params.merge(direction: true))
    end

    redirect_to conversation_path(:show, message_params[:conversation_id])
  end

  private
    def conversation_params
      params.require(:conversation).permit(:auditor_id, :subject)
    end

    def message_params
      params.require(:message).permit(:conversation_id, :body)
    end
end
