class AddAttachmentCashFlowStatementToTenantApplications < ActiveRecord::Migration
  def self.up
    add_column :tenant_applications, :cash_flow_statement_file_name, :string
    add_column :tenant_applications, :cash_flow_statement_content_type, :string
    add_column :tenant_applications, :cash_flow_statement_file_size, :integer
    add_column :tenant_applications, :cash_flow_statement_updated_at, :datetime
  end

  def self.down
    remove_column :tenant_applications, :cash_flow_statement_file_name
    remove_column :tenant_applications, :cash_flow_statement_content_type
    remove_column :tenant_applications, :cash_flow_statement_file_size
    remove_column :tenant_applications, :cash_flow_statement_updated_at
  end
end
