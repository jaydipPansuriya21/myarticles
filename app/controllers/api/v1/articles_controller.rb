module Api
  module V1
    class ArticlesController < ApplicationController
      include ActionController::HttpAuthentication::Basic::ControllerMethods
      http_basic_authenticate_with name: 'jaydip', password: '123456'

      def index
        article = Article.order("created_at DESC")
        render json: {status: 'SUCCESS', message: 'Loaded articles', data:article}, status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded article', data:article}, status: :ok
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: { status: 'SUCCESS', message: 'article saved', data:article }, status: :ok
        else
          render json: { status: 'failed', message: 'article wad not saved', data: article.errors.message }, status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find(params[:id])
        if article.destroy
          render json: { status: 'SUCCESS', message: 'article deleted', data:article }, status: :ok
        else
          render json: { status: 'failed', message: 'article was not deleted', data:article.errors.messages }, status: :unprocessable_entity
        end
      end

      def update
        article = Article.find(params[:id])
        if article.update(article_params)
          render json: { status: 'SUCCESS', message: 'article Updated', data:article }, status: :ok
        else
          render json: { status: 'failed', message: 'article was not updated', data:article.errors.messages }, status: :unprocessable_entity
        end

      end

      private
      def article_params
        params.permit(:title, :body)
      end

    end
  end
end