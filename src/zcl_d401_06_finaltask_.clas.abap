CLASS zcl_d401_06_finaltask_ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_d401_06_finaltask_ IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    Data lv_rental type ref to lcl_rental.
    CREATE ObJECT lv_rental.

    TRY.
    DATA(truck) = NEW lcl_truck(
                i_mv_make = 'Mercedes-Benz'
                i_mv_model = 'Actros'
                i_mv_price = '180000.00'
                i_mv_color = 'red'
                i_mv_cargo = 18000 ).
    CATCH cx_root.
    ENDTRY.
        APPEND truck to lv_rental->lt_vehicle_collection.

    TRY.
    truck = NEW lcl_truck(
                i_mv_make = 'DAF'
                i_mv_model = 'XF'
                i_mv_price = '118000.00'
                i_mv_color = 'red'
                i_mv_cargo = 18500 ).
    CATCH cx_root.
    ENDTRY.
        APPEND truck to lv_rental->lt_vehicle_collection.

    TRY.
    truck = NEW lcl_truck(
                i_mv_make = 'Volvo'
                i_mv_model = 'FH16'
                i_mv_price = '130000.00'
                i_mv_color = 'red'
                i_mv_cargo = 20000 ).
    CATCH cx_root.
    ENDTRY.
        APPEND truck to lv_rental->lt_vehicle_collection.

    TRY.
    truck = NEW lcl_truck(
                i_mv_make = 'Scania'
                i_mv_model = 'R Series'
                i_mv_price = '125000.00'
                i_mv_color = 'black'
                i_mv_cargo = 19000 ).
    CATCH cx_root.
    ENDTRY.
        APPEND truck to lv_rental->lt_vehicle_collection.

    TRY.
    truck = NEW lcl_truck(
                i_mv_make = 'MAN'
                i_mv_model = 'TGX'
                i_mv_price = '115000.00'
                i_mv_color = 'yellow'
                i_mv_cargo = 1750 ).
    CATCH cx_root.
    ENDTRY.
        APPEND truck to lv_rental->lt_vehicle_collection.



** Create five Busses


        TRY.
        DATA(bus) = NEW lcl_bus(
                    i_mv_make = 'Mercedes-Benz'
                    i_mv_model = 'Citaro'
                    i_mv_price = '300000.00'
                    i_mv_color = 'green'
                    i_mv_seats = 45 ).
        CATCH cx_root.
        ENDTRY.
            APPEND bus to lv_rental->lt_vehicle_collection.

        TRY.
              bus = NEW lcl_bus(
                    i_mv_make = 'MAN'
                    i_mv_model = 'Lion’s City'
                    i_mv_price = '280000.00'
                    i_mv_color = 'green'
                    i_mv_seats = 49 ).
        CATCH cx_root.
        ENDTRY.
            APPEND bus to lv_rental->lt_vehicle_collection.

        TRY.
              bus = NEW lcl_bus(
                    i_mv_make = 'Volvo'
                    i_mv_model = '7900 Electric'
                    i_mv_price = '350000.00'
                    i_mv_color = 'black'
                    i_mv_seats = 55 ).
        CATCH cx_root.
        ENDTRY.
            APPEND bus to lv_rental->lt_vehicle_collection.

        TRY.
              bus = NEW lcl_bus(
                    i_mv_make = 'Scania'
                    i_mv_model = 'Citywide'
                    i_mv_price = '320000.00'
                    i_mv_color = 'white'
                    i_mv_seats = 51 ).
        CATCH cx_root.
        ENDTRY.
            APPEND bus to lv_rental->lt_vehicle_collection.

        TRY.
              bus = NEW lcl_bus(
                    i_mv_make = 'Iveco'
                    i_mv_model = 'Urbanway'
                    i_mv_price = '310000.00'
                    i_mv_color = 'green'
                    i_mv_seats = 41 ).
        CATCH cx_root.
        ENDTRY.
            APPEND bus to lv_rental->lt_vehicle_collection.

       LOOP AT lv_rental->lt_vehicle_collection into DATA(vehicle).
        IF vehicle is INSTANCE OF lcl_truck.
         truck = CAST #( vehicle ).
         out->write( truck->display_attributes(  ) ).
        ELSE.
         bus = CAST #( vehicle ).
         out->write( bus->display_attributes(  ) ).
        ENDIF.
        out->write( '---------------------------------------------------' ).
       ENDLOOP.

       out->write( 'Truck with max load capacity:' ).
       out->write( lv_rental->get_max_cargo(  )->display_attributes(  )  ).
       out->write( '---------------------------------------------------' ).


  ENDMETHOD.

ENDCLASS.
