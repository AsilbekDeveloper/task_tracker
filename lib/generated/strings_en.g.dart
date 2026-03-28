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
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn.internal(_root);
	late final TranslationsNavigationEn navigation = TranslationsNavigationEn.internal(_root);

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

	/// en: 'Don't have an account?'
	String get dontHaveAccount => 'Don\'t have an account?';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// en: 'Register'
	String get register => 'Register';

	/// en: 'User is not logged in'
	String get userNotLoggedIn => 'User is not logged in';

	/// en: 'Fill email and password'
	String get fillEmailAndPassword => 'Fill email and password';

	/// en: 'Google Sign-In cancelled by user'
	String get googleSignInCancelled => 'Google Sign-In cancelled by user';

	/// en: 'Passwords do not match'
	String get passwordsDoNotMatch => 'Passwords do not match';

	/// en: 'Invalid email address'
	String get invalidEmail => 'Invalid email address';

	/// en: 'Password must be at least 6 characters'
	String get passwordTooShort => 'Password must be at least 6 characters';
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

	/// en: 'Choose an Icon'
	String get chooseAnIcon => 'Choose an Icon';
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

	/// en: 'No name'
	String get noName => 'No name';
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

	/// en: 'Please fill required fields'
	String get fillRequiredFields => 'Please fill required fields';

	/// en: 'Task title is required'
	String get titleRequired => 'Task title is required';

	/// en: 'Task description is required'
	String get descriptionRequired => 'Task description is required';

	/// en: 'Please select a category'
	String get selectCategory => 'Please select a category';

	/// en: 'Please select a priority'
	String get selectPriorityRequired => 'Please select a priority';

	/// en: 'Please select end time'
	String get selectEndTime => 'Please select end time';

	/// en: 'User not authenticated. Please login again'
	String get notAuthenticated => 'User not authenticated. Please login again';

	/// en: 'Unknown'
	String get unknown => 'Unknown';
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

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Language'
	String get selectLanguage => 'Select Language';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Dark Mode'
	String get darkMode => 'Dark Mode';

	/// en: 'Light Mode'
	String get lightMode => 'Light Mode';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign out error:'
	String get signOutError => 'Sign out error:';

	/// en: 'Server error:'
	String get serverError => 'Server error:';

	/// en: 'Google Sign-In failed:'
	String get googleSignInFailed => 'Google Sign-In failed:';

	/// en: 'UserId cannot be empty'
	String get userIdEmpty => 'UserId cannot be empty';

	/// en: 'Error fetching category list:'
	String get fetchCategoriesError => 'Error fetching category list:';

	/// en: 'Error creating category:'
	String get createCategoryError => 'Error creating category:';

	/// en: 'Error creating default category:'
	String get createDefaultCategoryError => 'Error creating default category:';

	/// en: 'Error deleting category:'
	String get deleteCategoryError => 'Error deleting category:';

	/// en: 'Error updating data:'
	String get updateDataError => 'Error updating data:';

	/// en: 'User not logged'
	String get userNotLogged => 'User not logged';

	/// en: 'Error creating task:'
	String get createTaskError => 'Error creating task:';

	/// en: 'Error fetching tasks:'
	String get fetchTasksError => 'Error fetching tasks:';

	/// en: 'Error deleting task:'
	String get deleteTaskError => 'Error deleting task:';

	/// en: 'Failed to create task:'
	String get failedToCreateTask => 'Failed to create task:';

	/// en: 'Failed to update task:'
	String get failedToUpdateTask => 'Failed to update task:';

	/// en: 'Something went wrong. Please try again'
	String get unknownError => 'Something went wrong. Please try again';

	/// en: 'Account not found. Please sign up'
	String get userNotFound => 'Account not found. Please sign up';

	/// en: 'Incorrect password'
	String get wrongPassword => 'Incorrect password';

	/// en: 'Invalid email format'
	String get invalidEmailFormat => 'Invalid email format';

	/// en: 'This account has been disabled'
	String get userDisabled => 'This account has been disabled';

	/// en: 'Too many attempts. Please try again later'
	String get tooManyRequests => 'Too many attempts. Please try again later';

	/// en: 'No internet connection'
	String get networkError => 'No internet connection';

	/// en: 'Email or password is incorrect'
	String get invalidCredentials => 'Email or password is incorrect';

	/// en: 'Error:'
	String get error => 'Error:';
}

