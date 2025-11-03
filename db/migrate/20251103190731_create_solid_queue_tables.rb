class CreateSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :class_name, null: false
      t.text :arguments
      t.integer :priority, default: 0, null: false
      t.string :active_job_id
      t.datetime :scheduled_at
      t.datetime :finished_at
      t.string :finished_reason
      t.string :concurrency_key
      t.integer :concurrency_limit

      t.timestamps

      t.index [:queue_name, :finished_at], name: "index_solid_queue_jobs_for_filtering"
      t.index [:scheduled_at, :finished_at], name: "index_solid_queue_jobs_for_alerting"
    end

    create_table :solid_queue_scheduled_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.string :queue_name, null: false
      t.integer :priority, default: 0, null: false
      t.datetime :scheduled_at, null: false

      t.timestamps

      t.index [:scheduled_at, :priority, :queue_name], name: "index_solid_queue_dispatch_all"
    end

    create_table :solid_queue_ready_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.string :queue_name, null: false
      t.integer :priority, default: 0, null: false

      t.timestamps

      t.index [:priority, :queue_name], name: "index_solid_queue_poll_all"
      t.index :queue_name, name: "index_solid_queue_poll_by_queue"
    end

    create_table :solid_queue_claimed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.bigint :process_id
      t.datetime :created_at, null: false

      t.index [:process_id, :job_id]
    end

    create_table :solid_queue_blocked_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.string :queue_name, null: false
      t.integer :priority, default: 0, null: false
      t.string :concurrency_key, null: false
      t.datetime :expires_at, null: false

      t.timestamps

      t.index [:expires_at, :concurrency_key], name: "index_solid_queue_blocked_executions_for_release"
      t.index [:concurrency_key, :priority, :queue_name], name: "index_solid_queue_blocked_executions_for_maintenance"
    end

    create_table :solid_queue_failed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.text :error
      t.integer :attempts, default: 0, null: false
      t.datetime :created_at, null: false

      t.index :job_id
    end

    create_table :solid_queue_pauses do |t|
      t.string :queue_name, null: false
      t.datetime :created_at, null: false

      t.index :queue_name, unique: true
    end

    create_table :solid_queue_processes do |t|
      t.string :kind, null: false
      t.datetime :last_heartbeat_at, null: false
      t.bigint :supervisor_id

      t.timestamps

      t.index [:last_heartbeat_at], name: "index_solid_queue_processes_on_last_heartbeat_at"
      t.index [:supervisor_id], name: "index_solid_queue_processes_on_supervisor_id"
    end

    create_table :solid_queue_semaphores do |t|
      t.string :key, null: false
      t.integer :value, default: 1, null: false
      t.datetime :expires_at, null: false

      t.timestamps

      t.index [:key, :value], name: "index_solid_queue_semaphores_on_key_and_value"
      t.index [:expires_at], name: "index_solid_queue_semaphores_on_expires_at"
    end

    create_table :solid_queue_recurring_tasks do |t|
      t.string :key, null: false
      t.string :schedule, null: false
      t.string :command
      t.string :class_name
      t.text :arguments
      t.string :queue_name
      t.integer :priority
      t.boolean :static, default: true, null: false
      t.text :description

      t.timestamps

      t.index :key, unique: true
      t.index :static
    end
  end
end
