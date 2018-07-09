require 'pp'

class PlanetNamer
  PREFIXES = %w[Esel Tele Telo Ril Os Charo Clau Para Kara Bana Ora Osir Pezo Huza Gen Nov Xon Adul Res Acu Mira Cura Lira Cli Kor Kal Zor Tun Aus Ger Swe Fre Rwa Nor Mex Arj Vene Mada Japa Jeso Blii Elis Rus Geor Plu Inter Zamb Tanza Mora].freeze
  SUFFIXES = %w[jor isia keth lis del ma na ba is tos tiz cus izus nova nuva zone zed dros iran oliv via ugua enzar pex xor rica esta bien ensia ania].freeze
  POSTS = %w[V Prime K1 K2 K3 K4 K5 I II III IV Alpha Beta Delta Epsilon Gamma Omega X Z].freeze

  def self.generate_one
    [[PREFIXES.sample, SUFFIXES.sample].join, POSTS.sample].join(" ")
  end

  def self.generate_all
    PREFIXES.map do |prefix|
      SUFFIXES.map { |suffix| prefix + suffix }.map do |name|
        name += extra_word
      end
    end.flatten
  end

  def self.extra_word
    return ' ' + POSTS.sample if rand > 0.5
    ''
  end
end
