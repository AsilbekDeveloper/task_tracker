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
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAuthRu auth = _TranslationsAuthRu._(_root);
	@override late final _TranslationsCategoryRu category = _TranslationsCategoryRu._(_root);
	@override late final _TranslationsHomeRu home = _TranslationsHomeRu._(_root);
	@override late final _TranslationsTaskRu task = _TranslationsTaskRu._(_root);
	@override late final _TranslationsCalendarRu calendar = _TranslationsCalendarRu._(_root);
	@override late final _TranslationsSettingsRu settings = _TranslationsSettingsRu._(_root);
	@override late final _TranslationsErrorsRu errors = _TranslationsErrorsRu._(_root);
	@override late final _TranslationsNavigationRu navigation = _TranslationsNavigationRu._(_root);
	@override String get logout => 'Выйти';
}

// Path: auth
class _TranslationsAuthRu extends TranslationsAuthEn {
	_TranslationsAuthRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Войти';
	@override String get signUp => 'Регистрация';
	@override String get email => 'Электронная почта';
	@override String get password => 'Пароль';
	@override String get confirmPassword => 'Подтвердите пароль';
	@override String get confirmYourPassword => 'Подтвердите ваш пароль';
	@override String get login => 'Вход';
	@override String get enterEmail => 'Введите вашу почту';
	@override String get enterPassword => 'Введите ваш пароль';
	@override String get username => 'Имя пользователя';
	@override String get or => 'или';
	@override String get loginGoogle => 'Войти через Google';
	@override String get registerGoogle => 'Зарегистрироваться через Google';
	@override String get loginApple => 'Войти через Apple';
	@override String get dontHaveAccount => 'Нет аккаунта?';
	@override String get alreadyHaveAccount => 'Уже есть аккаунт?';
	@override String get register => 'Регистрация';
	@override String get userNotLoggedIn => 'Пользователь не вошёл в систему';
	@override String get fillEmailAndPassword => 'Введите email и пароль';
	@override String get googleSignInCancelled => 'Вход через Google отменён пользователем';
	@override String get passwordsDoNotMatch => 'Пароли не совпадают';
	@override String get invalidEmail => 'Неверный адрес электронной почты';
	@override String get passwordTooShort => 'Пароль должен содержать не менее 6 символов';
}

// Path: category
class _TranslationsCategoryRu extends TranslationsCategoryEn {
	_TranslationsCategoryRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get createNewCategory => 'Создать новую категорию';
	@override String get categoryNaming => 'Название категории :';
	@override String get categoryName => 'Название категории';
	@override String get categoryIcon => 'Иконка категории :';
	@override String get categoryColor => 'Цвет категории :';
	@override String get chooseIcon => 'Выбрать иконку из библиотеки';
	@override String get select => 'Выбрать';
	@override String get categoriesPage => 'Страница категорий';
	@override String get createCategory => 'Создать категорию';
	@override String get cancel => 'Отмена';
	@override String get categoryLoadFailed => 'Не удалось загрузить категории';
	@override String get noCategoriesAvailable => 'Категории отсутствуют.';
	@override String get errorLoadingCategories => 'Ошибка загрузки категорий';
	@override String get changeIcon => 'Изменить иконку';
	@override String get fillAllFields => 'Пожалуйста, заполните все поля';
	@override String get categoryCreatedSuccess => 'Категория успешно создана!';
	@override String get categoryNotFound => 'Категория не найдена';
	@override String get tasksExistInCategory => 'В этой категории есть задачи';
	@override String get chooseAnIcon => 'Выберите иконку';
}

// Path: home
class _TranslationsHomeRu extends TranslationsHomeEn {
	_TranslationsHomeRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get whatWant => 'Что вы хотите сделать сегодня?';
	@override String get addTasks => 'Нажмите + чтобы добавить задачи';
	@override String get tasksList => 'Список задач';
	@override String get incomplete => 'Незавершенные';
	@override String get completed => 'Выполненные';
	@override String get home => 'Главная';
	@override String get calendar => 'Календарь';
	@override String get category => 'Категория';
	@override String get settings => 'Настройки';
	@override String get tasksNotDownloaded => 'Задачи не загружены';
	@override String get noTasksAvailable => 'Нет задач';
	@override String get errorLoadingTasks => 'Произошла ошибка';
	@override String get noName => 'Без имени';
}

