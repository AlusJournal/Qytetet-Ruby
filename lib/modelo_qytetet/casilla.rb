#encoding: utf-8
module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    attr_accessor :num_hoteles
    attr_accessor :num_casas
    attr_reader :tipo
    attr_accessor :titulo
    
    def initialize(numero_casilla, tipo)                   
       @numero_casilla = numero_casilla
       @tipo = tipo
       @coste = 0
       @num_hoteles = 0    
       @num_casas = 0    
       @titulo = nil    
     end    
         
     def self.init_calle(numero_casilla, coste, titulo)    
       casilla = new(numero_casilla, TipoCasilla::CALLE)    
       casilla.coste = coste    
       casilla.num_hoteles = 0    
       casilla.num_casas = 0    
       casilla.titulo = titulo
       casilla.titulo.casilla = casilla
       casilla
     end
     
     def asignar_propietario(jugador)
       @titulo.propietario = jugador
       @titulo
     end
     
     def calcular_valor_hipoteca
       (@titulo.hipoteca_base * num_casas * 0.5 * @titulo.hipoteca_base + num_hoteles * @titulo.hipoteca_base).round
     end
     
     def cancelar_hipoteca
       
     end
     
     def cobrar_alquiler
       coste_alquiler_base = (@titulo.alquiler_base + (num_casas*0.5 + num_hoteles*2)).round
       @titulo.cobrar_alquiler(coste_alquiler_base)
       coste_alquiler_base
     end
     
     def edificar_casa
       @num_casas + 1
       coste_edificar_casa = @titulo.precio_edificar
       coste_edificar_casa
     end
     
     def edificar_hotel
       @num_hoteles + 1
       coste_edificar_hotel = @titulo.precio_edificar
       coste_edificar_hotel
     end
     
     def esta_hipotecada
       titulo.hipotecada
     end
     
     def get_coste_hipoteca
       @titulo.hipoteca_base
     end
     
     def get_precio_edificar
       @titulo.precio_edificar
     end
     
     def hipotecar
       @titulo.hipotecada = true
       calcular_valor_hipoteca
     end
     
     def precio_total_comprar
       
     end
     
     def propietario_encarcelado
       @titulo.propietario_encarcelado
     end
     
     def se_puede_edificar_casa
       se_puede_edificar = false
       if(@num_casas<(4 * @titulo.propietario.factor_especulador))
         se_puede_edificar = true
       end
       se_puede_edificar
     end
     
     def se_puede_edificar_hotel
       se_puede_edificar = false
       if(@num_casas>(4 * @titulo.propietario.factor_especulador))
         if(@num_hoteles<(4 * @titulo.propietario.factor_especulador))
           se_puede_edificar = true
         end
       end
       se_puede_edificar
     end
 
     def soy_edificable
       es_edificable = false
       es_edificable = true if (@tipo == TipoCasilla::CALLE)
       es_edificable
     end
     
     def tengo_propietario
       @titulo.tengo_propietario
     end
     
     def vender_titulo
       @titulo.propietario = nil
       precio_compra = @coste+(@num_casas+@num_hoteles)*@titulo.precio_edificar
       @num_hoteles = 0
       @num_casas = 0
       return (precio_compra + (@titulo.factor_revalorizacion*precio_compra)).round
     end
    
     def asignar_titulo_propiedad
       
     end
    
    def to_s
      "#{@numero_casilla}. Coste: #{@coste}"
    end 
  
  end
end
