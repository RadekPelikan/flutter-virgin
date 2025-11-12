using FirebaseFlutter.Service.Services;

namespace FirebaseFlutter.Service.Domain.Contracts;

public record NewTopicNotificationModel(
    string Title,
    string Body,
    string Topic
);