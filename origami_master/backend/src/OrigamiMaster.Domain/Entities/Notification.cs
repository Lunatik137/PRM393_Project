using System;
using OrigamiMaster.Domain.Enums;

namespace OrigamiMaster.Domain.Entities;

public class Notification
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public NotificationType Type { get; set; }
    public Guid ReferenceId { get; set; }
    public bool IsRead { get; set; }
    public DateTime CreatedAt { get; set; }

    public void MarkAsRead()
    {
        IsRead = true;
    }
}
