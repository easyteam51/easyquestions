# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :google_oauth2
  #トークンの検証をスキップするようRailsに指示します。これにより、外部サービス（この場合はGoogle）からのコールバックリクエストがCSRFトークン検証プロセスをバイパスできるようになります。
  
  def google_oauth2
    # Googleからのレスポンスを取得

    @user = User.from_omniauth(request.env['omniauth.auth'])
    #Googleから返される認証データが含まれている User.from_omniauth メソッドを呼び出して、このデータからユーザーを見つけるか、新しく作成
    if @user.persisted?
      #データベースに存在するか確認
      sign_in_and_redirect @user, event: :authentication
      #ユーザーが見つかった（または作成された）場合、そのユーザーでサインインし、設定されたリダイレクト先にリダイレクトします。
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
      #Googleからのデータをセッションに一時保存し、ユーザー登録プロセスを完了できるようにします
      redirect_to new_user_registration_url
    end
  end

  def line
    # LINEからの認証データを処理する
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "LINE") if is_navigational_format?
    else
      session["devise.line_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
    #認証が失敗した場合に実行されるメソッドで、ルートパスにリダイレクトします。
  end
end