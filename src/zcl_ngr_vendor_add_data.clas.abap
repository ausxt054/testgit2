class ZCL_NGR_VENDOR_ADD_DATA definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_VENDOR_ADD_DATA .
protected section.
private section.
ENDCLASS.



CLASS ZCL_NGR_VENDOR_ADD_DATA IMPLEMENTATION.


  method IF_EX_VENDOR_ADD_DATA~BUILD_TEXT_FOR_CHANGE_DETAIL.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~CHECK_ACCOUNT_NUMBER.
  endmethod.


  METHOD if_ex_vendor_add_data~check_add_on_active.
    IF i_screen_group = 'ZN'. "NGR screen group
      e_add_on_active = 'X'.
    ENDIF.
  ENDMETHOD.


  METHOD if_ex_vendor_add_data~check_all_data.
    DATA: ls_lfa1 TYPE lfa1.
    DATA: ls_lfb1 TYPE lfb1.
    DATA(ltr_company_codes) = zcl_ngr_helper=>get_company_codes( ).

    IF i_lfb1 IS NOT INITIAL AND sy-binpt IS INITIAL. "don't do for batch
      SELECT SINGLE *
        INTO ls_lfa1
        FROM lfa1
        WHERE lifnr = i_lfa1-lifnr
        AND ktokk EQ 'ZNGR'.    "NGR vendor only

      SELECT SINGLE *
        INTO ls_lfb1
        FROM lfb1
        WHERE lifnr = i_lfb1-lifnr
        AND bukrs = i_lfb1-bukrs
        AND bukrs IN ltr_company_codes.

      CHECK ls_lfa1 IS NOT INITIAL AND ls_lfb1 IS NOT INITIAL.
      IF ls_lfb1-zahls EQ '1' AND ls_lfa1-zzext_block NE '' AND i_lfb1-zahls EQ ''.
        MESSAGE i001(zngr).
*      ELSEIF ( ls_lfa1-zzext_ngr_gstchange EQ 'X' AND i_lfb1-zahls EQ '' AND ls_lfb1-zahls NE '' ).
      ELSEIF ( ls_lfb1-zzext_ngr_gstchange EQ 'X' AND i_lfb1-zahls EQ '' AND ls_lfb1-zahls NE '' ).
        SELECT COUNT(*)
               FROM bsik
               WHERE lifnr = i_lfb1-lifnr
               AND bukrs EQ i_lfb1-bukrs.

        IF sy-dbcnt NE 0 AND ls_lfb1-zahls NE '2'. "don't pop up if it's already 2
          MESSAGE i002(zngr).
        ENDIF.

      ELSEIF ( ls_lfb1-zzext_ngr_gstchange EQ 'X' AND i_lfb1-zahls EQ '' AND ls_lfb1-zahls NE '2' ).
        MESSAGE i002(zngr).

      ELSEIF ( i_lfb1-zahls EQ '1' AND ls_lfb1-zahls NE '1' and ls_lfa1-zzext_block EQ '' ). "manually applied '1' - popup
        MESSAGE i003(zngr).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  method IF_EX_VENDOR_ADD_DATA~CHECK_DATA_CHANGED.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~GET_CHANGEDOCS_FOR_OWN_TABLES.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~INITIALIZE_ADD_ON_DATA.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~MODIFY_ACCOUNT_NUMBER.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~PRESET_VALUES_CCODE.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~PRESET_VALUES_PORG.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~PRESET_VALUES_PORG_ALTERNATIVE.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~READ_ADD_ON_DATA.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~SAVE_DATA.
  endmethod.


  method IF_EX_VENDOR_ADD_DATA~SET_USER_INPUTS.
  endmethod.
ENDCLASS.
