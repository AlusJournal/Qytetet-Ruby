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
            opcion = @vista.menu_gestion_inmobiliaria
            lista_propiedades= Array.new
            casillas = Array.new
            if (opcion == 5)
              casillas = @juego.propiedades_hipotecadas_jugador(true)
            else
              casillas = @juego.propiedades_hipotecadas_jugador(false)
            end
            
            casillas.each { |casilla|
              lista_propiedades<< casilla.titulo.nombre
            }
            if(lista_propiedades.size > 0 && opcion != 0)
              propiedad_elegida = @vista.menu_elegir_propiedad(lista_propiedades)
            end
            
            case(opcion)
            when 1 
              puedo = @juego.edificar_casa(casillas[propiedad_elegida])
              if(puedo)
                @vista.mostrar("Se ha podido edificar casa")
              else
                @vista.mostrar("No se ha podido edificar casa")
              end
            when 2
              puedo = @juego.edificar_hotel(casillas[propiedad_elegida])
              if(puedo)
                @vista.mostrar("Se ha podido edificar hotel")
              else
                @vista.mostrar("No se ha podido edificar hotel")
              end
            when 3
              puedo = @juego.vender_propiedad(casillas[propiedad_elegida])
              if(puedo)
                @vista.mostrar("Se ha vendido la propiedad")
              else
                @vista.mostrar("No se ha vendido la propiedad")
              end
            when 4
              puedo = @juego.hipotecar_propiedad(casillas[propiedad_elegida])
              if(puedo)
                @vista.mostrar("Se ha hipotecado la propiedad")
              else
                @vista.mostrar("No se ha hipotecado la propiedad")
              end
            when 5
              puedo = @juego.cancelar_hipoteca(casillas[propiedad_elegida])
              if(puedo)
                @vista.mostrar("Se ha cancelado la hipoteca")
              else
                @vista.mostrar("No se ha cancelado la hipoteca")
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
      for prop in propiedades
        prop_string= prop.numeroCasilla.to_s+' '+prop.titulo.nombre; 
        lista_propiedades<< prop_string
      end
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
