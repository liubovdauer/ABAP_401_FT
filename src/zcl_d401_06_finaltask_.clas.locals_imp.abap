
CLASS lcl_vehicle DEFINITION ABSTRACT.

  PUBLIC SECTION.

    DATA: mv_make  TYPE c LENGTH 20 READ-ONLY,
          mv_model TYPE c LENGTH 20 READ-ONLY,
          mv_price TYPE p LENGTH 15 DECIMALS 2 READ-ONLY,
          mv_color TYPE c LENGTH 15 READ-ONLY.

    METHODS constructor
      IMPORTING i_mv_make  TYPE c
                i_mv_model TYPE c
                i_mv_price TYPE p
                i_mv_color TYPE c
      RAISING   cx_abap_invalid_value.

    METHODS display_attributes
      RETURNING VALUE(r_result) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_vehicle IMPLEMENTATION.

  METHOD constructor.
    TRY.
        me->mv_make  = i_mv_make.
        me->mv_model = i_mv_model.
        me->mv_price = i_mv_price.
        me->mv_color = i_mv_color.
      CATCH cx_abap_invalid_value.

    ENDTRY.
  ENDMETHOD.

  METHOD display_attributes.

    APPEND | { 'Manufacturer:'  } { me->mv_make  }        | TO r_result.
    APPEND | { 'Model:'         } { me->mv_model }        | TO r_result.
    APPEND | { 'Price:'         } { me->mv_price } { '€' }| TO r_result.
    APPEND | { 'Color:'         } { me->mv_color }        | TO r_result.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.

  PUBLIC SECTION.

    DATA mv_cargo TYPE i READ-ONLY.

    METHODS constructor
      IMPORTING i_mv_make  TYPE c
                i_mv_model TYPE c
                i_mv_price TYPE p
                i_mv_color TYPE c
                i_mv_cargo TYPE i
      RAISING   zcx_d401_06_failed
                cx_abap_invalid_value.

    METHODS display_attributes REDEFINITION.
    METHODS get_cargo
      RETURNING VALUE(cargo_capacity) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_truck IMPLEMENTATION.


  METHOD constructor.

    super->constructor(
         i_mv_make  = i_mv_make
        i_mv_model  = i_mv_model
        i_mv_price  = i_mv_price
        i_mv_color  = i_mv_color ).

*    IF i_mv_cargo < 2000.
*    raise exception type zcx_d401_06_failed
*        EXPORTING
*            textid = zcx_d401_06_failed=>incorrect_load_capacity
*            i_mv_cargo = mv_cargo.
*    ENDIF.
    mv_cargo  = i_mv_cargo.

  ENDMETHOD.

  METHOD get_cargo.
    cargo_capacity = mv_cargo.
  ENDMETHOD.

  METHOD display_attributes.
    r_result = super->display_attributes(  ).
    APPEND | { 'Load Capacity:' } { me->mv_cargo }        | TO r_result.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_bus DEFINITION INHERITING FROM lcl_vehicle.

  PUBLIC SECTION.

    DATA mv_seats TYPE i READ-ONLY.
    METHODS constructor
      IMPORTING i_mv_make  TYPE c
                i_mv_model TYPE c
                i_mv_price TYPE p
                i_mv_color TYPE c
                i_mv_seats TYPE i

      RAISING   cx_abap_invalid_value.

    METHODS get_seats
      RETURNING VALUE(mv_seats) TYPE i.

    METHODS display_attributes REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_bus IMPLEMENTATION.

  METHOD constructor.

    super->constructor(
            i_mv_make   = i_mv_make
            i_mv_model  = i_mv_model
            i_mv_price  = i_mv_price
            i_mv_color  = i_mv_color ).
    mv_seats    = i_mv_seats.

  ENDMETHOD.

  METHOD get_seats.
    mv_seats = me->mv_seats.
  ENDMETHOD.

  METHOD display_attributes.
    r_result = super->display_attributes(  ).
    APPEND | { 'Seats:' } { me->mv_seats }        | TO r_result.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_rental DEFINITION.

  PUBLIC SECTION.
    DATA: truck                 TYPE REF TO lcl_truck,
          bus                   TYPE REF TO lcl_bus,
          lt_vehicle_collection TYPE TABLE OF REF TO lcl_vehicle.

    METHODS get_max_cargo
      RETURNING VALUE(max_cargo) TYPE REF TO lcl_truck.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_rental IMPLEMENTATION.



  METHOD get_max_cargo.
       data: lv_max_cargo type i value 0,
             lt_trucks type table of ref to lcl_truck.

        Loop at me->lt_vehicle_collection into data(vehicle).
            IF vehicle is instANCE OF lcl_truck.
            truck = CAST #( vehicle ).
                IF truck->mv_cargo > lv_max_cargo.
                    lv_max_cargo = truck->mv_cargo.
                    max_cargo = truck.
                ENDIF.
            ENDIF.
        ENDLOOP.

  ENDMETHOD.

ENDCLASS.
