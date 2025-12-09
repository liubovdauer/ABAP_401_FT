CLASS zcx_d401_06_failed DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .
    DATA mv_cargo type i READ-ONLY.
    METHODS constructor
      IMPORTING
        textid LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL
        i_mv_cargo TYPE i OPTIONAL.

   constants:
     begin of incorrect_load_capacity,
       msgid type symsgid value 'Z06_MESSAGE',
       msgno type symsgno value '010',
       attr1 type scx_attrname value 'mv_cargo',
       attr2 type scx_attrname value 'attr2',
       attr3 type scx_attrname value 'attr3',
       attr4 type scx_attrname value 'attr4',
     end of incorrect_load_capacity.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_d401_06_failed IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).



    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    me->mv_cargo = i_mv_cargo.

  ENDMETHOD.
ENDCLASS.
