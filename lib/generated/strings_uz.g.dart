///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsUz extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsUz({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.uz,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <uz>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsUz _root = this; // ignore: unused_field

	@override 
	TranslationsUz $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsUz(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAuthUz auth = _TranslationsAuthUz._(_root);
	@override late final _TranslationsCategoryUz category = _TranslationsCategoryUz._(_root);
	@override late final _TranslationsHomeUz home = _TranslationsHomeUz._(_root);
	@override late final _TranslationsTaskUz task = _TranslationsTaskUz._(_root);
	@override late final _TranslationsCalendarUz calendar = _TranslationsCalendarUz._(_root);
	@override String get logout => 'Chiqish';
}

// Path: auth
class _TranslationsAuthUz extends TranslationsAuthEn {
	_TranslationsAuthUz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Kirish';
	@override String get signUp => 'Ro‘yxatdan o‘tish';
	@override String get email => 'Email';
	@override String get password => 'Parol';
	@override String get confirmPassword => 'Parolni tasdiqlash';
	@override String get confirmYourPassword => 'Parolingizni tasdiqlang';
	@override String get login => 'Kirish';
	@override String get enterEmail => 'Emailingizni kiriting';
	@override String get enterPassword => 'Parolingizni kiriting';
	@override String get username => 'Foydalanuvchi nomi';
	@override String get or => 'yoki';
	@override String get loginGoogle => 'Google bilan kirish';
	@override String get registerGoogle => 'Google bilan ro‘yxatdan o‘tish';
	@override String get loginApple => 'Apple bilan kirish';
	@override String get dontHaveAccount => 'Akkountingiz yo‘qmi?';
	@override String get alreadyHaveAccount => 'Akkountingiz allaqachon mavjud?';
	@override String get register => 'Ro‘yxatdan o‘tish';
	@override String get userNotLoggedIn => 'Foydalanuvchi tizimga kirgan emas';
}

// Path: category
class _TranslationsCategoryUz extends TranslationsCategoryEn {
	_TranslationsCategoryUz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get createNewCategory => 'Yangi kategoriya yaratish';
	@override String get categoryNaming => 'Kategoriya nomi :';
	@override String get categoryName => 'Kategoriya nomi';
	@override String get categoryIcon => 'Kategoriya ikonkasi :';
	@override String get categoryColor => 'Kategoriya rangi :';
	@override String get chooseIcon => 'Kutubxonadan ikonka tanlash';
	@override String get select => 'Tanlash';
	@override String get categoriesPage => 'Kategoriyalar sahifasi';
	@override String get createCategory => 'Kategoriya yaratish';
	@override String get cancel => 'Bekor qilish';
	@override String get categoryLoadFailed => 'Kategoriyalar yuklanmadi';
	@override String get noCategoriesAvailable => 'Kategoriya mavjud emas.';
	@override String get errorLoadingCategories => 'Kategoriyalarni yuklashda xatolik';
	@override String get changeIcon => 'Ikonkani o‘zgartirish';
	@override String get fillAllFields => 'Iltimos, barcha maydonlarni to‘ldiring';
	@override String get categoryCreatedSuccess => 'Kategoriya muvaffaqiyatli yaratildi!';
	@override String get categoryNotFound => 'Kategoriya topilmadi';
	@override String get tasksExistInCategory => 'Bu kategoriyada topshiriqlar mavjud!';
}

// Path: home
class _TranslationsHomeUz extends TranslationsHomeEn {
	_TranslationsHomeUz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get whatWant => 'Bugun nima qilmoqchisiz?';
	@override String get addTasks => 'Vazifalarni qo‘shish uchun + tugmasini bosing';
	@override String get tasksList => 'Vazifalar ro‘yxati';
	@override String get incomplete => 'Tugallanmagan';
	@override String get completed => 'Tugallangan';
	@override String get home => 'Bosh sahifa';
	@override String get calendar => 'Kalendar';
	@override String get category => 'Kategoriya';
	@override String get settings => 'Sozlamalar';
	@override String get tasksNotDownloaded => 'Vazifalar yuklanmadi';
	@override String get noTasksAvailable => 'Vazifalar yo‘q';
	@override String get errorLoadingTasks => 'Xatolik yuz berdi';
}

// Path: task
class _TranslationsTaskUz extends TranslationsTaskEn {
	_TranslationsTaskUz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get taskTitle => 'Vazifa nomi';
	@override String get taskDesc => 'Vazifa tavsifi';
	@override String get taskTime => 'Vazifa vaqti:';
	@override String get taskCategory => 'Vazifa kategoriyasi:';
	@override String get taskPriority => 'Vazifa ustuvorligi:';
	@override String get editTask => 'Vazifani tahrirlash';
	@override String get enterTaskTitle => 'Vazifa nomini kiriting';
	@override String get enterTaskDesc => 'Vazifa tavsifini kiriting';
	@override String get save => 'Saqlash';
	@override String get priority => 'Ustuvorlik';
	@override String get addTask => 'Vazifa qo‘shish';
	@override String get createTask => 'Vazifa yaratish';
	@override String get creating => 'Yaratilmoqda...';
	@override String get select => 'Tanlash';
	@override String get taskCreatedSuccess => 'Vazifa muvaffaqiyatli yaratildi!';
	@override String get taskEditedSuccessfully => 'Vazifa muvaffaqiyatli tahrirlandi';
	@override String get loading => 'Yuklanmoqda...';
	@override String get selectPriority => 'Prioritetni tanlang';
}

