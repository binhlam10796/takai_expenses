//
//  Localized.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation

enum Localized: String, CaseIterable {
    // common
    case ok_string
    case cancel_string
    // custom error
    case error_404
    case nil_data_msg
    case generic_localized_net_error_message
    case generic_error_message
    case no_content_found
    case unauthorized_message
    case badRequest_message
    case not_found_message
    case forbidden_message
    case user_not_found_message
    case logout_error_message
    case login_error_message
    case no_connection_error_message
    case url_request_nil
    case no_local_data_found
    case json_decode_error
    case token_refresh_failed
    // splash
    case splash_view_controller_title
    // login
    case login_view_controller_title
    case login_view_controller_email_title
    case login_view_controller_email_hint
    case login_view_controller_password_title
    case login_view_controller_password_hint
    case login_view_controller_login_button
    case login_view_controller_create_account
    case login_view_controller_regiser
    // register
    case register_view_controller_title
    case register_view_controller_name_title
    case register_view_controller_name_hint
    case register_view_controller_name_invalid
    case register_view_controller_email_title
    case register_view_controller_email_hint
    case register_view_controller_email_invalid
    case register_view_controller_password_title
    case register_view_controller_password_hint
    case register_view_controller_password_invalid
    case register_view_controller_register_button
    case register_view_controller_have_account
    case register_view_controller_login
    // fam
    case fam_email_already_exists
    case fam_invalid_email
    case fam_incorrect_password
    case fam_unknown_error
    // home
    case home_view_controller_title
    case home_view_controller_money_unit
    // add expenses
    case add_expenses_view_controller_page_title_add
    case add_expenses_view_controller_page_title_edit
    case add_expenses_view_controller_title
    case add_expenses_view_controller_title_hint
    case add_expenses_view_controller_title_invalid
    case add_expenses_view_controller_date
    case add_expenses_view_controller_date_hint
    case add_expenses_view_controller_date_invalid
    case add_expenses_view_controller_amount
    case add_expenses_view_controller_amount_hint
    case add_expenses_view_controller_amount_invalid
    case add_expenses_view_controller_category
    case add_expenses_view_controller_category_hint
    case add_expenses_view_controller_category_invalid
    case add_expenses_view_controller_location
    case add_expenses_view_controller_location_hint
    case add_expenses_view_controller_location_invalid
    case add_expenses_view_controller_notes
    case add_expenses_view_controller_notes_hint
    case add_expenses_view_controller_notes_invalid
    case add_expenses_view_controller_button_save
    case add_expenses_view_controller_button_edit
    case add_expenses_view_controller_add_category_title
    case add_expenses_view_controller_add_category_hint
}
