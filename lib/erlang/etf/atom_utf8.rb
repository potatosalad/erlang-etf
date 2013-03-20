module Erlang
  module ETF

    #
    # 1   | 2   | Len
    # --- | --- | --------
    # 118 | Len | AtomName
    #
    # An atom is stored with a 2 byte unsigned length in big-endian
    # order, followed by `Len` bytes containing the `AtomName` encoded
    # in UTF-8.
    #
    # (see [`ATOM_UTF8_EXT`])
    #
    # [`ATOM_UTF8_EXT`]: http://erlang.org/doc/apps/erts/erl_ext_dist.html#ATOM_UTF8_EXT
    #
    class AtomUTF8
      include Term

      uint8 :tag, always: Terms::ATOM_UTF8_EXT

      uint16be :len, default: 0 do
        string :atom_name
      end

      undef deserialize_atom_name
      def deserialize_atom_name(buffer)
        self.atom_name = buffer.read(len).from_utf8_binary
      end

      undef serialize_atom_name
      def serialize_atom_name(buffer)
        buffer << atom_name.to_utf8_binary
      end

      finalize

      def initialize(atom_name)
        @atom_name = atom_name
        @len = atom_name.to_s.bytesize
      end

      def __ruby_evolve__
        atom_name.intern
      end
    end
  end
end