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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Akademi.al`
  String get title {
    return Intl.message(
      'Akademi.al',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Hyr`
  String get login {
    return Intl.message(
      'Hyr',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Regjistrohu`
  String get register {
    return Intl.message(
      'Regjistrohu',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Platformë mësimore me kurse live. Falas.`
  String get information_1_title {
    return Intl.message(
      'Platformë mësimore me kurse live. Falas.',
      name: 'information_1_title',
      desc: '',
      args: [],
    );
  }

  /// `Përmirësoni procesin e të mësuarit duke u bërë pjesë e një komuniteti virtual nxënësish dhe mësuesish.`
  String get information_1_content {
    return Intl.message(
      'Përmirësoni procesin e të mësuarit duke u bërë pjesë e një komuniteti virtual nxënësish dhe mësuesish.',
      name: 'information_1_content',
      desc: '',
      args: [],
    );
  }

  /// `Mbi 5000 video.\nFalas.`
  String get information_2_title {
    return Intl.message(
      'Mbi 5000 video.\nFalas.',
      name: 'information_2_title',
      desc: '',
      args: [],
    );
  }

  /// `Videot e përgatitura nga një staf i përzgjedhur mësuesish nga i gjithë vendi, janë të aksesueshme nga të gjithë nxënësit me krijimin e një llogarie në platformë, pa asnjë kosto.`
  String get information_2_content {
    return Intl.message(
      'Videot e përgatitura nga një staf i përzgjedhur mësuesish nga i gjithë vendi, janë të aksesueshme nga të gjithë nxënësit me krijimin e një llogarie në platformë, pa asnjë kosto.',
      name: 'information_2_content',
      desc: '',
      args: [],
    );
  }

  /// `Bashkëpuno në\nkohë reale`
  String get information_3_title {
    return Intl.message(
      'Bashkëpuno në\nkohë reale',
      name: 'information_3_title',
      desc: '',
      args: [],
    );
  }

  /// `Bëhu pjesë e një komuniteti virtual nxënësish me të  cilët mund të ndash njohuritë e tua.`
  String get information_3_content {
    return Intl.message(
      'Bëhu pjesë e një komuniteti virtual nxënësish me të  cilët mund të ndash njohuritë e tua.',
      name: 'information_3_content',
      desc: '',
      args: [],
    );
  }

  /// `Metoda\ninteraktive`
  String get information_4_title {
    return Intl.message(
      'Metoda\ninteraktive',
      name: 'information_4_title',
      desc: '',
      args: [],
    );
  }

  /// `Ndani materiale, dokumenta duke i bërë ato të aksesueshme kudo dhe kurdo.`
  String get information_4_content {
    return Intl.message(
      'Ndani materiale, dokumenta duke i bërë ato të aksesueshme kudo dhe kurdo.',
      name: 'information_4_content',
      desc: '',
      args: [],
    );
  }

  /// `Sqarim!`
  String get note_title {
    return Intl.message(
      'Sqarim!',
      name: 'note_title',
      desc: '',
      args: [],
    );
  }

  /// `Nxënësit mbi 13 vjeç mund të kyçen në sistem nëpërmjet adresës së email. Ndërsa nxënësit nën 13 vjeç mund të kyçen në sistem nëpërmjet emrit të përdoruesit të vendosur gjatë momentit të regjistrimit të llogarisë.`
  String get note_description {
    return Intl.message(
      'Nxënësit mbi 13 vjeç mund të kyçen në sistem nëpërmjet adresës së email. Ndërsa nxënësit nën 13 vjeç mund të kyçen në sistem nëpërmjet emrit të përdoruesit të vendosur gjatë momentit të regjistrimit të llogarisë.',
      name: 'note_description',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Formati emailit nuk është i saktë.`
  String get wrong_email {
    return Intl.message(
      'Formati emailit nuk është i saktë.',
      name: 'wrong_email',
      desc: '',
      args: [],
    );
  }

  /// `Fjalëkalimi`
  String get password {
    return Intl.message(
      'Fjalëkalimi',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Fjalëkalimi është i detyrueshëm`
  String get wrong_password {
    return Intl.message(
      'Fjalëkalimi është i detyrueshëm',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Harruat fjalëkalimin?`
  String get forgot_password {
    return Intl.message(
      'Harruat fjalëkalimin?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Nuk ke një llogari? `
  String get dont_have_account {
    return Intl.message(
      'Nuk ke një llogari? ',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Regjistrohu këtu`
  String get register_here_1 {
    return Intl.message(
      'Regjistrohu këtu',
      name: 'register_here_1',
      desc: '',
      args: [],
    );
  }

  /// `OSE`
  String get or {
    return Intl.message(
      'OSE',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Si quheni?`
  String get whats_your_name {
    return Intl.message(
      'Si quheni?',
      name: 'whats_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Emër`
  String get name {
    return Intl.message(
      'Emër',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Mbiemër`
  String get surname {
    return Intl.message(
      'Mbiemër',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Vazhdo`
  String get continue_label {
    return Intl.message(
      'Vazhdo',
      name: 'continue_label',
      desc: '',
      args: [],
    );
  }

  /// `Kur e keni ditëlindjen?`
  String get birthday_question {
    return Intl.message(
      'Kur e keni ditëlindjen?',
      name: 'birthday_question',
      desc: '',
      args: [],
    );
  }

  /// `Ditëlindja`
  String get birthday {
    return Intl.message(
      'Ditëlindja',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Anullo`
  String get cancel {
    return Intl.message(
      'Anullo',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Zgjidh`
  String get choose {
    return Intl.message(
      'Zgjidh',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Hapi {index}/4`
  String register_tracker(Object index) {
    return Intl.message(
      'Hapi $index/4',
      name: 'register_tracker',
      desc: '',
      args: [index],
    );
  }

  /// `Email juaj`
  String get your_email {
    return Intl.message(
      'Email juaj',
      name: 'your_email',
      desc: '',
      args: [],
    );
  }

  /// `Email prindit/kujdestarit`
  String get parent_email_label {
    return Intl.message(
      'Email prindit/kujdestarit',
      name: 'parent_email_label',
      desc: '',
      args: [],
    );
  }

  /// `nxënës@akademi.al...`
  String get example_email {
    return Intl.message(
      'nxënës@akademi.al...',
      name: 'example_email',
      desc: '',
      args: [],
    );
  }

  /// `kujdestari@email.com`
  String get example_parent_email {
    return Intl.message(
      'kujdestari@email.com',
      name: 'example_parent_email',
      desc: '',
      args: [],
    );
  }

  /// `Email kujdestarit dhe emri përdoruesit`
  String get parent_email {
    return Intl.message(
      'Email kujdestarit dhe emri përdoruesit',
      name: 'parent_email',
      desc: '',
      args: [],
    );
  }

  /// `Jemi entuziastë që do t’i bashkoheni platformës tonë, por na duhet të njoftojmë prindin/kujdestarin tuaj. Vendosni emailin e prindit/kujdestarit tuaj dhe emrin e përdoruesit të fëmijës.`
  String get parent_email_description {
    return Intl.message(
      'Jemi entuziastë që do t’i bashkoheni platformës tonë, por na duhet të njoftojmë prindin/kujdestarin tuaj. Vendosni emailin e prindit/kujdestarit tuaj dhe emrin e përdoruesit të fëmijës.',
      name: 'parent_email_description',
      desc: '',
      args: [],
    );
  }

  /// `Emri përdoruesit`
  String get username_label {
    return Intl.message(
      'Emri përdoruesit',
      name: 'username_label',
      desc: '',
      args: [],
    );
  }

  /// `Krijo një fjalëkalim`
  String get create_a_password {
    return Intl.message(
      'Krijo një fjalëkalim',
      name: 'create_a_password',
      desc: '',
      args: [],
    );
  }

  /// `Të paktën 8 karaktere`
  String get at_least_8_chars {
    return Intl.message(
      'Të paktën 8 karaktere',
      name: 'at_least_8_chars',
      desc: '',
      args: [],
    );
  }

  /// `Të paktën një shkronjë të madhe`
  String get at_least_1_macro {
    return Intl.message(
      'Të paktën një shkronjë të madhe',
      name: 'at_least_1_macro',
      desc: '',
      args: [],
    );
  }

  /// `Të paktën një karakter special`
  String get at_least_a_special_char {
    return Intl.message(
      'Të paktën një karakter special',
      name: 'at_least_a_special_char',
      desc: '',
      args: [],
    );
  }

  /// `Të paktën një numër`
  String get at_least_a_number {
    return Intl.message(
      'Të paktën një numër',
      name: 'at_least_a_number',
      desc: '',
      args: [],
    );
  }

  /// `Duke u shtypur butonin Përfundo ju pranoni `
  String get term_and_conditions {
    return Intl.message(
      'Duke u shtypur butonin Përfundo ju pranoni ',
      name: 'term_and_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Kushtet e Shërbimit, Politikat e Privatësisë`
  String get privacy_policy_registration {
    return Intl.message(
      'Kushtet e Shërbimit, Politikat e Privatësisë',
      name: 'privacy_policy_registration',
      desc: '',
      args: [],
    );
  }

  /// `Politikat e Përdorimit`
  String get usage_policy_registration {
    return Intl.message(
      'Politikat e Përdorimit',
      name: 'usage_policy_registration',
      desc: '',
      args: [],
    );
  }

  /// `Përfundo`
  String get end {
    return Intl.message(
      'Përfundo',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Harruat fjalëkalimin?`
  String get forgot_password_question {
    return Intl.message(
      'Harruat fjalëkalimin?',
      name: 'forgot_password_question',
      desc: '',
      args: [],
    );
  }

  /// `Vendosni adresën e emaili tuaj ose të prindit/kujdestarit tuaj që te merrni instruksionet për të ndryshuar fjalëkalimin.`
  String get forgot_password_description {
    return Intl.message(
      'Vendosni adresën e emaili tuaj ose të prindit/kujdestarit tuaj që te merrni instruksionet për të ndryshuar fjalëkalimin.',
      name: 'forgot_password_description',
      desc: '',
      args: [],
    );
  }

  /// `Dërgo  instruksionet`
  String get send_instructions {
    return Intl.message(
      'Dërgo  instruksionet',
      name: 'send_instructions',
      desc: '',
      args: [],
    );
  }

  /// `Emaili u dërgua me sukses`
  String get email_was_send_succesfully {
    return Intl.message(
      'Emaili u dërgua me sukses',
      name: 'email_was_send_succesfully',
      desc: '',
      args: [],
    );
  }

  /// `Emaili u dërgua te `
  String get email_sent_succesfully_description_1 {
    return Intl.message(
      'Emaili u dërgua te ',
      name: 'email_sent_succesfully_description_1',
      desc: '',
      args: [],
    );
  }

  /// ` Ju lutem kontrolloni emailin tuaj për të ndryshuar fjalëkalimin tuaj. Sigurohuni të kontrolloni gjithashtu kartelën Spam ose Promotions.`
  String get email_sent_succesfully_description_2 {
    return Intl.message(
      ' Ju lutem kontrolloni emailin tuaj për të ndryshuar fjalëkalimin tuaj. Sigurohuni të kontrolloni gjithashtu kartelën Spam ose Promotions.',
      name: 'email_sent_succesfully_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Ridërgo email`
  String get resend_email {
    return Intl.message(
      'Ridërgo email',
      name: 'resend_email',
      desc: '',
      args: [],
    );
  }

  /// `Hap emailin`
  String get open_email {
    return Intl.message(
      'Hap emailin',
      name: 'open_email',
      desc: '',
      args: [],
    );
  }

  /// `Nuk ju ka ardhur emaili?`
  String get email_not_recived {
    return Intl.message(
      'Nuk ju ka ardhur emaili?',
      name: 'email_not_recived',
      desc: '',
      args: [],
    );
  }

  /// `Platforma zyrtare mësimore e aprovuar nga\nMinistria e Arsimit, Sportit dhe Rinisë`
  String get splash_page_text {
    return Intl.message(
      'Platforma zyrtare mësimore e aprovuar nga\nMinistria e Arsimit, Sportit dhe Rinisë',
      name: 'splash_page_text',
      desc: '',
      args: [],
    );
  }

  /// `© {year} akademi.al `
  String copyright(Object year) {
    return Intl.message(
      '© $year akademi.al ',
      name: 'copyright',
      desc: '',
      args: [year],
    );
  }

  /// `Plotëso profilin`
  String get fill_your_profile {
    return Intl.message(
      'Plotëso profilin',
      name: 'fill_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Hapi {index}/7`
  String onboarding_tracker(Object index) {
    return Intl.message(
      'Hapi $index/7',
      name: 'onboarding_tracker',
      desc: '',
      args: [index],
    );
  }

  /// `Mirë se erdhe,\n{name}`
  String welcome_name(Object name) {
    return Intl.message(
      'Mirë se erdhe,\n$name',
      name: 'welcome_name',
      desc: '',
      args: [name],
    );
  }

  /// `Tashmë ju jeni një student i akademi.al. Ju do të keni mundësi të ndiqni kurset tona online, të mësoni dhe zhvilloni njohuritë në të gjithë lëndët e kursit tuaj. Suksese!`
  String get welcome_description {
    return Intl.message(
      'Tashmë ju jeni një student i akademi.al. Ju do të keni mundësi të ndiqni kurset tona online, të mësoni dhe zhvilloni njohuritë në të gjithë lëndët e kursit tuaj. Suksese!',
      name: 'welcome_description',
      desc: '',
      args: [],
    );
  }

  /// `Shteti`
  String get second_onboarding_page_title {
    return Intl.message(
      'Shteti',
      name: 'second_onboarding_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Fotoja e profilit`
  String get third_onboarding_page_title {
    return Intl.message(
      'Fotoja e profilit',
      name: 'third_onboarding_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Arsimi`
  String get fourth_onboarding_page_title {
    return Intl.message(
      'Arsimi',
      name: 'fourth_onboarding_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Kursi`
  String get fifth_onboarding_page_title {
    return Intl.message(
      'Kursi',
      name: 'fifth_onboarding_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Lëndët`
  String get sixth_onboarding_page_title {
    return Intl.message(
      'Lëndët',
      name: 'sixth_onboarding_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Kurse live`
  String get seventh_onboarding_page_title {
    return Intl.message(
      'Kurse live',
      name: 'seventh_onboarding_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Zgjidhni shtetin ku zhvilloni studimet tuaja.`
  String get choose_state {
    return Intl.message(
      'Zgjidhni shtetin ku zhvilloni studimet tuaja.',
      name: 'choose_state',
      desc: '',
      args: [],
    );
  }

  /// `Shqipëri`
  String get albania_nationality {
    return Intl.message(
      'Shqipëri',
      name: 'albania_nationality',
      desc: '',
      args: [],
    );
  }

  /// `Kosovë`
  String get kosova_nationality {
    return Intl.message(
      'Kosovë',
      name: 'kosova_nationality',
      desc: '',
      args: [],
    );
  }

  /// `Diaspora`
  String get diaspora_nationality {
    return Intl.message(
      'Diaspora',
      name: 'diaspora_nationality',
      desc: '',
      args: [],
    );
  }

  /// `Ngarko ose zgjidh foton e profilit.`
  String get choose_profile_picture_description {
    return Intl.message(
      'Ngarko ose zgjidh foton e profilit.',
      name: 'choose_profile_picture_description',
      desc: '',
      args: [],
    );
  }

  /// `Kursi`
  String get grade {
    return Intl.message(
      'Kursi',
      name: 'grade',
      desc: '',
      args: [],
    );
  }

  /// `Zgjidhni nivelin tuaj arsimor dhe do të keni mundësi të ndiqni video leksione sipas kursit që i përkisni.`
  String get choose_grade_description {
    return Intl.message(
      'Zgjidhni nivelin tuaj arsimor dhe do të keni mundësi të ndiqni video leksione sipas kursit që i përkisni.',
      name: 'choose_grade_description',
      desc: '',
      args: [],
    );
  }

  /// `Shënim: Ky konfigurim mund të ndryshohet përsëri në dashboard.`
  String get choose_grade_disclaimer {
    return Intl.message(
      'Shënim: Ky konfigurim mund të ndryshohet përsëri në dashboard.',
      name: 'choose_grade_disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Fillore`
  String get elementary {
    return Intl.message(
      'Fillore',
      name: 'elementary',
      desc: '',
      args: [],
    );
  }

  /// `Para-shkollor`
  String get preschool {
    return Intl.message(
      'Para-shkollor',
      name: 'preschool',
      desc: '',
      args: [],
    );
  }

  /// `9-vjeçare`
  String get middle_school {
    return Intl.message(
      '9-vjeçare',
      name: 'middle_school',
      desc: '',
      args: [],
    );
  }

  /// `E mesme`
  String get high_school {
    return Intl.message(
      'E mesme',
      name: 'high_school',
      desc: '',
      args: [],
    );
  }

  /// `Korporatat`
  String get corporate {
    return Intl.message(
      'Korporatat',
      name: 'corporate',
      desc: '',
      args: [],
    );
  }

  /// `Para-universitar`
  String get pre_university {
    return Intl.message(
      'Para-universitar',
      name: 'pre_university',
      desc: '',
      args: [],
    );
  }

  /// `Universitar`
  String get university {
    return Intl.message(
      'Universitar',
      name: 'university',
      desc: '',
      args: [],
    );
  }

  /// `Arsim Profesional`
  String get professional_school {
    return Intl.message(
      'Arsim Profesional',
      name: 'professional_school',
      desc: '',
      args: [],
    );
  }

  /// `Çfare kursi jeni?`
  String get what_grade_question {
    return Intl.message(
      'Çfare kursi jeni?',
      name: 'what_grade_question',
      desc: '',
      args: [],
    );
  }

  /// `Zgjidh lëndët. Mund të zgjidhni më shumë se një dhe ne do t’ju ofrojmë video leksione sipas zgjedhjes tuaj.`
  String get subjects_description {
    return Intl.message(
      'Zgjidh lëndët. Mund të zgjidhni më shumë se një dhe ne do t’ju ofrojmë video leksione sipas zgjedhjes tuaj.',
      name: 'subjects_description',
      desc: '',
      args: [],
    );
  }

  /// `Të gjitha`
  String get all_subjects {
    return Intl.message(
      'Të gjitha',
      name: 'all_subjects',
      desc: '',
      args: [],
    );
  }

  /// `Vendosni kodin/kodet e kursit live.`
  String get virtual_class_description {
    return Intl.message(
      'Vendosni kodin/kodet e kursit live.',
      name: 'virtual_class_description',
      desc: '',
      args: [],
    );
  }

  /// `Çfare eshte kursi live?`
  String get what_is_a_virtual_class {
    return Intl.message(
      'Çfare eshte kursi live?',
      name: 'what_is_a_virtual_class',
      desc: '',
      args: [],
    );
  }

  /// `Kursi live është një instrument për të organizuar seanca mësimore live që mund të ndiqen drejtpërdrejt nëpërmjet internetit. Kodin e kursit live e merrni nga mësuesi.`
  String get what_is_a_virtual_class_description {
    return Intl.message(
      'Kursi live është një instrument për të organizuar seanca mësimore live që mund të ndiqen drejtpërdrejt nëpërmjet internetit. Kodin e kursit live e merrni nga mësuesi.',
      name: 'what_is_a_virtual_class_description',
      desc: '',
      args: [],
    );
  }

  /// `Kodi kursit live`
  String get virtual_class_code {
    return Intl.message(
      'Kodi kursit live',
      name: 'virtual_class_code',
      desc: '',
      args: [],
    );
  }

  /// `(Jo e detyrueshme)`
  String get not_neccesessary {
    return Intl.message(
      '(Jo e detyrueshme)',
      name: 'not_neccesessary',
      desc: '',
      args: [],
    );
  }

  /// `psh 1234567....`
  String get virtual_class_code_label {
    return Intl.message(
      'psh 1234567....',
      name: 'virtual_class_code_label',
      desc: '',
      args: [],
    );
  }

  /// `Email nuk ekziston`
  String get email_does_not_exist {
    return Intl.message(
      'Email nuk ekziston',
      name: 'email_does_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Kontrolloni emailin tuaj për të përfunduar regjistrimin`
  String get check_email_to_finish_registration {
    return Intl.message(
      'Kontrolloni emailin tuaj për të përfunduar regjistrimin',
      name: 'check_email_to_finish_registration',
      desc: '',
      args: [],
    );
  }

  /// `Emaili i regjistrimit u dërgua te `
  String get registration_success_description_1 {
    return Intl.message(
      'Emaili i regjistrimit u dërgua te ',
      name: 'registration_success_description_1',
      desc: '',
      args: [],
    );
  }

  /// ` Ju lutem kontrolloni emailin tuaj për të finalizuar regjistrimin! Sigurohuni të kontrolloni gjithashtu kartelën Spam ose Promotions.`
  String get registration_success_description_2 {
    return Intl.message(
      ' Ju lutem kontrolloni emailin tuaj për të finalizuar regjistrimin! Sigurohuni të kontrolloni gjithashtu kartelën Spam ose Promotions.',
      name: 'registration_success_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Ngarko`
  String get upload {
    return Intl.message(
      'Ngarko',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Profil mësuesi`
  String get teacher_profile {
    return Intl.message(
      'Profil mësuesi',
      name: 'teacher_profile',
      desc: '',
      args: [],
    );
  }

  /// `Hap website`
  String get open_website {
    return Intl.message(
      'Hap website',
      name: 'open_website',
      desc: '',
      args: [],
    );
  }

  /// `Ke një llogari? `
  String get got_an_account {
    return Intl.message(
      'Ke një llogari? ',
      name: 'got_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Hyr këtu`
  String get enter_here {
    return Intl.message(
      'Hyr këtu',
      name: 'enter_here',
      desc: '',
      args: [],
    );
  }

  /// `Email ose emri i përdoruesit`
  String get email_or_username {
    return Intl.message(
      'Email ose emri i përdoruesit',
      name: 'email_or_username',
      desc: '',
      args: [],
    );
  }

  /// `Nuk pranohen përdorues nën 3 vjeç!`
  String get no_users_under_3 {
    return Intl.message(
      'Nuk pranohen përdorues nën 3 vjeç!',
      name: 'no_users_under_3',
      desc: '',
      args: [],
    );
  }

  /// `Kalo`
  String get skip {
    return Intl.message(
      'Kalo',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Kreu`
  String get home {
    return Intl.message(
      'Kreu',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Kurse`
  String get classrooms {
    return Intl.message(
      'Kurse',
      name: 'classrooms',
      desc: '',
      args: [],
    );
  }

  /// `Kalendari`
  String get calendar {
    return Intl.message(
      'Kalendari',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Lëndët`
  String get subjects {
    return Intl.message(
      'Lëndët',
      name: 'subjects',
      desc: '',
      args: [],
    );
  }

  /// `Kurse live ({number})`
  String virtual_classes(Object number) {
    return Intl.message(
      'Kurse live ($number)',
      name: 'virtual_classes',
      desc: '',
      args: [number],
    );
  }

  /// `Konfigurime`
  String get configuration {
    return Intl.message(
      'Konfigurime',
      name: 'configuration',
      desc: '',
      args: [],
    );
  }

  /// `Të gjitha`
  String get all {
    return Intl.message(
      'Të gjitha',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Ndërtoni njohuri të thella, dhe baza të forta në lëndët matematikë, shkencë, histori dhe më shumë…`
  String get subjects_browser_description {
    return Intl.message(
      'Ndërtoni njohuri të thella, dhe baza të forta në lëndët matematikë, shkencë, histori dhe më shumë…',
      name: 'subjects_browser_description',
      desc: '',
      args: [],
    );
  }

  /// `Kërko...`
  String get search {
    return Intl.message(
      'Kërko...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Filtro`
  String get filter {
    return Intl.message(
      'Filtro',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Kthehu`
  String get return_text {
    return Intl.message(
      'Kthehu',
      name: 'return_text',
      desc: '',
      args: [],
    );
  }

  /// `Apliko filtrat`
  String get apply_filters {
    return Intl.message(
      'Apliko filtrat',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `Apliko filtrat ({number})`
  String apply_filters_number(Object number) {
    return Intl.message(
      'Apliko filtrat ($number)',
      name: 'apply_filters_number',
      desc: '',
      args: [number],
    );
  }

  /// `Ndërtoni njohuri të thella, dhe baza të forta në lëndën e {name}.`
  String async_classroom_description(Object name) {
    return Intl.message(
      'Ndërtoni njohuri të thella, dhe baza të forta në lëndën e $name.',
      name: 'async_classroom_description',
      desc: '',
      args: [name],
    );
  }

  /// `Fillo Kursin`
  String get enroll {
    return Intl.message(
      'Fillo Kursin',
      name: 'enroll',
      desc: '',
      args: [],
    );
  }

  /// `Vazhdo Kursin`
  String get continue_course {
    return Intl.message(
      'Vazhdo Kursin',
      name: 'continue_course',
      desc: '',
      args: [],
    );
  }

  /// `Leksione`
  String get lessons {
    return Intl.message(
      'Leksione',
      name: 'lessons',
      desc: '',
      args: [],
    );
  }

  /// `Detaje`
  String get details {
    return Intl.message(
      'Detaje',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Pershkrimi`
  String get description {
    return Intl.message(
      'Pershkrimi',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Materiale`
  String get materials {
    return Intl.message(
      'Materiale',
      name: 'materials',
      desc: '',
      args: [],
    );
  }

  /// `Përfundo leksionin`
  String get end_lesson {
    return Intl.message(
      'Përfundo leksionin',
      name: 'end_lesson',
      desc: '',
      args: [],
    );
  }

  /// `Fillo kuicin`
  String get start_quiz {
    return Intl.message(
      'Fillo kuicin',
      name: 'start_quiz',
      desc: '',
      args: [],
    );
  }

  /// `Pyetja {index}`
  String question_number(Object index) {
    return Intl.message(
      'Pyetja $index',
      name: 'question_number',
      desc: '',
      args: [index],
    );
  }

  /// `Kontrollo përgjigjet`
  String get check_answers {
    return Intl.message(
      'Kontrollo përgjigjet',
      name: 'check_answers',
      desc: '',
      args: [],
    );
  }

  /// `Pergjigje e pasakte. Pergjigje e sakte eshte: `
  String get wrong_answer {
    return Intl.message(
      'Pergjigje e pasakte. Pergjigje e sakte eshte: ',
      name: 'wrong_answer',
      desc: '',
      args: [],
    );
  }

  /// `Mbyll`
  String get close {
    return Intl.message(
      'Mbyll',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Ribëj kuicin`
  String get redo_quiz {
    return Intl.message(
      'Ribëj kuicin',
      name: 'redo_quiz',
      desc: '',
      args: [],
    );
  }

  /// `Rezultati`
  String get results {
    return Intl.message(
      'Rezultati',
      name: 'results',
      desc: '',
      args: [],
    );
  }

  /// `Ju jeni pergjigjur sakte {number}/{total} pyetje ne kuic.`
  String correct_answer_number(Object number, Object total) {
    return Intl.message(
      'Ju jeni pergjigjur sakte $number/$total pyetje ne kuic.',
      name: 'correct_answer_number',
      desc: '',
      args: [number, total],
    );
  }

  /// `Hiq filtrat ({number})`
  String remove_filters(Object number) {
    return Intl.message(
      'Hiq filtrat ($number)',
      name: 'remove_filters',
      desc: '',
      args: [number],
    );
  }

  /// `Organizata`
  String get organization {
    return Intl.message(
      'Organizata',
      name: 'organization',
      desc: '',
      args: [],
    );
  }

  /// `Zgjidhni institucionin arsimor ku dëshironi të hyni.`
  String get choose_organization {
    return Intl.message(
      'Zgjidhni institucionin arsimor ku dëshironi të hyni.',
      name: 'choose_organization',
      desc: '',
      args: [],
    );
  }

  /// `Emaili regjistrimit u ridërgua me sukses. Kontrolloni emailin tuaj për të përfunduar regjistrimin`
  String get resend_succesfull {
    return Intl.message(
      'Emaili regjistrimit u ridërgua me sukses. Kontrolloni emailin tuaj për të përfunduar regjistrimin',
      name: 'resend_succesfull',
      desc: '',
      args: [],
    );
  }

  /// `Keni vendosur gabim të dhënat për fushën "Email ose emri i përdoruesit / Fjalëkalimin". Ju lutem verifikoni të dhënat!`
  String get wrong_login {
    return Intl.message(
      'Keni vendosur gabim të dhënat për fushën "Email ose emri i përdoruesit / Fjalëkalimin". Ju lutem verifikoni të dhënat!',
      name: 'wrong_login',
      desc: '',
      args: [],
    );
  }

  /// `Gabim!`
  String get wrong {
    return Intl.message(
      'Gabim!',
      name: 'wrong',
      desc: '',
      args: [],
    );
  }

  /// `Pergjigje sakte.`
  String get correct_answer {
    return Intl.message(
      'Pergjigje sakte.',
      name: 'correct_answer',
      desc: '',
      args: [],
    );
  }

  /// `Ekziston një llogari e regjistruar me këtë Email.`
  String get email_exists {
    return Intl.message(
      'Ekziston një llogari e regjistruar me këtë Email.',
      name: 'email_exists',
      desc: '',
      args: [],
    );
  }

  /// `Mungon lidhja me internetin.`
  String get internet_missing {
    return Intl.message(
      'Mungon lidhja me internetin.',
      name: 'internet_missing',
      desc: '',
      args: [],
    );
  }

  /// `Kurse live`
  String get virtual_classrooms {
    return Intl.message(
      'Kurse live',
      name: 'virtual_classrooms',
      desc: '',
      args: [],
    );
  }

  /// `Të gjitha ({number})`
  String all_number(Object number) {
    return Intl.message(
      'Të gjitha ($number)',
      name: 'all_number',
      desc: '',
      args: [number],
    );
  }

  /// `Kurse të regjistruara`
  String get async_classrooms {
    return Intl.message(
      'Kurse të regjistruara',
      name: 'async_classrooms',
      desc: '',
      args: [],
    );
  }

  /// `Duke pritur për aprovim...`
  String get waiting_for_approval {
    return Intl.message(
      'Duke pritur për aprovim...',
      name: 'waiting_for_approval',
      desc: '',
      args: [],
    );
  }

  /// `dërguar {date}`
  String send_on(Object date) {
    return Intl.message(
      'dërguar $date',
      name: 'send_on',
      desc: '',
      args: [date],
    );
  }

  /// `Hyr në kursin live`
  String get join_virtual_classroom {
    return Intl.message(
      'Hyr në kursin live',
      name: 'join_virtual_classroom',
      desc: '',
      args: [],
    );
  }

  /// `Për të hyrë në kursin live`
  String get to_enter_virtual_classroom {
    return Intl.message(
      'Për të hyrë në kursin live',
      name: 'to_enter_virtual_classroom',
      desc: '',
      args: [],
    );
  }

  /// `Ju duhet të përdorni një kod me 8 shkronja ose numra, pa hapësira ose karaktere speciale.`
  String get to_enter_virtual_classroom_description {
    return Intl.message(
      'Ju duhet të përdorni një kod me 8 shkronja ose numra, pa hapësira ose karaktere speciale.',
      name: 'to_enter_virtual_classroom_description',
      desc: '',
      args: [],
    );
  }

  /// `Merrni kodin e kursit nga mësuesi dhe vendoseni më poshtë.`
  String get take_code_and_enter_below {
    return Intl.message(
      'Merrni kodin e kursit nga mësuesi dhe vendoseni më poshtë.',
      name: 'take_code_and_enter_below',
      desc: '',
      args: [],
    );
  }

  /// `Kodi i kursit live`
  String get virtual_classroom_code {
    return Intl.message(
      'Kodi i kursit live',
      name: 'virtual_classroom_code',
      desc: '',
      args: [],
    );
  }

  /// `Shto`
  String get add {
    return Intl.message(
      'Shto',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Kreu`
  String get virtual_classroom_home {
    return Intl.message(
      'Kreu',
      name: 'virtual_classroom_home',
      desc: '',
      args: [],
    );
  }

  /// `Përmbajtja`
  String get virtual_classroom_content {
    return Intl.message(
      'Përmbajtja',
      name: 'virtual_classroom_content',
      desc: '',
      args: [],
    );
  }

  /// `Nxënësit`
  String get virtual_classroom_people {
    return Intl.message(
      'Nxënësit',
      name: 'virtual_classroom_people',
      desc: '',
      args: [],
    );
  }

  /// `Detyrat`
  String get virtual_classroom_homework {
    return Intl.message(
      'Detyrat',
      name: 'virtual_classroom_homework',
      desc: '',
      args: [],
    );
  }

  /// `{nr} nxënës`
  String nr_of_pupils(Object nr) {
    return Intl.message(
      '$nr nxënës',
      name: 'nr_of_pupils',
      desc: '',
      args: [nr],
    );
  }

  /// `Kodi kursit`
  String get classroom_code {
    return Intl.message(
      'Kodi kursit',
      name: 'classroom_code',
      desc: '',
      args: [],
    );
  }

  /// `Kodi i kursit u kopjua`
  String get classroom_code_copied {
    return Intl.message(
      'Kodi i kursit u kopjua',
      name: 'classroom_code_copied',
      desc: '',
      args: [],
    );
  }

  /// `Komunikoni dhe merrni të rejat më të fundit`
  String get communicate_and_get_latest_news {
    return Intl.message(
      'Komunikoni dhe merrni të rejat më të fundit',
      name: 'communicate_and_get_latest_news',
      desc: '',
      args: [],
    );
  }

  /// `Shikoni kur ka detyra të reja.`
  String get see_when_new_homework {
    return Intl.message(
      'Shikoni kur ka detyra të reja.',
      name: 'see_when_new_homework',
      desc: '',
      args: [],
    );
  }

  /// `Të gjitha komentet ({number})`
  String open_all_comments(Object number) {
    return Intl.message(
      'Të gjitha komentet ($number)',
      name: 'open_all_comments',
      desc: '',
      args: [number],
    );
  }

  /// `Shto nje koment...`
  String get add_a_comment {
    return Intl.message(
      'Shto nje koment...',
      name: 'add_a_comment',
      desc: '',
      args: [],
    );
  }

  /// `Shto një koment`
  String get add_a_comment_title {
    return Intl.message(
      'Shto një koment',
      name: 'add_a_comment_title',
      desc: '',
      args: [],
    );
  }

  /// `Ndaj dicka me kursin...`
  String get share_smth {
    return Intl.message(
      'Ndaj dicka me kursin...',
      name: 'share_smth',
      desc: '',
      args: [],
    );
  }

  /// `Rreth kursit`
  String get more_about_classroom {
    return Intl.message(
      'Rreth kursit',
      name: 'more_about_classroom',
      desc: '',
      args: [],
    );
  }

  /// `Çregjistrohu`
  String get unregister {
    return Intl.message(
      'Çregjistrohu',
      name: 'unregister',
      desc: '',
      args: [],
    );
  }

  /// `Emri i kursit live`
  String get virtual_classroom_name {
    return Intl.message(
      'Emri i kursit live',
      name: 'virtual_classroom_name',
      desc: '',
      args: [],
    );
  }

  /// `Shkolla`
  String get school {
    return Intl.message(
      'Shkolla',
      name: 'school',
      desc: '',
      args: [],
    );
  }

  /// `Lënda`
  String get subject {
    return Intl.message(
      'Lënda',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Je i sigurtë që dëshironi të çregjistroheni nga kursi “{name}”?`
  String sure_want_to_unregister_from_classroom(Object name) {
    return Intl.message(
      'Je i sigurtë që dëshironi të çregjistroheni nga kursi “$name”?',
      name: 'sure_want_to_unregister_from_classroom',
      desc: '',
      args: [name],
    );
  }

  /// `Po, çregjistrohu`
  String get yes_unregister {
    return Intl.message(
      'Po, çregjistrohu',
      name: 'yes_unregister',
      desc: '',
      args: [],
    );
  }

  /// `Ju nuk bëni pjesë në asnjë kurse live. Shtypni butonin më poshtë për tu bërë pjesë e një kursi live.`
  String get not_part_of_any_virtual_class {
    return Intl.message(
      'Ju nuk bëni pjesë në asnjë kurse live. Shtypni butonin më poshtë për tu bërë pjesë e një kursi live.',
      name: 'not_part_of_any_virtual_class',
      desc: '',
      args: [],
    );
  }

  /// `Mësues`
  String get teacher {
    return Intl.message(
      'Mësues',
      name: 'teacher',
      desc: '',
      args: [],
    );
  }

  /// `Nxënës`
  String get pupils {
    return Intl.message(
      'Nxënës',
      name: 'pupils',
      desc: '',
      args: [],
    );
  }

  /// `(Unë)`
  String get me {
    return Intl.message(
      '(Unë)',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Detyrat`
  String get homework {
    return Intl.message(
      'Detyrat',
      name: 'homework',
      desc: '',
      args: [],
    );
  }

  /// `Në korrigjim`
  String get evaluating {
    return Intl.message(
      'Në korrigjim',
      name: 'evaluating',
      desc: '',
      args: [],
    );
  }

  /// `Pa korrigjuar`
  String get not_evaluated {
    return Intl.message(
      'Pa korrigjuar',
      name: 'not_evaluated',
      desc: '',
      args: [],
    );
  }

  /// `Afati i përfundimit`
  String get end_deadline {
    return Intl.message(
      'Afati i përfundimit',
      name: 'end_deadline',
      desc: '',
      args: [],
    );
  }

  /// `Mësimi radhës`
  String get next_lesson {
    return Intl.message(
      'Mësimi radhës',
      name: 'next_lesson',
      desc: '',
      args: [],
    );
  }

  /// `Nota: {grade}`
  String grade_evaluation(Object grade) {
    return Intl.message(
      'Nota: $grade',
      name: 'grade_evaluation',
      desc: '',
      args: [grade],
    );
  }

  /// `Hap Zoom`
  String get open_zoom {
    return Intl.message(
      'Hap Zoom',
      name: 'open_zoom',
      desc: '',
      args: [],
    );
  }

  /// `Afati i dorëzimit të detyrës ka kaluar`
  String get deadline_over {
    return Intl.message(
      'Afati i dorëzimit të detyrës ka kaluar',
      name: 'deadline_over',
      desc: '',
      args: [],
    );
  }

  /// `Ngarko detyrën`
  String get upload_assignment {
    return Intl.message(
      'Ngarko detyrën',
      name: 'upload_assignment',
      desc: '',
      args: [],
    );
  }

  /// `Klikoni butonin “Dorëzo detyrën” pasi të ngarkoni dokumentat.`
  String get click_on_commit_assignment {
    return Intl.message(
      'Klikoni butonin “Dorëzo detyrën” pasi të ngarkoni dokumentat.',
      name: 'click_on_commit_assignment',
      desc: '',
      args: [],
    );
  }

  /// `Dorëzo detyrën`
  String get turn_in_assignment {
    return Intl.message(
      'Dorëzo detyrën',
      name: 'turn_in_assignment',
      desc: '',
      args: [],
    );
  }

  /// `Ju jeni duke dorëzuar detyrën për {lessonName}`
  String you_are_turning_in_assignment_for(Object lessonName) {
    return Intl.message(
      'Ju jeni duke dorëzuar detyrën për $lessonName',
      name: 'you_are_turning_in_assignment_for',
      desc: '',
      args: [lessonName],
    );
  }

  /// `Pasi ta dorëzoni detyrën, ju nuk mund ta ridorëzoni përsëri.`
  String get you_can_turn_in_assignment_only_one {
    return Intl.message(
      'Pasi ta dorëzoni detyrën, ju nuk mund ta ridorëzoni përsëri.',
      name: 'you_can_turn_in_assignment_only_one',
      desc: '',
      args: [],
    );
  }

  /// `Mirëseerdhe, `
  String get welcome_user {
    return Intl.message(
      'Mirëseerdhe, ',
      name: 'welcome_user',
      desc: '',
      args: [],
    );
  }

  /// `Vazhdo mësimin`
  String get continue_lesson {
    return Intl.message(
      'Vazhdo mësimin',
      name: 'continue_lesson',
      desc: '',
      args: [],
    );
  }

  /// `Detyra e dorëzuar`
  String get submitted_assignment {
    return Intl.message(
      'Detyra e dorëzuar',
      name: 'submitted_assignment',
      desc: '',
      args: [],
    );
  }

  /// `Profil prindi`
  String get parent_profile {
    return Intl.message(
      'Profil prindi',
      name: 'parent_profile',
      desc: '',
      args: [],
    );
  }

  /// `Emaili regjistrimit u ridërgua me sukses. Kontrolloni emailin tuaj për të përfunduar regjistrimin`
  String get resent_email_succefully {
    return Intl.message(
      'Emaili regjistrimit u ridërgua me sukses. Kontrolloni emailin tuaj për të përfunduar regjistrimin',
      name: 'resent_email_succefully',
      desc: '',
      args: [],
    );
  }

  /// `Detyrat`
  String get assignments {
    return Intl.message(
      'Detyrat',
      name: 'assignments',
      desc: '',
      args: [],
    );
  }

  /// `E radhës:`
  String get next_assignment {
    return Intl.message(
      'E radhës:',
      name: 'next_assignment',
      desc: '',
      args: [],
    );
  }

  /// `Këtu ju mund të shikoni totalin e detyrave të shtëpise të dhëna nga mësuesit tuaj në kurset live ku ju bëni pjesë.`
  String get empty_dashboard_assignments {
    return Intl.message(
      'Këtu ju mund të shikoni totalin e detyrave të shtëpise të dhëna nga mësuesit tuaj në kurset live ku ju bëni pjesë.',
      name: 'empty_dashboard_assignments',
      desc: '',
      args: [],
    );
  }

  /// `Ndrysho foton`
  String get change_profile_picture {
    return Intl.message(
      'Ndrysho foton',
      name: 'change_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Profili im`
  String get my_profile {
    return Intl.message(
      'Profili im',
      name: 'my_profile',
      desc: '',
      args: [],
    );
  }

  /// `Ndrysho fjalëkalimin`
  String get change_password {
    return Intl.message(
      'Ndrysho fjalëkalimin',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Ndrysho portalin`
  String get change_portal {
    return Intl.message(
      'Ndrysho portalin',
      name: 'change_portal',
      desc: '',
      args: [],
    );
  }

  /// `Dil`
  String get logout {
    return Intl.message(
      'Dil',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Ruaj`
  String get save {
    return Intl.message(
      'Ruaj',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Këtu ju mund të ndryshoni fjalekalimin tuaj.`
  String get you_can_change_your_password_here {
    return Intl.message(
      'Këtu ju mund të ndryshoni fjalekalimin tuaj.',
      name: 'you_can_change_your_password_here',
      desc: '',
      args: [],
    );
  }

  /// `Fjalëkalimi ekzistues`
  String get current_password {
    return Intl.message(
      'Fjalëkalimi ekzistues',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Krijo një fjalëkalim të ri`
  String get create_new_password {
    return Intl.message(
      'Krijo një fjalëkalim të ri',
      name: 'create_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Përsërit fjalëkalimin e ri`
  String get repeat_new_password {
    return Intl.message(
      'Përsërit fjalëkalimin e ri',
      name: 'repeat_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Fjalëkalimi u ndryshua me sukses!`
  String get password_changed_succesfully {
    return Intl.message(
      'Fjalëkalimi u ndryshua me sukses!',
      name: 'password_changed_succesfully',
      desc: '',
      args: [],
    );
  }

  /// `Fjalëkalimi ekzistues është i gabuar!`
  String get wrong_old_password {
    return Intl.message(
      'Fjalëkalimi ekzistues është i gabuar!',
      name: 'wrong_old_password',
      desc: '',
      args: [],
    );
  }

  /// `Profili im`
  String get my_profile_title {
    return Intl.message(
      'Profili im',
      name: 'my_profile_title',
      desc: '',
      args: [],
    );
  }

  /// `Emri`
  String get name_label {
    return Intl.message(
      'Emri',
      name: 'name_label',
      desc: '',
      args: [],
    );
  }

  /// `Emër përdoruesi`
  String get user_name_profile_label {
    return Intl.message(
      'Emër përdoruesi',
      name: 'user_name_profile_label',
      desc: '',
      args: [],
    );
  }

  /// `Shteti ku zhvilloni studimet`
  String get studying_state {
    return Intl.message(
      'Shteti ku zhvilloni studimet',
      name: 'studying_state',
      desc: '',
      args: [],
    );
  }

  /// `Emri`
  String get name_title {
    return Intl.message(
      'Emri',
      name: 'name_title',
      desc: '',
      args: [],
    );
  }

  /// `Emër përdoruesi`
  String get user_name_title {
    return Intl.message(
      'Emër përdoruesi',
      name: 'user_name_title',
      desc: '',
      args: [],
    );
  }

  /// `Shteti`
  String get state_title {
    return Intl.message(
      'Shteti',
      name: 'state_title',
      desc: '',
      args: [],
    );
  }

  /// `Shteti ku zhvilloni studimet`
  String get change_state_main_line {
    return Intl.message(
      'Shteti ku zhvilloni studimet',
      name: 'change_state_main_line',
      desc: '',
      args: [],
    );
  }

  /// `mësime të përfunduara deri në {today} `
  String lesson_completed_till_now(Object today) {
    return Intl.message(
      'mësime të përfunduara deri në $today ',
      name: 'lesson_completed_till_now',
      desc: '',
      args: [today],
    );
  }

  /// `Performanca e lëndëve`
  String get subjects_performance {
    return Intl.message(
      'Performanca e lëndëve',
      name: 'subjects_performance',
      desc: '',
      args: [],
    );
  }

  /// `Të gjitha lëndët ({number})`
  String all_subjects_progress(Object number) {
    return Intl.message(
      'Të gjitha lëndët ($number)',
      name: 'all_subjects_progress',
      desc: '',
      args: [number],
    );
  }

  /// `Performanca e lëndëve`
  String get subjects_performance_title {
    return Intl.message(
      'Performanca e lëndëve',
      name: 'subjects_performance_title',
      desc: '',
      args: [],
    );
  }

  /// `Profili u përditësua me sukses.`
  String get succesfully_changed_data {
    return Intl.message(
      'Profili u përditësua me sukses.',
      name: 'succesfully_changed_data',
      desc: '',
      args: [],
    );
  }

  /// `Ndodhi një gabim.`
  String get an_error_happend {
    return Intl.message(
      'Ndodhi një gabim.',
      name: 'an_error_happend',
      desc: '',
      args: [],
    );
  }

  /// `Ndryshini emrin dhe mbiemrin tuaj.`
  String get change_name_main_line {
    return Intl.message(
      'Ndryshini emrin dhe mbiemrin tuaj.',
      name: 'change_name_main_line',
      desc: '',
      args: [],
    );
  }

  /// `Ndryshoni emrin tuaj të përdoruesit.`
  String get change_username_main_line {
    return Intl.message(
      'Ndryshoni emrin tuaj të përdoruesit.',
      name: 'change_username_main_line',
      desc: '',
      args: [],
    );
  }

  /// `Momentalisht nuk ka te dhëna... \nGrafiku do të gjenerohet pasi të regjistroheni në të paktën 3 kurse të regjistruara.`
  String get no_statistics {
    return Intl.message(
      'Momentalisht nuk ka te dhëna... \nGrafiku do të gjenerohet pasi të regjistroheni në të paktën 3 kurse të regjistruara.',
      name: 'no_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Duke shkarkuar...`
  String get downloader {
    return Intl.message(
      'Duke shkarkuar...',
      name: 'downloader',
      desc: '',
      args: [],
    );
  }

  /// `Duke u shkarkuar...`
  String get it_is_downloading {
    return Intl.message(
      'Duke u shkarkuar...',
      name: 'it_is_downloading',
      desc: '',
      args: [],
    );
  }

  /// `Video u shkarkua me sukses`
  String get lesson_downloaded_succesfully {
    return Intl.message(
      'Video u shkarkua me sukses',
      name: 'lesson_downloaded_succesfully',
      desc: '',
      args: [],
    );
  }

  /// `Shkarkuar`
  String get downloaded {
    return Intl.message(
      'Shkarkuar',
      name: 'downloaded',
      desc: '',
      args: [],
    );
  }

  /// `Këtu ju mund të shikoni leksionet e shkarkuara nga kurset live ku ju bëni pjesë - pa qënë të lidhur me internetin.`
  String get no_videos_downloaded {
    return Intl.message(
      'Këtu ju mund të shikoni leksionet e shkarkuara nga kurset live ku ju bëni pjesë - pa qënë të lidhur me internetin.',
      name: 'no_videos_downloaded',
      desc: '',
      args: [],
    );
  }

  /// `Ndryshoni emrin dhe mbiemrin tuaj.`
  String get change_name_description {
    return Intl.message(
      'Ndryshoni emrin dhe mbiemrin tuaj.',
      name: 'change_name_description',
      desc: '',
      args: [],
    );
  }

  /// `Ndryshoni emrin tuaj të përdoruesit.`
  String get change_user_name_description {
    return Intl.message(
      'Ndryshoni emrin tuaj të përdoruesit.',
      name: 'change_user_name_description',
      desc: '',
      args: [],
    );
  }

  /// `Zgjidhni shtetin ku zhvilloni studimet tuaja.`
  String get change_state_description {
    return Intl.message(
      'Zgjidhni shtetin ku zhvilloni studimet tuaja.',
      name: 'change_state_description',
      desc: '',
      args: [],
    );
  }

  /// `Zgjidh Organizatën`
  String get choose_organization_title {
    return Intl.message(
      'Zgjidh Organizatën',
      name: 'choose_organization_title',
      desc: '',
      args: [],
    );
  }

  /// `Portali i nxënësit ({number})`
  String student_portal(Object number) {
    return Intl.message(
      'Portali i nxënësit ($number)',
      name: 'student_portal',
      desc: '',
      args: [number],
    );
  }

  /// `Njoftimet`
  String get all_notifications_title {
    return Intl.message(
      'Njoftimet',
      name: 'all_notifications_title',
      desc: '',
      args: [],
    );
  }

  /// `TË REJA`
  String get new_notifications {
    return Intl.message(
      'TË REJA',
      name: 'new_notifications',
      desc: '',
      args: [],
    );
  }

  /// `TË KALUARA`
  String get old_notifications {
    return Intl.message(
      'TË KALUARA',
      name: 'old_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Kalendari`
  String get calendar_title {
    return Intl.message(
      'Kalendari',
      name: 'calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `Nuk ka mësime për datën e zgjedhur`
  String get no_items_today_calendar {
    return Intl.message(
      'Nuk ka mësime për datën e zgjedhur',
      name: 'no_items_today_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Tjetër`
  String get other {
    return Intl.message(
      'Tjetër',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Të tjera`
  String get others {
    return Intl.message(
      'Të tjera',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Politikat e privatësisë`
  String get privacy_policy {
    return Intl.message(
      'Politikat e privatësisë',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `https://app.akademi.al/login/privacy-policy`
  String get privacy_policy_link {
    return Intl.message(
      'https://app.akademi.al/login/privacy-policy',
      name: 'privacy_policy_link',
      desc: '',
      args: [],
    );
  }

  /// `Termat e shërbimit`
  String get terms_and_conditions {
    return Intl.message(
      'Termat e shërbimit',
      name: 'terms_and_conditions',
      desc: '',
      args: [],
    );
  }

  /// `https://app.akademi.al/login/terms-of-service`
  String get terms_and_conditions_link {
    return Intl.message(
      'https://app.akademi.al/login/terms-of-service',
      name: 'terms_and_conditions_link',
      desc: '',
      args: [],
    );
  }

  /// `https://www.facebook.com/akademialb`
  String get facebook_link {
    return Intl.message(
      'https://www.facebook.com/akademialb',
      name: 'facebook_link',
      desc: '',
      args: [],
    );
  }

  /// `https://www.instagram.com/akademi.al/`
  String get instagram_link {
    return Intl.message(
      'https://www.instagram.com/akademi.al/',
      name: 'instagram_link',
      desc: '',
      args: [],
    );
  }

  /// `versioni {version}`
  String version(Object version) {
    return Intl.message(
      'versioni $version',
      name: 'version',
      desc: '',
      args: [version],
    );
  }

  /// `Nuk ka njoftime momentalisht. Rikthehuni përsëri më vone.`
  String get empty_notification {
    return Intl.message(
      'Nuk ka njoftime momentalisht. Rikthehuni përsëri më vone.',
      name: 'empty_notification',
      desc: '',
      args: [],
    );
  }

  /// `Nuk ka detyra të ardhshme në këtë moment.`
  String get no_homework_virtual_class {
    return Intl.message(
      'Nuk ka detyra të ardhshme në këtë moment.',
      name: 'no_homework_virtual_class',
      desc: '',
      args: [],
    );
  }

  /// `Ndrysho`
  String get change_comment {
    return Intl.message(
      'Ndrysho',
      name: 'change_comment',
      desc: '',
      args: [],
    );
  }

  /// `Fshi`
  String get delete_comment {
    return Intl.message(
      'Fshi',
      name: 'delete_comment',
      desc: '',
      args: [],
    );
  }

  /// `Je i sigurtë që dëshironi të fshini komentin tuaj?`
  String get are_you_sure_you_want_to_delete_comment {
    return Intl.message(
      'Je i sigurtë që dëshironi të fshini komentin tuaj?',
      name: 'are_you_sure_you_want_to_delete_comment',
      desc: '',
      args: [],
    );
  }

  /// `Po, fshi`
  String get yes_delete {
    return Intl.message(
      'Po, fshi',
      name: 'yes_delete',
      desc: '',
      args: [],
    );
  }

  /// `Po logoheni si mësues.`
  String get login_in_as_teacher {
    return Intl.message(
      'Po logoheni si mësues.',
      name: 'login_in_as_teacher',
      desc: '',
      args: [],
    );
  }

  /// `Momentarisht ky aplikacion mobile ofrohet vetëm për studentët.`
  String get teacher_message {
    return Intl.message(
      'Momentarisht ky aplikacion mobile ofrohet vetëm për studentët.',
      name: 'teacher_message',
      desc: '',
      args: [],
    );
  }

  /// `Po logoheni si prind.`
  String get login_in_as_parent {
    return Intl.message(
      'Po logoheni si prind.',
      name: 'login_in_as_parent',
      desc: '',
      args: [],
    );
  }

  /// `Viti i lindjes`
  String get birth_year {
    return Intl.message(
      'Viti i lindjes',
      name: 'birth_year',
      desc: '',
      args: [],
    );
  }

  /// `Nuk ka të dhëna`
  String get no_details {
    return Intl.message(
      'Nuk ka të dhëna',
      name: 'no_details',
      desc: '',
      args: [],
    );
  }

  /// `Arsimi`
  String get education {
    return Intl.message(
      'Arsimi',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Lidhja me internetin aktive.`
  String get activeConnection {
    return Intl.message(
      'Lidhja me internetin aktive.',
      name: 'activeConnection',
      desc: '',
      args: [],
    );
  }

  /// `Mungon lidhja me internetin.`
  String get noConnection {
    return Intl.message(
      'Mungon lidhja me internetin.',
      name: 'noConnection',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'sq'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}