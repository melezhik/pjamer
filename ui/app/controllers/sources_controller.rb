class SourcesController < ApplicationController

    def create

        @project = Project.find params[:project_id]
        @source = @project.sources.create( params[:source].permit( :url, :scm_type ) )

        begin
            @project.sources.find(@project[:distribution_source_id])
        rescue ActiveRecord::RecordNotFound => ex
            @project.update({:distribution_source_id => @source[:id]})
        end

        if @project.save
            flash[:notice] = "source ID:#{@source[:id]} has been successfully created"
        else
            flash[:alert] = "error has been occured when creating source: #{@project.errors.full_messages.join ' '}"
        end
        redirect_to edit_project_path @project

    end

    def destroy

        @project = Project.find(params[:project_id])
        @source = @project.sources.find(params[:id])
        url = @source.url
        @source.destroy
        flash[:notice] = "source ID:#{params[:id]}; Url: #{url} has been successfully deleted"
        redirect_to project_path @project
    end
    

    # used to set order in sources list; lift the source to versy first level
    def top
	st = true
	while (st == true ) do
		@project = Project.find(params[:project_id])
	        @source = @project.sources.find(params[:id])
		st = _pop_up(@project, @source) 
	end
        flash[:notice] = "source ID:#{params[:id]}; Url: #{@source.url} now has order number: #{@source.sn}"
        redirect_to [:edit, @project]
    end

    # used to set order in sources list; lift the source to 1 level up
    def up
        @project = Project.find(params[:project_id])
        @source = @project.sources.find(params[:id])
	_pop_up @project, @source
        flash[:notice] = "source ID:#{params[:id]}; Url: #{@source.url} now has order number: #{@source.sn}"
        redirect_to [:edit, @project]
    end

    def on
        @project = Project.find(params[:project_id])
        @source = @project.sources.find(params[:id])
        if @source.update({:state => true })
            flash[:notice] = "source ID:#{params[:id]}; Url: #{@source.url} has been sucessfully enabled"
            redirect_to [:edit, @project]
        else
            flash[:alert] = "error has been occured when enabling source ID:#{params[:id]}; Url: #{@source.url}"
            render :edit            
        end
    end

    def off
        @project = Project.find(params[:project_id])
        @source = @project.sources.find(params[:id])
        if @source.update({:state => false})
            flash[:notice] = "source ID:#{params[:id]}; Url: #{@source.url}  has been sucessfully disabled"
            redirect_to [:edit, @project]
        else
            flash[:alert] = "error has been occured when disabling source ID:#{params[:id]}; Url: #{@source.url}"
            render :edit            
        end
    end


   def _pop_up project, source

        change = false
	changed = false
        i = 0
        project.sources_ordered.reverse.each do |s|
            i+=1
            if s[:id] == source[:id]
                    change = true
            elsif change == true
                    sn = s[:sn]
                    s.update({ :sn => i-1 })
                    @source.update({ :sn => i })
                    change = false
		    changed = true	
            else
                    s.update({ :sn => i })
            end

        end
	return changed
   end

end
