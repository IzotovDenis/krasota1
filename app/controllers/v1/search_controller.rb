class V1::SearchController <  V1Controller

    def index
        begin
        @query_text = params[:q]
        @query = SearchHelper.string_find(params[:q])
        @ids = Item.search_for_ids(@query, set_options)
        @count = Item.search_for_ids(@query, set_options_ids)
        @order = "idx(array#{@ids.to_s}, items.id)::int" if @count.length > 0
        @items = Item.where(:id=>@ids).order("#{@order}").
        joins("LEFT OUTER JOIN likes ON (likes.item_id = items.id AND likes.user_id = #{current_user ? current_user.id : 0})").
        select("
        items.title,
        items.price,
        items.image,
        items.uid, 
        CASE coalesce(likes.id, 0) WHEN 0 THEN 'false'::boolean ELSE 'true' END AS user_like, 
        items.id")
        render json: {success: true, items:@items, total_entries:@count.length, query_string:@query_text, pageLoaded: params[:page]}, serializer: nil, adapter: false
        rescue => e
          render json: {error: true}, status: 500
        end
      end
      
      private    
      def set_options
        options = {}
        options[:per_page] = 10
        options[:page] = params[:page]
        options
      end
    
    
      def set_options_ids
        options = set_options
        options[:page] = nil
        options[:per_page] = 10
        options
      end

end