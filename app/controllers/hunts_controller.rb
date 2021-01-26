class HuntsController < ApplicationController
    before_action :set_hunt, only: [:level_1]
    before_action :authorized, :part_of_the_hunt, :killed_the_horse

    def level_1
        if current_user.hunts.first.id != 1
            redirect_to current_level_path
        end
    end


    def level_2
        
        if current_user.hunts.first.id != 2
            redirect_to current_level_path
        else
            cookies[:key] = {
                :value => ' Good show the secret phrase to get to the next level is Marjoram ',
                :expires => 60.seconds.from_now,
            }
            @hun = Hunt.find(current_user.hunts.ids)
            @hunt = @hun.first
            @h = HuntProgression.find(current_user.hunt_progressions.ids)
            @hp = @h.first
            if params[:guess] == @hunt.correct_answer
                current_user.hunt_progressions.update(hunt_id: 3)
                redirect_to level_3_path
            else
                @hp.failure
            end
        end
    end
        
    def level_3
        if current_user.hunts.first.id != 3
            redirect_to current_level_path
        end
        @hun = Hunt.find(current_user.hunts.ids)
        @hunt = @hun.first
        if params[:guess] == @hunt.correct_answer
            current_user.hunt_progressions.update(hunt_id: 4)
            redirect_to level_4_path
        else
            @hp.failure
        end
    end

    def level_4
        if current_user.hunts.first.id != 4
            redirect_to current_level_path
        end
    end

    def level_5
        if current_user.hunts.first.id != 5
            redirect_to current_level_path
        end
    
    end


    def level_select
        if current_user.hunts.first.id == 1
            redirect_to level_1_path
        elsif current_user.hunts.first.id == 2
            redirect_to level_2_path
        elsif current_user.hunts.first.id == 3
            redirect_to level_3_path
        elsif current_user.hunts.first.id == 4
            redirect_to level_4_path
        elsif current_user.hunts.first.id == 5
            redirect_to level_5_path
        end
    end

    def rotunda
        current_user.hunt_progressions.update(hunt_id: 2)
        redirect_to level_2_path
    end

    def rotunda4
        current_user.hunt_progressions.update(hunt_id: 5)
        redirect_to level_5_path
    end

    

private

    def set_hunt
        @hunt = Hunt.find(current_user.hunts.ids)
    end
end