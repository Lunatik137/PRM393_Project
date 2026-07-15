using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Profile.DTOs;

public class UserPostPaginationDto
{
    public IEnumerable<UserPostDto> Items { get; set; } = new List<UserPostDto>();
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public bool HasMore { get; set; }
}
