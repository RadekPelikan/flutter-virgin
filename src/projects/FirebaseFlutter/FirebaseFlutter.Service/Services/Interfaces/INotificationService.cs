using FirebaseFlutter.Service.Domain.Contracts;

namespace FirebaseFlutter.Service.Services.Interfaces;

public interface INotificationService
{
    Task<NewNotificationResultModel> SendNewNotification(NewNotificationModel notification, CancellationToken cancellationToken = default);
    
}