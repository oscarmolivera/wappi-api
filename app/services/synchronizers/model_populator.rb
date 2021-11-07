require 'faker'

module Synchronizers
  class ModelPopulator
    class << self
      def call(model, data)
        populate_user_model(data) if model == 'users'.to_sym
        populate_post_model(data) if model == 'posts'.to_sym
        populate_comment_model(data) if model == 'comments'.to_sym
      end

      def populate_user_model(users) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        return if User.all.count == users.count

        users.each do |item|
          company = populate_company_model(item[:company])
          password = Faker::Internet.password
          new_user = User.find_or_create_by(
            id: item[:id],
            email: item[:email],
            encrypted_password: password,
            name: item[:name],
            username: item[:username],
            phone: item[:phone],
            website: item[:website],
            company_id: company.id
          )
          new_user.update(
            password: password,
            password_confirmation: password
          )
          #new_user.skip_confirmation!
          new_user.save
          populate_address_model(item[:address], new_user.id)
          @new_user
        rescue ActiveRecord::RecordNotUnique
          retry
        end
      end

      def populate_address_model(address, user_id) # rubocop:disable Metrics/MethodLength
        new_address = Address.new(
          city: address[:city],
          street: address[:street],
          suite: address[:suite],
          zipcode: address[:zipcode],
          lat: address[:geo][:lat],
          lng: address[:geo][:lng],
          user_id: user_id
        )
        new_address.save
      rescue ActiveRecord::RecordNotUnique
        retry
      end

      def populate_company_model(company)
        Company.find_or_create_by!(
          name: company[:name],
          catch_phrase: company[:catchPhrase],
          bs: company[:bs]
        )
      rescue ActiveRecord::RecordNotUnique
        retry
      end

      def populate_post_model(posts) # rubocop:disable Metrics/MethodLength
        return if Post.all.count == posts.count

        posts.each do |item|
          
          Post.find_or_create_by!(
            id: item[:id],
            title: item[:title],
            body: item[:body],
            user_id: User.find(item[:userId]).id
          )
        rescue ActiveRecord::RecordNotUnique
          retry
        end
      end

      def populate_comment_model(comments) # rubocop:disable Metrics/MethodLength
        return if Comment.all.count == comments.count

        comments.each do |item|
          Rails.logger.info "ITEM# #{item[:id]}"
          Comment.find_or_create_by!(
            id: item[:id],
            name: item[:name],
            email: item[:email],
            body: item[:body],
            post_id: Post.find(item[:postId]).id
          )
        rescue ActiveRecord::RecordNotUnique
          retry
        end
      end
    end
  end
end
