// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email Address`
  String get email {
    return Intl.message('Email Address', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Please enter email`
  String get please_enter_email {
    return Intl.message(
      'Please enter email',
      name: 'please_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get please_enter_valid_email {
    return Intl.message(
      'Please enter a valid email address',
      name: 'please_enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get please_enter_your_password {
    return Intl.message(
      'Please enter your password',
      name: 'please_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message('Remember me', name: 'remember_me', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Continue with Google`
  String get continue_with_google {
    return Intl.message(
      'Continue with Google',
      name: 'continue_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continue_with_facebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continue_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get continue_with_apple {
    return Intl.message(
      'Continue with Apple',
      name: 'continue_with_apple',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message('OR', name: 'or', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message('Sign up', name: 'sign_up', desc: '', args: []);
  }

  /// `Please enter your First Name`
  String get please_enter_your_first_name {
    return Intl.message(
      'Please enter your First Name',
      name: 'please_enter_your_first_name',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Please enter your Last Name`
  String get please_enter_your_last_name {
    return Intl.message(
      'Please enter your Last Name',
      name: 'please_enter_your_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get password_must_be_at_least_8_characters {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'password_must_be_at_least_8_characters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get please_enter_password {
    return Intl.message(
      'Please enter password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `SETTINGS`
  String get settings {
    return Intl.message('SETTINGS', name: 'settings', desc: '', args: []);
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email To Receive Reset Code`
  String get enter_your_email_to_receive_reset_code {
    return Intl.message(
      'Enter Your Email To Receive Reset Code',
      name: 'enter_your_email_to_receive_reset_code',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuex {
    return Intl.message('Continue', name: 'continuex', desc: '', args: []);
  }

  /// `We've sent an email to`
  String get we_have_sent_an_email_to {
    return Intl.message(
      'We\'ve sent an email to',
      name: 'we_have_sent_an_email_to',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code`
  String get enter_code {
    return Intl.message('Enter Code', name: 'enter_code', desc: '', args: []);
  }

  /// `Please enter code sent to your email`
  String get please_enter_code_sent_to_your_email {
    return Intl.message(
      'Please enter code sent to your email',
      name: 'please_enter_code_sent_to_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive a code.`
  String get didnt_receive_code {
    return Intl.message(
      'Didn\'t receive a code.',
      name: 'didnt_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `VERIFY YOUR IDENTITY`
  String get verify_your_identity {
    return Intl.message(
      'VERIFY YOUR IDENTITY',
      name: 'verify_your_identity',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enter_your_new_password {
    return Intl.message(
      'Enter your new password',
      name: 'enter_your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get please_confirm_your_password {
    return Intl.message(
      'Please confirm your password',
      name: 'please_confirm_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `FINISH`
  String get finish {
    return Intl.message('FINISH', name: 'finish', desc: '', args: []);
  }

  /// `RATE APP`
  String get rate_app {
    return Intl.message('RATE APP', name: 'rate_app', desc: '', args: []);
  }

  /// `REVIEW`
  String get review {
    return Intl.message('REVIEW', name: 'review', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Edit Your Profile`
  String get edit_your_profile {
    return Intl.message(
      'Edit Your Profile',
      name: 'edit_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Change Your Password`
  String get change_your_password {
    return Intl.message(
      'Change Your Password',
      name: 'change_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Languages`
  String get languages {
    return Intl.message('Languages', name: 'languages', desc: '', args: []);
  }

  /// `PROFILE`
  String get profile {
    return Intl.message('PROFILE', name: 'profile', desc: '', args: []);
  }

  /// `Change Photo`
  String get change_photo {
    return Intl.message(
      'Change Photo',
      name: 'change_photo',
      desc: '',
      args: [],
    );
  }

  /// `Profile Updated Successfully`
  String get profile_updated_successfully {
    return Intl.message(
      'Profile Updated Successfully',
      name: 'profile_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile`
  String get failed_to_update_profile {
    return Intl.message(
      'Failed to update profile',
      name: 'failed_to_update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Choose from Gallery`
  String get choose_from_gallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'choose_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a Picture`
  String get take_a_picture {
    return Intl.message(
      'Take a Picture',
      name: 'take_a_picture',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enter_new_password {
    return Intl.message(
      'Enter New Password',
      name: 'enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Fitrix`
  String get app_name {
    return Intl.message('Fitrix', name: 'app_name', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Workouts`
  String get workouts {
    return Intl.message('Workouts', name: 'workouts', desc: '', args: []);
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Trainees`
  String get trainees {
    return Intl.message('Trainees', name: 'trainees', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Today's Stats`
  String get today_stats {
    return Intl.message(
      'Today\'s Stats',
      name: 'today_stats',
      desc: '',
      args: [],
    );
  }

  /// `Recent Workouts`
  String get recent_workouts {
    return Intl.message(
      'Recent Workouts',
      name: 'recent_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Body Progress`
  String get body_progress {
    return Intl.message(
      'Body Progress',
      name: 'body_progress',
      desc: '',
      args: [],
    );
  }

  /// `Personal Records`
  String get personal_records {
    return Intl.message(
      'Personal Records',
      name: 'personal_records',
      desc: '',
      args: [],
    );
  }

  /// `My Trainees`
  String get my_trainees {
    return Intl.message('My Trainees', name: 'my_trainees', desc: '', args: []);
  }

  /// `Quick Actions`
  String get quick_actions {
    return Intl.message(
      'Quick Actions',
      name: 'quick_actions',
      desc: '',
      args: [],
    );
  }

  /// `Start Workout`
  String get start_workout {
    return Intl.message(
      'Start Workout',
      name: 'start_workout',
      desc: '',
      args: [],
    );
  }

  /// `Log Measurement`
  String get log_measurement {
    return Intl.message(
      'Log Measurement',
      name: 'log_measurement',
      desc: '',
      args: [],
    );
  }

  /// `View All Workouts`
  String get view_all_workouts {
    return Intl.message(
      'View All Workouts',
      name: 'view_all_workouts',
      desc: '',
      args: [],
    );
  }

  /// `View All Trainees`
  String get view_all_trainees {
    return Intl.message(
      'View All Trainees',
      name: 'view_all_trainees',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all {
    return Intl.message('View All', name: 'view_all', desc: '', args: []);
  }

  /// `Manage Trainees`
  String get manage_trainees {
    return Intl.message(
      'Manage Trainees',
      name: 'manage_trainees',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Session`
  String get schedule_session {
    return Intl.message(
      'Schedule Session',
      name: 'schedule_session',
      desc: '',
      args: [],
    );
  }

  /// `Add Trainee`
  String get add_trainee {
    return Intl.message('Add Trainee', name: 'add_trainee', desc: '', args: []);
  }

  /// `Active Trainees`
  String get active_trainees {
    return Intl.message(
      'Active Trainees',
      name: 'active_trainees',
      desc: '',
      args: [],
    );
  }

  /// `No trainees yet`
  String get no_trainees_yet {
    return Intl.message(
      'No trainees yet',
      name: 'no_trainees_yet',
      desc: '',
      args: [],
    );
  }

  /// `Add your first trainee to get started`
  String get add_first_trainee {
    return Intl.message(
      'Add your first trainee to get started',
      name: 'add_first_trainee',
      desc: '',
      args: [],
    );
  }

  /// `No recent workouts`
  String get no_recent_workouts {
    return Intl.message(
      'No recent workouts',
      name: 'no_recent_workouts',
      desc: '',
      args: [],
    );
  }

  /// `No personal records yet`
  String get no_personal_records_yet {
    return Intl.message(
      'No personal records yet',
      name: 'no_personal_records_yet',
      desc: '',
      args: [],
    );
  }

  /// `This Month`
  String get this_month {
    return Intl.message('This Month', name: 'this_month', desc: '', args: []);
  }

  /// `Avg Duration`
  String get avg_duration {
    return Intl.message(
      'Avg Duration',
      name: 'avg_duration',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Completion`
  String get completion {
    return Intl.message('Completion', name: 'completion', desc: '', args: []);
  }

  /// `Rate`
  String get rate {
    return Intl.message('Rate', name: 'rate', desc: '', args: []);
  }

  /// `Current Weight`
  String get current_weight {
    return Intl.message(
      'Current Weight',
      name: 'current_weight',
      desc: '',
      args: [],
    );
  }

  /// `Weight Change`
  String get weight_change {
    return Intl.message(
      'Weight Change',
      name: 'weight_change',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat`
  String get body_fat {
    return Intl.message('Body Fat', name: 'body_fat', desc: '', args: []);
  }

  /// `Muscle Mass`
  String get muscle_mass {
    return Intl.message('Muscle Mass', name: 'muscle_mass', desc: '', args: []);
  }

  /// `kg`
  String get kg {
    return Intl.message('kg', name: 'kg', desc: '', args: []);
  }

  /// `Exercises`
  String get exercises {
    return Intl.message('Exercises', name: 'exercises', desc: '', args: []);
  }

  /// `Sets`
  String get sets {
    return Intl.message('Sets', name: 'sets', desc: '', args: []);
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `In Progress`
  String get in_progress {
    return Intl.message('In Progress', name: 'in_progress', desc: '', args: []);
  }

  /// `Total Workouts`
  String get total_workouts {
    return Intl.message(
      'Total Workouts',
      name: 'total_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Last Workout`
  String get last_workout {
    return Intl.message(
      'Last Workout',
      name: 'last_workout',
      desc: '',
      args: [],
    );
  }

  /// `Trainer`
  String get trainer {
    return Intl.message('Trainer', name: 'trainer', desc: '', args: []);
  }

  /// `User`
  String get user {
    return Intl.message('User', name: 'user', desc: '', args: []);
  }

  /// `Welcome Trainer!`
  String get welcome_trainer {
    return Intl.message(
      'Welcome Trainer!',
      name: 'welcome_trainer',
      desc: '',
      args: [],
    );
  }

  /// `Error loading data`
  String get error_loading_data {
    return Intl.message(
      'Error loading data',
      name: 'error_loading_data',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `No data available`
  String get no_data_available {
    return Intl.message(
      'No data available',
      name: 'no_data_available',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get some_thing_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'some_thing_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Bad Request - The request was invalid or cannot be processed`
  String get error_400 {
    return Intl.message(
      'Bad Request - The request was invalid or cannot be processed',
      name: 'error_400',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized - Please login to continue`
  String get error_401 {
    return Intl.message(
      'Unauthorized - Please login to continue',
      name: 'error_401',
      desc: '',
      args: [],
    );
  }

  /// `Forbidden - You don't have permission to access this resource`
  String get error_401_403 {
    return Intl.message(
      'Forbidden - You don\'t have permission to access this resource',
      name: 'error_401_403',
      desc: '',
      args: [],
    );
  }

  /// `Forbidden - Access denied`
  String get error_403 {
    return Intl.message(
      'Forbidden - Access denied',
      name: 'error_403',
      desc: '',
      args: [],
    );
  }

  /// `Not Found - The requested resource was not found`
  String get error_404 {
    return Intl.message(
      'Not Found - The requested resource was not found',
      name: 'error_404',
      desc: '',
      args: [],
    );
  }

  /// `Method Not Allowed - The request method is not supported`
  String get error_405 {
    return Intl.message(
      'Method Not Allowed - The request method is not supported',
      name: 'error_405',
      desc: '',
      args: [],
    );
  }

  /// `Not Acceptable - The server cannot produce a response matching the request`
  String get error_406 {
    return Intl.message(
      'Not Acceptable - The server cannot produce a response matching the request',
      name: 'error_406',
      desc: '',
      args: [],
    );
  }

  /// `Request Timeout - The request took too long to process`
  String get error_408 {
    return Intl.message(
      'Request Timeout - The request took too long to process',
      name: 'error_408',
      desc: '',
      args: [],
    );
  }

  /// `Conflict - The request conflicts with the current state of the server`
  String get error_409 {
    return Intl.message(
      'Conflict - The request conflicts with the current state of the server',
      name: 'error_409',
      desc: '',
      args: [],
    );
  }

  /// `Gone - The requested resource is no longer available`
  String get error_410 {
    return Intl.message(
      'Gone - The requested resource is no longer available',
      name: 'error_410',
      desc: '',
      args: [],
    );
  }

  /// `Length Required - Content-Length header is missing`
  String get error_411 {
    return Intl.message(
      'Length Required - Content-Length header is missing',
      name: 'error_411',
      desc: '',
      args: [],
    );
  }

  /// `Precondition Failed - One or more conditions in the request failed`
  String get error_412 {
    return Intl.message(
      'Precondition Failed - One or more conditions in the request failed',
      name: 'error_412',
      desc: '',
      args: [],
    );
  }

  /// `Payload Too Large - The request is larger than the server is willing to process`
  String get error_413 {
    return Intl.message(
      'Payload Too Large - The request is larger than the server is willing to process',
      name: 'error_413',
      desc: '',
      args: [],
    );
  }

  /// `URI Too Long - The request URI is too long`
  String get error_414 {
    return Intl.message(
      'URI Too Long - The request URI is too long',
      name: 'error_414',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Media Type - The media type is not supported`
  String get error_415 {
    return Intl.message(
      'Unsupported Media Type - The media type is not supported',
      name: 'error_415',
      desc: '',
      args: [],
    );
  }

  /// `Unprocessable Entity - The request was well-formed but contains invalid data`
  String get error_422 {
    return Intl.message(
      'Unprocessable Entity - The request was well-formed but contains invalid data',
      name: 'error_422',
      desc: '',
      args: [],
    );
  }

  /// `Too Many Requests - You have sent too many requests in a given time`
  String get error_429 {
    return Intl.message(
      'Too Many Requests - You have sent too many requests in a given time',
      name: 'error_429',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error - Something went wrong on the server`
  String get error_500 {
    return Intl.message(
      'Internal Server Error - Something went wrong on the server',
      name: 'error_500',
      desc: '',
      args: [],
    );
  }

  /// `Not Implemented - The server does not support this functionality`
  String get error_501 {
    return Intl.message(
      'Not Implemented - The server does not support this functionality',
      name: 'error_501',
      desc: '',
      args: [],
    );
  }

  /// `Bad Gateway - Invalid response from the upstream server`
  String get error_502 {
    return Intl.message(
      'Bad Gateway - Invalid response from the upstream server',
      name: 'error_502',
      desc: '',
      args: [],
    );
  }

  /// `Service Unavailable - The server is temporarily unable to handle the request`
  String get error_503 {
    return Intl.message(
      'Service Unavailable - The server is temporarily unable to handle the request',
      name: 'error_503',
      desc: '',
      args: [],
    );
  }

  /// `Gateway Timeout - The upstream server failed to respond in time`
  String get error_504 {
    return Intl.message(
      'Gateway Timeout - The upstream server failed to respond in time',
      name: 'error_504',
      desc: '',
      args: [],
    );
  }

  /// `HTTP Version Not Supported - The HTTP version is not supported`
  String get error_505 {
    return Intl.message(
      'HTTP Version Not Supported - The HTTP version is not supported',
      name: 'error_505',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error - Something unexpected happened`
  String get error_unexpected {
    return Intl.message(
      'Unexpected Error - Something unexpected happened',
      name: 'error_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `Network Error - Please check your internet connection`
  String get error_network {
    return Intl.message(
      'Network Error - Please check your internet connection',
      name: 'error_network',
      desc: '',
      args: [],
    );
  }

  /// `Connection Timeout - The request took too long`
  String get error_timeout {
    return Intl.message(
      'Connection Timeout - The request took too long',
      name: 'error_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Request Cancelled - The request was cancelled`
  String get error_cancelled {
    return Intl.message(
      'Request Cancelled - The request was cancelled',
      name: 'error_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error - Unable to connect to server`
  String get error_connection {
    return Intl.message(
      'Connection Error - Unable to connect to server',
      name: 'error_connection',
      desc: '',
      args: [],
    );
  }

  /// `Page Not Found`
  String get not_found_subtitle {
    return Intl.message(
      'Page Not Found',
      name: 'not_found_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `The page you are looking for doesn't exist or has been moved. Please check the URL or go back to the home page.`
  String get not_found_description {
    return Intl.message(
      'The page you are looking for doesn\'t exist or has been moved. Please check the URL or go back to the home page.',
      name: 'not_found_description',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Contact our support team.`
  String get contact_us_help {
    return Intl.message(
      'Need help? Contact our support team.',
      name: 'contact_us_help',
      desc: '',
      args: [],
    );
  }

  /// `My Workouts`
  String get my_workouts {
    return Intl.message('My Workouts', name: 'my_workouts', desc: '', args: []);
  }

  /// `Create Workout`
  String get create_workout {
    return Intl.message(
      'Create Workout',
      name: 'create_workout',
      desc: '',
      args: [],
    );
  }

  /// `Workout History`
  String get workout_history {
    return Intl.message(
      'Workout History',
      name: 'workout_history',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `This Week`
  String get this_week {
    return Intl.message('This Week', name: 'this_week', desc: '', args: []);
  }

  /// `No workouts found`
  String get no_workouts_found {
    return Intl.message(
      'No workouts found',
      name: 'no_workouts_found',
      desc: '',
      args: [],
    );
  }

  /// `Start tracking your workouts`
  String get start_tracking {
    return Intl.message(
      'Start tracking your workouts',
      name: 'start_tracking',
      desc: '',
      args: [],
    );
  }

  /// `My Progress`
  String get my_progress {
    return Intl.message('My Progress', name: 'my_progress', desc: '', args: []);
  }

  /// `Weight Progress`
  String get weight_progress {
    return Intl.message(
      'Weight Progress',
      name: 'weight_progress',
      desc: '',
      args: [],
    );
  }

  /// `Measurements`
  String get measurements {
    return Intl.message(
      'Measurements',
      name: 'measurements',
      desc: '',
      args: [],
    );
  }

  /// `Goals`
  String get goals {
    return Intl.message('Goals', name: 'goals', desc: '', args: []);
  }

  /// `Achievements`
  String get achievements {
    return Intl.message(
      'Achievements',
      name: 'achievements',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message('Statistics', name: 'statistics', desc: '', args: []);
  }

  /// `No progress data available`
  String get no_progress_data {
    return Intl.message(
      'No progress data available',
      name: 'no_progress_data',
      desc: '',
      args: [],
    );
  }

  /// `Chest`
  String get chest {
    return Intl.message('Chest', name: 'chest', desc: '', args: []);
  }

  /// `Waist`
  String get waist {
    return Intl.message('Waist', name: 'waist', desc: '', args: []);
  }

  /// `Hips`
  String get hips {
    return Intl.message('Hips', name: 'hips', desc: '', args: []);
  }

  /// `Arms`
  String get arms {
    return Intl.message('Arms', name: 'arms', desc: '', args: []);
  }

  /// `Thighs`
  String get thighs {
    return Intl.message('Thighs', name: 'thighs', desc: '', args: []);
  }

  /// `cm`
  String get cm {
    return Intl.message('cm', name: 'cm', desc: '', args: []);
  }

  /// `Personal Information`
  String get personal_information {
    return Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get app_settings {
    return Intl.message(
      'App Settings',
      name: 'app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help_support {
    return Intl.message(
      'Help & Support',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Member Since`
  String get member_since {
    return Intl.message(
      'Member Since',
      name: 'member_since',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Contact Support`
  String get contact_support {
    return Intl.message(
      'Contact Support',
      name: 'contact_support',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Workout Sections`
  String get workout_sections {
    return Intl.message(
      'Workout Sections',
      name: 'workout_sections',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message('Custom', name: 'custom', desc: '', args: []);
  }

  /// `Log`
  String get log {
    return Intl.message('Log', name: 'log', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Legs`
  String get legs {
    return Intl.message('Legs', name: 'legs', desc: '', args: []);
  }

  /// `Shoulders`
  String get shoulders {
    return Intl.message('Shoulders', name: 'shoulders', desc: '', args: []);
  }

  /// `Core`
  String get core {
    return Intl.message('Core', name: 'core', desc: '', args: []);
  }

  /// `Chest exercises for upper body strength`
  String get chest_description {
    return Intl.message(
      'Chest exercises for upper body strength',
      name: 'chest_description',
      desc: '',
      args: [],
    );
  }

  /// `Build a strong and wide back`
  String get back_description {
    return Intl.message(
      'Build a strong and wide back',
      name: 'back_description',
      desc: '',
      args: [],
    );
  }

  /// `Leg day for lower body power`
  String get legs_description {
    return Intl.message(
      'Leg day for lower body power',
      name: 'legs_description',
      desc: '',
      args: [],
    );
  }

  /// `Shoulder exercises for definition`
  String get shoulders_description {
    return Intl.message(
      'Shoulder exercises for definition',
      name: 'shoulders_description',
      desc: '',
      args: [],
    );
  }

  /// `Biceps and triceps exercises`
  String get arms_description {
    return Intl.message(
      'Biceps and triceps exercises',
      name: 'arms_description',
      desc: '',
      args: [],
    );
  }

  /// `Strengthen your core and abs`
  String get core_description {
    return Intl.message(
      'Strengthen your core and abs',
      name: 'core_description',
      desc: '',
      args: [],
    );
  }

  /// `Search exercises...`
  String get search_exercises {
    return Intl.message(
      'Search exercises...',
      name: 'search_exercises',
      desc: '',
      args: [],
    );
  }

  /// `Beginner`
  String get beginner {
    return Intl.message('Beginner', name: 'beginner', desc: '', args: []);
  }

  /// `Intermediate`
  String get intermediate {
    return Intl.message(
      'Intermediate',
      name: 'intermediate',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message('Advanced', name: 'advanced', desc: '', args: []);
  }

  /// `Sort By`
  String get sort_by {
    return Intl.message('Sort By', name: 'sort_by', desc: '', args: []);
  }

  /// `Name (A-Z)`
  String get name_a_z {
    return Intl.message('Name (A-Z)', name: 'name_a_z', desc: '', args: []);
  }

  /// `Difficulty`
  String get difficulty {
    return Intl.message('Difficulty', name: 'difficulty', desc: '', args: []);
  }

  /// `Most Popular`
  String get most_popular {
    return Intl.message(
      'Most Popular',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `No exercises found`
  String get no_exercises_found {
    return Intl.message(
      'No exercises found',
      name: 'no_exercises_found',
      desc: '',
      args: [],
    );
  }

  /// `Try adjusting your search or filter`
  String get try_adjusting_search {
    return Intl.message(
      'Try adjusting your search or filter',
      name: 'try_adjusting_search',
      desc: '',
      args: [],
    );
  }

  /// `Create Custom`
  String get create_custom {
    return Intl.message(
      'Create Custom',
      name: 'create_custom',
      desc: '',
      args: [],
    );
  }

  /// `Target Muscles`
  String get target_muscles {
    return Intl.message(
      'Target Muscles',
      name: 'target_muscles',
      desc: '',
      args: [],
    );
  }

  /// `Add to Workout`
  String get add_to_workout {
    return Intl.message(
      'Add to Workout',
      name: 'add_to_workout',
      desc: '',
      args: [],
    );
  }

  /// `Added to workout`
  String get added_to_workout {
    return Intl.message(
      'Added to workout',
      name: 'added_to_workout',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `My Custom Exercises`
  String get my_custom_exercises {
    return Intl.message(
      'My Custom Exercises',
      name: 'my_custom_exercises',
      desc: '',
      args: [],
    );
  }

  /// `No Custom Exercises Yet`
  String get no_custom_exercises_yet {
    return Intl.message(
      'No Custom Exercises Yet',
      name: 'no_custom_exercises_yet',
      desc: '',
      args: [],
    );
  }

  /// `Create your own exercises to personalize your workouts`
  String get create_your_own_exercises {
    return Intl.message(
      'Create your own exercises to personalize your workouts',
      name: 'create_your_own_exercises',
      desc: '',
      args: [],
    );
  }

  /// `Create Your First Exercise`
  String get create_your_first_exercise {
    return Intl.message(
      'Create Your First Exercise',
      name: 'create_your_first_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Create Custom Exercise`
  String get create_custom_exercise {
    return Intl.message(
      'Create Custom Exercise',
      name: 'create_custom_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Edit Exercise`
  String get edit_exercise {
    return Intl.message(
      'Edit Exercise',
      name: 'edit_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Delete Exercise`
  String get delete_exercise {
    return Intl.message(
      'Delete Exercise',
      name: 'delete_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Name`
  String get exercise_name {
    return Intl.message(
      'Exercise Name',
      name: 'exercise_name',
      desc: '',
      args: [],
    );
  }

  /// `Section`
  String get section {
    return Intl.message('Section', name: 'section', desc: '', args: []);
  }

  /// `Exercise created successfully`
  String get exercise_created_successfully {
    return Intl.message(
      'Exercise created successfully',
      name: 'exercise_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete Exercise?`
  String get delete_exercise_confirmation {
    return Intl.message(
      'Delete Exercise?',
      name: 'delete_exercise_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this exercise?`
  String get delete_exercise_message {
    return Intl.message(
      'Are you sure you want to delete this exercise?',
      name: 'delete_exercise_message',
      desc: '',
      args: [],
    );
  }

  /// `Exercise deleted`
  String get exercise_deleted {
    return Intl.message(
      'Exercise deleted',
      name: 'exercise_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Equipment`
  String get equipment {
    return Intl.message('Equipment', name: 'equipment', desc: '', args: []);
  }

  /// `Barbell`
  String get barbell {
    return Intl.message('Barbell', name: 'barbell', desc: '', args: []);
  }

  /// `Dumbbells`
  String get dumbbells {
    return Intl.message('Dumbbells', name: 'dumbbells', desc: '', args: []);
  }

  /// `Cable Machine`
  String get cable_machine {
    return Intl.message(
      'Cable Machine',
      name: 'cable_machine',
      desc: '',
      args: [],
    );
  }

  /// `Bodyweight`
  String get bodyweight {
    return Intl.message('Bodyweight', name: 'bodyweight', desc: '', args: []);
  }

  /// `Machine`
  String get machine {
    return Intl.message('Machine', name: 'machine', desc: '', args: []);
  }

  /// `Pull-up Bar`
  String get pull_up_bar {
    return Intl.message('Pull-up Bar', name: 'pull_up_bar', desc: '', args: []);
  }

  /// `Bench Press`
  String get bench_press {
    return Intl.message('Bench Press', name: 'bench_press', desc: '', args: []);
  }

  /// `Classic compound exercise for chest development. Lie on bench and press barbell up.`
  String get bench_press_description {
    return Intl.message(
      'Classic compound exercise for chest development. Lie on bench and press barbell up.',
      name: 'bench_press_description',
      desc: '',
      args: [],
    );
  }

  /// `Incline Dumbbell Press`
  String get incline_dumbbell_press {
    return Intl.message(
      'Incline Dumbbell Press',
      name: 'incline_dumbbell_press',
      desc: '',
      args: [],
    );
  }

  /// `Target upper chest with incline angle. Press dumbbells upward from incline bench.`
  String get incline_dumbbell_press_description {
    return Intl.message(
      'Target upper chest with incline angle. Press dumbbells upward from incline bench.',
      name: 'incline_dumbbell_press_description',
      desc: '',
      args: [],
    );
  }

  /// `Cable Flyes`
  String get cable_flyes {
    return Intl.message('Cable Flyes', name: 'cable_flyes', desc: '', args: []);
  }

  /// `Isolation exercise for chest. Use cables to bring hands together in front.`
  String get cable_flyes_description {
    return Intl.message(
      'Isolation exercise for chest. Use cables to bring hands together in front.',
      name: 'cable_flyes_description',
      desc: '',
      args: [],
    );
  }

  /// `Push-ups`
  String get push_ups {
    return Intl.message('Push-ups', name: 'push_ups', desc: '', args: []);
  }

  /// `Bodyweight chest exercise. Lower body to ground and push back up.`
  String get push_ups_description {
    return Intl.message(
      'Bodyweight chest exercise. Lower body to ground and push back up.',
      name: 'push_ups_description',
      desc: '',
      args: [],
    );
  }

  /// `Dumbbell Flyes`
  String get dumbbell_flyes {
    return Intl.message(
      'Dumbbell Flyes',
      name: 'dumbbell_flyes',
      desc: '',
      args: [],
    );
  }

  /// `Stretch chest muscles with dumbbell flyes on flat bench.`
  String get dumbbell_flyes_description {
    return Intl.message(
      'Stretch chest muscles with dumbbell flyes on flat bench.',
      name: 'dumbbell_flyes_description',
      desc: '',
      args: [],
    );
  }

  /// `Deadlift`
  String get deadlift {
    return Intl.message('Deadlift', name: 'deadlift', desc: '', args: []);
  }

  /// `King of back exercises. Lift barbell from ground to standing position.`
  String get deadlift_description {
    return Intl.message(
      'King of back exercises. Lift barbell from ground to standing position.',
      name: 'deadlift_description',
      desc: '',
      args: [],
    );
  }

  /// `Pull-ups`
  String get pull_ups {
    return Intl.message('Pull-ups', name: 'pull_ups', desc: '', args: []);
  }

  /// `Bodyweight exercise for lat development. Pull yourself up to bar.`
  String get pull_ups_description {
    return Intl.message(
      'Bodyweight exercise for lat development. Pull yourself up to bar.',
      name: 'pull_ups_description',
      desc: '',
      args: [],
    );
  }

  /// `Barbell Rows`
  String get barbell_rows {
    return Intl.message(
      'Barbell Rows',
      name: 'barbell_rows',
      desc: '',
      args: [],
    );
  }

  /// `Build thick back with bent-over rows. Pull barbell to lower chest.`
  String get barbell_rows_description {
    return Intl.message(
      'Build thick back with bent-over rows. Pull barbell to lower chest.',
      name: 'barbell_rows_description',
      desc: '',
      args: [],
    );
  }

  /// `Lat Pulldown`
  String get lat_pulldown {
    return Intl.message(
      'Lat Pulldown',
      name: 'lat_pulldown',
      desc: '',
      args: [],
    );
  }

  /// `Cable exercise for lats. Pull bar down to upper chest.`
  String get lat_pulldown_description {
    return Intl.message(
      'Cable exercise for lats. Pull bar down to upper chest.',
      name: 'lat_pulldown_description',
      desc: '',
      args: [],
    );
  }

  /// `Squats`
  String get squats {
    return Intl.message('Squats', name: 'squats', desc: '', args: []);
  }

  /// `King of leg exercises. Lower body with barbell on shoulders.`
  String get squats_description {
    return Intl.message(
      'King of leg exercises. Lower body with barbell on shoulders.',
      name: 'squats_description',
      desc: '',
      args: [],
    );
  }

  /// `Leg Press`
  String get leg_press {
    return Intl.message('Leg Press', name: 'leg_press', desc: '', args: []);
  }

  /// `Push weight up with legs on leg press machine.`
  String get leg_press_description {
    return Intl.message(
      'Push weight up with legs on leg press machine.',
      name: 'leg_press_description',
      desc: '',
      args: [],
    );
  }

  /// `Romanian Deadlift`
  String get romanian_deadlift {
    return Intl.message(
      'Romanian Deadlift',
      name: 'romanian_deadlift',
      desc: '',
      args: [],
    );
  }

  /// `Target hamstrings with straight-leg deadlift motion.`
  String get romanian_deadlift_description {
    return Intl.message(
      'Target hamstrings with straight-leg deadlift motion.',
      name: 'romanian_deadlift_description',
      desc: '',
      args: [],
    );
  }

  /// `Leg Curls`
  String get leg_curls {
    return Intl.message('Leg Curls', name: 'leg_curls', desc: '', args: []);
  }

  /// `Isolate hamstrings with leg curl machine.`
  String get leg_curls_description {
    return Intl.message(
      'Isolate hamstrings with leg curl machine.',
      name: 'leg_curls_description',
      desc: '',
      args: [],
    );
  }

  /// `Calf Raises`
  String get calf_raises {
    return Intl.message('Calf Raises', name: 'calf_raises', desc: '', args: []);
  }

  /// `Build calf muscles by raising heels.`
  String get calf_raises_description {
    return Intl.message(
      'Build calf muscles by raising heels.',
      name: 'calf_raises_description',
      desc: '',
      args: [],
    );
  }

  /// `Overhead Press`
  String get overhead_press {
    return Intl.message(
      'Overhead Press',
      name: 'overhead_press',
      desc: '',
      args: [],
    );
  }

  /// `Press barbell overhead for shoulder development.`
  String get overhead_press_description {
    return Intl.message(
      'Press barbell overhead for shoulder development.',
      name: 'overhead_press_description',
      desc: '',
      args: [],
    );
  }

  /// `Lateral Raises`
  String get lateral_raises {
    return Intl.message(
      'Lateral Raises',
      name: 'lateral_raises',
      desc: '',
      args: [],
    );
  }

  /// `Raise dumbbells to sides for shoulder width.`
  String get lateral_raises_description {
    return Intl.message(
      'Raise dumbbells to sides for shoulder width.',
      name: 'lateral_raises_description',
      desc: '',
      args: [],
    );
  }

  /// `Front Raises`
  String get front_raises {
    return Intl.message(
      'Front Raises',
      name: 'front_raises',
      desc: '',
      args: [],
    );
  }

  /// `Raise dumbbells in front for front deltoid focus.`
  String get front_raises_description {
    return Intl.message(
      'Raise dumbbells in front for front deltoid focus.',
      name: 'front_raises_description',
      desc: '',
      args: [],
    );
  }

  /// `Barbell Curls`
  String get barbell_curls {
    return Intl.message(
      'Barbell Curls',
      name: 'barbell_curls',
      desc: '',
      args: [],
    );
  }

  /// `Classic bicep exercise with barbell.`
  String get barbell_curls_description {
    return Intl.message(
      'Classic bicep exercise with barbell.',
      name: 'barbell_curls_description',
      desc: '',
      args: [],
    );
  }

  /// `Tricep Dips`
  String get tricep_dips {
    return Intl.message('Tricep Dips', name: 'tricep_dips', desc: '', args: []);
  }

  /// `Bodyweight exercise for triceps.`
  String get tricep_dips_description {
    return Intl.message(
      'Bodyweight exercise for triceps.',
      name: 'tricep_dips_description',
      desc: '',
      args: [],
    );
  }

  /// `Hammer Curls`
  String get hammer_curls {
    return Intl.message(
      'Hammer Curls',
      name: 'hammer_curls',
      desc: '',
      args: [],
    );
  }

  /// `Curl dumbbells with neutral grip for brachialis.`
  String get hammer_curls_description {
    return Intl.message(
      'Curl dumbbells with neutral grip for brachialis.',
      name: 'hammer_curls_description',
      desc: '',
      args: [],
    );
  }

  /// `Overhead Tricep Extension`
  String get overhead_tricep_extension {
    return Intl.message(
      'Overhead Tricep Extension',
      name: 'overhead_tricep_extension',
      desc: '',
      args: [],
    );
  }

  /// `Extend dumbbell overhead for tricep isolation.`
  String get overhead_tricep_extension_description {
    return Intl.message(
      'Extend dumbbell overhead for tricep isolation.',
      name: 'overhead_tricep_extension_description',
      desc: '',
      args: [],
    );
  }

  /// `Planks`
  String get planks {
    return Intl.message('Planks', name: 'planks', desc: '', args: []);
  }

  /// `Hold body in plank position for core strength.`
  String get planks_description {
    return Intl.message(
      'Hold body in plank position for core strength.',
      name: 'planks_description',
      desc: '',
      args: [],
    );
  }

  /// `Crunches`
  String get crunches {
    return Intl.message('Crunches', name: 'crunches', desc: '', args: []);
  }

  /// `Classic ab exercise. Curl upper body towards knees.`
  String get crunches_description {
    return Intl.message(
      'Classic ab exercise. Curl upper body towards knees.',
      name: 'crunches_description',
      desc: '',
      args: [],
    );
  }

  /// `Russian Twists`
  String get russian_twists {
    return Intl.message(
      'Russian Twists',
      name: 'russian_twists',
      desc: '',
      args: [],
    );
  }

  /// `Rotate torso side to side for obliques.`
  String get russian_twists_description {
    return Intl.message(
      'Rotate torso side to side for obliques.',
      name: 'russian_twists_description',
      desc: '',
      args: [],
    );
  }

  /// `Leg Raises`
  String get leg_raises {
    return Intl.message('Leg Raises', name: 'leg_raises', desc: '', args: []);
  }

  /// `Raise legs for lower ab development.`
  String get leg_raises_description {
    return Intl.message(
      'Raise legs for lower ab development.',
      name: 'leg_raises_description',
      desc: '',
      args: [],
    );
  }

  /// `Upper Chest`
  String get upper_chest {
    return Intl.message('Upper Chest', name: 'upper_chest', desc: '', args: []);
  }

  /// `Triceps`
  String get triceps {
    return Intl.message('Triceps', name: 'triceps', desc: '', args: []);
  }

  /// `Lats`
  String get lats {
    return Intl.message('Lats', name: 'lats', desc: '', args: []);
  }

  /// `Biceps`
  String get biceps {
    return Intl.message('Biceps', name: 'biceps', desc: '', args: []);
  }

  /// `Lower Back`
  String get lower_back {
    return Intl.message('Lower Back', name: 'lower_back', desc: '', args: []);
  }

  /// `Glutes`
  String get glutes {
    return Intl.message('Glutes', name: 'glutes', desc: '', args: []);
  }

  /// `Hamstrings`
  String get hamstrings {
    return Intl.message('Hamstrings', name: 'hamstrings', desc: '', args: []);
  }

  /// `Quads`
  String get quads {
    return Intl.message('Quads', name: 'quads', desc: '', args: []);
  }

  /// `Side Delts`
  String get side_delts {
    return Intl.message('Side Delts', name: 'side_delts', desc: '', args: []);
  }

  /// `Front Delts`
  String get front_delts {
    return Intl.message('Front Delts', name: 'front_delts', desc: '', args: []);
  }

  /// `Forearms`
  String get forearms {
    return Intl.message('Forearms', name: 'forearms', desc: '', args: []);
  }

  /// `Abs`
  String get abs {
    return Intl.message('Abs', name: 'abs', desc: '', args: []);
  }

  /// `Obliques`
  String get obliques {
    return Intl.message('Obliques', name: 'obliques', desc: '', args: []);
  }

  /// `Lower Abs`
  String get lower_abs {
    return Intl.message('Lower Abs', name: 'lower_abs', desc: '', args: []);
  }

  /// `Calves`
  String get calves {
    return Intl.message('Calves', name: 'calves', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Push yourself, because no one else is going to do it for you 💪`
  String get motivational_quote_1 {
    return Intl.message(
      'Push yourself, because no one else is going to do it for you 💪',
      name: 'motivational_quote_1',
      desc: '',
      args: [],
    );
  }

  /// `Great things never come from comfort zones 🔥`
  String get motivational_quote_2 {
    return Intl.message(
      'Great things never come from comfort zones 🔥',
      name: 'motivational_quote_2',
      desc: '',
      args: [],
    );
  }

  /// `The only bad workout is the one that didn't happen ⚡`
  String get motivational_quote_3 {
    return Intl.message(
      'The only bad workout is the one that didn\'t happen ⚡',
      name: 'motivational_quote_3',
      desc: '',
      args: [],
    );
  }

  /// `Your body can stand almost anything. It's your mind that needs convincing 🧠`
  String get motivational_quote_4 {
    return Intl.message(
      'Your body can stand almost anything. It\'s your mind that needs convincing 🧠',
      name: 'motivational_quote_4',
      desc: '',
      args: [],
    );
  }

  /// `Success starts with self-discipline 🎯`
  String get motivational_quote_5 {
    return Intl.message(
      'Success starts with self-discipline 🎯',
      name: 'motivational_quote_5',
      desc: '',
      args: [],
    );
  }

  /// `Train insane or remain the same 🏋️`
  String get motivational_quote_6 {
    return Intl.message(
      'Train insane or remain the same 🏋️',
      name: 'motivational_quote_6',
      desc: '',
      args: [],
    );
  }

  /// `Your only limit is you 🚀`
  String get motivational_quote_7 {
    return Intl.message(
      'Your only limit is you 🚀',
      name: 'motivational_quote_7',
      desc: '',
      args: [],
    );
  }

  /// `Don't wish for it, work for it 💯`
  String get motivational_quote_8 {
    return Intl.message(
      'Don\'t wish for it, work for it 💯',
      name: 'motivational_quote_8',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue your fitness journey`
  String get signInToContinue {
    return Intl.message(
      'Sign in to continue your fitness journey',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message('Remember me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back, {name}!`
  String welcomeBackUser(String name) {
    return Intl.message(
      'Welcome back, $name!',
      name: 'welcomeBackUser',
      desc: '',
      args: [name],
    );
  }

  /// `Please complete your profile to continue`
  String get completeProfileMessage {
    return Intl.message(
      'Please complete your profile to continue',
      name: 'completeProfileMessage',
      desc: '',
      args: [],
    );
  }

  /// `FITRIX`
  String get appName {
    return Intl.message('FITRIX', name: 'appName', desc: '', args: []);
  }

  /// `FIT YOUR LIFE. FIX YOUR FUTURE`
  String get appTagline {
    return Intl.message(
      'FIT YOUR LIFE. FIX YOUR FUTURE',
      name: 'appTagline',
      desc: '',
      args: [],
    );
  }

  /// `Transform Your Body, Transform Your Life`
  String get transformYourLife {
    return Intl.message(
      'Transform Your Body, Transform Your Life',
      name: 'transformYourLife',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registered email and we'll send a reset link.`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter your registered email and we\'ll send a reset link.',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `A password reset link was sent to your email.`
  String get resetLinkSent {
    return Intl.message(
      'A password reset link was sent to your email.',
      name: 'resetLinkSent',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get enterValidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Join Fitrix and start your transformation`
  String get joinFitrix {
    return Intl.message(
      'Join Fitrix and start your transformation',
      name: 'joinFitrix',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Choose a username`
  String get chooseUsername {
    return Intl.message(
      'Choose a username',
      name: 'chooseUsername',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Create a strong password`
  String get createPassword {
    return Intl.message(
      'Create a strong password',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Role`
  String get selectYourRole {
    return Intl.message(
      'Select Your Role',
      name: 'selectYourRole',
      desc: '',
      args: [],
    );
  }

  /// `Normal User`
  String get normalUser {
    return Intl.message('Normal User', name: 'normalUser', desc: '', args: []);
  }

  /// `Track workouts & progress`
  String get normalUserDesc {
    return Intl.message(
      'Track workouts & progress',
      name: 'normalUserDesc',
      desc: '',
      args: [],
    );
  }

  /// `Create & manage plans`
  String get trainerDesc {
    return Intl.message(
      'Create & manage plans',
      name: 'trainerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccountButton {
    return Intl.message(
      'Create Account',
      name: 'createAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful! Welcome {username}`
  String registrationSuccess(String username) {
    return Intl.message(
      'Registration successful! Welcome $username',
      name: 'registrationSuccess',
      desc: '',
      args: [username],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message('Dismiss', name: 'dismiss', desc: '', args: []);
  }

  /// `Username is required`
  String get usernameRequired {
    return Intl.message(
      'Username is required',
      name: 'usernameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Username must be at least 3 characters`
  String get usernameMinLength {
    return Intl.message(
      'Username must be at least 3 characters',
      name: 'usernameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phoneRequired {
    return Intl.message(
      'Phone number is required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid Egyptian phone number (e.g., 01012345678)`
  String get invalidEgyptianPhone {
    return Intl.message(
      'Please enter a valid Egyptian phone number (e.g., 01012345678)',
      name: 'invalidEgyptianPhone',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 11 digits`
  String get phoneExactLength {
    return Intl.message(
      'Phone number must be 11 digits',
      name: 'phoneExactLength',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain uppercase, lowercase and number`
  String get passwordComplexity {
    return Intl.message(
      'Password must contain uppercase, lowercase and number',
      name: 'passwordComplexity',
      desc: '',
      args: [],
    );
  }

  /// `Complete Profile`
  String get completeProfile {
    return Intl.message(
      'Complete Profile',
      name: 'completeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Let's set up your fitness journey`
  String get setupFitnessJourney {
    return Intl.message(
      'Let\'s set up your fitness journey',
      name: 'setupFitnessJourney',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Weight (kg)`
  String get weightKg {
    return Intl.message('Weight (kg)', name: 'weightKg', desc: '', args: []);
  }

  /// `Body Fat %`
  String get bodyFatPercent {
    return Intl.message(
      'Body Fat %',
      name: 'bodyFatPercent',
      desc: '',
      args: [],
    );
  }

  /// `Muscle Mass (kg)`
  String get muscleMassKg {
    return Intl.message(
      'Muscle Mass (kg)',
      name: 'muscleMassKg',
      desc: '',
      args: [],
    );
  }

  /// `Complete Profile`
  String get completeProfileButton {
    return Intl.message(
      'Complete Profile',
      name: 'completeProfileButton',
      desc: '',
      args: [],
    );
  }

  /// `Profile completed! Welcome to Fitrix, {name}!`
  String profileCompletedWelcome(String name) {
    return Intl.message(
      'Profile completed! Welcome to Fitrix, $name!',
      name: 'profileCompletedWelcome',
      desc: '',
      args: [name],
    );
  }

  /// `First name is required`
  String get firstNameRequired {
    return Intl.message(
      'First name is required',
      name: 'firstNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Last name is required`
  String get lastNameRequired {
    return Intl.message(
      'Last name is required',
      name: 'lastNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Gender is required`
  String get genderRequired {
    return Intl.message(
      'Gender is required',
      name: 'genderRequired',
      desc: '',
      args: [],
    );
  }

  /// `Select Male or Female`
  String get selectMaleOrFemale {
    return Intl.message(
      'Select Male or Female',
      name: 'selectMaleOrFemale',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid weight in kg`
  String get enterValidWeight {
    return Intl.message(
      'Enter a valid weight in kg',
      name: 'enterValidWeight',
      desc: '',
      args: [],
    );
  }

  /// `Please check the weight entered`
  String get checkWeightEntered {
    return Intl.message(
      'Please check the weight entered',
      name: 'checkWeightEntered',
      desc: '',
      args: [],
    );
  }

  /// `Enter a number`
  String get enterNumber {
    return Intl.message(
      'Enter a number',
      name: 'enterNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter realistic % fat (1-70)`
  String get enterRealisticBodyFat {
    return Intl.message(
      'Enter realistic % fat (1-70)',
      name: 'enterRealisticBodyFat',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid muscle mass (kg)`
  String get enterValidMuscleMass {
    return Intl.message(
      'Enter a valid muscle mass (kg)',
      name: 'enterValidMuscleMass',
      desc: '',
      args: [],
    );
  }

  /// `Please check muscle mass entered`
  String get checkMuscleMassEntered {
    return Intl.message(
      'Please check muscle mass entered',
      name: 'checkMuscleMassEntered',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Weight is required`
  String get weightRequired {
    return Intl.message(
      'Weight is required',
      name: 'weightRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get enterFirstName {
    return Intl.message(
      'Enter your first name',
      name: 'enterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your last name`
  String get enterLastName {
    return Intl.message(
      'Enter your last name',
      name: 'enterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your weight in kg`
  String get enterWeight {
    return Intl.message(
      'Enter your weight in kg',
      name: 'enterWeight',
      desc: '',
      args: [],
    );
  }

  /// `Enter your body fat percentage (optional)`
  String get enterBodyFat {
    return Intl.message(
      'Enter your body fat percentage (optional)',
      name: 'enterBodyFat',
      desc: '',
      args: [],
    );
  }

  /// `Enter your muscle mass in kg (optional)`
  String get enterMuscleMass {
    return Intl.message(
      'Enter your muscle mass in kg (optional)',
      name: 'enterMuscleMass',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get x {
    return Intl.message('', name: 'x', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
