class RatingsController < ActionController::Base
  
  
  def update
     @rating = Rating.find(params[:id])
     @book = @rating.book
     if @rating.update_attributes(score: params[:score])
       respond_to do |format|
         format.js
       end
     end
   end
   
   def new
     @rating = Rating.new
   end
  
end
