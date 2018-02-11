#encoding: utf-8
require_relative "../modelo_qytetet/qytetet"
require_relative "vista_textual_qytetet"
module InterfazTextualQytetet
  class ControladorQytetet
    
    include ModeloQytetet
    
    def main 
      inicializacion_juego
      desarrollo_juego
    end
    
    def desarrollo_juego
      final_juego = false
      begin
        @vista.mostrar("Turno de jugador #{@jugador.nombre} con saldo #{@jugador.saldo} ")
        sigue_jugando = true
        
        if(@jugador.encarcelado)
          @vista.mostrar("Estas en la carcel")
          nro_metodo = @vista.menu_salir_carcel
          metodo = nil
          case (nro_metodo)
          when 0
            metodo = MetodoSalirCarcel::TIRANDODADO
          when 1
            metodo = MetodoSalirCarcel::PAGANDOLIBERTAD
          end
          sale = @juego.intentar_salir_carcel(metodo)
          if(sale)
            @vista.mostrar("!Lo has conseguido! Has podido salir de la carcel, sigues jugando.")
          else
            @vista.mostrar("No has conseguido salir de la carcel, pierdes turno.")
            sigue_jugando = false
          end
        end
          
          if(sigue_jugando)
            tiene_propietario = @juego.jugar
            @vista.mostrar("Ahora esta en la casilla -> #{@jugador.casilla_actual}")
            case(@jugador.casilla_actual.tipo)
            when TipoCasilla::SORPRESA
              @vista.mostrar("·Has caído en una casilla sorpresa")
              @vista.mostrar(@juego.carta_actual.to_s)
              nueva_casilla = @juego.aplicar_sorpresa
              if(nueva_casilla)
                @vista.mostrar(" ·Has caído en una propiedad con propietario y has pagado su alquiler")
              end
            when TipoCasilla::CALLE
              if(tiene_propietario)
                @vista.mostrar("·Has caído en una casilla con propietario")
              else
                @vista.mostrar("·Esta casilla no tiene propietario")
                comprar = @vista.elegir_quiero_comprar
                if(comprar == 1)
                  puedo_comprar = @juego.comprar_titulo_propiedad
                  if(puedo_comprar)
                    @vista.mostrar("Has comprado la casilla -> #{@jugador.casilla_actual.numero_casilla}")
                  else
                    @vista.mostrar("No puedes comprar la casilla -> #{@jugador.casilla_actual.numero_casilla}")
                  end
                end
              end
            end
          end
          
          if((!@jugador.encarcelado)&&(@jugador.tengo_propiedades)&&(@jugador.saldo > 0))
            gestion = @vista.menu_gestion_inmobiliaria
            while gestion != 0
              edit_casilla = elegir_propiedad(@jugador.propiedades).calle
              case gestion
                when 1
                  edificada = @juego.edificar_casa(edit_casilla)
                  @vista.mostrar(" -> " + (edificada ? "Has edificado" : "No has podido edificar") + " una casa")
                when 2
                  edificado = @juego.edificar_hotel(edit_casilla)
                  @vista.mostrar(" -> " + (edificado ? "Has edificado" : "No has podido edificar") + " un hotel")
                when 3
                  vendido = @juego.vender_propiedad(edit_casilla)
                  @vista.mostrar(" -> " + (vendido ? "Has vendido" : "No has podido vender") + " la casilla")
                when 4
                  hipotecada = @juego.hipotecar_propiedad(edit_casilla)
                  @vista.mostrar(" -> " + (hipotecada ? "Has hipotecado" : "No has podido hipotecar") + " la casilla")
                when 5
                  cancelada = @juego.cancelar_hipoteca(edit_casilla)
                  @vista.mostrar(" -> " + (cancelada ? "Has cancelado" : "No has podido cancelar") + " la hipoteca de la casilla")
              end
              if @jugador.tengo_propiedades
                gestion = @vista.menu_gestion_inmobiliaria
              else
                gestion = 0
              end
            end
          end
          
        if(@jugador.saldo <= 0)
          @vista.mostrar("#{@jugador.nombre} ha caido en bancarrota. FINAL DEL JUEGO")
          final_juego = true
        else
          @jugador = @juego.siguiente_jugador
          @casilla = @jugador.casilla_actual
        end
        
      end until final_juego
      
      nombres = Array.new
      nombres = @juego.obtener_ranking
      nombres.each { |nombre|
        @vista.mostrar(nombre)
      }
      
    end
    
    def elegir_propiedad(propiedades)
      @vista.mostrar("\tCasilla\tTitulo");
        
      lista_propiedades= Array.new
      propiedades.each { |prop|
        prop_string= prop.calle.numero_casilla.to_s+' '+prop.nombre
        lista_propiedades<< prop_string
      }
      
      seleccion=@vista.menu_elegir_propiedad(lista_propiedades)
      propiedades.at(seleccion)
    end
    
    def inicializacion_juego
      @juego = ModeloQytetet::Qytetet.instance
      @vista = VistaTextualQytetet.new

      nombres = Array.new
      nombres = @vista.obtener_nombre_jugadores
      @juego.inicializar_juego(nombres)

      @jugador = @juego.jugador_actual
      @casilla = @jugador.casilla_actual
    end
  end
  qytetet = ControladorQytetet.new
  qytetet.main
end
