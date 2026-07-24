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

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter email`
  String get please_enter_email {
    return Intl.message(
      'Enter email',
      name: 'please_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get please_enter_valid_email {
    return Intl.message(
      'Invalid email',
      name: 'please_enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get please_enter_your_password {
    return Intl.message(
      'Enter password',
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

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Min 8 chars`
  String get password_must_be_at_least_8_characters {
    return Intl.message(
      'Min 8 chars',
      name: 'password_must_be_at_least_8_characters',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get please_enter_password {
    return Intl.message(
      'Enter password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
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

  /// `Enter email for reset code`
  String get enter_your_email_to_receive_reset_code {
    return Intl.message(
      'Enter email for reset code',
      name: 'enter_your_email_to_receive_reset_code',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuex {
    return Intl.message('Continue', name: 'continuex', desc: '', args: []);
  }

  /// `Email sent to`
  String get we_have_sent_an_email_to {
    return Intl.message(
      'Email sent to',
      name: 'we_have_sent_an_email_to',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code`
  String get enter_code {
    return Intl.message('Enter Code', name: 'enter_code', desc: '', args: []);
  }

  /// `Enter code from email`
  String get please_enter_code_sent_to_your_email {
    return Intl.message(
      'Enter code from email',
      name: 'please_enter_code_sent_to_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive code?`
  String get didnt_receive_code {
    return Intl.message(
      'Didn\'t receive code?',
      name: 'didnt_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `Verify Identity`
  String get verify_your_identity {
    return Intl.message(
      'Verify Identity',
      name: 'verify_your_identity',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enter_your_new_password {
    return Intl.message(
      'Enter new password',
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

  /// `Confirm Password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get please_confirm_your_password {
    return Intl.message(
      'Confirm password',
      name: 'please_confirm_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Rate App`
  String get rate_app {
    return Intl.message('Rate App', name: 'rate_app', desc: '', args: []);
  }

  /// `Review`
  String get review {
    return Intl.message('Review', name: 'review', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_your_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_your_password {
    return Intl.message(
      'Change Password',
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

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
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

  /// `Profile updated!`
  String get profile_updated_successfully {
    return Intl.message(
      'Profile updated!',
      name: 'profile_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Update failed`
  String get failed_to_update_profile {
    return Intl.message(
      'Update failed',
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

  /// `Gallery`
  String get choose_from_gallery {
    return Intl.message(
      'Gallery',
      name: 'choose_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get take_a_picture {
    return Intl.message('Camera', name: 'take_a_picture', desc: '', args: []);
  }

  /// `New password`
  String get enter_new_password {
    return Intl.message(
      'New password',
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

  /// `View All`
  String get view_all_workouts {
    return Intl.message(
      'View All',
      name: 'view_all_workouts',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all_trainees {
    return Intl.message(
      'View All',
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

  /// `Add your first trainee`
  String get add_first_trainee {
    return Intl.message(
      'Add your first trainee',
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

  /// `No records yet`
  String get no_personal_records_yet {
    return Intl.message(
      'No records yet',
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

  /// `mins`
  String get minutes {
    return Intl.message('mins', name: 'minutes', desc: '', args: []);
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

  /// `No data available for this period`
  String get no_data_available {
    return Intl.message(
      'No data available for this period',
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

  /// `Invalid request`
  String get error_400 {
    return Intl.message(
      'Invalid request',
      name: 'error_400',
      desc: '',
      args: [],
    );
  }

  /// `Login required`
  String get error_401 {
    return Intl.message(
      'Login required',
      name: 'error_401',
      desc: '',
      args: [],
    );
  }

  /// `Access denied`
  String get error_401_403 {
    return Intl.message(
      'Access denied',
      name: 'error_401_403',
      desc: '',
      args: [],
    );
  }

  /// `Forbidden`
  String get error_403 {
    return Intl.message('Forbidden', name: 'error_403', desc: '', args: []);
  }

  /// `Not found`
  String get error_404 {
    return Intl.message('Not found', name: 'error_404', desc: '', args: []);
  }

  /// `Method not allowed`
  String get error_405 {
    return Intl.message(
      'Method not allowed',
      name: 'error_405',
      desc: '',
      args: [],
    );
  }

  /// `Not acceptable`
  String get error_406 {
    return Intl.message(
      'Not acceptable',
      name: 'error_406',
      desc: '',
      args: [],
    );
  }

  /// `Request timeout`
  String get error_408 {
    return Intl.message(
      'Request timeout',
      name: 'error_408',
      desc: '',
      args: [],
    );
  }

  /// `Conflict`
  String get error_409 {
    return Intl.message('Conflict', name: 'error_409', desc: '', args: []);
  }

  /// `Gone`
  String get error_410 {
    return Intl.message('Gone', name: 'error_410', desc: '', args: []);
  }

  /// `Length required`
  String get error_411 {
    return Intl.message(
      'Length required',
      name: 'error_411',
      desc: '',
      args: [],
    );
  }

  /// `Precondition failed`
  String get error_412 {
    return Intl.message(
      'Precondition failed',
      name: 'error_412',
      desc: '',
      args: [],
    );
  }

  /// `File too large`
  String get error_413 {
    return Intl.message(
      'File too large',
      name: 'error_413',
      desc: '',
      args: [],
    );
  }

  /// `URL too long`
  String get error_414 {
    return Intl.message('URL too long', name: 'error_414', desc: '', args: []);
  }

  /// `Unsupported format`
  String get error_415 {
    return Intl.message(
      'Unsupported format',
      name: 'error_415',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data`
  String get error_422 {
    return Intl.message('Invalid data', name: 'error_422', desc: '', args: []);
  }

  /// `Too many requests`
  String get error_429 {
    return Intl.message(
      'Too many requests',
      name: 'error_429',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get error_500 {
    return Intl.message('Server error', name: 'error_500', desc: '', args: []);
  }

  /// `Not implemented`
  String get error_501 {
    return Intl.message(
      'Not implemented',
      name: 'error_501',
      desc: '',
      args: [],
    );
  }

  /// `Bad gateway`
  String get error_502 {
    return Intl.message('Bad gateway', name: 'error_502', desc: '', args: []);
  }

  /// `Service unavailable`
  String get error_503 {
    return Intl.message(
      'Service unavailable',
      name: 'error_503',
      desc: '',
      args: [],
    );
  }

  /// `Gateway timeout`
  String get error_504 {
    return Intl.message(
      'Gateway timeout',
      name: 'error_504',
      desc: '',
      args: [],
    );
  }

  /// `HTTP version error`
  String get error_505 {
    return Intl.message(
      'HTTP version error',
      name: 'error_505',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error`
  String get error_unexpected {
    return Intl.message(
      'Unexpected error',
      name: 'error_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get error_network {
    return Intl.message(
      'Network error',
      name: 'error_network',
      desc: '',
      args: [],
    );
  }

  /// `Timeout`
  String get error_timeout {
    return Intl.message('Timeout', name: 'error_timeout', desc: '', args: []);
  }

  /// `Cancelled`
  String get error_cancelled {
    return Intl.message(
      'Cancelled',
      name: 'error_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Connection error`
  String get error_connection {
    return Intl.message(
      'Connection error',
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

  /// `Page doesn't exist or moved`
  String get not_found_description {
    return Intl.message(
      'Page doesn\'t exist or moved',
      name: 'not_found_description',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Contact support`
  String get contact_us_help {
    return Intl.message(
      'Need help? Contact support',
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

  /// `History`
  String get workout_history {
    return Intl.message('History', name: 'workout_history', desc: '', args: []);
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

  /// `Start tracking`
  String get start_tracking {
    return Intl.message(
      'Start tracking',
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

  /// `No progress data`
  String get no_progress_data {
    return Intl.message(
      'No progress data',
      name: 'no_progress_data',
      desc: '',
      args: [],
    );
  }

  /// `Chest`
  String get chest {
    return Intl.message('Chest', name: 'chest', desc: '', args: []);
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

  /// `Arms`
  String get arms {
    return Intl.message('Arms', name: 'arms', desc: '', args: []);
  }

  /// `Core`
  String get core {
    return Intl.message('Core', name: 'core', desc: '', args: []);
  }

  /// `Waist`
  String get waist {
    return Intl.message('Waist', name: 'waist', desc: '', args: []);
  }

  /// `Hips`
  String get hips {
    return Intl.message('Hips', name: 'hips', desc: '', args: []);
  }

  /// `Thighs`
  String get thighs {
    return Intl.message('Thighs', name: 'thighs', desc: '', args: []);
  }

  /// `cm`
  String get cm {
    return Intl.message('cm', name: 'cm', desc: '', args: []);
  }

  /// `Personal Info`
  String get personal_information {
    return Intl.message(
      'Personal Info',
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

  /// `Phone`
  String get phone_number {
    return Intl.message('Phone', name: 'phone_number', desc: '', args: []);
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

  /// `Sections`
  String get workout_sections {
    return Intl.message(
      'Sections',
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

  /// `Upper body strength`
  String get chest_description {
    return Intl.message(
      'Upper body strength',
      name: 'chest_description',
      desc: '',
      args: [],
    );
  }

  /// `Strong wide back`
  String get back_description {
    return Intl.message(
      'Strong wide back',
      name: 'back_description',
      desc: '',
      args: [],
    );
  }

  /// `Lower body power`
  String get legs_description {
    return Intl.message(
      'Lower body power',
      name: 'legs_description',
      desc: '',
      args: [],
    );
  }

  /// `Shoulder definition`
  String get shoulders_description {
    return Intl.message(
      'Shoulder definition',
      name: 'shoulders_description',
      desc: '',
      args: [],
    );
  }

  /// `Biceps & triceps`
  String get arms_description {
    return Intl.message(
      'Biceps & triceps',
      name: 'arms_description',
      desc: '',
      args: [],
    );
  }

  /// `Core & abs`
  String get core_description {
    return Intl.message(
      'Core & abs',
      name: 'core_description',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search_exercises {
    return Intl.message(
      'Search...',
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

  /// `Popular`
  String get most_popular {
    return Intl.message('Popular', name: 'most_popular', desc: '', args: []);
  }

  /// `No exercises`
  String get no_exercises_found {
    return Intl.message(
      'No exercises',
      name: 'no_exercises_found',
      desc: '',
      args: [],
    );
  }

  /// `Adjust search`
  String get try_adjusting_search {
    return Intl.message(
      'Adjust search',
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

  /// `Added!`
  String get added_to_workout {
    return Intl.message('Added!', name: 'added_to_workout', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `My Custom`
  String get my_custom_exercises {
    return Intl.message(
      'My Custom',
      name: 'my_custom_exercises',
      desc: '',
      args: [],
    );
  }

  /// `No custom exercises`
  String get no_custom_exercises_yet {
    return Intl.message(
      'No custom exercises',
      name: 'no_custom_exercises_yet',
      desc: '',
      args: [],
    );
  }

  /// `Create your own`
  String get create_your_own_exercises {
    return Intl.message(
      'Create your own',
      name: 'create_your_own_exercises',
      desc: '',
      args: [],
    );
  }

  /// `Create First`
  String get create_your_first_exercise {
    return Intl.message(
      'Create First',
      name: 'create_your_first_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Create Custom`
  String get create_custom_exercise {
    return Intl.message(
      'Create Custom',
      name: 'create_custom_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit_exercise {
    return Intl.message('Edit', name: 'edit_exercise', desc: '', args: []);
  }

  /// `Delete`
  String get delete_exercise {
    return Intl.message('Delete', name: 'delete_exercise', desc: '', args: []);
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

  /// `Created!`
  String get exercise_created_successfully {
    return Intl.message(
      'Created!',
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

  /// `Delete this exercise?`
  String get delete_exercise_message {
    return Intl.message(
      'Delete this exercise?',
      name: 'delete_exercise_message',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get exercise_deleted {
    return Intl.message(
      'Deleted',
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

  /// `Cable`
  String get cable_machine {
    return Intl.message('Cable', name: 'cable_machine', desc: '', args: []);
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

  /// `EZ Bar`
  String get ez_bar {
    return Intl.message('EZ Bar', name: 'ez_bar', desc: '', args: []);
  }

  /// `Kettlebell`
  String get kettlebell {
    return Intl.message('Kettlebell', name: 'kettlebell', desc: '', args: []);
  }

  /// `Weight Plates`
  String get weight_plates {
    return Intl.message(
      'Weight Plates',
      name: 'weight_plates',
      desc: '',
      args: [],
    );
  }

  /// `Smith Machine`
  String get smith_machine {
    return Intl.message(
      'Smith Machine',
      name: 'smith_machine',
      desc: '',
      args: [],
    );
  }

  /// `Leg Press`
  String get leg_press_machine {
    return Intl.message(
      'Leg Press',
      name: 'leg_press_machine',
      desc: '',
      args: [],
    );
  }

  /// `Chest Press`
  String get chest_press_machine {
    return Intl.message(
      'Chest Press',
      name: 'chest_press_machine',
      desc: '',
      args: [],
    );
  }

  /// `Shoulder Press`
  String get shoulder_press_machine {
    return Intl.message(
      'Shoulder Press',
      name: 'shoulder_press_machine',
      desc: '',
      args: [],
    );
  }

  /// `Lat Pulldown`
  String get lat_pulldown_machine {
    return Intl.message(
      'Lat Pulldown',
      name: 'lat_pulldown_machine',
      desc: '',
      args: [],
    );
  }

  /// `Seated Row`
  String get seated_row_machine {
    return Intl.message(
      'Seated Row',
      name: 'seated_row_machine',
      desc: '',
      args: [],
    );
  }

  /// `Leg Curl`
  String get leg_curl_machine {
    return Intl.message(
      'Leg Curl',
      name: 'leg_curl_machine',
      desc: '',
      args: [],
    );
  }

  /// `Leg Extension`
  String get leg_extension_machine {
    return Intl.message(
      'Leg Extension',
      name: 'leg_extension_machine',
      desc: '',
      args: [],
    );
  }

  /// `Hack Squat`
  String get hack_squat_machine {
    return Intl.message(
      'Hack Squat',
      name: 'hack_squat_machine',
      desc: '',
      args: [],
    );
  }

  /// `Pec Deck`
  String get pec_deck_machine {
    return Intl.message(
      'Pec Deck',
      name: 'pec_deck_machine',
      desc: '',
      args: [],
    );
  }

  /// `Treadmill`
  String get treadmill {
    return Intl.message('Treadmill', name: 'treadmill', desc: '', args: []);
  }

  /// `Bike`
  String get stationary_bike {
    return Intl.message('Bike', name: 'stationary_bike', desc: '', args: []);
  }

  /// `Rowing`
  String get rowing_machine {
    return Intl.message('Rowing', name: 'rowing_machine', desc: '', args: []);
  }

  /// `Elliptical`
  String get elliptical_machine {
    return Intl.message(
      'Elliptical',
      name: 'elliptical_machine',
      desc: '',
      args: [],
    );
  }

  /// `Stair Climber`
  String get stair_climber {
    return Intl.message(
      'Stair Climber',
      name: 'stair_climber',
      desc: '',
      args: [],
    );
  }

  /// `Dip Station`
  String get dip_station {
    return Intl.message('Dip Station', name: 'dip_station', desc: '', args: []);
  }

  /// `TRX`
  String get suspension_trainer {
    return Intl.message('TRX', name: 'suspension_trainer', desc: '', args: []);
  }

  /// `Bands`
  String get resistance_bands {
    return Intl.message('Bands', name: 'resistance_bands', desc: '', args: []);
  }

  /// `Battle Ropes`
  String get battle_ropes {
    return Intl.message(
      'Battle Ropes',
      name: 'battle_ropes',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Ball`
  String get medicine_ball {
    return Intl.message(
      'Medicine Ball',
      name: 'medicine_ball',
      desc: '',
      args: [],
    );
  }

  /// `Stability Ball`
  String get stability_ball {
    return Intl.message(
      'Stability Ball',
      name: 'stability_ball',
      desc: '',
      args: [],
    );
  }

  /// `Foam Roller`
  String get foam_roller {
    return Intl.message('Foam Roller', name: 'foam_roller', desc: '', args: []);
  }

  /// `Flat Bench`
  String get flat_bench {
    return Intl.message('Flat Bench', name: 'flat_bench', desc: '', args: []);
  }

  /// `Incline Bench`
  String get incline_bench {
    return Intl.message(
      'Incline Bench',
      name: 'incline_bench',
      desc: '',
      args: [],
    );
  }

  /// `Decline Bench`
  String get decline_bench {
    return Intl.message(
      'Decline Bench',
      name: 'decline_bench',
      desc: '',
      args: [],
    );
  }

  /// `Adjustable Bench`
  String get adjustable_bench {
    return Intl.message(
      'Adjustable Bench',
      name: 'adjustable_bench',
      desc: '',
      args: [],
    );
  }

  /// `Squat Rack`
  String get squat_rack {
    return Intl.message('Squat Rack', name: 'squat_rack', desc: '', args: []);
  }

  /// `Power Rack`
  String get power_rack {
    return Intl.message('Power Rack', name: 'power_rack', desc: '', args: []);
  }

  /// `Ab Wheel`
  String get ab_wheel {
    return Intl.message('Ab Wheel', name: 'ab_wheel', desc: '', args: []);
  }

  /// `Plyo Box`
  String get plyo_box {
    return Intl.message('Plyo Box', name: 'plyo_box', desc: '', args: []);
  }

  /// `Slam Ball`
  String get slam_ball {
    return Intl.message('Slam Ball', name: 'slam_ball', desc: '', args: []);
  }

  /// `Sandbag`
  String get sandbag {
    return Intl.message('Sandbag', name: 'sandbag', desc: '', args: []);
  }

  /// `Rings`
  String get gymnastic_rings {
    return Intl.message('Rings', name: 'gymnastic_rings', desc: '', args: []);
  }

  /// `Parallettes`
  String get parallettes {
    return Intl.message('Parallettes', name: 'parallettes', desc: '', args: []);
  }

  /// `None`
  String get none {
    return Intl.message('None', name: 'none', desc: '', args: []);
  }

  /// `Other`
  String get other_custom {
    return Intl.message('Other', name: 'other_custom', desc: '', args: []);
  }

  /// `Bench Press`
  String get bench_press {
    return Intl.message('Bench Press', name: 'bench_press', desc: '', args: []);
  }

  /// `Classic chest exercise`
  String get bench_press_description {
    return Intl.message(
      'Classic chest exercise',
      name: 'bench_press_description',
      desc: '',
      args: [],
    );
  }

  /// `Incline Press`
  String get incline_dumbbell_press {
    return Intl.message(
      'Incline Press',
      name: 'incline_dumbbell_press',
      desc: '',
      args: [],
    );
  }

  /// `Upper chest focus`
  String get incline_dumbbell_press_description {
    return Intl.message(
      'Upper chest focus',
      name: 'incline_dumbbell_press_description',
      desc: '',
      args: [],
    );
  }

  /// `Cable Flyes`
  String get cable_flyes {
    return Intl.message('Cable Flyes', name: 'cable_flyes', desc: '', args: []);
  }

  /// `Chest isolation`
  String get cable_flyes_description {
    return Intl.message(
      'Chest isolation',
      name: 'cable_flyes_description',
      desc: '',
      args: [],
    );
  }

  /// `Push-ups`
  String get push_ups {
    return Intl.message('Push-ups', name: 'push_ups', desc: '', args: []);
  }

  /// `Bodyweight chest`
  String get push_ups_description {
    return Intl.message(
      'Bodyweight chest',
      name: 'push_ups_description',
      desc: '',
      args: [],
    );
  }

  /// `DB Flyes`
  String get dumbbell_flyes {
    return Intl.message('DB Flyes', name: 'dumbbell_flyes', desc: '', args: []);
  }

  /// `Chest stretch`
  String get dumbbell_flyes_description {
    return Intl.message(
      'Chest stretch',
      name: 'dumbbell_flyes_description',
      desc: '',
      args: [],
    );
  }

  /// `Deadlift`
  String get deadlift {
    return Intl.message('Deadlift', name: 'deadlift', desc: '', args: []);
  }

  /// `King of back`
  String get deadlift_description {
    return Intl.message(
      'King of back',
      name: 'deadlift_description',
      desc: '',
      args: [],
    );
  }

  /// `Pull-ups`
  String get pull_ups {
    return Intl.message('Pull-ups', name: 'pull_ups', desc: '', args: []);
  }

  /// `Lat development`
  String get pull_ups_description {
    return Intl.message(
      'Lat development',
      name: 'pull_ups_description',
      desc: '',
      args: [],
    );
  }

  /// `BB Rows`
  String get barbell_rows {
    return Intl.message('BB Rows', name: 'barbell_rows', desc: '', args: []);
  }

  /// `Thick back`
  String get barbell_rows_description {
    return Intl.message(
      'Thick back',
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

  /// `Cable lats`
  String get lat_pulldown_description {
    return Intl.message(
      'Cable lats',
      name: 'lat_pulldown_description',
      desc: '',
      args: [],
    );
  }

  /// `Squats`
  String get squats {
    return Intl.message('Squats', name: 'squats', desc: '', args: []);
  }

  /// `King of legs`
  String get squats_description {
    return Intl.message(
      'King of legs',
      name: 'squats_description',
      desc: '',
      args: [],
    );
  }

  /// `Leg Press`
  String get leg_press {
    return Intl.message('Leg Press', name: 'leg_press', desc: '', args: []);
  }

  /// `Quad focus`
  String get leg_press_description {
    return Intl.message(
      'Quad focus',
      name: 'leg_press_description',
      desc: '',
      args: [],
    );
  }

  /// `RDL`
  String get romanian_deadlift {
    return Intl.message('RDL', name: 'romanian_deadlift', desc: '', args: []);
  }

  /// `Hamstring focus`
  String get romanian_deadlift_description {
    return Intl.message(
      'Hamstring focus',
      name: 'romanian_deadlift_description',
      desc: '',
      args: [],
    );
  }

  /// `Leg Curls`
  String get leg_curls {
    return Intl.message('Leg Curls', name: 'leg_curls', desc: '', args: []);
  }

  /// `Hamstring isolation`
  String get leg_curls_description {
    return Intl.message(
      'Hamstring isolation',
      name: 'leg_curls_description',
      desc: '',
      args: [],
    );
  }

  /// `Calf Raises`
  String get calf_raises {
    return Intl.message('Calf Raises', name: 'calf_raises', desc: '', args: []);
  }

  /// `Calf building`
  String get calf_raises_description {
    return Intl.message(
      'Calf building',
      name: 'calf_raises_description',
      desc: '',
      args: [],
    );
  }

  /// `OHP`
  String get overhead_press {
    return Intl.message('OHP', name: 'overhead_press', desc: '', args: []);
  }

  /// `Shoulder mass`
  String get overhead_press_description {
    return Intl.message(
      'Shoulder mass',
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

  /// `Shoulder width`
  String get lateral_raises_description {
    return Intl.message(
      'Shoulder width',
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

  /// `Front delts`
  String get front_raises_description {
    return Intl.message(
      'Front delts',
      name: 'front_raises_description',
      desc: '',
      args: [],
    );
  }

  /// `BB Curls`
  String get barbell_curls {
    return Intl.message('BB Curls', name: 'barbell_curls', desc: '', args: []);
  }

  /// `Bicep mass`
  String get barbell_curls_description {
    return Intl.message(
      'Bicep mass',
      name: 'barbell_curls_description',
      desc: '',
      args: [],
    );
  }

  /// `Tricep Dips`
  String get tricep_dips {
    return Intl.message('Tricep Dips', name: 'tricep_dips', desc: '', args: []);
  }

  /// `Tricep size`
  String get tricep_dips_description {
    return Intl.message(
      'Tricep size',
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

  /// `Brachialis`
  String get hammer_curls_description {
    return Intl.message(
      'Brachialis',
      name: 'hammer_curls_description',
      desc: '',
      args: [],
    );
  }

  /// `Tricep Extension`
  String get overhead_tricep_extension {
    return Intl.message(
      'Tricep Extension',
      name: 'overhead_tricep_extension',
      desc: '',
      args: [],
    );
  }

  /// `Tricep isolation`
  String get overhead_tricep_extension_description {
    return Intl.message(
      'Tricep isolation',
      name: 'overhead_tricep_extension_description',
      desc: '',
      args: [],
    );
  }

  /// `Planks`
  String get planks {
    return Intl.message('Planks', name: 'planks', desc: '', args: []);
  }

  /// `Core strength`
  String get planks_description {
    return Intl.message(
      'Core strength',
      name: 'planks_description',
      desc: '',
      args: [],
    );
  }

  /// `Crunches`
  String get crunches {
    return Intl.message('Crunches', name: 'crunches', desc: '', args: []);
  }

  /// `Ab exercise`
  String get crunches_description {
    return Intl.message(
      'Ab exercise',
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

  /// `Obliques`
  String get russian_twists_description {
    return Intl.message(
      'Obliques',
      name: 'russian_twists_description',
      desc: '',
      args: [],
    );
  }

  /// `Leg Raises`
  String get leg_raises {
    return Intl.message('Leg Raises', name: 'leg_raises', desc: '', args: []);
  }

  /// `Lower abs`
  String get leg_raises_description {
    return Intl.message(
      'Lower abs',
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

  /// `Dismiss`
  String get dismiss {
    return Intl.message('Dismiss', name: 'dismiss', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Undo`
  String get undo {
    return Intl.message('Undo', name: 'undo', desc: '', args: []);
  }

  /// `Push yourself! 💪`
  String get motivational_quote_1 {
    return Intl.message(
      'Push yourself! 💪',
      name: 'motivational_quote_1',
      desc: '',
      args: [],
    );
  }

  /// `Great things come from action 🔥`
  String get motivational_quote_2 {
    return Intl.message(
      'Great things come from action 🔥',
      name: 'motivational_quote_2',
      desc: '',
      args: [],
    );
  }

  /// `No bad workout ⚡`
  String get motivational_quote_3 {
    return Intl.message(
      'No bad workout ⚡',
      name: 'motivational_quote_3',
      desc: '',
      args: [],
    );
  }

  /// `Convince your mind 🧠`
  String get motivational_quote_4 {
    return Intl.message(
      'Convince your mind 🧠',
      name: 'motivational_quote_4',
      desc: '',
      args: [],
    );
  }

  /// `Self-discipline wins 🎯`
  String get motivational_quote_5 {
    return Intl.message(
      'Self-discipline wins 🎯',
      name: 'motivational_quote_5',
      desc: '',
      args: [],
    );
  }

  /// `Train hard 🏋️`
  String get motivational_quote_6 {
    return Intl.message(
      'Train hard 🏋️',
      name: 'motivational_quote_6',
      desc: '',
      args: [],
    );
  }

  /// `No limits 🚀`
  String get motivational_quote_7 {
    return Intl.message(
      'No limits 🚀',
      name: 'motivational_quote_7',
      desc: '',
      args: [],
    );
  }

  /// `Work for it 💯`
  String get motivational_quote_8 {
    return Intl.message(
      'Work for it 💯',
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

  /// `Sign in to continue`
  String get signInToContinue {
    return Intl.message(
      'Sign in to continue',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailAddress {
    return Intl.message('Email', name: 'emailAddress', desc: '', args: []);
  }

  /// `Enter email`
  String get enterYourEmail {
    return Intl.message(
      'Enter email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterYourPassword {
    return Intl.message(
      'Enter password',
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

  /// `Email required`
  String get emailRequired {
    return Intl.message(
      'Email required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password required`
  String get passwordRequired {
    return Intl.message(
      'Password required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Min 6 chars`
  String get passwordMinLength {
    return Intl.message(
      'Min 6 chars',
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

  /// `Complete profile to continue`
  String get completeProfileMessage {
    return Intl.message(
      'Complete profile to continue',
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

  /// `Enter email for reset link`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter email for reset link',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send Link`
  String get sendResetLink {
    return Intl.message('Send Link', name: 'sendResetLink', desc: '', args: []);
  }

  /// `Reset link sent to email`
  String get resetLinkSent {
    return Intl.message(
      'Reset link sent to email',
      name: 'resetLinkSent',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid email`
  String get enterValidEmail {
    return Intl.message(
      'Enter valid email',
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

  /// `Join Fitrix`
  String get joinFitrix {
    return Intl.message('Join Fitrix', name: 'joinFitrix', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Choose username`
  String get chooseUsername {
    return Intl.message(
      'Choose username',
      name: 'chooseUsername',
      desc: '',
      args: [],
    );
  }

  /// `Create password`
  String get createPassword {
    return Intl.message(
      'Create password',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `Select Role`
  String get selectYourRole {
    return Intl.message(
      'Select Role',
      name: 'selectYourRole',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get normalUser {
    return Intl.message('User', name: 'normalUser', desc: '', args: []);
  }

  /// `Track workouts`
  String get normalUserDesc {
    return Intl.message(
      'Track workouts',
      name: 'normalUserDesc',
      desc: '',
      args: [],
    );
  }

  /// `Manage plans`
  String get trainerDesc {
    return Intl.message(
      'Manage plans',
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

  /// `Have account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Have account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {username}!`
  String registrationSuccess(String username) {
    return Intl.message(
      'Welcome $username!',
      name: 'registrationSuccess',
      desc: '',
      args: [username],
    );
  }

  /// `Username required`
  String get usernameRequired {
    return Intl.message(
      'Username required',
      name: 'usernameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Min 3 chars`
  String get usernameMinLength {
    return Intl.message(
      'Min 3 chars',
      name: 'usernameMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Phone required`
  String get phoneRequired {
    return Intl.message(
      'Phone required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone`
  String get invalidEgyptianPhone {
    return Intl.message(
      'Invalid phone',
      name: 'invalidEgyptianPhone',
      desc: '',
      args: [],
    );
  }

  /// `11 digits`
  String get phoneExactLength {
    return Intl.message(
      '11 digits',
      name: 'phoneExactLength',
      desc: '',
      args: [],
    );
  }

  /// `Weak password`
  String get passwordComplexity {
    return Intl.message(
      'Weak password',
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

  /// `Setup fitness journey`
  String get setupFitnessJourney {
    return Intl.message(
      'Setup fitness journey',
      name: 'setupFitnessJourney',
      desc: '',
      args: [],
    );
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

  /// `Complete`
  String get completeProfileButton {
    return Intl.message(
      'Complete',
      name: 'completeProfileButton',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {name}!`
  String profileCompletedWelcome(String name) {
    return Intl.message(
      'Welcome $name!',
      name: 'profileCompletedWelcome',
      desc: '',
      args: [name],
    );
  }

  /// `First name required`
  String get firstNameRequired {
    return Intl.message(
      'First name required',
      name: 'firstNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Last name required`
  String get lastNameRequired {
    return Intl.message(
      'Last name required',
      name: 'lastNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Select gender`
  String get genderRequired {
    return Intl.message(
      'Select gender',
      name: 'genderRequired',
      desc: '',
      args: [],
    );
  }

  /// `Male or Female`
  String get selectMaleOrFemale {
    return Intl.message(
      'Male or Female',
      name: 'selectMaleOrFemale',
      desc: '',
      args: [],
    );
  }

  /// `Invalid weight`
  String get enterValidWeight {
    return Intl.message(
      'Invalid weight',
      name: 'enterValidWeight',
      desc: '',
      args: [],
    );
  }

  /// `Check weight`
  String get checkWeightEntered {
    return Intl.message(
      'Check weight',
      name: 'checkWeightEntered',
      desc: '',
      args: [],
    );
  }

  /// `Enter number`
  String get enterNumber {
    return Intl.message(
      'Enter number',
      name: 'enterNumber',
      desc: '',
      args: [],
    );
  }

  /// `Body fat: 1-70%`
  String get enterRealisticBodyFat {
    return Intl.message(
      'Body fat: 1-70%',
      name: 'enterRealisticBodyFat',
      desc: '',
      args: [],
    );
  }

  /// `Invalid muscle`
  String get enterValidMuscleMass {
    return Intl.message(
      'Invalid muscle',
      name: 'enterValidMuscleMass',
      desc: '',
      args: [],
    );
  }

  /// `Check muscle`
  String get checkMuscleMassEntered {
    return Intl.message(
      'Check muscle',
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

  /// `Weight required`
  String get weightRequired {
    return Intl.message(
      'Weight required',
      name: 'weightRequired',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get enterFirstName {
    return Intl.message(
      'First name',
      name: 'enterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get enterLastName {
    return Intl.message('Last name', name: 'enterLastName', desc: '', args: []);
  }

  /// `Weight (kg)`
  String get enterWeight {
    return Intl.message('Weight (kg)', name: 'enterWeight', desc: '', args: []);
  }

  /// `Body fat %`
  String get enterBodyFat {
    return Intl.message('Body fat %', name: 'enterBodyFat', desc: '', args: []);
  }

  /// `Muscle (kg)`
  String get enterMuscleMass {
    return Intl.message(
      'Muscle (kg)',
      name: 'enterMuscleMass',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInformation {
    return Intl.message(
      'Personal Info',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneNumber {
    return Intl.message('Phone', name: 'phoneNumber', desc: '', args: []);
  }

  /// `Member Since`
  String get memberSince {
    return Intl.message(
      'Member Since',
      name: 'memberSince',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message('Role', name: 'role', desc: '', args: []);
  }

  /// `Change Password`
  String get changeYourPassword {
    return Intl.message(
      'Change Password',
      name: 'changeYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacyPolicy {
    return Intl.message('Privacy', name: 'privacyPolicy', desc: '', args: []);
  }

  /// `Terms`
  String get termsConditions {
    return Intl.message('Terms', name: 'termsConditions', desc: '', args: []);
  }

  /// `Support`
  String get contactSupport {
    return Intl.message('Support', name: 'contactSupport', desc: '', args: []);
  }

  /// `Logout`
  String get logoutConfirmTitle {
    return Intl.message(
      'Logout',
      name: 'logoutConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirmMessage {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Logged out`
  String get loggedOutSuccess {
    return Intl.message(
      'Logged out',
      name: 'loggedOutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicyTitle {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get termsConditionsTitle {
    return Intl.message(
      'Terms',
      name: 'termsConditionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get contactSupportTitle {
    return Intl.message(
      'Support',
      name: 'contactSupportTitle',
      desc: '',
      args: [],
    );
  }

  /// `About Fitrix`
  String get aboutTitle {
    return Intl.message('About Fitrix', name: 'aboutTitle', desc: '', args: []);
  }

  /// `Updated`
  String get lastUpdated {
    return Intl.message('Updated', name: 'lastUpdated', desc: '', args: []);
  }

  /// `Email`
  String get sendEmail {
    return Intl.message('Email', name: 'sendEmail', desc: '', args: []);
  }

  /// `Call`
  String get callUs {
    return Intl.message('Call', name: 'callUs', desc: '', args: []);
  }

  /// `WhatsApp`
  String get whatsapp {
    return Intl.message('WhatsApp', name: 'whatsapp', desc: '', args: []);
  }

  /// `Message`
  String get sendMessage {
    return Intl.message('Message', name: 'sendMessage', desc: '', args: []);
  }

  /// `Build`
  String get buildNumber {
    return Intl.message('Build', name: 'buildNumber', desc: '', args: []);
  }

  /// `Developer`
  String get developer {
    return Intl.message('Developer', name: 'developer', desc: '', args: []);
  }

  /// `Website`
  String get website {
    return Intl.message('Website', name: 'website', desc: '', args: []);
  }

  /// `Visit`
  String get visitWebsite {
    return Intl.message('Visit', name: 'visitWebsite', desc: '', args: []);
  }

  /// `Follow Us`
  String get followUs {
    return Intl.message('Follow Us', name: 'followUs', desc: '', args: []);
  }

  /// `Share`
  String get shareApp {
    return Intl.message('Share', name: 'shareApp', desc: '', args: []);
  }

  /// `Introduction`
  String get introduction {
    return Intl.message(
      'Introduction',
      name: 'introduction',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Fitrix. We protect your privacy.`
  String get introductionText {
    return Intl.message(
      'Welcome to Fitrix. We protect your privacy.',
      name: 'introductionText',
      desc: '',
      args: [],
    );
  }

  /// `Data We Collect`
  String get informationWeCollect {
    return Intl.message(
      'Data We Collect',
      name: 'informationWeCollect',
      desc: '',
      args: [],
    );
  }

  /// `We collect:`
  String get informationWeCollectText {
    return Intl.message(
      'We collect:',
      name: 'informationWeCollectText',
      desc: '',
      args: [],
    );
  }

  /// `Personal info`
  String get personalInformationItem {
    return Intl.message(
      'Personal info',
      name: 'personalInformationItem',
      desc: '',
      args: [],
    );
  }

  /// `Profile data`
  String get profileInformationItem {
    return Intl.message(
      'Profile data',
      name: 'profileInformationItem',
      desc: '',
      args: [],
    );
  }

  /// `Health data`
  String get healthDataItem {
    return Intl.message(
      'Health data',
      name: 'healthDataItem',
      desc: '',
      args: [],
    );
  }

  /// `Usage data`
  String get usageDataItem {
    return Intl.message(
      'Usage data',
      name: 'usageDataItem',
      desc: '',
      args: [],
    );
  }

  /// `How We Use Data`
  String get howWeUseInfo {
    return Intl.message(
      'How We Use Data',
      name: 'howWeUseInfo',
      desc: '',
      args: [],
    );
  }

  /// `We use data to:`
  String get howWeUseInfoText {
    return Intl.message(
      'We use data to:',
      name: 'howWeUseInfoText',
      desc: '',
      args: [],
    );
  }

  /// `Provide services`
  String get provideServicesItem {
    return Intl.message(
      'Provide services',
      name: 'provideServicesItem',
      desc: '',
      args: [],
    );
  }

  /// `Personalize`
  String get personalizeExperienceItem {
    return Intl.message(
      'Personalize',
      name: 'personalizeExperienceItem',
      desc: '',
      args: [],
    );
  }

  /// `Track progress`
  String get trackProgressItem {
    return Intl.message(
      'Track progress',
      name: 'trackProgressItem',
      desc: '',
      args: [],
    );
  }

  /// `Send updates`
  String get sendNotificationsItem {
    return Intl.message(
      'Send updates',
      name: 'sendNotificationsItem',
      desc: '',
      args: [],
    );
  }

  /// `Improve app`
  String get improveServicesItem {
    return Intl.message(
      'Improve app',
      name: 'improveServicesItem',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get dataSecurity {
    return Intl.message('Security', name: 'dataSecurity', desc: '', args: []);
  }

  /// `Your data is encrypted`
  String get dataSecurityText {
    return Intl.message(
      'Your data is encrypted',
      name: 'dataSecurityText',
      desc: '',
      args: [],
    );
  }

  /// `Your Rights`
  String get yourRights {
    return Intl.message('Your Rights', name: 'yourRights', desc: '', args: []);
  }

  /// `You can:`
  String get yourRightsText {
    return Intl.message('You can:', name: 'yourRightsText', desc: '', args: []);
  }

  /// `Access data`
  String get accessDataItem {
    return Intl.message(
      'Access data',
      name: 'accessDataItem',
      desc: '',
      args: [],
    );
  }

  /// `Correct data`
  String get correctDataItem {
    return Intl.message(
      'Correct data',
      name: 'correctDataItem',
      desc: '',
      args: [],
    );
  }

  /// `Delete data`
  String get deleteDataItem {
    return Intl.message(
      'Delete data',
      name: 'deleteDataItem',
      desc: '',
      args: [],
    );
  }

  /// `Opt-out`
  String get optOutItem {
    return Intl.message('Opt-out', name: 'optOutItem', desc: '', args: []);
  }

  /// `Export data`
  String get exportDataItem {
    return Intl.message(
      'Export data',
      name: 'exportDataItem',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contactUsSection {
    return Intl.message(
      'Contact',
      name: 'contactUsSection',
      desc: '',
      args: [],
    );
  }

  /// `Questions? Email appfitrix@gmail.com`
  String get contactUsText {
    return Intl.message(
      'Questions? Email appfitrix@gmail.com',
      name: 'contactUsText',
      desc: '',
      args: [],
    );
  }

  /// `Terms Acceptance`
  String get acceptanceOfTerms {
    return Intl.message(
      'Terms Acceptance',
      name: 'acceptanceOfTerms',
      desc: '',
      args: [],
    );
  }

  /// `By using Fitrix, you agree to terms`
  String get acceptanceOfTermsText {
    return Intl.message(
      'By using Fitrix, you agree to terms',
      name: 'acceptanceOfTermsText',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get userAccount {
    return Intl.message('Account', name: 'userAccount', desc: '', args: []);
  }

  /// `You're responsible for:`
  String get userAccountText {
    return Intl.message(
      'You\'re responsible for:',
      name: 'userAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Keep credentials safe`
  String get maintainCredentialsItem {
    return Intl.message(
      'Keep credentials safe',
      name: 'maintainCredentialsItem',
      desc: '',
      args: [],
    );
  }

  /// `All activities`
  String get accountActivitiesItem {
    return Intl.message(
      'All activities',
      name: 'accountActivitiesItem',
      desc: '',
      args: [],
    );
  }

  /// `Accurate info`
  String get accurateInfoItem {
    return Intl.message(
      'Accurate info',
      name: 'accurateInfoItem',
      desc: '',
      args: [],
    );
  }

  /// `Update info`
  String get updateInfoItem {
    return Intl.message(
      'Update info',
      name: 'updateInfoItem',
      desc: '',
      args: [],
    );
  }

  /// `Acceptable Use`
  String get acceptableUse {
    return Intl.message(
      'Acceptable Use',
      name: 'acceptableUse',
      desc: '',
      args: [],
    );
  }

  /// `Don't:`
  String get acceptableUseText {
    return Intl.message(
      'Don\'t:',
      name: 'acceptableUseText',
      desc: '',
      args: [],
    );
  }

  /// `Post inappropriate content`
  String get inappropriateContentItem {
    return Intl.message(
      'Post inappropriate content',
      name: 'inappropriateContentItem',
      desc: '',
      args: [],
    );
  }

  /// `Harass users`
  String get harassUsersItem {
    return Intl.message(
      'Harass users',
      name: 'harassUsersItem',
      desc: '',
      args: [],
    );
  }

  /// `Hack`
  String get unauthorizedAccessItem {
    return Intl.message(
      'Hack',
      name: 'unauthorizedAccessItem',
      desc: '',
      args: [],
    );
  }

  /// `Commercial use`
  String get commercialUseItem {
    return Intl.message(
      'Commercial use',
      name: 'commercialUseItem',
      desc: '',
      args: [],
    );
  }

  /// `Break laws`
  String get violateLawsItem {
    return Intl.message(
      'Break laws',
      name: 'violateLawsItem',
      desc: '',
      args: [],
    );
  }

  /// `Health Notice`
  String get healthDisclaimer {
    return Intl.message(
      'Health Notice',
      name: 'healthDisclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Fitrix tracks fitness but:`
  String get healthDisclaimerText {
    return Intl.message(
      'Fitrix tracks fitness but:',
      name: 'healthDisclaimerText',
      desc: '',
      args: [],
    );
  }

  /// `Not medical advice`
  String get notMedicalAdviceItem {
    return Intl.message(
      'Not medical advice',
      name: 'notMedicalAdviceItem',
      desc: '',
      args: [],
    );
  }

  /// `Consult doctor`
  String get consultProviderItem {
    return Intl.message(
      'Consult doctor',
      name: 'consultProviderItem',
      desc: '',
      args: [],
    );
  }

  /// `Use at risk`
  String get useAtRiskItem {
    return Intl.message(
      'Use at risk',
      name: 'useAtRiskItem',
      desc: '',
      args: [],
    );
  }

  /// `Not liable`
  String get notLiableItem {
    return Intl.message(
      'Not liable',
      name: 'notLiableItem',
      desc: '',
      args: [],
    );
  }

  /// `IP Rights`
  String get intellectualProperty {
    return Intl.message(
      'IP Rights',
      name: 'intellectualProperty',
      desc: '',
      args: [],
    );
  }

  /// `All content owned by us`
  String get intellectualPropertyText {
    return Intl.message(
      'All content owned by us',
      name: 'intellectualPropertyText',
      desc: '',
      args: [],
    );
  }

  /// `Termination`
  String get termination {
    return Intl.message('Termination', name: 'termination', desc: '', args: []);
  }

  /// `We can suspend accounts`
  String get terminationText {
    return Intl.message(
      'We can suspend accounts',
      name: 'terminationText',
      desc: '',
      args: [],
    );
  }

  /// `Term Changes`
  String get changesToTerms {
    return Intl.message(
      'Term Changes',
      name: 'changesToTerms',
      desc: '',
      args: [],
    );
  }

  /// `We can modify terms`
  String get changesToTermsText {
    return Intl.message(
      'We can modify terms',
      name: 'changesToTermsText',
      desc: '',
      args: [],
    );
  }

  /// `Questions? appfitrix@gmail.com`
  String get legalContact {
    return Intl.message(
      'Questions? appfitrix@gmail.com',
      name: 'legalContact',
      desc: '',
      args: [],
    );
  }

  /// `How can we help?`
  String get howCanWeHelp {
    return Intl.message(
      'How can we help?',
      name: 'howCanWeHelp',
      desc: '',
      args: [],
    );
  }

  /// `Support team ready`
  String get supportTeamReady {
    return Intl.message(
      'Support team ready',
      name: 'supportTeamReady',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get frequentlyAskedQuestions {
    return Intl.message(
      'FAQ',
      name: 'frequentlyAskedQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Reset password?`
  String get faqResetPassword {
    return Intl.message(
      'Reset password?',
      name: 'faqResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Tap 'Forgot Password'`
  String get faqResetPasswordAnswer {
    return Intl.message(
      'Tap \'Forgot Password\'',
      name: 'faqResetPasswordAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Sync devices?`
  String get faqSyncData {
    return Intl.message(
      'Sync devices?',
      name: 'faqSyncData',
      desc: '',
      args: [],
    );
  }

  /// `Auto synced`
  String get faqSyncDataAnswer {
    return Intl.message(
      'Auto synced',
      name: 'faqSyncDataAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Track workouts?`
  String get faqTrackWorkouts {
    return Intl.message(
      'Track workouts?',
      name: 'faqTrackWorkouts',
      desc: '',
      args: [],
    );
  }

  /// `Tap + button`
  String get faqTrackWorkoutsAnswer {
    return Intl.message(
      'Tap + button',
      name: 'faqTrackWorkoutsAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Your Fitness Companion`
  String get personalFitnessCompanion {
    return Intl.message(
      'Your Fitness Companion',
      name: 'personalFitnessCompanion',
      desc: '',
      args: [],
    );
  }

  /// `Track workouts, monitor progress`
  String get appDescription {
    return Intl.message(
      'Track workouts, monitor progress',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Fitrix Team`
  String get fitrixTeam {
    return Intl.message('Fitrix Team', name: 'fitrixTeam', desc: '', args: []);
  }

  /// `October 2025`
  String get lastUpdatedDate {
    return Intl.message(
      'October 2025',
      name: 'lastUpdatedDate',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveChanges {
    return Intl.message('Save', name: 'saveChanges', desc: '', args: []);
  }

  /// `Height (cm)`
  String get height {
    return Intl.message('Height (cm)', name: 'height', desc: '', args: []);
  }

  /// `Height`
  String get enterHeight {
    return Intl.message('Height', name: 'enterHeight', desc: '', args: []);
  }

  /// `Height required`
  String get heightRequired {
    return Intl.message(
      'Height required',
      name: 'heightRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid height`
  String get enterValidHeight {
    return Intl.message(
      'Invalid height',
      name: 'enterValidHeight',
      desc: '',
      args: [],
    );
  }

  /// `Check height`
  String get checkHeightEntered {
    return Intl.message(
      'Check height',
      name: 'checkHeightEntered',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated!`
  String get profileUpdatedSuccess {
    return Intl.message(
      'Profile updated!',
      name: 'profileUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get exercise_details {
    return Intl.message(
      'Details',
      name: 'exercise_details',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get view_details {
    return Intl.message(
      'View Details',
      name: 'view_details',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `Steps`
  String get step_by_step_instructions {
    return Intl.message(
      'Steps',
      name: 'step_by_step_instructions',
      desc: '',
      args: [],
    );
  }

  /// `Difficulty`
  String get select_difficulty {
    return Intl.message(
      'Difficulty',
      name: 'select_difficulty',
      desc: '',
      args: [],
    );
  }

  /// `Equipment`
  String get select_equipment {
    return Intl.message(
      'Equipment',
      name: 'select_equipment',
      desc: '',
      args: [],
    );
  }

  /// `Add image`
  String get tap_to_add_image {
    return Intl.message(
      'Add image',
      name: 'tap_to_add_image',
      desc: '',
      args: [],
    );
  }

  /// `e.g., Chest Press`
  String get eg_chest_press {
    return Intl.message(
      'e.g., Chest Press',
      name: 'eg_chest_press',
      desc: '',
      args: [],
    );
  }

  /// `Name required`
  String get please_enter_exercise_name {
    return Intl.message(
      'Name required',
      name: 'please_enter_exercise_name',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get brief_description_of_the_exercise {
    return Intl.message(
      'Description',
      name: 'brief_description_of_the_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Custom Equipment`
  String get custom_equipment {
    return Intl.message(
      'Custom Equipment',
      name: 'custom_equipment',
      desc: '',
      args: [],
    );
  }

  /// `Equipment name`
  String get enter_your_equipment_name {
    return Intl.message(
      'Equipment name',
      name: 'enter_your_equipment_name',
      desc: '',
      args: [],
    );
  }

  /// `Name required`
  String get please_enter_custom_equipment_name {
    return Intl.message(
      'Name required',
      name: 'please_enter_custom_equipment_name',
      desc: '',
      args: [],
    );
  }

  /// `Image failed`
  String get failed_to_pick_image {
    return Intl.message(
      'Image failed',
      name: 'failed_to_pick_image',
      desc: '',
      args: [],
    );
  }

  /// `Public`
  String get public_exercises {
    return Intl.message('Public', name: 'public_exercises', desc: '', args: []);
  }

  /// `Select Session`
  String get select_workout {
    return Intl.message(
      'Select Session',
      name: 'select_workout',
      desc: '',
      args: [],
    );
  }

  /// `No Sessions`
  String get no_workout_sessions {
    return Intl.message(
      'No Sessions',
      name: 'no_workout_sessions',
      desc: '',
      args: [],
    );
  }

  /// `Create session`
  String get create_new_session_to_start {
    return Intl.message(
      'Create session',
      name: 'create_new_session_to_start',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create_session {
    return Intl.message('Create', name: 'create_session', desc: '', args: []);
  }

  /// `Session created!`
  String get session_created {
    return Intl.message(
      'Session created!',
      name: 'session_created',
      desc: '',
      args: [],
    );
  }

  /// `Added!`
  String get exercise_added_successfully {
    return Intl.message(
      'Added!',
      name: 'exercise_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Adding...`
  String get adding {
    return Intl.message('Adding...', name: 'adding', desc: '', args: []);
  }

  /// `Session completed`
  String get cannot_add_to_completed_session {
    return Intl.message(
      'Session completed',
      name: 'cannot_add_to_completed_session',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get network_error {
    return Intl.message(
      'Network error',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `Add failed`
  String get failed_to_add_exercise {
    return Intl.message(
      'Add failed',
      name: 'failed_to_add_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get something_went_wrong {
    return Intl.message(
      'Error',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `No Workouts`
  String get no_workouts_yet {
    return Intl.message(
      'No Workouts',
      name: 'no_workouts_yet',
      desc: '',
      args: [],
    );
  }

  /// `Create first workout`
  String get start_your_fitness_journey {
    return Intl.message(
      'Create first workout',
      name: 'start_your_fitness_journey',
      desc: '',
      args: [],
    );
  }

  /// `Session created!`
  String get workout_session_created {
    return Intl.message(
      'Session created!',
      name: 'workout_session_created',
      desc: '',
      args: [],
    );
  }

  /// `Total Sets`
  String get total_sets {
    return Intl.message('Total Sets', name: 'total_sets', desc: '', args: []);
  }

  /// `Complete`
  String get complete_workout {
    return Intl.message(
      'Complete',
      name: 'complete_workout',
      desc: '',
      args: [],
    );
  }

  /// `Completed!`
  String get workout_completed {
    return Intl.message(
      'Completed!',
      name: 'workout_completed',
      desc: '',
      args: [],
    );
  }

  /// `Started!`
  String get workout_started {
    return Intl.message(
      'Started!',
      name: 'workout_started',
      desc: '',
      args: [],
    );
  }

  /// `Workout done!`
  String get workout_completed_success {
    return Intl.message(
      'Workout done!',
      name: 'workout_completed_success',
      desc: '',
      args: [],
    );
  }

  /// `No sets`
  String get no_sets_yet {
    return Intl.message('No sets', name: 'no_sets_yet', desc: '', args: []);
  }

  /// `No Exercises`
  String get no_exercises_added {
    return Intl.message(
      'No Exercises',
      name: 'no_exercises_added',
      desc: '',
      args: [],
    );
  }

  /// `Tap + to add`
  String get tap_add_to_start {
    return Intl.message(
      'Tap + to add',
      name: 'tap_add_to_start',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get workout_not_found {
    return Intl.message(
      'Not Found',
      name: 'workout_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Exercises appear here`
  String get exercises_will_appear_here {
    return Intl.message(
      'Exercises appear here',
      name: 'exercises_will_appear_here',
      desc: '',
      args: [],
    );
  }

  /// `Add Set`
  String get add_set {
    return Intl.message('Add Set', name: 'add_set', desc: '', args: []);
  }

  /// `Edit Set`
  String get edit_set {
    return Intl.message('Edit Set', name: 'edit_set', desc: '', args: []);
  }

  /// `Set`
  String get set {
    return Intl.message('Set', name: 'set', desc: '', args: []);
  }

  /// `Reps`
  String get reps {
    return Intl.message('Reps', name: 'reps', desc: '', args: []);
  }

  /// `Weight (kg)`
  String get weight_kg {
    return Intl.message('Weight (kg)', name: 'weight_kg', desc: '', args: []);
  }

  /// `Rest (sec)`
  String get rest_time_seconds {
    return Intl.message(
      'Rest (sec)',
      name: 'rest_time_seconds',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get optional_notes {
    return Intl.message('Notes', name: 'optional_notes', desc: '', args: []);
  }

  /// `Reps required`
  String get please_enter_reps {
    return Intl.message(
      'Reps required',
      name: 'please_enter_reps',
      desc: '',
      args: [],
    );
  }

  /// `Weight required`
  String get please_enter_weight {
    return Intl.message(
      'Weight required',
      name: 'please_enter_weight',
      desc: '',
      args: [],
    );
  }

  /// `Invalid number`
  String get please_enter_valid_number {
    return Intl.message(
      'Invalid number',
      name: 'please_enter_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Sessions`
  String get sessions {
    return Intl.message('Sessions', name: 'sessions', desc: '', args: []);
  }

  /// `Not started`
  String get not_started {
    return Intl.message('Not started', name: 'not_started', desc: '', args: []);
  }

  /// `No exercises`
  String get no_exercises_added_yet {
    return Intl.message(
      'No exercises',
      name: 'no_exercises_added_yet',
      desc: '',
      args: [],
    );
  }

  /// `New Workout?`
  String get create_new_workout {
    return Intl.message(
      'New Workout?',
      name: 'create_new_workout',
      desc: '',
      args: [],
    );
  }

  /// `Create session?`
  String get create_workout_confirmation {
    return Intl.message(
      'Create session?',
      name: 'create_workout_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get success {
    return Intl.message('Success!', name: 'success', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm_create_session {
    return Intl.message(
      'Confirm',
      name: 'confirm_create_session',
      desc: '',
      args: [],
    );
  }

  /// `Sure?`
  String get are_you_sure {
    return Intl.message('Sure?', name: 'are_you_sure', desc: '', args: []);
  }

  /// `Select Date`
  String get select_workout_date {
    return Intl.message(
      'Select Date',
      name: 'select_workout_date',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get workout_date {
    return Intl.message('Date', name: 'workout_date', desc: '', args: []);
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message('Tomorrow', name: 'tomorrow', desc: '', args: []);
  }

  /// `Notes`
  String get add_notes {
    return Intl.message('Notes', name: 'add_notes', desc: '', args: []);
  }

  /// `Add notes about this workout...`
  String get add_workout_notes {
    return Intl.message(
      'Add notes about this workout...',
      name: 'add_workout_notes',
      desc: '',
      args: [],
    );
  }

  /// `Search date...`
  String get search_by_date {
    return Intl.message(
      'Search date...',
      name: 'search_by_date',
      desc: '',
      args: [],
    );
  }

  /// `Searching`
  String get searching_for {
    return Intl.message('Searching', name: 'searching_for', desc: '', args: []);
  }

  /// `found`
  String get found {
    return Intl.message('found', name: 'found', desc: '', args: []);
  }

  /// `Results`
  String get search_results {
    return Intl.message('Results', name: 'search_results', desc: '', args: []);
  }

  /// `Try other date`
  String get try_different_date {
    return Intl.message(
      'Try other date',
      name: 'try_different_date',
      desc: '',
      args: [],
    );
  }

  /// `Add Exercise`
  String get add_exercise {
    return Intl.message(
      'Add Exercise',
      name: 'add_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Tap to add`
  String get tap_to_add_exercise {
    return Intl.message(
      'Tap to add',
      name: 'tap_to_add_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get current_measurements {
    return Intl.message(
      'Current',
      name: 'current_measurements',
      desc: '',
      args: [],
    );
  }

  /// `Goals`
  String get fitness_goals {
    return Intl.message('Goals', name: 'fitness_goals', desc: '', args: []);
  }

  /// `Weight Goal (kg)`
  String get weight_goal {
    return Intl.message(
      'Weight Goal (kg)',
      name: 'weight_goal',
      desc: '',
      args: [],
    );
  }

  /// `Target weight`
  String get enter_weight_goal {
    return Intl.message(
      'Target weight',
      name: 'enter_weight_goal',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat Goal`
  String get body_fat_goal {
    return Intl.message(
      'Body Fat Goal',
      name: 'body_fat_goal',
      desc: '',
      args: [],
    );
  }

  /// `Target fat`
  String get enter_body_fat_goal {
    return Intl.message(
      'Target fat',
      name: 'enter_body_fat_goal',
      desc: '',
      args: [],
    );
  }

  /// `Muscle Mass Goal`
  String get muscle_mass_goal {
    return Intl.message(
      'Muscle Mass Goal',
      name: 'muscle_mass_goal',
      desc: '',
      args: [],
    );
  }

  /// `Target muscle`
  String get enter_muscle_mass_goal {
    return Intl.message(
      'Target muscle',
      name: 'enter_muscle_mass_goal',
      desc: '',
      args: [],
    );
  }

  /// `Measurements & Goals`
  String get body_measurements_and_goals {
    return Intl.message(
      'Measurements & Goals',
      name: 'body_measurements_and_goals',
      desc: '',
      args: [],
    );
  }

  /// `Goal Weight (kg)`
  String get goal_weight {
    return Intl.message(
      'Goal Weight (kg)',
      name: 'goal_weight',
      desc: '',
      args: [],
    );
  }

  /// `Current Body Fat`
  String get current_body_fat {
    return Intl.message(
      'Current Body Fat',
      name: 'current_body_fat',
      desc: '',
      args: [],
    );
  }

  /// `Goal Body Fat`
  String get goal_body_fat {
    return Intl.message(
      'Goal Body Fat',
      name: 'goal_body_fat',
      desc: '',
      args: [],
    );
  }

  /// `Current Muscle Mass`
  String get current_muscle_mass {
    return Intl.message(
      'Current Muscle Mass',
      name: 'current_muscle_mass',
      desc: '',
      args: [],
    );
  }

  /// `Goal Muscle Mass`
  String get goal_muscle_mass {
    return Intl.message(
      'Goal Muscle Mass',
      name: 'goal_muscle_mass',
      desc: '',
      args: [],
    );
  }

  /// `Goal`
  String get goal {
    return Intl.message('Goal', name: 'goal', desc: '', args: []);
  }

  /// `Reorder Sections`
  String get reorder_sections {
    return Intl.message(
      'Reorder Sections',
      name: 'reorder_sections',
      desc: '',
      args: [],
    );
  }

  /// `Drag to reorder`
  String get drag_sections_instruction {
    return Intl.message(
      'Drag to reorder',
      name: 'drag_sections_instruction',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply_order {
    return Intl.message('Apply', name: 'apply_order', desc: '', args: []);
  }

  /// `Update profile info`
  String get updateYourProfileInformation {
    return Intl.message(
      'Update profile info',
      name: 'updateYourProfileInformation',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Phone number',
      name: 'enterPhoneNumber',
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

  /// `Rate App`
  String get rateApp {
    return Intl.message('Rate App', name: 'rateApp', desc: '', args: []);
  }

  /// `App Settings`
  String get appSettings {
    return Intl.message(
      'App Settings',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Body fat required`
  String get bodyFatRequired {
    return Intl.message(
      'Body fat required',
      name: 'bodyFatRequired',
      desc: '',
      args: [],
    );
  }

  /// `Muscle mass required`
  String get muscleMassRequired {
    return Intl.message(
      'Muscle mass required',
      name: 'muscleMassRequired',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile & Measurements`
  String get edit_profile_and_measurements {
    return Intl.message(
      'Edit Profile & Measurements',
      name: 'edit_profile_and_measurements',
      desc: '',
      args: [],
    );
  }

  /// `Fitrix User`
  String get fitrixUser {
    return Intl.message('Fitrix User', name: 'fitrixUser', desc: '', args: []);
  }

  /// `Muscle Mass`
  String get muscleMass {
    return Intl.message('Muscle Mass', name: 'muscleMass', desc: '', args: []);
  }

  /// `Body Fat`
  String get bodyFat {
    return Intl.message('Body Fat', name: 'bodyFat', desc: '', args: []);
  }

  /// `Weight`
  String get weight {
    return Intl.message('Weight', name: 'weight', desc: '', args: []);
  }

  /// `Records`
  String get records {
    return Intl.message('Records', name: 'records', desc: '', args: []);
  }

  /// `Per Week`
  String get per_week {
    return Intl.message('Per Week', name: 'per_week', desc: '', args: []);
  }

  /// `m`
  String get minutes_short {
    return Intl.message('m', name: 'minutes_short', desc: '', args: []);
  }

  /// `Personal Bests`
  String get personal_bests {
    return Intl.message(
      'Personal Bests',
      name: 'personal_bests',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volume {
    return Intl.message('Volume', name: 'volume', desc: '', args: []);
  }

  /// `Measurement History`
  String get measurement_history {
    return Intl.message(
      'Measurement History',
      name: 'measurement_history',
      desc: '',
      args: [],
    );
  }

  /// `View detailed charts & analytics`
  String get view_charts_analytics {
    return Intl.message(
      'View detailed charts & analytics',
      name: 'view_charts_analytics',
      desc: '',
      args: [],
    );
  }

  /// `Line`
  String get line_chart {
    return Intl.message('Line', name: 'line_chart', desc: '', args: []);
  }

  /// `Bar`
  String get bar_chart {
    return Intl.message('Bar', name: 'bar_chart', desc: '', args: []);
  }

  /// `Area`
  String get area_chart {
    return Intl.message('Area', name: 'area_chart', desc: '', args: []);
  }

  /// `Body Fat Progress`
  String get body_fat_progress {
    return Intl.message(
      'Body Fat Progress',
      name: 'body_fat_progress',
      desc: '',
      args: [],
    );
  }

  /// `Muscle Mass Progress`
  String get muscle_mass_progress {
    return Intl.message(
      'Muscle Mass Progress',
      name: 'muscle_mass_progress',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Avg`
  String get average {
    return Intl.message('Avg', name: 'average', desc: '', args: []);
  }

  /// `Max`
  String get max_value {
    return Intl.message('Max', name: 'max_value', desc: '', args: []);
  }

  /// `Min`
  String get min_value {
    return Intl.message('Min', name: 'min_value', desc: '', args: []);
  }

  /// `7 Days`
  String get period_7_days {
    return Intl.message('7 Days', name: 'period_7_days', desc: '', args: []);
  }

  /// `30 Days`
  String get period_30_days {
    return Intl.message('30 Days', name: 'period_30_days', desc: '', args: []);
  }

  /// `90 Days`
  String get period_90_days {
    return Intl.message('90 Days', name: 'period_90_days', desc: '', args: []);
  }

  /// `6 Months`
  String get period_6_months {
    return Intl.message(
      '6 Months',
      name: 'period_6_months',
      desc: '',
      args: [],
    );
  }

  /// `1 Year`
  String get period_1_year {
    return Intl.message('1 Year', name: 'period_1_year', desc: '', args: []);
  }

  /// `Current`
  String get current2 {
    return Intl.message('Current', name: 'current2', desc: '', args: []);
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Record Details`
  String get record_details {
    return Intl.message(
      'Record Details',
      name: 'record_details',
      desc: '',
      args: [],
    );
  }

  /// `All Records`
  String get all_records {
    return Intl.message('All Records', name: 'all_records', desc: '', args: []);
  }

  /// `Exercise`
  String get exercise {
    return Intl.message('Exercise', name: 'exercise', desc: '', args: []);
  }

  /// `Unknown Exercise`
  String get unknown_exercise {
    return Intl.message(
      'Unknown Exercise',
      name: 'unknown_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Workout Session`
  String get workout_session {
    return Intl.message(
      'Workout Session',
      name: 'workout_session',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Loading records...`
  String get loading_records {
    return Intl.message(
      'Loading records...',
      name: 'loading_records',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Loading achievements...`
  String get loading_achievements {
    return Intl.message(
      'Loading achievements...',
      name: 'loading_achievements',
      desc: '',
      args: [],
    );
  }

  /// `Custom Exercises`
  String get custom_exercises {
    return Intl.message(
      'Custom Exercises',
      name: 'custom_exercises',
      desc: '',
      args: [],
    );
  }

  /// `My Exercises`
  String get my_exercises {
    return Intl.message(
      'My Exercises',
      name: 'my_exercises',
      desc: '',
      args: [],
    );
  }

  /// `View all your custom exercises`
  String get view_all_custom {
    return Intl.message(
      'View all your custom exercises',
      name: 'view_all_custom',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get birth_date {
    return Intl.message('Birth Date', name: 'birth_date', desc: '', args: []);
  }

  /// `Select your birth date`
  String get select_birth_date {
    return Intl.message(
      'Select your birth date',
      name: 'select_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Deleting...`
  String get deleting {
    return Intl.message('Deleting...', name: 'deleting', desc: '', args: []);
  }

  /// `Choose a Section`
  String get choose_section_for_exercise {
    return Intl.message(
      'Choose a Section',
      name: 'choose_section_for_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Select which category your custom exercise belongs to`
  String get select_category_for_custom_exercise {
    return Intl.message(
      'Select which category your custom exercise belongs to',
      name: 'select_category_for_custom_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Loading sections...`
  String get loading_sections {
    return Intl.message(
      'Loading sections...',
      name: 'loading_sections',
      desc: '',
      args: [],
    );
  }

  /// `Select Section`
  String get select_section {
    return Intl.message(
      'Select Section',
      name: 'select_section',
      desc: '',
      args: [],
    );
  }

  /// `Manage your custom exercises`
  String get manage_your_exercises {
    return Intl.message(
      'Manage your custom exercises',
      name: 'manage_your_exercises',
      desc: '',
      args: [],
    );
  }

  /// `Try adjusting your filters or search terms`
  String get try_different_filters {
    return Intl.message(
      'Try adjusting your filters or search terms',
      name: 'try_different_filters',
      desc: '',
      args: [],
    );
  }

  /// `Clear Filters`
  String get clear_filters {
    return Intl.message(
      'Clear Filters',
      name: 'clear_filters',
      desc: '',
      args: [],
    );
  }

  /// `Update Your Password`
  String get change_password_title {
    return Intl.message(
      'Update Your Password',
      name: 'change_password_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter your current password and choose a new one`
  String get change_password_subtitle {
    return Intl.message(
      'Enter your current password and choose a new one',
      name: 'change_password_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get current_password {
    return Intl.message(
      'Current Password',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your current password`
  String get please_enter_current_password {
    return Intl.message(
      'Enter your current password',
      name: 'please_enter_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password`
  String get please_enter_new_password {
    return Intl.message(
      'Enter a new password',
      name: 'please_enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your new password`
  String get please_confirm_new_password {
    return Intl.message(
      'Confirm your new password',
      name: 'please_confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_must_be_at_least_6_characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_must_be_at_least_6_characters',
      desc: '',
      args: [],
    );
  }

  /// `Password Requirements:`
  String get password_requirements {
    return Intl.message(
      'Password Requirements:',
      name: 'password_requirements',
      desc: '',
      args: [],
    );
  }

  /// `At least 6 characters`
  String get at_least_6_characters {
    return Intl.message(
      'At least 6 characters',
      name: 'at_least_6_characters',
      desc: '',
      args: [],
    );
  }

  /// `Contains an uppercase letter`
  String get contains_uppercase_letter {
    return Intl.message(
      'Contains an uppercase letter',
      name: 'contains_uppercase_letter',
      desc: '',
      args: [],
    );
  }

  /// `Contains a number`
  String get contains_number {
    return Intl.message(
      'Contains a number',
      name: 'contains_number',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed_successfully {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Sound Effects`
  String get sound_effects {
    return Intl.message(
      'Sound Effects',
      name: 'sound_effects',
      desc: '',
      args: [],
    );
  }

  /// `Don't show this again`
  String get dont_show_again {
    return Intl.message(
      'Don\'t show this again',
      name: 'dont_show_again',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message('Continue', name: 'continue_text', desc: '', args: []);
  }

  /// `Complete`
  String get complete {
    return Intl.message('Complete', name: 'complete', desc: '', args: []);
  }

  /// `Secure your account with a strong password`
  String get secure_your_account {
    return Intl.message(
      'Secure your account with a strong password',
      name: 'secure_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Password Strength`
  String get password_strength {
    return Intl.message(
      'Password Strength',
      name: 'password_strength',
      desc: '',
      args: [],
    );
  }

  /// `Strong`
  String get strong {
    return Intl.message('Strong', name: 'strong', desc: '', args: []);
  }

  /// `Medium`
  String get medium {
    return Intl.message('Medium', name: 'medium', desc: '', args: []);
  }

  /// `Weak`
  String get weak {
    return Intl.message('Weak', name: 'weak', desc: '', args: []);
  }

  /// `Very Weak`
  String get very_weak {
    return Intl.message('Very Weak', name: 'very_weak', desc: '', args: []);
  }

  /// `Contains special character (!@#$%^&*)`
  String get contains_special_character {
    return Intl.message(
      'Contains special character (!@#\$%^&*)',
      name: 'contains_special_character',
      desc: '',
      args: [],
    );
  }

  /// `Passwords match`
  String get passwords_match {
    return Intl.message(
      'Passwords match',
      name: 'passwords_match',
      desc: '',
      args: [],
    );
  }

  /// `Show Tutorial`
  String get show_tutorial {
    return Intl.message(
      'Show Tutorial',
      name: 'show_tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Height Measurement`
  String get height_measurement {
    return Intl.message(
      'Height Measurement',
      name: 'height_measurement',
      desc: '',
      args: [],
    );
  }

  /// `Tap to set your height using the interactive meter`
  String get tap_to_set_height {
    return Intl.message(
      'Tap to set your height using the interactive meter',
      name: 'tap_to_set_height',
      desc: '',
      args: [],
    );
  }

  /// `Weight Tracking`
  String get weight_tracking {
    return Intl.message(
      'Weight Tracking',
      name: 'weight_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Tap to set your current weight and goal weight`
  String get tap_to_set_current_and_goal_weight {
    return Intl.message(
      'Tap to set your current weight and goal weight',
      name: 'tap_to_set_current_and_goal_weight',
      desc: '',
      args: [],
    );
  }

  /// `Tap to set your current body fat and goal using interactive sliders`
  String get tap_to_set_body_fat_goal_slider {
    return Intl.message(
      'Tap to set your current body fat and goal using interactive sliders',
      name: 'tap_to_set_body_fat_goal_slider',
      desc: '',
      args: [],
    );
  }

  /// `Tap to set your current muscle mass and goal using interactive sliders`
  String get tap_to_set_muscle_mass_goal_slider {
    return Intl.message(
      'Tap to set your current muscle mass and goal using interactive sliders',
      name: 'tap_to_set_muscle_mass_goal_slider',
      desc: '',
      args: [],
    );
  }

  /// `Set Body Fat Goals`
  String get set_body_fat_goals {
    return Intl.message(
      'Set Body Fat Goals',
      name: 'set_body_fat_goals',
      desc: '',
      args: [],
    );
  }

  /// `Set Muscle Mass Goals`
  String get set_muscle_mass_goals {
    return Intl.message(
      'Set Muscle Mass Goals',
      name: 'set_muscle_mass_goals',
      desc: '',
      args: [],
    );
  }

  /// `Adjust the sliders below to set your current value and goal`
  String get adjust_sliders_to_set_goals {
    return Intl.message(
      'Adjust the sliders below to set your current value and goal',
      name: 'adjust_sliders_to_set_goals',
      desc: '',
      args: [],
    );
  }

  /// `Fat`
  String get fat {
    return Intl.message('Fat', name: 'fat', desc: '', args: []);
  }

  /// `Gain Muscle`
  String get gain_muscle {
    return Intl.message('Gain Muscle', name: 'gain_muscle', desc: '', args: []);
  }

  /// `Lose Muscle`
  String get lose_muscle {
    return Intl.message('Lose Muscle', name: 'lose_muscle', desc: '', args: []);
  }

  /// `Reduce Fat`
  String get reduce_fat {
    return Intl.message('Reduce Fat', name: 'reduce_fat', desc: '', args: []);
  }

  /// `Increase Fat`
  String get increase_fat {
    return Intl.message(
      'Increase Fat',
      name: 'increase_fat',
      desc: '',
      args: [],
    );
  }

  /// `to gain`
  String get to_gain {
    return Intl.message('to gain', name: 'to_gain', desc: '', args: []);
  }

  /// `to lose`
  String get to_lose {
    return Intl.message('to lose', name: 'to_lose', desc: '', args: []);
  }

  /// `Tap to edit`
  String get tap_to_edit {
    return Intl.message('Tap to edit', name: 'tap_to_edit', desc: '', args: []);
  }

  /// `Drag items to change their order`
  String get drag_to_reorder_sections {
    return Intl.message(
      'Drag items to change their order',
      name: 'drag_to_reorder_sections',
      desc: '',
      args: [],
    );
  }

  /// `Section order saved successfully`
  String get section_order_saved {
    return Intl.message(
      'Section order saved successfully',
      name: 'section_order_saved',
      desc: '',
      args: [],
    );
  }

  /// `Set Your Height`
  String get set_your_height {
    return Intl.message(
      'Set Your Height',
      name: 'set_your_height',
      desc: '',
      args: [],
    );
  }

  /// `Adjust the slider to set your height`
  String get adjust_slider_to_set_height {
    return Intl.message(
      'Adjust the slider to set your height',
      name: 'adjust_slider_to_set_height',
      desc: '',
      args: [],
    );
  }

  /// `Accurate height is important for calculating BMI and other metrics`
  String get height_measurement_info {
    return Intl.message(
      'Accurate height is important for calculating BMI and other metrics',
      name: 'height_measurement_info',
      desc: '',
      args: [],
    );
  }

  /// `Set Current Weight`
  String get set_current_weight {
    return Intl.message(
      'Set Current Weight',
      name: 'set_current_weight',
      desc: '',
      args: [],
    );
  }

  /// `Set Goal Weight`
  String get set_goal_weight {
    return Intl.message(
      'Set Goal Weight',
      name: 'set_goal_weight',
      desc: '',
      args: [],
    );
  }

  /// `Adjust the slider to set your weight`
  String get adjust_slider_to_set_weight {
    return Intl.message(
      'Adjust the slider to set your weight',
      name: 'adjust_slider_to_set_weight',
      desc: '',
      args: [],
    );
  }

  /// `Track your current weight regularly for accurate progress`
  String get weight_measurement_info {
    return Intl.message(
      'Track your current weight regularly for accurate progress',
      name: 'weight_measurement_info',
      desc: '',
      args: [],
    );
  }

  /// `Set a realistic goal weight based on your fitness objectives`
  String get weight_goal_info {
    return Intl.message(
      'Set a realistic goal weight based on your fitness objectives',
      name: 'weight_goal_info',
      desc: '',
      args: [],
    );
  }

  /// `Volume Progress`
  String get volume_progress {
    return Intl.message(
      'Volume Progress',
      name: 'volume_progress',
      desc: '',
      args: [],
    );
  }

  /// `Reps Progress`
  String get reps_progress {
    return Intl.message(
      'Reps Progress',
      name: 'reps_progress',
      desc: '',
      args: [],
    );
  }

  /// `Peak`
  String get peak {
    return Intl.message('Peak', name: 'peak', desc: '', args: []);
  }

  /// `View Progress`
  String get view_progress {
    return Intl.message(
      'View Progress',
      name: 'view_progress',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `We'll send a password reset link to your email`
  String get resetPasswordInfo {
    return Intl.message(
      'We\'ll send a password reset link to your email',
      name: 'resetPasswordInfo',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `Workout Details`
  String get workout_details {
    return Intl.message(
      'Workout Details',
      name: 'workout_details',
      desc: '',
      args: [],
    );
  }

  /// `Sections`
  String get sections {
    return Intl.message('Sections', name: 'sections', desc: '', args: []);
  }

  /// `Personalize your app appearance`
  String get choose_your_theme {
    return Intl.message(
      'Personalize your app appearance',
      name: 'choose_your_theme',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_theme {
    return Intl.message('Light Mode', name: 'light_theme', desc: '', args: []);
  }

  /// `Bright and clean interface`
  String get light_theme_desc {
    return Intl.message(
      'Bright and clean interface',
      name: 'light_theme_desc',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_theme {
    return Intl.message('Dark Mode', name: 'dark_theme', desc: '', args: []);
  }

  /// `Easy on the eyes`
  String get dark_theme_desc {
    return Intl.message(
      'Easy on the eyes',
      name: 'dark_theme_desc',
      desc: '',
      args: [],
    );
  }

  /// `System Default`
  String get system_theme {
    return Intl.message(
      'System Default',
      name: 'system_theme',
      desc: '',
      args: [],
    );
  }

  /// `Follows device settings`
  String get system_theme_desc {
    return Intl.message(
      'Follows device settings',
      name: 'system_theme_desc',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Mark All Read`
  String get mark_all_read {
    return Intl.message(
      'Mark All Read',
      name: 'mark_all_read',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Read`
  String get mark_as_read {
    return Intl.message(
      'Mark as Read',
      name: 'mark_as_read',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications`
  String get no_notifications {
    return Intl.message(
      'No Notifications',
      name: 'no_notifications',
      desc: '',
      args: [],
    );
  }

  /// `You're all caught up! Check back later for new updates.`
  String get no_notifications_desc {
    return Intl.message(
      'You\'re all caught up! Check back later for new updates.',
      name: 'no_notifications_desc',
      desc: '',
      args: [],
    );
  }

  /// `Delete Notification`
  String get delete_notification {
    return Intl.message(
      'Delete Notification',
      name: 'delete_notification',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this notification?`
  String get delete_notification_confirmation {
    return Intl.message(
      'Are you sure you want to delete this notification?',
      name: 'delete_notification_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information`
  String get additional_info {
    return Intl.message(
      'Additional Information',
      name: 'additional_info',
      desc: '',
      args: [],
    );
  }

  /// `User Requests`
  String get user_requests {
    return Intl.message(
      'User Requests',
      name: 'user_requests',
      desc: '',
      args: [],
    );
  }

  /// `Trainer Requests`
  String get trainer_requests {
    return Intl.message(
      'Trainer Requests',
      name: 'trainer_requests',
      desc: '',
      args: [],
    );
  }

  /// `Search for a trainer...`
  String get search_trainer {
    return Intl.message(
      'Search for a trainer...',
      name: 'search_trainer',
      desc: '',
      args: [],
    );
  }

  /// `No Requests Found`
  String get no_requests_found {
    return Intl.message(
      'No Requests Found',
      name: 'no_requests_found',
      desc: '',
      args: [],
    );
  }

  /// `Requested on {date}`
  String requested_on(String date) {
    return Intl.message(
      'Requested on $date',
      name: 'requested_on',
      desc: 'Shows when the trainer request was created',
      args: [date],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message('Requests', name: 'requests', desc: '', args: []);
  }

  /// `View Requests`
  String get view_requests {
    return Intl.message(
      'View Requests',
      name: 'view_requests',
      desc: '',
      args: [],
    );
  }

  /// `Trainer Profile`
  String get trainer_profile {
    return Intl.message(
      'Trainer Profile',
      name: 'trainer_profile',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept_request {
    return Intl.message('Accept', name: 'accept_request', desc: '', args: []);
  }

  /// `Reject`
  String get reject_request {
    return Intl.message('Reject', name: 'reject_request', desc: '', args: []);
  }

  /// `Trainer ID`
  String get trainer_id {
    return Intl.message('Trainer ID', name: 'trainer_id', desc: '', args: []);
  }

  /// `Message`
  String get request_message {
    return Intl.message('Message', name: 'request_message', desc: '', args: []);
  }

  /// `Trainee Requests`
  String get trainee_requests {
    return Intl.message(
      'Trainee Requests',
      name: 'trainee_requests',
      desc: '',
      args: [],
    );
  }

  /// `No pending requests`
  String get no_pending_requests {
    return Intl.message(
      'No pending requests',
      name: 'no_pending_requests',
      desc: '',
      args: [],
    );
  }

  /// `Trainee requests will appear here`
  String get trainee_requests_will_appear {
    return Intl.message(
      'Trainee requests will appear here',
      name: 'trainee_requests_will_appear',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Request accepted successfully`
  String get request_accepted {
    return Intl.message(
      'Request accepted successfully',
      name: 'request_accepted',
      desc: '',
      args: [],
    );
  }

  /// `Request rejected successfully`
  String get request_rejected {
    return Intl.message(
      'Request rejected successfully',
      name: 'request_rejected',
      desc: '',
      args: [],
    );
  }

  /// `My Requests`
  String get my_requests {
    return Intl.message('My Requests', name: 'my_requests', desc: '', args: []);
  }

  /// `Find Trainers`
  String get find_trainers {
    return Intl.message(
      'Find Trainers',
      name: 'find_trainers',
      desc: '',
      args: [],
    );
  }

  /// `All Trainers`
  String get all_trainers {
    return Intl.message(
      'All Trainers',
      name: 'all_trainers',
      desc: '',
      args: [],
    );
  }

  /// `Search for trainers...`
  String get search_trainers {
    return Intl.message(
      'Search for trainers...',
      name: 'search_trainers',
      desc: '',
      args: [],
    );
  }

  /// `No trainer requests at the moment`
  String get no_trainer_requests_message {
    return Intl.message(
      'No trainer requests at the moment',
      name: 'no_trainer_requests_message',
      desc: '',
      args: [],
    );
  }

  /// `No Trainers Found`
  String get no_trainers_found {
    return Intl.message(
      'No Trainers Found',
      name: 'no_trainers_found',
      desc: '',
      args: [],
    );
  }

  /// `All trainers have pending requests`
  String get no_available_trainers_message {
    return Intl.message(
      'All trainers have pending requests',
      name: 'no_available_trainers_message',
      desc: '',
      args: [],
    );
  }

  /// `No trainers available in the system`
  String get no_trainers_message {
    return Intl.message(
      'No trainers available in the system',
      name: 'no_trainers_message',
      desc: '',
      args: [],
    );
  }

  /// `{count} pending {count, plural, =1{request} other{requests}}`
  String pending_requests_count(int count) {
    return Intl.message(
      '$count pending ${Intl.plural(count, one: 'request', other: 'requests')}',
      name: 'pending_requests_count',
      desc: '',
      args: [count],
    );
  }

  /// `Send Request`
  String get send_request {
    return Intl.message(
      'Send Request',
      name: 'send_request',
      desc: '',
      args: [],
    );
  }

  /// `Sending request to {name}`
  String sending_request_to(String name) {
    return Intl.message(
      'Sending request to $name',
      name: 'sending_request_to',
      desc: '',
      args: [name],
    );
  }

  /// `Add a message (optional)`
  String get add_message_optional {
    return Intl.message(
      'Add a message (optional)',
      name: 'add_message_optional',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `My Trainers`
  String get my_trainers {
    return Intl.message('My Trainers', name: 'my_trainers', desc: '', args: []);
  }

  /// `No Trainers Yet`
  String get no_my_trainers_found {
    return Intl.message(
      'No Trainers Yet',
      name: 'no_my_trainers_found',
      desc: '',
      args: [],
    );
  }

  /// `You haven't connected with any trainers yet`
  String get no_my_trainers_message {
    return Intl.message(
      'You haven\'t connected with any trainers yet',
      name: 'no_my_trainers_message',
      desc: '',
      args: [],
    );
  }

  /// `You have {count} {count, plural, =1{trainer} other{trainers}}`
  String my_trainers_count(num count) {
    return Intl.message(
      'You have $count ${Intl.plural(count, one: 'trainer', other: 'trainers')}',
      name: 'my_trainers_count',
      desc: '',
      args: [count],
    );
  }

  /// `Connected`
  String get connected {
    return Intl.message('Connected', name: 'connected', desc: '', args: []);
  }

  /// `Message`
  String get message {
    return Intl.message('Message', name: 'message', desc: '', args: []);
  }

  /// `All Trainees`
  String get all_trainees {
    return Intl.message(
      'All Trainees',
      name: 'all_trainees',
      desc: '',
      args: [],
    );
  }

  /// `Search for trainees...`
  String get search_trainees {
    return Intl.message(
      'Search for trainees...',
      name: 'search_trainees',
      desc: '',
      args: [],
    );
  }

  /// `No trainee requests at the moment`
  String get no_trainee_requests_message {
    return Intl.message(
      'No trainee requests at the moment',
      name: 'no_trainee_requests_message',
      desc: '',
      args: [],
    );
  }

  /// `No Trainees Yet`
  String get no_my_trainees_found {
    return Intl.message(
      'No Trainees Yet',
      name: 'no_my_trainees_found',
      desc: '',
      args: [],
    );
  }

  /// `You haven't connected with any trainees yet`
  String get no_my_trainees_message {
    return Intl.message(
      'You haven\'t connected with any trainees yet',
      name: 'no_my_trainees_message',
      desc: '',
      args: [],
    );
  }

  /// `You have {count} {count, plural, =1{trainee} other{trainees}}`
  String my_trainees_count(int count) {
    return Intl.message(
      'You have $count ${Intl.plural(count, one: 'trainee', other: 'trainees')}',
      name: 'my_trainees_count',
      desc: '',
      args: [count],
    );
  }

  /// `No Trainees Found`
  String get no_trainees_found {
    return Intl.message(
      'No Trainees Found',
      name: 'no_trainees_found',
      desc: '',
      args: [],
    );
  }

  /// `No trainees available in the system`
  String get no_trainees_message {
    return Intl.message(
      'No trainees available in the system',
      name: 'no_trainees_message',
      desc: '',
      args: [],
    );
  }

  /// `Send Invitation`
  String get send_invitation {
    return Intl.message(
      'Send Invitation',
      name: 'send_invitation',
      desc: '',
      args: [],
    );
  }

  /// `Sending invitation to {name}`
  String sending_invitation_to(String name) {
    return Intl.message(
      'Sending invitation to $name',
      name: 'sending_invitation_to',
      desc: '',
      args: [name],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Clients`
  String get clients {
    return Intl.message('Clients', name: 'clients', desc: '', args: []);
  }

  /// `Trainer Dashboard`
  String get trainer_dashboard_title {
    return Intl.message(
      'Trainer Dashboard',
      name: 'trainer_dashboard_title',
      desc: '',
      args: [],
    );
  }

  /// `Total Clients`
  String get total_clients {
    return Intl.message(
      'Total Clients',
      name: 'total_clients',
      desc: '',
      args: [],
    );
  }

  /// `Recent Clients`
  String get recent_clients {
    return Intl.message(
      'Recent Clients',
      name: 'recent_clients',
      desc: '',
      args: [],
    );
  }

  /// `No clients yet`
  String get no_clients_yet {
    return Intl.message(
      'No clients yet',
      name: 'no_clients_yet',
      desc: '',
      args: [],
    );
  }

  /// `Pending Requests`
  String get pending_requests {
    return Intl.message(
      'Pending Requests',
      name: 'pending_requests',
      desc: '',
      args: [],
    );
  }

  /// `Tap to view and manage requests`
  String get view_pending_requests {
    return Intl.message(
      'Tap to view and manage requests',
      name: 'view_pending_requests',
      desc: '',
      args: [],
    );
  }

  /// `Find Clients`
  String get find_clients {
    return Intl.message(
      'Find Clients',
      name: 'find_clients',
      desc: '',
      args: [],
    );
  }

  /// `My Clients`
  String get my_clients {
    return Intl.message('My Clients', name: 'my_clients', desc: '', args: []);
  }

  /// `Search clients...`
  String get search_clients {
    return Intl.message(
      'Search clients...',
      name: 'search_clients',
      desc: '',
      args: [],
    );
  }

  /// `Add Client`
  String get add_client {
    return Intl.message('Add Client', name: 'add_client', desc: '', args: []);
  }

  /// `Search and send requests to potential clients`
  String get add_client_description {
    return Intl.message(
      'Search and send requests to potential clients',
      name: 'add_client_description',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get good_morning {
    return Intl.message(
      'Good Morning',
      name: 'good_morning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get good_afternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'good_afternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get good_evening {
    return Intl.message(
      'Good Evening',
      name: 'good_evening',
      desc: '',
      args: [],
    );
  }

  /// `Remove Client`
  String get remove_client {
    return Intl.message(
      'Remove Client',
      name: 'remove_client',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Search by name or email`
  String get search_by_name_or_email {
    return Intl.message(
      'Search by name or email',
      name: 'search_by_name_or_email',
      desc: '',
      args: [],
    );
  }

  /// `Start searching for clients`
  String get start_searching_clients {
    return Intl.message(
      'Start searching for clients',
      name: 'start_searching_clients',
      desc: '',
      args: [],
    );
  }

  /// `No users found`
  String get no_users_found {
    return Intl.message(
      'No users found',
      name: 'no_users_found',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get client {
    return Intl.message('Client', name: 'client', desc: '', args: []);
  }

  /// `Request sent successfully`
  String get request_sent {
    return Intl.message(
      'Request sent successfully',
      name: 'request_sent',
      desc: '',
      args: [],
    );
  }

  /// `Assign Workout`
  String get assign_workout {
    return Intl.message(
      'Assign Workout',
      name: 'assign_workout',
      desc: '',
      args: [],
    );
  }

  /// `Notes (Optional)`
  String get notes_optional {
    return Intl.message(
      'Notes (Optional)',
      name: 'notes_optional',
      desc: '',
      args: [],
    );
  }

  /// `Workout assigned successfully`
  String get workout_assigned_successfully {
    return Intl.message(
      'Workout assigned successfully',
      name: 'workout_assigned_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Assign`
  String get assign {
    return Intl.message('Assign', name: 'assign', desc: '', args: []);
  }

  /// `workouts completed`
  String get workouts_completed {
    return Intl.message(
      'workouts completed',
      name: 'workouts_completed',
      desc: '',
      args: [],
    );
  }

  /// `Active Workouts`
  String get active_workouts {
    return Intl.message(
      'Active Workouts',
      name: 'active_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message('Overview', name: 'overview', desc: '', args: []);
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `Client Workouts`
  String get client_workouts {
    return Intl.message(
      'Client Workouts',
      name: 'client_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Select a client to create workout`
  String get select_client_to_create_workout {
    return Intl.message(
      'Select a client to create workout',
      name: 'select_client_to_create_workout',
      desc: '',
      args: [],
    );
  }

  /// `No clients available to create workouts`
  String get no_clients_to_create_workout {
    return Intl.message(
      'No clients available to create workouts',
      name: 'no_clients_to_create_workout',
      desc: '',
      args: [],
    );
  }

  /// `Create Workout for Client`
  String get create_workout_for_client {
    return Intl.message(
      'Create Workout for Client',
      name: 'create_workout_for_client',
      desc: '',
      args: [],
    );
  }

  /// `Creating workout for`
  String get creating_workout_for {
    return Intl.message(
      'Creating workout for',
      name: 'creating_workout_for',
      desc: '',
      args: [],
    );
  }

  /// `Workout Name`
  String get workout_name {
    return Intl.message(
      'Workout Name',
      name: 'workout_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter workout name`
  String get enter_workout_name {
    return Intl.message(
      'Enter workout name',
      name: 'enter_workout_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a workout name`
  String get please_enter_workout_name {
    return Intl.message(
      'Please enter a workout name',
      name: 'please_enter_workout_name',
      desc: '',
      args: [],
    );
  }

  /// `Workout created successfully`
  String get workout_created_successfully {
    return Intl.message(
      'Workout created successfully',
      name: 'workout_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Create the first workout for this client`
  String get create_first_workout_for_client {
    return Intl.message(
      'Create the first workout for this client',
      name: 'create_first_workout_for_client',
      desc: '',
      args: [],
    );
  }

  /// `Trainer Mode`
  String get trainer_mode {
    return Intl.message(
      'Trainer Mode',
      name: 'trainer_mode',
      desc: '',
      args: [],
    );
  }

  /// `My Training`
  String get my_training {
    return Intl.message('My Training', name: 'my_training', desc: '', args: []);
  }

  /// `Manage Trainer Requests`
  String get manage_trainer_requests {
    return Intl.message(
      'Manage Trainer Requests',
      name: 'manage_trainer_requests',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message('Messages', name: 'messages', desc: '', args: []);
  }

  /// `No Conversations`
  String get no_conversations {
    return Intl.message(
      'No Conversations',
      name: 'no_conversations',
      desc: '',
      args: [],
    );
  }

  /// `Start chatting with your clients`
  String get start_chatting_with_clients {
    return Intl.message(
      'Start chatting with your clients',
      name: 'start_chatting_with_clients',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet`
  String get no_messages_yet {
    return Intl.message(
      'No messages yet',
      name: 'no_messages_yet',
      desc: '',
      args: [],
    );
  }

  /// `Start the conversation`
  String get start_conversation {
    return Intl.message(
      'Start the conversation',
      name: 'start_conversation',
      desc: '',
      args: [],
    );
  }

  /// `Type a message...`
  String get type_message {
    return Intl.message(
      'Type a message...',
      name: 'type_message',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Search conversations...`
  String get search_conversations {
    return Intl.message(
      'Search conversations...',
      name: 'search_conversations',
      desc: '',
      args: [],
    );
  }

  /// `Recent Chats`
  String get recent_chats {
    return Intl.message(
      'Recent Chats',
      name: 'recent_chats',
      desc: '',
      args: [],
    );
  }

  /// `All Clients`
  String get all_clients {
    return Intl.message('All Clients', name: 'all_clients', desc: '', args: []);
  }

  /// `No results found`
  String get no_results_found {
    return Intl.message(
      'No results found',
      name: 'no_results_found',
      desc: '',
      args: [],
    );
  }

  /// `Try a different search term`
  String get try_different_search {
    return Intl.message(
      'Try a different search term',
      name: 'try_different_search',
      desc: '',
      args: [],
    );
  }

  /// `Switch to All Clients tab to start chatting`
  String get start_chatting_with_clients_tab {
    return Intl.message(
      'Switch to All Clients tab to start chatting',
      name: 'start_chatting_with_clients_tab',
      desc: '',
      args: [],
    );
  }

  /// `View All Clients`
  String get view_all_clients {
    return Intl.message(
      'View All Clients',
      name: 'view_all_clients',
      desc: '',
      args: [],
    );
  }

  /// `No Clients`
  String get no_clients {
    return Intl.message('No Clients', name: 'no_clients', desc: '', args: []);
  }

  /// `Add clients to start chatting`
  String get add_clients_to_chat {
    return Intl.message(
      'Add clients to start chatting',
      name: 'add_clients_to_chat',
      desc: '',
      args: [],
    );
  }

  /// `Cannot Start Chat`
  String get cannot_start_chat {
    return Intl.message(
      'Cannot Start Chat',
      name: 'cannot_start_chat',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `View All Trainers`
  String get view_all_trainers {
    return Intl.message(
      'View All Trainers',
      name: 'view_all_trainers',
      desc: '',
      args: [],
    );
  }

  /// `No Trainers`
  String get no_trainers {
    return Intl.message('No Trainers', name: 'no_trainers', desc: '', args: []);
  }

  /// `No trainers are available at the moment`
  String get no_trainers_available {
    return Intl.message(
      'No trainers are available at the moment',
      name: 'no_trainers_available',
      desc: '',
      args: [],
    );
  }

  /// `X`
  String get X {
    return Intl.message('X', name: 'X', desc: '', args: []);
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
