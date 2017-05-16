require 'erlang/map'

module Erlang
  module ETF
    module Extensions

      module ErlangMap

        def __erlang_type__
          :map
        end

        def __erlang_evolve__
          if size == 0
            ETF::Map.new([])
          else
            ETF::Map.new(map.map {|(key, value)| [key.__erlang_evolve__, value.__erlang_evolve__]}.flatten)
          end
        end

      end
    end
  end
end
