# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    attr_accessor :num_hoteles
    attr_accessor :num_casas
    attr_reader :casilla
    attr_accessor :titulo
    
    def initialize(numero_casilla, coste, titulo)
      @numero_casilla = numero_casilla 
      @coste = coste
      @num_hoteles = 0
      @num_casas = 0
      @casilla = TipoCasilla::CALLE
      @titulo = titulo
    end
    
    def initialize(numero_casilla, casilla)
      @numero_casilla = numero_casilla 
      @casilla = casilla
    end
    
    #SetTituloPropiedad preguntar
    
    def to_s
      "#{@numero_casilla}. Coste: #{@coste}"
    end 
  
  end
end
