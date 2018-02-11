#encoding: utf-8
module ModeloQytetet
  class TituloPropiedad
    attr_reader :nombre
    attr_accessor :hipotecada
    attr_reader :alquiler_base
    attr_reader :factor_revalorizacion
    attr_reader :hipoteca_base
    attr_reader :precio_edificar
    attr_accessor :casilla
    attr_accessor :propietario
    attr_accessor :calle
    
    def initialize(nombre, alquiler_base, factor_revalorizacion, hipoteca_base, precio_edificar)
      @nombre = nombre
      @hipotecada = false
      @alquiler_base = alquiler_base
      @factor_revalorizacion = factor_revalorizacion
      @hipoteca_base = hipoteca_base
      @precio_edificar = precio_edificar
      @propietario = nil
      @calle = nil
    end
    
    def cobrar_alquiler(coste)
      @propietario.modificar_saldo((-1)*coste)
    end
    
    def propietario_encarcelado
      @propietario.encarcelado
    end
    
    def tengo_propietario
      propietario = false
      if(@propietario != nil)
        propietario = true
      end
      propietario
    end
    
    def to_s
      "#{nombre}. Alquiler base: #{@alquiler_base}$. Factor de Revalorizacion #{@factor_revalorizacion}. Hipoteca Base: #{@hipoteca_base}$. Precio Edificar #{@precio_edificar}$"
    end 
  end
end
