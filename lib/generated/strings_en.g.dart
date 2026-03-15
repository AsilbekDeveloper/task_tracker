///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsCategoryEn category = TranslationsCategoryEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsTaskEn task = TranslationsTaskEn.internal(_root);
	late final TranslationsCalendarEn calendar = TranslationsCalendarEn.internal(_root);

	/// en: 'Log out'
	String get logout => 'Log out';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	/// en: 'Sign Up'
	String get signUp => 'Sign Up';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirmPassword => 'Confirm Password';

	/// en: 'Confirm your Password'
	String get confirmYourPassword => 'Confirm your Password';

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Enter your Email'
	String get enterEmail => 'Enter your Email';

	/// en: 'Enter your Password'
	String get enterPassword => 'Enter your Password';

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'or'
	String get or => 'or';

	/// en: 'Login with Google'
	String get loginGoogle => 'Login with Google';

	/// en: 'Register with Google'
	String get registerGoogle => 'Register with Google';

	/// en: 'Login with Apple'
	String get loginApple => 'Login with Apple';

	/// en: 'Don’t have an account?'
	String get dontHaveAccount => 'Don’t have an account?';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// en: 'Register'
	String get register => 'Register';

	/// en: 'User is not logged in'
	String get userNotLoggedIn => 'User is not logged in';
}

// Path: category
class TranslationsCategoryEn {
	TranslationsCategoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create new category'
	String get createNewCategory => 'Create new category';

	/// en: 'Category name :'
	String get categoryNaming => 'Category name :';

	/// en: 'Category name'
	String get categoryName => 'Category name';

	/// en: 'Category icon :'
	String get categoryIcon => 'Category icon :';

	/// en: 'Category color :'
	String get categoryColor => 'Category color :';

	/// en: 'Choose icon from library'
	String get chooseIcon => 'Choose icon from library';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Categories Page'
	String get categoriesPage => 'Categories Page';

	/// en: 'Create Category'
	String get createCategory => 'Create Category';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Categories failed'
	String get categoryLoadFailed => 'Categories failed';

	/// en: 'No categories available.'
	String get noCategoriesAvailable => 'No categories available.';

	/// en: 'Error loading categories'
	String get errorLoadingCategories => 'Error loading categories';

	/// en: 'Change Icon'
	String get changeIcon => 'Change Icon';

	/// en: 'Please fill all fields'
	String get fillAllFields => 'Please fill all fields';

	/// en: 'Category successfully created!'
	String get categoryCreatedSuccess => 'Category successfully created!';

	/// en: 'Category not found'
	String get categoryNotFound => 'Category not found';

	/// en: 'There are tasks in this category'
	String get tasksExistInCategory => 'There are tasks in this category';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What do you want to do today?'
	String get whatWant => 'What do you want to do today?';

	/// en: 'Tap + to add your tasks'
	String get addTasks => 'Tap + to add your tasks';

	/// en: 'Tasks list'
	String get tasksList => 'Tasks list';

	/// en: 'Incomplete'
	String get incomplete => 'Incomplete';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Calendar'
	String get calendar => 'Calendar';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Tasks not downloaded'
	String get tasksNotDownloaded => 'Tasks not downloaded';

	/// en: 'No tasks available'
	String get noTasksAvailable => 'No tasks available';

	/// en: 'Error occurred'
	String get errorLoadingTasks => 'Error occurred';
}

// Path: task
class TranslationsTaskEn {
	TranslationsTaskEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Task Title'
	String get taskTitle => 'Task Title';

	/// en: 'Task Description'
	String get taskDesc => 'Task Description';

	/// en: 'Task Time:'
	String get taskTime => 'Task Time:';

	/// en: 'Task Category:'
	String get taskCategory => 'Task Category:';

	/// en: 'Task Priority:'
	String get taskPriority => 'Task Priority:';

	/// en: 'Edit Task'
	String get editTask => 'Edit Task';

	/// en: 'Enter your task title'
	String get enterTaskTitle => 'Enter your task title';

	/// en: 'Enter your task description'
	String get enterTaskDesc => 'Enter your task description';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Priority'
	String get priority => 'Priority';

	/// en: 'Add Task'
	String get addTask => 'Add Task';

	/// en: 'Create Task'
	String get createTask => 'Create Task';

	/// en: 'Creating...'
	String get creating => 'Creating...';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Task successfully created!'
	String get taskCreatedSuccess => 'Task successfully created!';

