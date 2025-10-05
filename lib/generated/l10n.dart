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
    return Intl.message('Login', name: 'login_widgets', desc: '', args: []);
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

  /// `Daily Notifications`
  String get daily_notifications {
    return Intl.message(
      'Daily Notifications',
      name: 'daily_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Daily Challenges`
  String get daily_challenges {
    return Intl.message(
      'Daily Challenges',
      name: 'daily_challenges',
      desc: '',
      args: [],
    );
  }

  /// `Push notification at the specified time every day`
  String get push_notification_every_day {
    return Intl.message(
      'Push notification at the specified time every day',
      name: 'push_notification_every_day',
      desc: '',
      args: [],
    );
  }

  /// `ON`
  String get on {
    return Intl.message('ON', name: 'on', desc: '', args: []);
  }

  /// `OFF`
  String get off {
    return Intl.message('OFF', name: 'off', desc: '', args: []);
  }

  /// `Daily Notification Time`
  String get daily_notification_time {
    return Intl.message(
      'Daily Notification Time',
      name: 'daily_notification_time',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get select_time {
    return Intl.message('Select Time', name: 'select_time', desc: '', args: []);
  }

  /// `Notifications Quotes`
  String get notifications_quotes {
    return Intl.message(
      'Notifications Quotes',
      name: 'notifications_quotes',
      desc: '',
      args: [],
    );
  }

  /// `Add Quote`
  String get add_quote {
    return Intl.message('Add Quote', name: 'add_quote', desc: '', args: []);
  }

  /// `Quotes`
  String get quotes {
    return Intl.message('Quotes', name: 'quotes', desc: '', args: []);
  }

  /// `Show Suggestions`
  String get show_suggestions {
    return Intl.message(
      'Show Suggestions',
      name: 'show_suggestions',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Motivational Quote`
  String get choose_a_motivational_quote {
    return Intl.message(
      'Choose a Motivational Quote',
      name: 'choose_a_motivational_quote',
      desc: '',
      args: [],
    );
  }

  /// `No more quotes available.`
  String get no_more_quotes_available {
    return Intl.message(
      'No more quotes available.',
      name: 'no_more_quotes_available',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Add Motivational Quote`
  String get add_motivational_quote {
    return Intl.message(
      'Add Motivational Quote',
      name: 'add_motivational_quote',
      desc: '',
      args: [],
    );
  }

  /// `Type your motivational quote...`
  String get type_your_motivational_quote {
    return Intl.message(
      'Type your motivational quote...',
      name: 'type_your_motivational_quote',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Edit Notification`
  String get edit_notification {
    return Intl.message(
      'Edit Notification',
      name: 'edit_notification',
      desc: '',
      args: [],
    );
  }

  /// `Edit your message`
  String get edit_your_message {
    return Intl.message(
      'Edit your message',
      name: 'edit_your_message',
      desc: '',
      args: [],
    );
  }

  /// `MY CHALLENGES`
  String get my_challenges {
    return Intl.message(
      'MY CHALLENGES',
      name: 'my_challenges',
      desc: '',
      args: [],
    );
  }

  /// `RECOMMENDED FOR YOU`
  String get recommended_for_you {
    return Intl.message(
      'RECOMMENDED FOR YOU',
      name: 'recommended_for_you',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all {
    return Intl.message('View All', name: 'view_all', desc: '', args: []);
  }

  /// `Great, your today’s \nplan almost done`
  String get great_your_todays_plan_almost_done {
    return Intl.message(
      'Great, your today’s \nplan almost done',
      name: 'great_your_todays_plan_almost_done',
      desc: '',
      args: [],
    );
  }

  /// `View challenges`
  String get view_challenges {
    return Intl.message(
      'View challenges',
      name: 'view_challenges',
      desc: '',
      args: [],
    );
  }

  /// `Followers List`
  String get followers_list {
    return Intl.message(
      'Followers List',
      name: 'followers_list',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message('Followers', name: 'followers', desc: '', args: []);
  }

  /// `Following`
  String get following {
    return Intl.message('Following', name: 'following', desc: '', args: []);
  }

  /// `Likes`
  String get likes {
    return Intl.message('Likes', name: 'likes', desc: '', args: []);
  }

  /// `Unexpected error occurred`
  String get unexpected_error_occurred {
    return Intl.message(
      'Unexpected error occurred',
      name: 'unexpected_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `This email is not associated with your account`
  String get this_email_is_not_associated_with_your_account {
    return Intl.message(
      'This email is not associated with your account',
      name: 'this_email_is_not_associated_with_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There's something wrong with the information you entered. Please check and try again.`
  String get error_400 {
    return Intl.message(
      'Oops! There\'s something wrong with the information you entered. Please check and try again.',
      name: 'error_400',
      desc: '',
      args: [],
    );
  }

  /// `The email or password you entered is incorrect. Please try again.`
  String get error_401 {
    return Intl.message(
      'The email or password you entered is incorrect. Please try again.',
      name: 'error_401',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, you need to be logged in to do that. Please log in or create an account.`
  String get error_401_403 {
    return Intl.message(
      'Sorry, you need to be logged in to do that. Please log in or create an account.',
      name: 'error_401_403',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find what you were looking for. It might be missing or the link might be broken.`
  String get error_404 {
    return Intl.message(
      'We couldn\'t find what you were looking for. It might be missing or the link might be broken.',
      name: 'error_404',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, you're not allowed to do that. Please try a different way.`
  String get error_405 {
    return Intl.message(
      'Sorry, you\'re not allowed to do that. Please try a different way.',
      name: 'error_405',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again or contact us if the problem continues.`
  String get error_406 {
    return Intl.message(
      'Something went wrong. Please try again or contact us if the problem continues.',
      name: 'error_406',
      desc: '',
      args: [],
    );
  }

  /// `The request took too long. Please check your internet connection and try again.`
  String get error_408 {
    return Intl.message(
      'The request took too long. Please check your internet connection and try again.',
      name: 'error_408',
      desc: '',
      args: [],
    );
  }

  /// `There's a conflict with the data. Please try again later or contact us.`
  String get error_409 {
    return Intl.message(
      'There\'s a conflict with the data. Please try again later or contact us.',
      name: 'error_409',
      desc: '',
      args: [],
    );
  }

  /// `This content is no longer available.`
  String get error_410 {
    return Intl.message(
      'This content is no longer available.',
      name: 'error_410',
      desc: '',
      args: [],
    );
  }

  /// `Some information is missing. Please fill in all the required fields.`
  String get error_411 {
    return Intl.message(
      'Some information is missing. Please fill in all the required fields.',
      name: 'error_411',
      desc: '',
      args: [],
    );
  }

  /// `Your request didn't meet the requirements. Please check and try again.`
  String get error_412 {
    return Intl.message(
      'Your request didn\'t meet the requirements. Please check and try again.',
      name: 'error_412',
      desc: '',
      args: [],
    );
  }

  /// `The file you uploaded is too large. Please choose a smaller file.`
  String get error_413 {
    return Intl.message(
      'The file you uploaded is too large. Please choose a smaller file.',
      name: 'error_413',
      desc: '',
      args: [],
    );
  }

  /// `The website address is too long. Please try a shorter one.`
  String get error_414 {
    return Intl.message(
      'The website address is too long. Please try a shorter one.',
      name: 'error_414',
      desc: '',
      args: [],
    );
  }

  /// `There's a problem with the file you uploaded. Please try a different file type.`
  String get error_415 {
    return Intl.message(
      'There\'s a problem with the file you uploaded. Please try a different file type.',
      name: 'error_415',
      desc: '',
      args: [],
    );
  }

  /// `The information you entered is not valid. Please check and try again.`
  String get error_422 {
    return Intl.message(
      'The information you entered is not valid. Please check and try again.',
      name: 'error_422',
      desc: '',
      args: [],
    );
  }

  /// `You're making too many requests. Please try again later.`
  String get error_429 {
    return Intl.message(
      'You\'re making too many requests. Please try again later.',
      name: 'error_429',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong on our end. Please try again later.`
  String get error_500 {
    return Intl.message(
      'Oops! Something went wrong on our end. Please try again later.',
      name: 'error_500',
      desc: '',
      args: [],
    );
  }

  /// `This feature is not available yet. Please check back later.`
  String get error_501 {
    return Intl.message(
      'This feature is not available yet. Please check back later.',
      name: 'error_501',
      desc: '',
      args: [],
    );
  }

  /// `We're having trouble connecting to the server. Please try again later.`
  String get error_502 {
    return Intl.message(
      'We\'re having trouble connecting to the server. Please try again later.',
      name: 'error_502',
      desc: '',
      args: [],
    );
  }

  /// `The service is temporarily unavailable. Please try again later.`
  String get error_503 {
    return Intl.message(
      'The service is temporarily unavailable. Please try again later.',
      name: 'error_503',
      desc: '',
      args: [],
    );
  }

  /// `The connection timed out. Please check your internet connection and try again.`
  String get error_504 {
    return Intl.message(
      'The connection timed out. Please check your internet connection and try again.',
      name: 'error_504',
      desc: '',
      args: [],
    );
  }

  /// `This request is not supported. Please try a different way.`
  String get error_505 {
    return Intl.message(
      'This request is not supported. Please try a different way.',
      name: 'error_505',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred, try again later.`
  String get error_unexpected {
    return Intl.message(
      'An unexpected error occurred, try again later.',
      name: 'error_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `VIEW ALL CHALLENGES`
  String get view_all_challenges {
    return Intl.message(
      'VIEW ALL CHALLENGES',
      name: 'view_all_challenges',
      desc: '',
      args: [],
    );
  }

  /// `VIEW ALL COURSES`
  String get view_all_courses {
    return Intl.message(
      'VIEW ALL COURSES',
      name: 'view_all_courses',
      desc: '',
      args: [],
    );
  }

  /// `DEVELOP YOURSELF`
  String get develop_your_self {
    return Intl.message(
      'DEVELOP YOURSELF',
      name: 'develop_your_self',
      desc: '',
      args: [],
    );
  }

  /// `CHALLENGES`
  String get challenges {
    return Intl.message('CHALLENGES', name: 'challenges', desc: '', args: []);
  }

  /// `Video`
  String get video {
    return Intl.message('Video', name: 'video', desc: '', args: []);
  }

  /// `Add New Challenge`
  String get add_new_challenge {
    return Intl.message(
      'Add New Challenge',
      name: 'add_new_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Your Challenge Type`
  String get your_challenge_type {
    return Intl.message(
      'Your Challenge Type',
      name: 'your_challenge_type',
      desc: '',
      args: [],
    );
  }

  /// `Your Challenge Name`
  String get your_challenge_name {
    return Intl.message(
      'Your Challenge Name',
      name: 'your_challenge_name',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message('Task', name: 'task', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Time`
  String get Time {
    return Intl.message('Time', name: 'Time', desc: '', args: []);
  }

  /// `Please enter your challenge name`
  String get please_enter_your_challenge_name {
    return Intl.message(
      'Please enter your challenge name',
      name: 'please_enter_your_challenge_name',
      desc: '',
      args: [],
    );
  }

  /// `Achievement`
  String get achievement {
    return Intl.message('Achievement', name: 'achievement', desc: '', args: []);
  }

  /// `Badge`
  String get badge {
    return Intl.message('Badge', name: 'badge', desc: '', args: []);
  }

  /// `Follow`
  String get follow {
    return Intl.message('Follow', name: 'follow', desc: '', args: []);
  }

  /// `Days Badges`
  String get days_badge {
    return Intl.message('Days Badges', name: 'days_badge', desc: '', args: []);
  }

  /// `Challenges Badges`
  String get challenges_badges {
    return Intl.message(
      'Challenges Badges',
      name: 'challenges_badges',
      desc: '',
      args: [],
    );
  }

  /// `LAST WEEK PROGRESS`
  String get last_week_progress {
    return Intl.message(
      'LAST WEEK PROGRESS',
      name: 'last_week_progress',
      desc: '',
      args: [],
    );
  }

  /// `THIS WEEK PROGRESS`
  String get this_week_progress {
    return Intl.message(
      'THIS WEEK PROGRESS',
      name: 'this_week_progress',
      desc: '',
      args: [],
    );
  }

  /// `VIEW ALL PROGRESS`
  String get view_all_progress {
    return Intl.message(
      'VIEW ALL PROGRESS',
      name: 'view_all_progress',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message('Day', name: 'day', desc: '', args: []);
  }

  /// `Best Achiever`
  String get best_achiever {
    return Intl.message(
      'Best Achiever',
      name: 'best_achiever',
      desc: '',
      args: [],
    );
  }

  /// `Daily Progress`
  String get daily_progress {
    return Intl.message(
      'Daily Progress',
      name: 'daily_progress',
      desc: '',
      args: [],
    );
  }

  /// `How Are You Feeling Today`
  String get how_are_you_feeling_today {
    return Intl.message(
      'How Are You Feeling Today',
      name: 'how_are_you_feeling_today',
      desc: '',
      args: [],
    );
  }

  /// `Your mood today`
  String get your_mood_today {
    return Intl.message(
      'Your mood today',
      name: 'your_mood_today',
      desc: '',
      args: [],
    );
  }

  /// `Great`
  String get great {
    return Intl.message('Great', name: 'great', desc: '', args: []);
  }

  /// `Good`
  String get good {
    return Intl.message('Good', name: 'good', desc: '', args: []);
  }

  /// `Okay`
  String get ok {
    return Intl.message('Okay', name: 'ok', desc: '', args: []);
  }

  /// `Bad`
  String get bad {
    return Intl.message('Bad', name: 'bad', desc: '', args: []);
  }

  /// `Surprised`
  String get surprised {
    return Intl.message('Surprised', name: 'surprised', desc: '', args: []);
  }

  /// `Join Team`
  String get join_team {
    return Intl.message('Join Team', name: 'join_team', desc: '', args: []);
  }

  /// `Like`
  String get like {
    return Intl.message('Like', name: 'like', desc: '', args: []);
  }

  /// `Comment`
  String get comment {
    return Intl.message('Comment', name: 'comment', desc: '', args: []);
  }

  /// `Join Challenge`
  String get join_challenge {
    return Intl.message(
      'Join Challenge',
      name: 'join_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get lesson {
    return Intl.message('Lesson', name: 'lesson', desc: '', args: []);
  }

  /// `Your plan will create now`
  String get your_plan_will_create_now {
    return Intl.message(
      'Your plan will create now',
      name: 'your_plan_will_create_now',
      desc: '',
      args: [],
    );
  }

  /// `End of the Book`
  String get end_of_book {
    return Intl.message(
      'End of the Book',
      name: 'end_of_book',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Congratulations! 🎉`
  String get congratulations {
    return Intl.message(
      '🎉 Congratulations! 🎉',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully finished the book`
  String get book_finished_successfully {
    return Intl.message(
      'You have successfully finished the book',
      name: 'book_finished_successfully',
      desc: '',
      args: [],
    );
  }

  /// `We hope you enjoyed the reading\nand gained great value`
  String get hope_you_enjoyed_reading {
    return Intl.message(
      'We hope you enjoyed the reading\nand gained great value',
      name: 'hope_you_enjoyed_reading',
      desc: '',
      args: [],
    );
  }

  /// `Achievement Unlocked`
  String get achievement_unlocked {
    return Intl.message(
      'Achievement Unlocked',
      name: 'achievement_unlocked',
      desc: '',
      args: [],
    );
  }

  /// `Book Completed`
  String get book_completed {
    return Intl.message(
      'Book Completed',
      name: 'book_completed',
      desc: '',
      args: [],
    );
  }

  /// `Knowledge Gained`
  String get knowledge_gained {
    return Intl.message(
      'Knowledge Gained',
      name: 'knowledge_gained',
      desc: '',
      args: [],
    );
  }

  /// `Wisdom Achieved`
  String get wisdom_achieved {
    return Intl.message(
      'Wisdom Achieved',
      name: 'wisdom_achieved',
      desc: '',
      args: [],
    );
  }

  /// `Return to Home`
  String get return_to_home {
    return Intl.message(
      'Return to Home',
      name: 'return_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Read Another Book`
  String get read_another_book {
    return Intl.message(
      'Read Another Book',
      name: 'read_another_book',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load data`
  String get failed_to_load_data {
    return Intl.message(
      'Failed to load data',
      name: 'failed_to_load_data',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Times`
  String get prayer_times {
    return Intl.message(
      'Prayer Times',
      name: 'prayer_times',
      desc: '',
      args: [],
    );
  }

  /// `Fajr`
  String get fajr {
    return Intl.message('Fajr', name: 'fajr', desc: '', args: []);
  }

  /// `Sunrise`
  String get sunrise {
    return Intl.message('Sunrise', name: 'sunrise', desc: '', args: []);
  }

  /// `Dhuhr`
  String get dhuhr {
    return Intl.message('Dhuhr', name: 'dhuhr', desc: '', args: []);
  }

  /// `Asr`
  String get asr {
    return Intl.message('Asr', name: 'asr', desc: '', args: []);
  }

  /// `Maghrib`
  String get maghrib {
    return Intl.message('Maghrib', name: 'maghrib', desc: '', args: []);
  }

  /// `Isha`
  String get isha {
    return Intl.message('Isha', name: 'isha', desc: '', args: []);
  }

  /// `Prayed`
  String get prayed {
    return Intl.message('Prayed', name: 'prayed', desc: '', args: []);
  }

  /// `Missed`
  String get missed {
    return Intl.message('Missed', name: 'missed', desc: '', args: []);
  }

  /// `Unmarked`
  String get unmarked {
    return Intl.message('Unmarked', name: 'unmarked', desc: '', args: []);
  }

  /// `Daily Reading Challenge`
  String get daily_reading_challenge {
    return Intl.message(
      'Daily Reading Challenge',
      name: 'daily_reading_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get book {
    return Intl.message('Book', name: 'book', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Courses`
  String get courses {
    return Intl.message('Courses', name: 'courses', desc: '', args: []);
  }

  /// `Join Them`
  String get join_them {
    return Intl.message('Join Them', name: 'join_them', desc: '', args: []);
  }

  /// `No Challenges for now`
  String get no_challenges_for_now {
    return Intl.message(
      'No Challenges for now',
      name: 'no_challenges_for_now',
      desc: '',
      args: [],
    );
  }

  /// `No courses available for this category`
  String get no_courses_available_for_this_category {
    return Intl.message(
      'No courses available for this category',
      name: 'no_courses_available_for_this_category',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your Photo`
  String get upload_your_photo {
    return Intl.message(
      'Upload Your Photo',
      name: 'upload_your_photo',
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

  /// `Birth Date ?`
  String get birth_date_question {
    return Intl.message(
      'Birth Date ?',
      name: 'birth_date_question',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Please Select Gender`
  String get please_select_gender {
    return Intl.message(
      'Please Select Gender',
      name: 'please_select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Date of Birth`
  String get please_select_birth_date {
    return Intl.message(
      'Please Select Date of Birth',
      name: 'please_select_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `male`
  String get male {
    return Intl.message('male', name: 'male', desc: '', args: []);
  }

  /// `LET US KNOW ABOUT YOUR SELF`
  String get let_us_know_about_yourself {
    return Intl.message(
      'LET US KNOW ABOUT YOUR SELF',
      name: 'let_us_know_about_yourself',
      desc: '',
      args: [],
    );
  }

  /// `What are you interested in`
  String get what_are_you_interested_in {
    return Intl.message(
      'What are you interested in',
      name: 'what_are_you_interested_in',
      desc: '',
      args: [],
    );
  }

  /// `🎉Awesome! Your account’s ready — just a few quick steps to go!`
  String get account_created_successfully {
    return Intl.message(
      '🎉Awesome! Your account’s ready — just a few quick steps to go!',
      name: 'account_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `You did it! Welcome to the crew!😎`
  String get completed_successfully {
    return Intl.message(
      'You did it! Welcome to the crew!😎',
      name: 'completed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load interests`
  String get failed_to_load_interests {
    return Intl.message(
      'Failed to load interests',
      name: 'failed_to_load_interests',
      desc: '',
      args: [],
    );
  }

  /// `No interests found`
  String get no_interests_found {
    return Intl.message(
      'No interests found',
      name: 'no_interests_found',
      desc: '',
      args: [],
    );
  }

  /// `Update user info failed`
  String get update_user_info_failed {
    return Intl.message(
      'Update user info failed',
      name: 'update_user_info_failed',
      desc: '',
      args: [],
    );
  }

  /// `Not Prayed`
  String get not_prayed {
    return Intl.message('Not Prayed', name: 'not_prayed', desc: '', args: []);
  }

  /// `Late`
  String get late {
    return Intl.message('Late', name: 'late', desc: '', args: []);
  }

  /// `On Time`
  String get on_time {
    return Intl.message('On Time', name: 'on_time', desc: '', args: []);
  }

  /// `In Jamaah`
  String get in_jamaah {
    return Intl.message('In Jamaah', name: 'in_jamaah', desc: '', args: []);
  }

  /// `Not Available`
  String get not_available {
    return Intl.message(
      'Not Available',
      name: 'not_available',
      desc: '',
      args: [],
    );
  }

  /// `YouTube`
  String get youtube {
    return Intl.message('YouTube', name: 'youtube', desc: '', args: []);
  }

  /// `Choose Watching Method`
  String get choose_watching_method {
    return Intl.message(
      'Choose Watching Method',
      name: 'choose_watching_method',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to watch the video in-app or on YouTube?`
  String get watch_in_app_or_youtube {
    return Intl.message(
      'Would you like to watch the video in-app or on YouTube?',
      name: 'watch_in_app_or_youtube',
      desc: '',
      args: [],
    );
  }

  /// `In App`
  String get in_app {
    return Intl.message('In App', name: 'in_app', desc: '', args: []);
  }

  /// `Open on YouTube`
  String get open_in_youtube {
    return Intl.message(
      'Open on YouTube',
      name: 'open_in_youtube',
      desc: '',
      args: [],
    );
  }

  /// `Video Settings`
  String get video_settings {
    return Intl.message(
      'Video Settings',
      name: 'video_settings',
      desc: '',
      args: [],
    );
  }

  /// `Quality`
  String get quality {
    return Intl.message('Quality', name: 'quality', desc: '', args: []);
  }

  /// `Playback Speed`
  String get playback_speed {
    return Intl.message(
      'Playback Speed',
      name: 'playback_speed',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volume {
    return Intl.message('Volume', name: 'volume', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Failed to load questions`
  String get failed_to_load_questions {
    return Intl.message(
      'Failed to load questions',
      name: 'failed_to_load_questions',
      desc: '',
      args: [],
    );
  }

  /// `Pick what you love 💛`
  String get choose_what_you_like {
    return Intl.message(
      'Pick what you love 💛',
      name: 'choose_what_you_like',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Select...`
  String get select {
    return Intl.message('Select...', name: 'select', desc: '', args: []);
  }

  /// `No questions found`
  String get no_questions_found {
    return Intl.message(
      'No questions found',
      name: 'no_questions_found',
      desc: '',
      args: [],
    );
  }

  /// `There is No Categories`
  String get there_is_no_categories {
    return Intl.message(
      'There is No Categories',
      name: 'there_is_no_categories',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `How often do you want to do it?`
  String get how_often_do_you_want_to_do_it {
    return Intl.message(
      'How often do you want to do it?',
      name: 'how_often_do_you_want_to_do_it',
      desc: '',
      args: [],
    );
  }

  /// `Stopwatch`
  String get stopwatch {
    return Intl.message('Stopwatch', name: 'stopwatch', desc: '', args: []);
  }

  /// `Countdown`
  String get countdown {
    return Intl.message('Countdown', name: 'countdown', desc: '', args: []);
  }

  /// `Enter amount`
  String get enter_amount {
    return Intl.message(
      'Enter amount',
      name: 'enter_amount',
      desc: '',
      args: [],
    );
  }

  /// `Enter Other Number`
  String get enter_other_number {
    return Intl.message(
      'Enter Other Number',
      name: 'enter_other_number',
      desc: '',
      args: [],
    );
  }

  /// `Every Day`
  String get every_day {
    return Intl.message('Every Day', name: 'every_day', desc: '', args: []);
  }

  /// `Specific Days Of The Week`
  String get specific_days_week {
    return Intl.message(
      'Specific Days Of The Week',
      name: 'specific_days_week',
      desc: '',
      args: [],
    );
  }

  /// `Specific Days Of The Month`
  String get specific_days_month {
    return Intl.message(
      'Specific Days Of The Month',
      name: 'specific_days_month',
      desc: '',
      args: [],
    );
  }

  /// `Specific Days Of The Year`
  String get specific_days_year {
    return Intl.message(
      'Specific Days Of The Year',
      name: 'specific_days_year',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message('Repeat', name: 'repeat', desc: '', args: []);
  }

  /// `Saturday`
  String get saturday {
    return Intl.message('Saturday', name: 'saturday', desc: '', args: []);
  }

  /// `Sunday`
  String get sunday {
    return Intl.message('Sunday', name: 'sunday', desc: '', args: []);
  }

  /// `Monday`
  String get monday {
    return Intl.message('Monday', name: 'monday', desc: '', args: []);
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message('Tuesday', name: 'tuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message('Wednesday', name: 'wednesday', desc: '', args: []);
  }

  /// `Thursday`
  String get thursday {
    return Intl.message('Thursday', name: 'thursday', desc: '', args: []);
  }

  /// `Friday`
  String get friday {
    return Intl.message('Friday', name: 'friday', desc: '', args: []);
  }

  /// `January`
  String get january {
    return Intl.message('January', name: 'january', desc: '', args: []);
  }

  /// `February`
  String get february {
    return Intl.message('February', name: 'february', desc: '', args: []);
  }

  /// `March`
  String get march {
    return Intl.message('March', name: 'march', desc: '', args: []);
  }

  /// `April`
  String get april {
    return Intl.message('April', name: 'april', desc: '', args: []);
  }

  /// `May`
  String get may {
    return Intl.message('May', name: 'may', desc: '', args: []);
  }

  /// `June`
  String get june {
    return Intl.message('June', name: 'june', desc: '', args: []);
  }

  /// `July`
  String get july {
    return Intl.message('July', name: 'july', desc: '', args: []);
  }

  /// `August`
  String get august {
    return Intl.message('August', name: 'august', desc: '', args: []);
  }

  /// `September`
  String get september {
    return Intl.message('September', name: 'september', desc: '', args: []);
  }

  /// `October`
  String get october {
    return Intl.message('October', name: 'october', desc: '', args: []);
  }

  /// `November`
  String get november {
    return Intl.message('November', name: 'november', desc: '', args: []);
  }

  /// `December`
  String get december {
    return Intl.message('December', name: 'december', desc: '', args: []);
  }

  /// `Every`
  String get every {
    return Intl.message('Every', name: 'every', desc: '', args: []);
  }

  /// `Year calendar selection would go here`
  String get year_calendar_selection {
    return Intl.message(
      'Year calendar selection would go here',
      name: 'year_calendar_selection',
      desc: '',
      args: [],
    );
  }

  /// `SUN`
  String get sun {
    return Intl.message('SUN', name: 'sun', desc: '', args: []);
  }

  /// `MON`
  String get mon {
    return Intl.message('MON', name: 'mon', desc: '', args: []);
  }

  /// `TUE`
  String get tue {
    return Intl.message('TUE', name: 'tue', desc: '', args: []);
  }

  /// `WED`
  String get wed {
    return Intl.message('WED', name: 'wed', desc: '', args: []);
  }

  /// `THU`
  String get thu {
    return Intl.message('THU', name: 'thu', desc: '', args: []);
  }

  /// `FRI`
  String get fri {
    return Intl.message('FRI', name: 'fri', desc: '', args: []);
  }

  /// `SAT`
  String get sat {
    return Intl.message('SAT', name: 'sat', desc: '', args: []);
  }

  /// `Couldn't detect the user's mood.`
  String get mood_not_detected {
    return Intl.message(
      'Couldn\'t detect the user\'s mood.',
      name: 'mood_not_detected',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save the user's mood.`
  String get mood_save_failed {
    return Intl.message(
      'Failed to save the user\'s mood.',
      name: 'mood_save_failed',
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

  /// `Invalid Action`
  String get invalidAction {
    return Intl.message(
      'Invalid Action',
      name: 'invalidAction',
      desc: '',
      args: [],
    );
  }

  /// `You can't set the prayer status for a future day.`
  String get cannot_set_future_prayer {
    return Intl.message(
      'You can\'t set the prayer status for a future day.',
      name: 'cannot_set_future_prayer',
      desc: '',
      args: [],
    );
  }

  /// `Too much time has passed since this day, and it can no longer be edited.`
  String get too_late_to_edit_prayer {
    return Intl.message(
      'Too much time has passed since this day, and it can no longer be edited.',
      name: 'too_late_to_edit_prayer',
      desc: '',
      args: [],
    );
  }

  /// `You cannot view a day that hasn't come yet`
  String get cannot_view_future_day {
    return Intl.message(
      'You cannot view a day that hasn\'t come yet',
      name: 'cannot_view_future_day',
      desc: '',
      args: [],
    );
  }

  /// `Challenge created successfully!`
  String get challenge_created_successfully {
    return Intl.message(
      'Challenge created successfully!',
      name: 'challenge_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid amount`
  String get invalid_amount {
    return Intl.message(
      'Please enter a valid amount',
      name: 'invalid_amount',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get updated_successfully {
    return Intl.message(
      'Updated Successfully',
      name: 'updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Create Zikr`
  String get create_zikr {
    return Intl.message('Create Zikr', name: 'create_zikr', desc: '', args: []);
  }

  /// `Image uploaded successfully.`
  String get image_uploaded_successfully {
    return Intl.message(
      'Image uploaded successfully.',
      name: 'image_uploaded_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least two interest.`
  String get select_at_least_two_interest {
    return Intl.message(
      'Please select at least two interest.',
      name: 'select_at_least_two_interest',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Reset`
  String get reset_confirmation_title {
    return Intl.message(
      'Confirm Reset',
      name: 'reset_confirmation_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reset all Azkar?`
  String get reset_confirmation_content {
    return Intl.message(
      'Are you sure you want to reset all Azkar?',
      name: 'reset_confirmation_content',
      desc: '',
      args: [],
    );
  }

  /// ` Zikr counters saved successfully`
  String get zikr_saved_successfully {
    return Intl.message(
      ' Zikr counters saved successfully',
      name: 'zikr_saved_successfully',
      desc: '',
      args: [],
    );
  }

  /// `🔄 Counters have been reset successfully`
  String get zikr_reset_successfully {
    return Intl.message(
      '🔄 Counters have been reset successfully',
      name: 'zikr_reset_successfully',
      desc: '',
      args: [],
    );
  }

  /// ` An error occurred while saving, please try again`
  String get zikr_save_error {
    return Intl.message(
      ' An error occurred while saving, please try again',
      name: 'zikr_save_error',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please log in again.`
  String get session_expired {
    return Intl.message(
      'Your session has expired. Please log in again.',
      name: 'session_expired',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Congrats! You reached your goal!`
  String get goal_achieved_title {
    return Intl.message(
      '🎉 Congrats! You reached your goal!',
      name: 'goal_achieved_title',
      desc: '',
      args: [],
    );
  }

  /// `Keep going and achieve more!`
  String get goal_achieved_message {
    return Intl.message(
      'Keep going and achieve more!',
      name: 'goal_achieved_message',
      desc: '',
      args: [],
    );
  }

  /// `No challenges for this day yet! Add or join one 😊`
  String get no_challenges_today {
    return Intl.message(
      'No challenges for this day yet! Add or join one 😊',
      name: 'no_challenges_today',
      desc: '',
      args: [],
    );
  }

  /// `⏱ Reset Timer`
  String get reset_timer {
    return Intl.message(
      '⏱ Reset Timer',
      name: 'reset_timer',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reset the timer?`
  String get reset_timer_confirmation {
    return Intl.message(
      'Are you sure you want to reset the timer?',
      name: 'reset_timer_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `You can only edit the challenge on its current day`
  String get edit_challenge_not_allowed {
    return Intl.message(
      'You can only edit the challenge on its current day',
      name: 'edit_challenge_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Tracking`
  String get prayer_tracking {
    return Intl.message(
      'Prayer Tracking',
      name: 'prayer_tracking',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Congratulations! All challenges completed!`
  String get congratulations_all_challenges_completed {
    return Intl.message(
      '🎉 Congratulations! All challenges completed!',
      name: 'congratulations_all_challenges_completed',
      desc: '',
      args: [],
    );
  }

  /// `Good progress! Keep going 💪`
  String get good_progress_keep_going {
    return Intl.message(
      'Good progress! Keep going 💪',
      name: 'good_progress_keep_going',
      desc: '',
      args: [],
    );
  }

  /// `Nice start! Continue your challenges 🔥`
  String get nice_start_continue_your_challenges {
    return Intl.message(
      'Nice start! Continue your challenges 🔥',
      name: 'nice_start_continue_your_challenges',
      desc: '',
      args: [],
    );
  }

  /// `Start your daily challenges! 🚀`
  String get start_your_daily_challenges {
    return Intl.message(
      'Start your daily challenges! 🚀',
      name: 'start_your_daily_challenges',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Congratulations! Perfect Day!`
  String get daily_completion_title_1 {
    return Intl.message(
      '🎉 Congratulations! Perfect Day!',
      name: 'daily_completion_title_1',
      desc: '',
      args: [],
    );
  }

  /// `You completed all your challenges today! Keep up this amazing achievement 💪✨`
  String get daily_completion_message_1 {
    return Intl.message(
      'You completed all your challenges today! Keep up this amazing achievement 💪✨',
      name: 'daily_completion_message_1',
      desc: '',
      args: [],
    );
  }

  /// `🌟 Fantastic Achievement!`
  String get daily_completion_title_2 {
    return Intl.message(
      '🌟 Fantastic Achievement!',
      name: 'daily_completion_title_2',
      desc: '',
      args: [],
    );
  }

  /// `All challenges completed! You're a true warrior 🏆`
  String get daily_completion_message_2 {
    return Intl.message(
      'All challenges completed! You\'re a true warrior 🏆',
      name: 'daily_completion_message_2',
      desc: '',
      args: [],
    );
  }

  /// `🔥 Day Full of Achievement!`
  String get daily_completion_title_3 {
    return Intl.message(
      '🔥 Day Full of Achievement!',
      name: 'daily_completion_title_3',
      desc: '',
      args: [],
    );
  }

  /// `100% completed! This is what I call excellence 🚀`
  String get daily_completion_message_3 {
    return Intl.message(
      '100% completed! This is what I call excellence 🚀',
      name: 'daily_completion_message_3',
      desc: '',
      args: [],
    );
  }

  /// `💪 Strength and Determination!`
  String get daily_completion_title_4 {
    return Intl.message(
      '💪 Strength and Determination!',
      name: 'daily_completion_title_4',
      desc: '',
      args: [],
    );
  }

  /// `All challenges accomplished! Get ready for more tomorrow ⭐`
  String get daily_completion_message_4 {
    return Intl.message(
      'All challenges accomplished! Get ready for more tomorrow ⭐',
      name: 'daily_completion_message_4',
      desc: '',
      args: [],
    );
  }

  /// ` Congrats 🎉`
  String get congratulations_title {
    return Intl.message(
      ' Congrats 🎉',
      name: 'congratulations_title',
      desc: '',
      args: [],
    );
  }

  /// `Well done! 🎉`
  String get well_done {
    return Intl.message('Well done! 🎉', name: 'well_done', desc: '', args: []);
  }

  /// `Great achievement!`
  String get great_achievement {
    return Intl.message(
      'Great achievement!',
      name: 'great_achievement',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Congrats!`
  String get goal_title_1 {
    return Intl.message(
      '🎉 Congrats!',
      name: 'goal_title_1',
      desc: '',
      args: [],
    );
  }

  /// `🔥 Awesome!`
  String get goal_title_2 {
    return Intl.message(
      '🔥 Awesome!',
      name: 'goal_title_2',
      desc: '',
      args: [],
    );
  }

  /// `👏 Well done!`
  String get goal_title_3 {
    return Intl.message(
      '👏 Well done!',
      name: 'goal_title_3',
      desc: '',
      args: [],
    );
  }

  /// `🚀 Great!`
  String get goal_title_4 {
    return Intl.message('🚀 Great!', name: 'goal_title_4', desc: '', args: []);
  }

  /// `💪 Strong!`
  String get goal_title_5 {
    return Intl.message('💪 Strong!', name: 'goal_title_5', desc: '', args: []);
  }

  /// `✨ Excellent!`
  String get goal_title_6 {
    return Intl.message(
      '✨ Excellent!',
      name: 'goal_title_6',
      desc: '',
      args: [],
    );
  }

  /// `🌟 Superb!`
  String get goal_title_7 {
    return Intl.message('🌟 Superb!', name: 'goal_title_7', desc: '', args: []);
  }

  /// `🥳 Nice!`
  String get goal_title_8 {
    return Intl.message('🥳 Nice!', name: 'goal_title_8', desc: '', args: []);
  }

  /// `🏆 Winner!`
  String get goal_title_9 {
    return Intl.message('🏆 Winner!', name: 'goal_title_9', desc: '', args: []);
  }

  /// `📈 Progress!`
  String get goal_title_10 {
    return Intl.message(
      '📈 Progress!',
      name: 'goal_title_10',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Congratulations! You completed the challenge!`
  String get goal_message_1 {
    return Intl.message(
      '🎉 Congratulations! You completed the challenge!',
      name: 'goal_message_1',
      desc: '',
      args: [],
    );
  }

  /// `🔥 Great work! Another challenge done.`
  String get goal_message_2 {
    return Intl.message(
      '🔥 Great work! Another challenge done.',
      name: 'goal_message_2',
      desc: '',
      args: [],
    );
  }

  /// `👏 Well played! Challenge completed.`
  String get goal_message_3 {
    return Intl.message(
      '👏 Well played! Challenge completed.',
      name: 'goal_message_3',
      desc: '',
      args: [],
    );
  }

  /// `🚀 Awesome! One more step forward.`
  String get goal_message_4 {
    return Intl.message(
      '🚀 Awesome! One more step forward.',
      name: 'goal_message_4',
      desc: '',
      args: [],
    );
  }

  /// `💪 Strong and determined! Challenge finished.`
  String get goal_message_5 {
    return Intl.message(
      '💪 Strong and determined! Challenge finished.',
      name: 'goal_message_5',
      desc: '',
      args: [],
    );
  }

  /// `✨ Excellent job, you nailed it!`
  String get goal_message_6 {
    return Intl.message(
      '✨ Excellent job, you nailed it!',
      name: 'goal_message_6',
      desc: '',
      args: [],
    );
  }

  /// `🌟 Another challenge conquered!`
  String get goal_message_7 {
    return Intl.message(
      '🌟 Another challenge conquered!',
      name: 'goal_message_7',
      desc: '',
      args: [],
    );
  }

  /// `🥳 Fantastic! Challenge completed.`
  String get goal_message_8 {
    return Intl.message(
      '🥳 Fantastic! Challenge completed.',
      name: 'goal_message_8',
      desc: '',
      args: [],
    );
  }

  /// `🏆 Victory! That challenge is behind you.`
  String get goal_message_9 {
    return Intl.message(
      '🏆 Victory! That challenge is behind you.',
      name: 'goal_message_9',
      desc: '',
      args: [],
    );
  }

  /// `📈 Progress made! Keep going strong.`
  String get goal_message_10 {
    return Intl.message(
      '📈 Progress made! Keep going strong.',
      name: 'goal_message_10',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '// 📱 ===== BAD MOOD DIALOG KEYS =====' key

  // skipped getter for the '// Main Dialog' key

  /// `I'm here for you ❤️`
  String get im_here_for_you {
    return Intl.message(
      'I\'m here for you ❤️',
      name: 'im_here_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions to feel better`
  String get helpful_suggestions {
    return Intl.message(
      'Suggestions to feel better',
      name: 'helpful_suggestions',
      desc: '',
      args: [],
    );
  }

  /// `I need some personal space`
  String get need_personal_space {
    return Intl.message(
      'I need some personal space',
      name: 'need_personal_space',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '// Random Support Messages' key

  /// `I don't know what's bothering you, but I'm here if you want to talk 🤗`
  String get bad_mood_message_1 {
    return Intl.message(
      'I don\'t know what\'s bothering you, but I\'m here if you want to talk 🤗',
      name: 'bad_mood_message_1',
      desc: '',
      args: [],
    );
  }

  /// `Tough day? It's okay, tomorrow will be better God willing 💙`
  String get bad_mood_message_2 {
    return Intl.message(
      'Tough day? It\'s okay, tomorrow will be better God willing 💙',
      name: 'bad_mood_message_2',
      desc: '',
      args: [],
    );
  }

  /// `Feeling like you're not okay? It's normal, we all go through days like this`
  String get bad_mood_message_3 {
    return Intl.message(
      'Feeling like you\'re not okay? It\'s normal, we all go through days like this',
      name: 'bad_mood_message_3',
      desc: '',
      args: [],
    );
  }

  /// `You don't have to be strong all the time, sometimes we need to feel sad`
  String get bad_mood_message_4 {
    return Intl.message(
      'You don\'t have to be strong all the time, sometimes we need to feel sad',
      name: 'bad_mood_message_4',
      desc: '',
      args: [],
    );
  }

  /// `It's just a bad day, not a bad life 🌅`
  String get bad_mood_message_5 {
    return Intl.message(
      'It\'s just a bad day, not a bad life 🌅',
      name: 'bad_mood_message_5',
      desc: '',
      args: [],
    );
  }

  /// `Want to talk a bit? Or do you want space alone?`
  String get bad_mood_message_6 {
    return Intl.message(
      'Want to talk a bit? Or do you want space alone?',
      name: 'bad_mood_message_6',
      desc: '',
      args: [],
    );
  }

  /// `I know this time is hard for you, but you're stronger than this 💪`
  String get bad_mood_message_7 {
    return Intl.message(
      'I know this time is hard for you, but you\'re stronger than this 💪',
      name: 'bad_mood_message_7',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '// Activities Dialog' key

  /// `Things that might help you 💙`
  String get activities_help_you {
    return Intl.message(
      'Things that might help you 💙',
      name: 'activities_help_you',
      desc: '',
      args: [],
    );
  }

  /// `Deep breathing`
  String get deep_breathing {
    return Intl.message(
      'Deep breathing',
      name: 'deep_breathing',
      desc: '',
      args: [],
    );
  }

  /// `5 minutes of calm breathing`
  String get deep_breathing_desc {
    return Intl.message(
      '5 minutes of calm breathing',
      name: 'deep_breathing_desc',
      desc: '',
      args: [],
    );
  }

  /// `Listen to music`
  String get listen_music {
    return Intl.message(
      'Listen to music',
      name: 'listen_music',
      desc: '',
      args: [],
    );
  }

  /// `A song you love`
  String get listen_music_desc {
    return Intl.message(
      'A song you love',
      name: 'listen_music_desc',
      desc: '',
      args: [],
    );
  }

  /// `Take a walk`
  String get take_walk {
    return Intl.message('Take a walk', name: 'take_walk', desc: '', args: []);
  }

  /// `Even if just 10 minutes`
  String get take_walk_desc {
    return Intl.message(
      'Even if just 10 minutes',
      name: 'take_walk_desc',
      desc: '',
      args: [],
    );
  }

  /// `Call someone close`
  String get call_someone {
    return Intl.message(
      'Call someone close',
      name: 'call_someone',
      desc: '',
      args: [],
    );
  }

  /// `A friend or family`
  String get call_someone_desc {
    return Intl.message(
      'A friend or family',
      name: 'call_someone_desc',
      desc: '',
      args: [],
    );
  }

  /// `Write your feelings`
  String get write_feelings {
    return Intl.message(
      'Write your feelings',
      name: 'write_feelings',
      desc: '',
      args: [],
    );
  }

  /// `On paper or phone`
  String get write_feelings_desc {
    return Intl.message(
      'On paper or phone',
      name: 'write_feelings_desc',
      desc: '',
      args: [],
    );
  }

  /// `Thank you`
  String get thank_you {
    return Intl.message('Thank you', name: 'thank_you', desc: '', args: []);
  }

  // skipped getter for the '// Space Messages' key

  /// `Alright, take the time you need. I'll be here when you're ready 🤗`
  String get space_message_1 {
    return Intl.message(
      'Alright, take the time you need. I\'ll be here when you\'re ready 🤗',
      name: 'space_message_1',
      desc: '',
      args: [],
    );
  }

  /// `No problem, sometimes we need to be alone for a while. Take care of yourself ❤️`
  String get space_message_2 {
    return Intl.message(
      'No problem, sometimes we need to be alone for a while. Take care of yourself ❤️',
      name: 'space_message_2',
      desc: '',
      args: [],
    );
  }

  /// `You know yourself better than anyone. Take your time and come back when you feel like it 🌸`
  String get space_message_3 {
    return Intl.message(
      'You know yourself better than anyone. Take your time and come back when you feel like it 🌸',
      name: 'space_message_3',
      desc: '',
      args: [],
    );
  }

  /// `Personal space is important. Use it for something you love or just relax 💙`
  String get space_message_4 {
    return Intl.message(
      'Personal space is important. Use it for something you love or just relax 💙',
      name: 'space_message_4',
      desc: '',
      args: [],
    );
  }

  /// `No challenges available for this category`
  String get no_challenges_available_for_this_category {
    return Intl.message(
      'No challenges available for this category',
      name: 'no_challenges_available_for_this_category',
      desc: '',
      args: [],
    );
  }

  /// `Achiever User`
  String get achiever_user {
    return Intl.message(
      'Achiever User',
      name: 'achiever_user',
      desc: '',
      args: [],
    );
  }

  /// `Friends' Timeline`
  String get timeline_header {
    return Intl.message(
      'Friends\' Timeline',
      name: 'timeline_header',
      desc: '',
      args: [],
    );
  }

  /// `No participants found`
  String get no_participants_found {
    return Intl.message(
      'No participants found',
      name: 'no_participants_found',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong .`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong .',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Challenge Participants`
  String get challenge_participants {
    return Intl.message(
      'Challenge Participants',
      name: 'challenge_participants',
      desc: '',
      args: [],
    );
  }

  /// `Loading participants...`
  String get loading_participants {
    return Intl.message(
      'Loading participants...',
      name: 'loading_participants',
      desc: '',
      args: [],
    );
  }

  /// `Join Challenge`
  String get join_challenge_confirmation_title {
    return Intl.message(
      'Join Challenge',
      name: 'join_challenge_confirmation_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to join the "{challengeTitle}" challenge?`
  String join_challenge_confirmation_message(Object challengeTitle) {
    return Intl.message(
      'Are you sure you want to join the "$challengeTitle" challenge?',
      name: 'join_challenge_confirmation_message',
      desc: '',
      args: [challengeTitle],
    );
  }

  /// `Join Now`
  String get join_now {
    return Intl.message('Join Now', name: 'join_now', desc: '', args: []);
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Joining...`
  String get joining {
    return Intl.message('Joining...', name: 'joining', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Got it`
  String get got_it {
    return Intl.message('Got it', name: 'got_it', desc: '', args: []);
  }

  /// `Delete Confirmation`
  String get delete_confirmation {
    return Intl.message(
      'Delete Confirmation',
      name: 'delete_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete "{itemName}"?`
  String delete_confirmation_message(Object itemName) {
    return Intl.message(
      'Are you sure you want to delete "$itemName"?',
      name: 'delete_confirmation_message',
      desc: '',
      args: [itemName],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get logout_confirmation_message {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_confirmation_message',
      desc: '',
      args: [],
    );
  }

  /// `Stay`
  String get stay {
    return Intl.message('Stay', name: 'stay', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Quran Reading`
  String get quran_reading {
    return Intl.message(
      'Quran Reading',
      name: 'quran_reading',
      desc: '',
      args: [],
    );
  }

  /// `Azkar`
  String get azkar {
    return Intl.message('Azkar', name: 'azkar', desc: '', args: []);
  }

  /// `📰 No news available.\n Follow someone to see the latest updates.`
  String get timeline_message_1 {
    return Intl.message(
      '📰 No news available.\n Follow someone to see the latest updates.',
      name: 'timeline_message_1',
      desc: '',
      args: [],
    );
  }

  /// `📭 Your timeline is empty! \n Follow people to get the latest news.`
  String get timeline_message_2 {
    return Intl.message(
      '📭 Your timeline is empty! \n Follow people to get the latest news.',
      name: 'timeline_message_2',
      desc: '',
      args: [],
    );
  }

  /// `🔔 Nothing new for now,\n start following your friends to stay updated.`
  String get timeline_message_3 {
    return Intl.message(
      '🔔 Nothing new for now,\n start following your friends to stay updated.',
      name: 'timeline_message_3',
      desc: '',
      args: [],
    );
  }

  /// `💬 Stay connected! \n  Follow someone to see what's happening.`
  String get timeline_message_4 {
    return Intl.message(
      '💬 Stay connected! \n  Follow someone to see what\'s happening.',
      name: 'timeline_message_4',
      desc: '',
      args: [],
    );
  }

  /// `🌍 Discover more! \n Follow people and explore the latest updates.`
  String get timeline_message_5 {
    return Intl.message(
      '🌍 Discover more! \n Follow people and explore the latest updates.',
      name: 'timeline_message_5',
      desc: '',
      args: [],
    );
  }

  /// `Leave Challenge`
  String get leave_challenge {
    return Intl.message(
      'Leave Challenge',
      name: 'leave_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Leaving...`
  String get leaving {
    return Intl.message('Leaving...', name: 'leaving', desc: '', args: []);
  }

  /// `Leave Challenge`
  String get leave_challenge_confirmation_title {
    return Intl.message(
      'Leave Challenge',
      name: 'leave_challenge_confirmation_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to leave {challengeTitle}?`
  String leave_challenge_confirmation_message(Object challengeTitle) {
    return Intl.message(
      'Are you sure you want to leave $challengeTitle?',
      name: 'leave_challenge_confirmation_message',
      desc: '',
      args: [challengeTitle],
    );
  }

  /// `Leave Now`
  String get leave_now {
    return Intl.message('Leave Now', name: 'leave_now', desc: '', args: []);
  }

  /// `Search in challenges`
  String get search_in_challenges {
    return Intl.message(
      'Search in challenges',
      name: 'search_in_challenges',
      desc: '',
      args: [],
    );
  }

  /// `No search results`
  String get no_search_results {
    return Intl.message(
      'No search results',
      name: 'no_search_results',
      desc: '',
      args: [],
    );
  }

  /// `Ready for the next challenge? \n💪 Come back and join now!`
  String get motivational_join_challenges {
    return Intl.message(
      'Ready for the next challenge? \n💪 Come back and join now!',
      name: 'motivational_join_challenges',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interests {
    return Intl.message('Interests', name: 'interests', desc: '', args: []);
  }

  /// `Categories list has been updated successfully ✅`
  String get categories_update_success {
    return Intl.message(
      'Categories list has been updated successfully ✅',
      name: 'categories_update_success',
      desc: '',
      args: [],
    );
  }

  /// `Go to Page`
  String get go_to_page {
    return Intl.message('Go to Page', name: 'go_to_page', desc: '', args: []);
  }

  /// `Enter page number ({min} - {max})`
  String enter_page_number(Object min, Object max) {
    return Intl.message(
      'Enter page number ($min - $max)',
      name: 'enter_page_number',
      desc: '',
      args: [min, max],
    );
  }

  /// `Page Number`
  String get page_number {
    return Intl.message('Page Number', name: 'page_number', desc: '', args: []);
  }

  /// `Go`
  String get go {
    return Intl.message('Go', name: 'go', desc: '', args: []);
  }

  /// `Page {pageNumber} saved successfully`
  String bookmark_saved(Object pageNumber) {
    return Intl.message(
      'Page $pageNumber saved successfully',
      name: 'bookmark_saved',
      desc: '',
      args: [pageNumber],
    );
  }

  /// `Failed to load PDF: {error}`
  String pdf_load_error(Object error) {
    return Intl.message(
      'Failed to load PDF: $error',
      name: 'pdf_load_error',
      desc: '',
      args: [error],
    );
  }

  /// `Page {current} of {total}`
  String page_indicator(Object current, Object total) {
    return Intl.message(
      'Page $current of $total',
      name: 'page_indicator',
      desc: '',
      args: [current, total],
    );
  }

  /// `Saved: Page {pageNumber}`
  String saved_page(Object pageNumber) {
    return Intl.message(
      'Saved: Page $pageNumber',
      name: 'saved_page',
      desc: '',
      args: [pageNumber],
    );
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

  /// `The entered page number is greater than the total pages ({totalPages})`
  String page_number_exceeds_total(Object totalPages) {
    return Intl.message(
      'The entered page number is greater than the total pages ($totalPages)',
      name: 'page_number_exceeds_total',
      desc: '',
      args: [totalPages],
    );
  }

  /// `You have successfully completed reading the book`
  String get congratulations_message {
    return Intl.message(
      'You have successfully completed reading the book',
      name: 'congratulations_message',
      desc: '',
      args: [],
    );
  }

  /// `Total Pages`
  String get total_pages {
    return Intl.message('Total Pages', name: 'total_pages', desc: '', args: []);
  }

  /// `Last Saved Page`
  String get last_saved_page {
    return Intl.message(
      'Last Saved Page',
      name: 'last_saved_page',
      desc: '',
      args: [],
    );
  }

  /// `Back to Last Page`
  String get back_to_last_page {
    return Intl.message(
      'Back to Last Page',
      name: 'back_to_last_page',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get back_to_home {
    return Intl.message(
      'Back to Home',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Select Time Duration`
  String get select_time_duration {
    return Intl.message(
      'Select Time Duration',
      name: 'select_time_duration',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `Enter Custom Time`
  String get enter_custom_time {
    return Intl.message(
      'Enter Custom Time',
      name: 'enter_custom_time',
      desc: '',
      args: [],
    );
  }

  /// `Enter Time Duration`
  String get enter_time_duration {
    return Intl.message(
      'Enter Time Duration',
      name: 'enter_time_duration',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Time Duration`
  String get invalid_time_duration {
    return Intl.message(
      'Invalid Time Duration',
      name: 'invalid_time_duration',
      desc: '',
      args: [],
    );
  }

  /// `Enter Minutes`
  String get enter_minutes {
    return Intl.message(
      'Enter Minutes',
      name: 'enter_minutes',
      desc: '',
      args: [],
    );
  }

  /// `Enter Hours`
  String get enter_hours {
    return Intl.message('Enter Hours', name: 'enter_hours', desc: '', args: []);
  }

  /// `min`
  String get min_suffix {
    return Intl.message('min', name: 'min_suffix', desc: '', args: []);
  }

  /// `hr`
  String get hour_suffix {
    return Intl.message('hr', name: 'hour_suffix', desc: '', args: []);
  }

  /// `Challenges Badge`
  String get challenges_badge {
    return Intl.message(
      'Challenges Badge',
      name: 'challenges_badge',
      desc: '',
      args: [],
    );
  }

  /// `Category Challenges Badge`
  String get category_challenges_badge {
    return Intl.message(
      'Category Challenges Badge',
      name: 'category_challenges_badge',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Average`
  String get weekly_average_title {
    return Intl.message(
      'Weekly Average',
      name: 'weekly_average_title',
      desc: '',
      args: [],
    );
  }

  /// `Your productivity this week`
  String get weekly_average_subtitle {
    return Intl.message(
      'Your productivity this week',
      name: 'weekly_average_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Needs Improvement`
  String get weekly_label_low {
    return Intl.message(
      'Needs Improvement',
      name: 'weekly_label_low',
      desc: '',
      args: [],
    );
  }

  /// `Getting Better`
  String get weekly_label_medium {
    return Intl.message(
      'Getting Better',
      name: 'weekly_label_medium',
      desc: '',
      args: [],
    );
  }

  /// `Productive`
  String get weekly_label_high {
    return Intl.message(
      'Productive',
      name: 'weekly_label_high',
      desc: '',
      args: [],
    );
  }

  /// `Super Productive`
  String get weekly_label_super {
    return Intl.message(
      'Super Productive',
      name: 'weekly_label_super',
      desc: '',
      args: [],
    );
  }

  /// `No images yet! 😊`
  String get no_challenge_images_title {
    return Intl.message(
      'No images yet! 😊',
      name: 'no_challenge_images_title',
      desc: '',
      args: [],
    );
  }

  /// `Tap the + button to add your challenge images.`
  String get no_challenge_images_subtitle {
    return Intl.message(
      'Tap the + button to add your challenge images.',
      name: 'no_challenge_images_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `No followers yet! 😊`
  String get no_followers_title {
    return Intl.message(
      'No followers yet! 😊',
      name: 'no_followers_title',
      desc: '',
      args: [],
    );
  }

  /// `Add users to see their activity and images.`
  String get no_followers_subtitle {
    return Intl.message(
      'Add users to see their activity and images.',
      name: 'no_followers_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `New Challenger`
  String get default_achiever {
    return Intl.message(
      'New Challenger',
      name: 'default_achiever',
      desc: '',
      args: [],
    );
  }

  /// `Saving Progress...`
  String get saving_progress {
    return Intl.message(
      'Saving Progress...',
      name: 'saving_progress',
      desc: '',
      args: [],
    );
  }

  /// `Share the challenge with you 💪\n{link}`
  String share_challenge_text(Object link) {
    return Intl.message(
      'Share the challenge with you 💪\n$link',
      name: 'share_challenge_text',
      desc: '',
      args: [link],
    );
  }

  /// `Challenge`
  String get share_challenge_subject {
    return Intl.message(
      'Challenge',
      name: 'share_challenge_subject',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get oops_title {
    return Intl.message('Oops!', name: 'oops_title', desc: '', args: []);
  }

  /// `Page not found`
  String get not_found_subtitle {
    return Intl.message(
      'Page not found',
      name: 'not_found_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Or you can contact us for help`
  String get contact_us_help {
    return Intl.message(
      'Or you can contact us for help',
      name: 'contact_us_help',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we can’t find the page you’re looking for.\nGo back to the homepage.`
  String get not_found_description {
    return Intl.message(
      'Sorry, we can’t find the page you’re looking for.\nGo back to the homepage.',
      name: 'not_found_description',
      desc: '',
      args: [],
    );
  }

  /// `x`
  String get x {
    return Intl.message('x', name: 'x', desc: '', args: []);
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