// Path: task
class _TranslationsTaskRu extends TranslationsTaskEn {
	_TranslationsTaskRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get taskTitle => 'Название задачи';
	@override String get taskDesc => 'Описание задачи';
	@override String get taskTime => 'Время задачи:';
	@override String get taskCategory => 'Категория задачи:';
	@override String get taskPriority => 'Приоритет задачи:';
	@override String get editTask => 'Редактировать задачу';
	@override String get enterTaskTitle => 'Введите название задачи';
	@override String get enterTaskDesc => 'Введите описание задачи';
	@override String get save => 'Сохранить';
	@override String get priority => 'Приоритет';
	@override String get addTask => 'Добавить задачу';
	@override String get createTask => 'Создать задачу';
	@override String get creating => 'Создание...';
	@override String get select => 'Выбрать';
	@override String get taskCreatedSuccess => 'Задача успешно создана!';
	@override String get taskEditedSuccessfully => 'Задача успешно отредактирована';
	@override String get loading => 'Загрузка...';
	@override String get selectPriority => 'Выбрать приоритет';
	@override String get fillRequiredFields => 'Пожалуйста, заполните все поля';
	@override String get titleRequired => 'Название задачи обязательно';
	@override String get descriptionRequired => 'Описание задачи обязательно';
	@override String get selectCategory => 'Пожалуйста, выберите категорию';
	@override String get selectPriorityRequired => 'Пожалуйста, выберите приоритет';
	@override String get selectEndTime => 'Пожалуйста, выберите время окончания';
	@override String get notAuthenticated => 'Пользователь не авторизован. Пожалуйста, войдите снова';
	@override String get unknown => 'Неизвестно';
}

// Path: calendar
class _TranslationsCalendarRu extends TranslationsCalendarEn {
	_TranslationsCalendarRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get calendar => 'Календарь';
	@override String get errorLoadingTasks => 'Ошибка загрузки задач';
	@override String get tryAgain => 'Попробовать снова';
	@override String get noTasksForDate => 'На эту дату задач нет';
	@override String get tasksCompleted => 'Выполнено {completed} из {total} задач';
}

// Path: settings
class _TranslationsSettingsRu extends TranslationsSettingsEn {
	_TranslationsSettingsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get selectLanguage => 'Выбрать язык';
	@override String get theme => 'Тема';
	@override String get darkMode => 'Тёмный режим';
	@override String get lightMode => 'Светлый режим';
}

// Path: errors
class _TranslationsErrorsRu extends TranslationsErrorsEn {
	_TranslationsErrorsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get signOutError => 'Ошибка выхода:';
	@override String get serverError => 'Ошибка сервера:';
	@override String get googleSignInFailed => 'Ошибка входа через Google:';
	@override String get userIdEmpty => 'UserId не может быть пустым';
	@override String get fetchCategoriesError => 'Ошибка получения списка категорий:';
	@override String get createCategoryError => 'Ошибка создания категории:';
	@override String get createDefaultCategoryError => 'Ошибка создания категории по умолчанию:';
	@override String get deleteCategoryError => 'Ошибка удаления категории:';
	@override String get updateDataError => 'Ошибка обновления данных:';
	@override String get userNotLogged => 'Пользователь не вошёл в систему';
	@override String get createTaskError => 'Ошибка создания задачи:';
	@override String get fetchTasksError => 'Ошибка получения задач:';
	@override String get deleteTaskError => 'Ошибка удаления задачи:';
	@override String get failedToCreateTask => 'Не удалось создать задачу:';
	@override String get failedToUpdateTask => 'Не удалось обновить задачу:';
	@override String get unknownError => 'Произошла ошибка. Попробуйте снова';
	@override String get userNotFound => 'Аккаунт не найден. Зарегистрируйтесь';
	@override String get wrongPassword => 'Неверный пароль';
	@override String get invalidEmailFormat => 'Неверный формат email';
	@override String get userDisabled => 'Этот аккаунт заблокирован';
	@override String get tooManyRequests => 'Слишком много попыток. Попробуйте позже';
	@override String get networkError => 'Нет подключения к интернету';
	@override String get invalidCredentials => 'Неверный email или пароль';
	@override String get error => 'Ошибка';
}