	/// en: 'Task edited successfully'
	String get taskEditedSuccessfully => 'Task edited successfully';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Select priority'
	String get selectPriority => 'Select priority';
}

// Path: calendar
class TranslationsCalendarEn {
	TranslationsCalendarEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Calendar'
	String get calendar => 'Calendar';

	/// en: 'Error loading tasks'
	String get errorLoadingTasks => 'Error loading tasks';

	/// en: 'Try Again'
	String get tryAgain => 'Try Again';

	/// en: 'No tasks for this date'
	String get noTasksForDate => 'No tasks for this date';

	/// en: '{completed} of {total} tasks completed'
	String get tasksCompleted => '{completed} of {total} tasks completed';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.signIn' => 'Sign In',
			'auth.signUp' => 'Sign Up',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.confirmPassword' => 'Confirm Password',
			'auth.confirmYourPassword' => 'Confirm your Password',
			'auth.login' => 'Login',
			'auth.enterEmail' => 'Enter your Email',
			'auth.enterPassword' => 'Enter your Password',
			'auth.username' => 'Username',
			'auth.or' => 'or',
			'auth.loginGoogle' => 'Login with Google',
			'auth.registerGoogle' => 'Register with Google',
			'auth.loginApple' => 'Login with Apple',
			'auth.dontHaveAccount' => 'Don’t have an account?',
			'auth.alreadyHaveAccount' => 'Already have an account?',
			'auth.register' => 'Register',
			'auth.userNotLoggedIn' => 'User is not logged in',
			'category.createNewCategory' => 'Create new category',
			'category.categoryNaming' => 'Category name :',
			'category.categoryName' => 'Category name',
			'category.categoryIcon' => 'Category icon :',
			'category.categoryColor' => 'Category color :',
			'category.chooseIcon' => 'Choose icon from library',
			'category.select' => 'Select',
			'category.categoriesPage' => 'Categories Page',
			'category.createCategory' => 'Create Category',
			'category.cancel' => 'Cancel',
			'category.categoryLoadFailed' => 'Categories failed',
			'category.noCategoriesAvailable' => 'No categories available.',
			'category.errorLoadingCategories' => 'Error loading categories',
			'category.changeIcon' => 'Change Icon',
			'category.fillAllFields' => 'Please fill all fields',
			'category.categoryCreatedSuccess' => 'Category successfully created!',
			'category.categoryNotFound' => 'Category not found',
			'category.tasksExistInCategory' => 'There are tasks in this category',
			'home.whatWant' => 'What do you want to do today?',
			'home.addTasks' => 'Tap + to add your tasks',
			'home.tasksList' => 'Tasks list',
			'home.incomplete' => 'Incomplete',
			'home.completed' => 'Completed',
			'home.home' => 'Home',
			'home.calendar' => 'Calendar',
			'home.category' => 'Category',
			'home.settings' => 'Settings',
			'home.tasksNotDownloaded' => 'Tasks not downloaded',
			'home.noTasksAvailable' => 'No tasks available',
			'home.errorLoadingTasks' => 'Error occurred',
			'task.taskTitle' => 'Task Title',
			'task.taskDesc' => 'Task Description',
			'task.taskTime' => 'Task Time:',
			'task.taskCategory' => 'Task Category:',
			'task.taskPriority' => 'Task Priority:',
			'task.editTask' => 'Edit Task',
			'task.enterTaskTitle' => 'Enter your task title',
			'task.enterTaskDesc' => 'Enter your task description',
			'task.save' => 'Save',
			'task.priority' => 'Priority',
			'task.addTask' => 'Add Task',
			'task.createTask' => 'Create Task',
			'task.creating' => 'Creating...',
			'task.select' => 'Select',
			'task.taskCreatedSuccess' => 'Task successfully created!',
			'task.taskEditedSuccessfully' => 'Task edited successfully',
			'task.loading' => 'Loading...',
			'task.selectPriority' => 'Select priority',
			'calendar.calendar' => 'Calendar',
			'calendar.errorLoadingTasks' => 'Error loading tasks',
			'calendar.tryAgain' => 'Try Again',
			'calendar.noTasksForDate' => 'No tasks for this date',
			'calendar.tasksCompleted' => '{completed} of {total} tasks completed',
			'logout' => 'Log out',
			_ => null,
		};
	}
}
