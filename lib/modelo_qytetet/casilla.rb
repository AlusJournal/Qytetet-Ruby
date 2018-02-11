#encoding: utf-8
module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    attr_reader :tipo
    
    
    def initialize(numero_casilla, tipo)                   
       @numero_casilla = numero_casilla
       @tipo = tipo
       @coste = 0   
     end    
 
     def soy_edificable
       false
     end
    
    def to_s
      "Casilla: #{@numero_casilla}. Tipo: #{@tipo}"
    end 
  
  end
end
