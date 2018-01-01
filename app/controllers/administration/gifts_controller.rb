class Administration::GiftsController < ApplicationController
    def index
        unless @logged_in.admin?(:manage_gifts)
            render html: t('not_authorized'), layout: true, status: 401
            return
        end

        @title = I18n.t('admin.gifts.heading')
        @gifts = Gift.all()
        @gift = Gift.new()
        @formUrl = administration_gifts_path
    end

    def show
        unless @logged_in.admin?(:manage_gifts)
            render html: t('not_authorized'), layout: true, status: 401
            return
        end

        @gift = Gift.find(params[:id])
        @formUrl = administration_gift_path(@gift)
        @people = @gift.people
    end

    def update
        unless @logged_in.admin?(:manage_gifts)
            render html: t('not_authorized'), layout: true, status: 401
            return
        end

        @gift = Gift.find(params[:id])
        if @gift.update_attributes(gift_params)
            flash[:notice] = t('admin.gifts.saved')
            redirect_to administration_gift_path(@gift)
        else
            render action: 'index'
        end
    end

    def new
        unless @logged_in.admin?(:manage_gifts)
            render html: t('not_authorized'), layout: true, status: 401
            return
        end
            @gift = Gift.new()
            @formUrl = administration_gifts_path
    end

    def create
        unless @logged_in.admin?(:manage_gifts)
            render html: t('not_authorized'), layout: true, status: 401
            return
        end

        @gift = Gift.new(gift_params)
        if @gift.save
            if @logged_in.admin?(:manage_gifts)
                flash[:notice] = t('gifts.created')
            end
            redirect_to administration_gift_path(@gift)
        else
            render action: 'new'
        end
    end

    def gift_attributes
        %i(name)
    end
    
    def gift_params
        params.require(:gift).permit(*gift_attributes)
    end

end