// Path: navigation
class _TranslationsNavigationRu extends TranslationsNavigationEn {
	_TranslationsNavigationRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get home => 'Главная';
	@override String get calendar => 'Календарь';
	@override String get category => 'Категория';
	@override String get settings => 'Настройки';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.signIn' => 'Войти',
			'auth.signUp' => 'Регистрация',
			'auth.email' => 'Электронная почта',
			'auth.password' => 'Пароль',
			'auth.confirmPassword' => 'Подтвердите пароль',
			'auth.confirmYourPassword' => 'Подтвердите ваш пароль',
			'auth.login' => 'Вход',
			'auth.enterEmail' => 'Введите вашу почту',
			'auth.enterPassword' => 'Введите ваш пароль',
			'auth.username' => 'Имя пользователя',
			'auth.or' => 'или',
			'auth.loginGoogle' => 'Войти через Google',
			'auth.registerGoogle' => 'Зарегистрироваться через Google',
			'auth.loginApple' => 'Войти через Apple',
			'auth.dontHaveAccount' => 'Нет аккаунта?',
			'auth.alreadyHaveAccount' => 'Уже есть аккаунт?',
			'auth.register' => 'Регистрация',
			'auth.userNotLoggedIn' => 'Пользователь не вошёл в систему',
			'auth.fillEmailAndPassword' => 'Введите email и пароль',
			'auth.googleSignInCancelled' => 'Вход через Google отменён пользователем',
			'auth.passwordsDoNotMatch' => 'Пароли не совпадают',
			'auth.invalidEmail' => 'Неверный адрес электронной почты',
			'auth.passwordTooShort' => 'Пароль должен содержать не менее 6 символов',
			'category.createNewCategory' => 'Создать новую категорию',
			'category.categoryNaming' => 'Название категории :',
			'category.categoryName' => 'Название категории',
			'category.categoryIcon' => 'Иконка категории :',
			'category.categoryColor' => 'Цвет категории :',
			'category.chooseIcon' => 'Выбрать иконку из библиотеки',
			'category.select' => 'Выбрать',
			'category.categoriesPage' => 'Страница категорий',
			'category.createCategory' => 'Создать категорию',
			'category.cancel' => 'Отмена',
			'category.categoryLoadFailed' => 'Не удалось загрузить категории',
			'category.noCategoriesAvailable' => 'Категории отсутствуют.',
			'category.errorLoadingCategories' => 'Ошибка загрузки категорий',
			'category.changeIcon' => 'Изменить иконку',
			'category.fillAllFields' => 'Пожалуйста, заполните все поля',
			'category.categoryCreatedSuccess' => 'Категория успешно создана!',
			'category.categoryNotFound' => 'Категория не найдена',
			'category.tasksExistInCategory' => 'В этой категории есть задачи',
			'category.chooseAnIcon' => 'Выберите иконку',
			'home.whatWant' => 'Что вы хотите сделать сегодня?',
			'home.addTasks' => 'Нажмите + чтобы добавить задачи',
			'home.tasksList' => 'Список задач',
			'home.incomplete' => 'Незавершенные',
			'home.completed' => 'Выполненные',
			'home.home' => 'Главная',
			'home.calendar' => 'Календарь',
			'home.category' => 'Категория',
			'home.settings' => 'Настройки',
			'home.tasksNotDownloaded' => 'Задачи не загружены',
			'home.noTasksAvailable' => 'Нет задач',
			'home.errorLoadingTasks' => 'Произошла ошибка',
			'home.noName' => 'Без имени',
			'task.taskTitle' => 'Название задачи',
			'task.taskDesc' => 'Описание задачи',
			'task.taskTime' => 'Время задачи:',
			'task.taskCategory' => 'Категория задачи:',
			'task.taskPriority' => 'Приоритет задачи:',
			'task.editTask' => 'Редактировать задачу',
			'task.enterTaskTitle' => 'Введите название задачи',
			'task.enterTaskDesc' => 'Введите описание задачи',
			'task.save' => 'Сохранить',
			'task.priority' => 'Приоритет',
			'task.addTask' => 'Добавить задачу',
			'task.createTask' => 'Создать задачу',
			'task.creating' => 'Создание...',
			'task.select' => 'Выбрать',
			'task.taskCreatedSuccess' => 'Задача успешно создана!',
			'task.taskEditedSuccessfully' => 'Задача успешно отредактирована',
			'task.loading' => 'Загрузка...',
			'task.selectPriority' => 'Выбрать приоритет',
			'task.fillRequiredFields' => 'Пожалуйста, заполните все поля',
			'task.titleRequired' => 'Название задачи обязательно',
			'task.descriptionRequired' => 'Описание задачи обязательно',
			'task.selectCategory' => 'Пожалуйста, выберите категорию',
			'task.selectPriorityRequired' => 'Пожалуйста, выберите приоритет',
			'task.selectEndTime' => 'Пожалуйста, выберите время окончания',
			'task.notAuthenticated' => 'Пользователь не авторизован. Пожалуйста, войдите снова',
			'task.unknown' => 'Неизвестно',
			'calendar.calendar' => 'Календарь',
			'calendar.errorLoadingTasks' => 'Ошибка загрузки задач',
			'calendar.tryAgain' => 'Попробовать снова',
			'calendar.noTasksForDate' => 'На эту дату задач нет',
			'calendar.tasksCompleted' => 'Выполнено {completed} из {total} задач',
			'settings.selectLanguage' => 'Выбрать язык',
			'settings.theme' => 'Тема',
			'settings.darkMode' => 'Тёмный режим',
			'settings.lightMode' => 'Светлый режим',
			'errors.signOutError' => 'Ошибка выхода:',
			'errors.serverError' => 'Ошибка сервера:',
			'errors.googleSignInFailed' => 'Ошибка входа через Google:',
			'errors.userIdEmpty' => 'UserId не может быть пустым',
			'errors.fetchCategoriesError' => 'Ошибка получения списка категорий:',
			'errors.createCategoryError' => 'Ошибка создания категории:',
			'errors.createDefaultCategoryError' => 'Ошибка создания категории по умолчанию:',
			'errors.deleteCategoryError' => 'Ошибка удаления категории:',
			'errors.updateDataError' => 'Ошибка обновления данных:',
			'errors.userNotLogged' => 'Пользователь не вошёл в систему',
			'errors.createTaskError' => 'Ошибка создания задачи:',
			'errors.fetchTasksError' => 'Ошибка получения задач:',
			'errors.deleteTaskError' => 'Ошибка удаления задачи:',
			'errors.failedToCreateTask' => 'Не удалось создать задачу:',
			'errors.failedToUpdateTask' => 'Не удалось обновить задачу:',
			'errors.unknownError' => 'Произошла ошибка. Попробуйте снова',
			'errors.userNotFound' => 'Аккаунт не найден. Зарегистрируйтесь',
			'errors.wrongPassword' => 'Неверный пароль',
			'errors.invalidEmailFormat' => 'Неверный формат email',
			'errors.userDisabled' => 'Этот аккаунт заблокирован',
			'errors.tooManyRequests' => 'Слишком много попыток. Попробуйте позже',
			'errors.networkError' => 'Нет подключения к интернету',
			'errors.invalidCredentials' => 'Неверный email или пароль',
			'errors.error' => 'Ошибка',
			'navigation.home' => 'Главная',
			'navigation.calendar' => 'Календарь',
			'navigation.category' => 'Категория',
			'navigation.settings' => 'Настройки',
			'logout' => 'Выйти',
			_ => null,
		};
	}
}
