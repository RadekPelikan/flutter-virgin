using FirebaseAdmin.Messaging;
using FirebaseFlutter.Service.Domain.Contracts;
using FirebaseFlutter.Service.Services.Interfaces;

namespace FirebaseFlutter.Service.Services;

public class NotificationService(
    FirebaseMessaging messaging
) : INotificationService
{
    public async Task<NewNotificationResultModel> SendNewNotification(NewNotificationModel notification,
        CancellationToken cancellationToken = default)
    {
        var message = new Message()
        {
            Notification = new Notification()
            {
                Title = notification.Title,
                Body = notification.Body,
            },
            Token = notification.FcmToken
        };

        try
        {
            var result = await messaging.SendAsync(message, cancellationToken);
            return new NewNotificationResultModel(result);
        }
        catch (FirebaseMessagingException ex)
        {
            return  new NewNotificationResultModel(ex.Message);
        }
    }
}