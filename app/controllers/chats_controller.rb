class ChatsController < ApplicationController
  before_action :authenticate_user! # Deviseのログイン確認

  def show
    # メッセージ一覧を取得
    @messages = Message.all
    end
    
    private
    
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
    
    end