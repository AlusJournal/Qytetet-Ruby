# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Especulador < Jugador
    def initialize(jugador, fianza)
      super(jugador.nombre)
      constructor_copia(jugador)

      @fianza = fianza
      @factor_especulador = 2
    end
    
    protected
    def pagar_impuestos(cantidad)
      modificar_saldo((-1)*(cantidad / 2))
    end

    def ir_a_carcel(casilla)
      evitar_carcel = pagar_fianza(@fianza)
      if evitar_carcel
        super
      end
    end
    
    def convertirme(fianza)
      self
    end

    private
    def pagar_fianza(cantidad)
      tengo_saldo = tengo_saldo(cantidad)
      if tengo_saldo
          modificar_saldo(-1 * cantidad)
      end
      tengo_saldo
    end
    
  end
end
