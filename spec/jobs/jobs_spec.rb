require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
    class TestJob < ApplicationJob
      def perform(*args); end
    end

    describe "job execution" do
      it "executes successfully" do
        expect { TestJob.perform_later }.to have_enqueued_job(TestJob)
      end
    end
  end
