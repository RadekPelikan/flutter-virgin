namespace FirebaseFlutter.Service.Domain.Contracts;

public record NewNotificationModel(
    string Title,
    string Body,
    string FcmToken
);