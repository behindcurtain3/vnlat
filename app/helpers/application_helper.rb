module ApplicationHelper

    def graham?
       current_user.id == 2 
    end
    
    def justin?
       current_user.id == 1 
    end

end
