##########################################################################
# Copyright 2017 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################
module ApiV3
  module Plugin
    class BasePluginInfoRepresenter < BaseRepresenter
      alias_method :plugin, :represented

      link :self do |opts|
        opts[:url_builder].apiv3_admin_plugin_info_url(id)
      end

      link :doc do |opts|
        'https://api.gocd.org/#plugin-info'
      end

      link :find do |opts|
        opts[:url_builder].apiv3_admin_plugin_info_url(id: '__plugin_id__').gsub(/__plugin_id__/, ':plugin_id')
      end

      property :id, exec_context: :decorator
      property :version, exec_context: :decorator
      property :getExtensionName, as: :type
      property :status, exec_context: :decorator do
        property :state, getter: lambda {|*| state.to_s.downcase}
        property :messages, if: lambda {|args| !self.messages.blank?}
      end

      property :plugin_file_location, exec_context: :decorator
      property :isBundledPlugin, as: :bundled_plugin, exec_context: :decorator

      property :about, exec_context: :decorator do
        property :name
        property :version
        property :target_go_version
        property :description
        property :target_operating_systems, getter: lambda {|opts| self.target_operating_systems.to_a}

        property :vendor do
          property :name
          property :url
        end
      end

      protected

      delegate :id, :version, :status, :about, :plugin_file_location, :isBundledPlugin, to: :descriptor

      def descriptor
        plugin.getDescriptor()
      end
    end
  end
end