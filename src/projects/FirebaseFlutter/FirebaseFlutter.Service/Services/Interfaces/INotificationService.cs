using FirebaseFlutter.Service.Domain.Contracts;

namespace FirebaseFlutter.Service.Services.Interfaces;

public interface INotificationService
{
    Task<NewNotificationResultModel> SendNewNotificationAsync(NewNotificationModel notification, CancellationToken cancellationToken = default);

    Task<NewNotificationResultModel> SendNewTopicNotificationAsync(NewTopicNotificationModel notification,
        CancellationToken cancellationToken = default);
}