#encoding: utf-8
require "singleton"
module ModeloQytetet
  class Qytetet
    include Singleton
    
    attr_reader :mazo
    attr_reader :jugadores
    attr_reader :jugador_actual
    attr_reader :carta_actual
    attr_reader :tablero
    
    MAX_JUGADORES = 4
    MAX_CARTAS = 10
    MAX_CASILLAS = 20
    PRECIO_LIBERTAD = 200
    SALDO_SALIDA = 1000
    
    def initialize
      @jugador_actual
      @jugadores = Array.new
      @tablero
      @carta_actual
      @mazo = Array.new
      @dado = Dado.new
    end
    
    def aplicar_sorpresa
      tiene_propietario = false
      if (carta_actual.tipo == TipoSorpresa.PAGARCOBRAR)
        @jugador_actual.modificar_saldo(@carta_actual.valor)
      elsif (carta_actual.tipo == TipoSorpresa.IRACASILLA)
        es_carcel = @tablero.es_casilla_carcel(@carta_actual.valor)
        if(es_carcel)
          encarcelar_jugador
        else
          nueva_casilla = @tablero.obtener_casilla_numero(@carta_actual.valor)
          tiene_propietario = @jugador_actual.actualizar_posicion(nueva_casilla)
        end
      elsif (carta_actual.tipo == TipoSorpresa.PORCASAHOTEL)
        @jugador_actual.pagar_cobrar_por_casa_y_hotel(@carta_actual.valor)
      elsif (carta_actual.tipo == TipoSorpresa.PORJUGADOR)
        jugadores.each{ |jugador|
          jugador.modificar_saldo(@carta_actual.valor)
          @jugador_actual.modificar_saldo((-1)*@carta_actual.valor)
        }
      end
      
      if (carta_actual.tipo == TipoSorpresa.SALIRCARCEL)
        @jugador_actual.set_carta_libertad(@carta_actual)
      else
        @mazo<< @cartaActual
      end
      tiene_propietario
    end
    
    def cancelar_hipoteca(casilla)
      puedo_hipotecar = false
      if(casilla.soy_edificable)
        se_puede_hipotecar = casilla.esta_hipotecada
        if(se_puede_hipotecar)
          puedo_hipotecar = !@jugador_actual.puedo_hipotecar(casilla)
          if(puedo_hipotecar)
            cantidad_recibida = casilla.hipotecar
            @jugador_actual.modificar_saldo((-1)*cantidad_recibida)
          end
        end
      end
      puedo_hipotecar
    end
    
    def comprar_titulo_propiedad
      puedo_comprar = @jugador_actual.comprar_titulo
      puedo_comprar
    end
    
    def edificar_casa(casilla)
      puedo_edificar = false
      if (casilla.soy_edificable)
        se_puede_edificar = casilla.se_puede_edificar_casa
        if (se_puede_edificar)
          puedo_edificar = @jugador_actual.puedo_edificar_casas(casilla)
          if(puedo_edificar)
            coste_edificar_casa = casilla.edificar_casa
            @jugador_actual.modificar_saldo(coste_edificar_casa)
          end
        end
      end
      puedo_edificar
    end
    
    def edificar_hotel(casilla)
      puedo_edificar = false
      if (casilla.soy_edificable)
        se_puede_edificar = casilla.se_puede_edificar_hotel
        if (se_puede_edificar)
          puedo_edificar = @jugador_actual.puedo_edificar_hoteles(casilla)
          if(puedo_edificar)
            coste_edificar_hotel = casilla.edificar_hotel
            @jugador_actual.modificar_saldo(coste_edificar_hotel)
          end
        end
      end
      puedo_edificar
    end
    
    def get_carta_actual
      @carta_actual
    end
    
    def get_jugador_actual
      @jugador_actual
    end
    
    def hipotecar_propiedad(casilla)
      puedo_hipotecar = false
      if(casilla.soy_edificable)
        se_puede_edificar = !casilla.esta_hipotecada
        if(se_puede_hipotecar)
          puedo_hipotecar = @jugador_actual.puedo_hipotecar(casilla)
          if(puedo_hipotecar)
            cantidad_recibida = casilla.hipotecar
            @jugador_actual.modificar_saldo(cantidad_recibida)
          end
        end
      end
      puedo_hipotecar
    end
    
    def inicializar_juego(nombres)
      inicializar_jugadores(nombres)
      inicializar_cartas_sorpresa
      inicializar_tablero
      salida_jugadores
    end
    
    def intentar_salir_carcel(metodo)
      libre = false
      if (metodo == MetodoSalirCarcel::TIRANDODADO)
        valor_dado = dado.instance.tirar
        if(valor_dado > 5)
          libre = true
        end
      elsif (metodo == MetodoSalirCarcel::PAGANDOLIBERTAD)
        tengo_saldo = @jugador_actual.pagar_libertad((-1)*PRECIO_LIBERTAD)
        libre = tengo_saldo
      end
      libre
    end
    
    def jugar
      valor_dado = dado.instance.tirar
      casilla_posicion = @jugador_actual.casilla_actual
      nueva_casilla = @tablero.obtener_nueva_casilla(casilla_posicion, valor_dado)
      tiene_propietario = @jugador_actual.actualizar_posicion(nueva_casilla)
      if(nueva_casilla.soy_edificable())
        if(nueva_casilla.tipo == TipoCasilla::JUEZ)
          encarcelar_jugador
        elsif nueva_casilla.tipo == TipoCasilla::SORPRESA
          @carta_actual=@mazo[0]
          @mazo-=[@carta_actual]
        end
      end
      tiene_propietario
    end
    
    def obtener_ranking
        ranking = Array.new
      @jugadores.each{ |jugador|
        capital = jugador.obtener_capital()
        s =" #{jugador.nombre} + \tSaldo: + #{Integer.to_s(capital)}"
        ranking<<s
      }
      ranking
    end
    
    def propiedades_hipotecadas_jugador(hipotecada)
      titulos = @jugador_actual.obtener_propiedades_hipotecadas(hipotecada)
      casillas = Array.new
      
      titulos.each{ |titulo|
        casillas<< titulo.casilla 
      }
      casillas
    end
    
    def siguiente_jugador
      siguiente = 0;
      if @jugador_actual != nil
        index = @jugadores.index(@jugador_actual)
        if index < (@jugadores.size - 1)
          siguiente = index + 1
        end
      end
      @jugador_actual = @jugadores[siguiente]
    end
    def vender_propiedad(casilla)
      puedo_vender = false;
        if(casilla.soy_edificable())
          puedo_vender = @jugador_actual.puedo_vender_propiedad(casilla)
          if(puedo_vender)
            @jugador_actual.vender_propiedad(casilla)
          end
        end
        puedo_vender
    end
    
    def encarcelar_jugador
      if(!@jugador_actual.tengo_carta_libertad)
        casilla_carcel = @tablero.carcel
        @jugador_actual.ir_a_carcel(casilla_carcel)
      else
        carta = @jugador_actual.devolver_carta_libertad()
        @mazo<< carta
      end
    end
    
    def inicializar_cartas_sorpresa
      @mazo = Array.new
      @mazo << Sorpresa.new("La DEA te ha pillado con cocaína y pasarás un tiempo en Litchfield", @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Encuentras un acceso al Upside Down y te lleva directo a Jackson", 16, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Te han invitado a una fiesta por la noche en casa de Jessica", 13, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Los otros jugadores han probado tu producto azul y te pagan unos cuantos gramos", 500, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Jessica Jones ha expuesto tus secretos y pagas a los testigos para que nadie hable", -400, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Cada celda de pabellón te pagan por tus servicios al protegerles", 300, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("Taylor ha decidido que tu hotel está contruido en un lugar histórico de Stars Hollow", -400, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("El Presidente te otorga un presupuesto solicitado", 600, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Matt Murdock te ha defendido en un juicio y debes pagar sus honorarios", -700, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Elisabeth II te ha dado un indulto y puedes abandonar la prisión", 0, TipoSorpresa::SALIRCARCEL)
    end
    
    def inicializar_jugadores(nombres)
      nombres.each{ |jugador|
        @jugadores<< nombres
      }
    end
    
    def inicializar_tablero
      @tablero = Tablero.new
    end
    
    def salida_jugadores
      @jugadores.each { |jugador| 
        jugador.casilla_actual(tablero.obtener_casilla_numero(0))
        jugador.saldo(7500)
      }
      
      @jugador_actual = @jugadores[ rand()*@jugadores.size() -1]
    end
  end
end
