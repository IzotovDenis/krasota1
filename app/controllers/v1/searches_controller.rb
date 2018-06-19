class V1::SearchesController <  V1Controller

    def index
        begin
        @query_text = params[:q]
        @query = SearchHelper.string_find(params[:q])
        @ids = Item.search_for_ids(@query, set_options)
        @count = Item.search_for_ids(@query, set_options_ids)
        @order = "idx(array#{@ids.to_s}, items.id::int)" if @count.length > 0
        @items = Item.where(:id=>@ids).order("#{@order}")
        render json: {success: true, items:@items, total_entries:@count.length, query_string:@query_text}, serializer: nil, adapter: false
        rescue => e
          render json: {error: true, msg: e}, status: 500
        end
      end
      
      private    
      def set_options
        options = {}
        options[:per_page] = 20
        options[:page] = params[:page]
        options
      end
    
    
      def set_options_ids
        options = set_options
        options[:page] = nil
        options[:per_page] = 300
        options
      end

end