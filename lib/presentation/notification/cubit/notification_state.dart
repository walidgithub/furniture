abstract class NotificationState{}

class NotificationInitial extends NotificationState{}

class NotificationSentSucceededState extends NotificationState{}

class NotificationDeletedSucceededState extends NotificationState{}

class NotificationShowSucceededState extends NotificationState{}

class NotificationLoadingState extends NotificationState{}

class NotificationErrorState extends NotificationState{}
class NotificationShowingErrorState extends NotificationState{}
class NotificationDeletingErrorState extends NotificationState{}

class NotificationNoInternetState extends NotificationState{}