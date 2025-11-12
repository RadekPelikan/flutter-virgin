using FirebaseAdmin.Messaging;
using FirebaseFlutter.Service.Domain.Contracts;
using FirebaseFlutter.Service.Services.Interfaces;

namespace FirebaseFlutter.Service.Services;

public class NotificationService(
    FirebaseMessaging messaging
) : INotificationService
{
    public sealed class Topic 
    {
        public static readonly Topic Offer = new Topic("Offer");
        public static readonly Topic Chat = new Topic("Chat");

        public string Code { get; }

        private Topic(string code)
        {
            Code = code;
        }
        
        public static IEnumerable<Topic> GetAll() => new[] { Offer, Chat };
        
        public static bool IsValid(string topicCode)
            => GetAll().Any(t => t == topicCode);

        public static bool IsValid(Topic topic) => IsValid(topic.Code);

        public override string ToString()
        {
            return this.Code;
        }

        public override bool Equals(object? obj)
            => obj is Topic other && Code == other.Code;

        public override int GetHashCode() => Code.GetHashCode();

        // Operator overloads with Topic
        public static bool operator ==(Topic? left, Topic? right)
            => ReferenceEquals(left, right) || (left?.Equals(right) ?? false);

        public static bool operator !=(Topic? left, Topic? right)
            => !(left == right);

        // Operator overloads with string
        public static bool operator ==(Topic? left, string? right)
            => left?.Code == right;

        public static bool operator !=(Topic? left, string? right)
            => !(left == right);

        public static bool operator ==(string? left, Topic? right)
            => right == left; // reuse the previous overload

        public static bool operator !=(string? left, Topic? right)
            => !(left == right);
    }
    
    public async Task<NewNotificationResultModel> SendNewNotificationAsync(NewNotificationModel notification,
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
    public async Task<NewNotificationResultModel> SendNewTopicNotificationAsync(NewTopicNotificationModel notification,
        CancellationToken cancellationToken = default)
    {
        if (Topic.IsValid(notification.Topic) is false)
        {
            return new NewNotificationResultModel($"Invalid topic {notification.Topic}");
        }
        
        var message = new Message()
        {
            Notification = new Notification()
            {
                Title = notification.Title,
                Body = notification.Body,
            },
            Topic = notification.Topic,
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