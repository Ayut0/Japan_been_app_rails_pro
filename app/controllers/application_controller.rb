class ApplicationController < ActionController::Base
    include SessionsHelper

    before_action :set_search, :get_prefectures, :index

    
    def set_search
        @search = Prefecture.ransack(params[:q])
        @search_Prefectures = @search.result
    end

    def get_prefectures
        @prefectures = Prefecture.all
        @prefectures = @prefectures.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    end

    def index
        @prefectures = Prefecture.all
        @prefectures = @prefectures.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
      end

    # def current_user
    #     if (user_id = session[:user_id])
    #         @current_user ||= User.find_by(id: user_id)
    #     elsif (user_id = cookies.signed[:user_id])
    #         user = User.ind_by(id: user_id)
    #         if user && user.authenticated?(cookies[:remember_token])
    #             # ユーザーIDと記憶ダイジェストを使ってユーザーを取得した後にはlog_inメソッドでセッションも開始している
    #             log_in user
    #             @current_user = user
    #         end
    #     end
    # end

    # ログインしていないユーザーをログインページにリダイレクトするアクションを作成する
    # application_controllerに追加することで、全てのコントローラで利用できるようになる
    private

        # ログイン済みユーザーかどうか確認
        def logged_in_user
            # logged_in?：ユーザーがログインしていればtrue、その他ならfalseを返す
            unless logged_in?
                redirect_to login_url
            end
        end

end