// Path: calendar
class _TranslationsCalendarUz extends TranslationsCalendarEn {
	_TranslationsCalendarUz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get calendar => 'Kalendar';
	@override String get errorLoadingTasks => 'Vazifalarni yuklashda xatolik';
	@override String get tryAgain => 'Qayta urinish';
	@override String get noTasksForDate => 'Bu sana uchun vazifalar yo‘q';
	@override String get tasksCompleted => '{total} ta vazifadan {completed} tasi bajarildi';
}

/// The flat map containing all translations for locale <uz>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsUz {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.signIn' => 'Kirish',
			'auth.signUp' => 'Ro‘yxatdan o‘tish',
			'auth.email' => 'Email',
			'auth.password' => 'Parol',
			'auth.confirmPassword' => 'Parolni tasdiqlash',
			'auth.confirmYourPassword' => 'Parolingizni tasdiqlang',
			'auth.login' => 'Kirish',
			'auth.enterEmail' => 'Emailingizni kiriting',
			'auth.enterPassword' => 'Parolingizni kiriting',
			'auth.username' => 'Foydalanuvchi nomi',
			'auth.or' => 'yoki',
			'auth.loginGoogle' => 'Google bilan kirish',
			'auth.registerGoogle' => 'Google bilan ro‘yxatdan o‘tish',
			'auth.loginApple' => 'Apple bilan kirish',
			'auth.dontHaveAccount' => 'Akkountingiz yo‘qmi?',
			'auth.alreadyHaveAccount' => 'Akkountingiz allaqachon mavjud?',
			'auth.register' => 'Ro‘yxatdan o‘tish',
			'auth.userNotLoggedIn' => 'Foydalanuvchi tizimga kirgan emas',
			'category.createNewCategory' => 'Yangi kategoriya yaratish',
			'category.categoryNaming' => 'Kategoriya nomi :',
			'category.categoryName' => 'Kategoriya nomi',
			'category.categoryIcon' => 'Kategoriya ikonkasi :',
			'category.categoryColor' => 'Kategoriya rangi :',
			'category.chooseIcon' => 'Kutubxonadan ikonka tanlash',
			'category.select' => 'Tanlash',
			'category.categoriesPage' => 'Kategoriyalar sahifasi',
			'category.createCategory' => 'Kategoriya yaratish',
			'category.cancel' => 'Bekor qilish',
			'category.categoryLoadFailed' => 'Kategoriyalar yuklanmadi',
			'category.noCategoriesAvailable' => 'Kategoriya mavjud emas.',
			'category.errorLoadingCategories' => 'Kategoriyalarni yuklashda xatolik',
			'category.changeIcon' => 'Ikonkani o‘zgartirish',
			'category.fillAllFields' => 'Iltimos, barcha maydonlarni to‘ldiring',
			'category.categoryCreatedSuccess' => 'Kategoriya muvaffaqiyatli yaratildi!',
			'category.categoryNotFound' => 'Kategoriya topilmadi',
			'category.tasksExistInCategory' => 'Bu kategoriyada topshiriqlar mavjud!',
			'home.whatWant' => 'Bugun nima qilmoqchisiz?',
			'home.addTasks' => 'Vazifalarni qo‘shish uchun + tugmasini bosing',
			'home.tasksList' => 'Vazifalar ro‘yxati',
			'home.incomplete' => 'Tugallanmagan',
			'home.completed' => 'Tugallangan',
			'home.home' => 'Bosh sahifa',
			'home.calendar' => 'Kalendar',
			'home.category' => 'Kategoriya',
			'home.settings' => 'Sozlamalar',
			'home.tasksNotDownloaded' => 'Vazifalar yuklanmadi',
			'home.noTasksAvailable' => 'Vazifalar yo‘q',
			'home.errorLoadingTasks' => 'Xatolik yuz berdi',
			'task.taskTitle' => 'Vazifa nomi',
			'task.taskDesc' => 'Vazifa tavsifi',
			'task.taskTime' => 'Vazifa vaqti:',
			'task.taskCategory' => 'Vazifa kategoriyasi:',
			'task.taskPriority' => 'Vazifa ustuvorligi:',
			'task.editTask' => 'Vazifani tahrirlash',
			'task.enterTaskTitle' => 'Vazifa nomini kiriting',
			'task.enterTaskDesc' => 'Vazifa tavsifini kiriting',
			'task.save' => 'Saqlash',
			'task.priority' => 'Ustuvorlik',
			'task.addTask' => 'Vazifa qo‘shish',
			'task.createTask' => 'Vazifa yaratish',
			'task.creating' => 'Yaratilmoqda...',
			'task.select' => 'Tanlash',
			'task.taskCreatedSuccess' => 'Vazifa muvaffaqiyatli yaratildi!',
			'task.taskEditedSuccessfully' => 'Vazifa muvaffaqiyatli tahrirlandi',
			'task.loading' => 'Yuklanmoqda...',
			'task.selectPriority' => 'Prioritetni tanlang',
			'calendar.calendar' => 'Kalendar',
			'calendar.errorLoadingTasks' => 'Vazifalarni yuklashda xatolik',
			'calendar.tryAgain' => 'Qayta urinish',
			'calendar.noTasksForDate' => 'Bu sana uchun vazifalar yo‘q',
			'calendar.tasksCompleted' => '{total} ta vazifadan {completed} tasi bajarildi',
			'logout' => 'Chiqish',
			_ => null,
		};
	}
}
