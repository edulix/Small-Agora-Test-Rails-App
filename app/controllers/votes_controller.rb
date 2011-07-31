class VotesController < ApplicationController
  # GET /votes
  # GET /votes.xml
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.xml
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.xml
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.xml
  def create

    args = [params[:dnie_certificate], params[:votes_signature]]

    params[:voting_id].each_index { |index|
        voting = Voting.find(params[:voting_id][index])
        args += [params[:encrypted_vote][index], voting.public_key]
    }

    result = %x[votecheck.sh #{args.join(' ')}]

    if result != 'FAIL'
        # "CIF (with number),Name,Surname1,Surname2"
        cif, name, surname1, surname2 = result.split(',')
        # if we were really recording the votes, we would add the cif, surname1,
        # surname2 to each of the votings refered in params[:vote_id]
        print cif, name, surname1, surname2
    end

    respond_to do |format|
      if result == 'FAIL'
        format.html { head :bad_request }
      else
        format.html { head :ok }
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.xml
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to(@vote, :notice => 'Vote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.xml
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to(votes_url) }
      format.xml  { head :ok }
    end
  end
end
