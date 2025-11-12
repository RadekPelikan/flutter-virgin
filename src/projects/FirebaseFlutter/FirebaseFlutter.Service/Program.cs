using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using FirebaseFlutter.Service.Domain.Contracts;
using FirebaseFlutter.Service.Services;
using FirebaseFlutter.Service.Services.Interfaces;
using Google.Apis.Auth.OAuth2;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

// Firebase setup
FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromFile(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "firebase.secret.json")),
});

// Add services
builder.Services
    .AddEndpointsApiExplorer() // Required for minimal APIs
    .AddSwaggerGen(); // Add Swagger generator

builder.Services
    .AddTransient<FirebaseMessaging>(provider => FirebaseMessaging.DefaultInstance)
    .AddTransient<INotificationService, NotificationService>();

var app = builder.Build();

// Configure middleware
if (app.Environment.IsDevelopment())
{
    app.UseSwagger(); // Generate Swagger JSON
    app.UseSwaggerUI(); // Swagger UI at /swagger
}

app.UseHttpsRedirection();

// Minimal API endpoint
app.MapPost("/notification", async (
        NewNotificationModel notification,
        INotificationService notificationService
    ) =>
    {
        var serviceResult = await notificationService.SendNewNotificationAsync(notification);
        return Results.Ok(serviceResult);
    })
    .WithName("SendNotification") // Optional: name for Swagger
    .WithOpenApi(); // Optional: enables Swagger documentation for this endpoint

app.MapPost("/notification/topic", async (
        NewTopicNotificationModel notification,
        INotificationService notificationService
    ) =>
    {
        var serviceResult = await notificationService.SendNewTopicNotificationAsync(notification);
        return Results.Ok(serviceResult);
    })
    .WithName("SendTopicNotification") // Optional: name for Swagger
    .WithOpenApi(); // Optional: enables Swagger documentation for this endpoint

app.Run();