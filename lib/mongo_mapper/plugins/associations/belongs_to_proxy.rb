# encoding: UTF-8
module MongoMapper
  module Plugins
    module Associations
      class BelongsToProxy < Proxy
        def replace(doc)
          proxy_owner[association.foreign_key] = doc ? doc.id : nil
          @target = doc
        end

        def save_to_collection(options={})
          @target.save if @target
        end

        protected
          def find_target
            return nil if proxy_owner[association.foreign_key].nil?
            klass.find_by_id(proxy_owner[association.foreign_key])
          end
      end
    end
  end
end
