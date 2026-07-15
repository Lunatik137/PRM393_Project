using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class NotificationRepository : INotificationRepository
{
    private readonly ApplicationDbContext _context;

    public NotificationRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Notification?> GetByIdAsync(Guid id)
    {
        return await _context.Notifications.AsNoTracking().FirstOrDefaultAsync(n => n.Id == id);
    }

    public async Task<IEnumerable<Notification>> GetByUserIdAsync(Guid userId)
    {
        return await _context.Notifications.AsNoTracking().Where(n => n.UserId == userId).ToListAsync();
    }

    public async Task AddAsync(Notification notification)
    {
        await _context.Notifications.AddAsync(notification);
    }

    public Task UpdateAsync(Notification notification)
    {
        _context.Notifications.Update(notification);
        return Task.CompletedTask;
    }

    public Task DeleteAsync(Notification notification)
    {
        _context.Notifications.Remove(notification);
        return Task.CompletedTask;
    }
}
