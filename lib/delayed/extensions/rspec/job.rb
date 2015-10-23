module Delayed
  class Job
    class << self
      attr_accessor :execute_synchronously

      def execute_synchronously?
        !!execute_synchronously
      end

      def execute_asynchronously!
        self.execute_synchronously = false
      end

      attr_accessor :silence_errors

      def silence_errors?
        !!silence_errors
      end

      def silence_errors!
        self.silence_errors = true
      end

      attr_accessor :silence_warnings

      def silence_warnings?
        !!silence_warnings
      end

      def silence_warnings!
        self.silence_warnings = true
      end

      def reset!
        self.execute_synchronously = true
        self.silence_warnings = false
      end

      alias_method :_enqueue, :enqueue

      def enqueue(*args)
        if execute_synchronously?
          options = args.extract_options!

          options[:payload_object] ||= args.shift
          options[:priority] ||= Delayed::Worker.default_priority

          if options[:queue].nil?
            if options[:payload_object].respond_to?(:queue_name)
              options[:queue] = options[:payload_object].queue_name
            end
            options[:queue] ||= Delayed::Worker.default_queue_name
          end

          new(options).tap do |job|
            Delayed::Worker.lifecycle.run_callbacks(:enqueue, job) do
              job.hook(:enqueue)
              begin
                job.invoke_job
              rescue Exception => e
                job.attempts = 1
                job.locked_at = nil
                job.locked_by = nil
                job.last_error = e.message
                job.failed_at = Time.now.utc
                job.save
                if !silence_errors?
                  raise e
                elsif !silence_warnings?
                  bt = e.backtrace.join("\n  ")
                  warn "[WARNING] #{job.name} - #{e}\n  #{bt}" unless silence_warnings?
                end
              end
            end
          end
        else
          _enqueue(* args)
        end
      end
    end
  end
end
