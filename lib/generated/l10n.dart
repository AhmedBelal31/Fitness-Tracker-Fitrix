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
