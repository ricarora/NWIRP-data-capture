# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.
class JudgesController < ApplicationController
  before_action :set_judge, only: [:update, :destroy]
  before_filter :authenticate_user!
  respond_to :html

  def index
    @judges = Judge.all
    respond_with(@judges)
  end

  def new
    @judge = Judge.new
    respond_with(@judge)
  end

  def create
    if current_user && current_user.admin
      @judge = Judge.new(judge_params)
      @judge.name
      if @judge.save
        redirect_to judges_path, notice: "Judge successfully added."
      else
        redirect_to judges_path, notice: "Judge unable to be added."
      end
    else
      redirect_to judges_path, notice: "Only admin can create Judge."
    end
  end

  def destroy
    if current_user && current_user.admin
      @judge.destroy
      redirect_to judges_path, notice: "Judge successfully deleted."
    else
      redirect_to judges_path, notice: "Only admin can delete Judges."
    end
  end

  private
    def set_judge
      @judge = Judge.find(params[:id])
    end

    def judge_params
      params.require(:judge).permit(:name)
    end
end