// Path: navigation
class TranslationsNavigationEn {
	TranslationsNavigationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Calendar'
	String get calendar => 'Calendar';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Settings'
	String get settings => 'Settings';
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
			'auth.dontHaveAccount' => 'Don\'t have an account?',
			'auth.alreadyHaveAccount' => 'Already have an account?',
			'auth.register' => 'Register',
			'auth.userNotLoggedIn' => 'User is not logged in',
			'auth.fillEmailAndPassword' => 'Fill email and password',
			'auth.googleSignInCancelled' => 'Google Sign-In cancelled by user',
			'auth.passwordsDoNotMatch' => 'Passwords do not match',
			'auth.invalidEmail' => 'Invalid email address',
			'auth.passwordTooShort' => 'Password must be at least 6 characters',
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
			'category.chooseAnIcon' => 'Choose an Icon',
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
			'home.noName' => 'No name',
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
			'task.fillRequiredFields' => 'Please fill required fields',
			'task.titleRequired' => 'Task title is required',
			'task.descriptionRequired' => 'Task description is required',
			'task.selectCategory' => 'Please select a category',
			'task.selectPriorityRequired' => 'Please select a priority',
			'task.selectEndTime' => 'Please select end time',
			'task.notAuthenticated' => 'User not authenticated. Please login again',
			'task.unknown' => 'Unknown',
			'calendar.calendar' => 'Calendar',
			'calendar.errorLoadingTasks' => 'Error loading tasks',
			'calendar.tryAgain' => 'Try Again',
			'calendar.noTasksForDate' => 'No tasks for this date',
			'calendar.tasksCompleted' => '{completed} of {total} tasks completed',
			'settings.selectLanguage' => 'Select Language',
			'settings.theme' => 'Theme',
			'settings.darkMode' => 'Dark Mode',
			'settings.lightMode' => 'Light Mode',
			'errors.signOutError' => 'Sign out error:',
			'errors.serverError' => 'Server error:',
			'errors.googleSignInFailed' => 'Google Sign-In failed:',
			'errors.userIdEmpty' => 'UserId cannot be empty',
			'errors.fetchCategoriesError' => 'Error fetching category list:',
			'errors.createCategoryError' => 'Error creating category:',
			'errors.createDefaultCategoryError' => 'Error creating default category:',
			'errors.deleteCategoryError' => 'Error deleting category:',
			'errors.updateDataError' => 'Error updating data:',
			'errors.userNotLogged' => 'User not logged',
			'errors.createTaskError' => 'Error creating task:',
			'errors.fetchTasksError' => 'Error fetching tasks:',
			'errors.deleteTaskError' => 'Error deleting task:',
			'errors.failedToCreateTask' => 'Failed to create task:',
			'errors.failedToUpdateTask' => 'Failed to update task:',
			'errors.unknownError' => 'Something went wrong. Please try again',
			'errors.userNotFound' => 'Account not found. Please sign up',
			'errors.wrongPassword' => 'Incorrect password',
			'errors.invalidEmailFormat' => 'Invalid email format',
			'errors.userDisabled' => 'This account has been disabled',
			'errors.tooManyRequests' => 'Too many attempts. Please try again later',
			'errors.networkError' => 'No internet connection',
			'errors.invalidCredentials' => 'Email or password is incorrect',
			'errors.error' => 'Error:',
			'navigation.home' => 'Home',
			'navigation.calendar' => 'Calendar',
			'navigation.category' => 'Category',
			'navigation.settings' => 'Settings',
			'logout' => 'Log out',
			_ => null,
		};
	}
}
