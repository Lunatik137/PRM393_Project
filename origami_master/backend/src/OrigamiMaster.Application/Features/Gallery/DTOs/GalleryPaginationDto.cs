using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Gallery.DTOs;

public class GalleryPaginationDto
{
    public IEnumerable<GalleryItemDto> Items { get; set; } = new List<GalleryItemDto>();
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public bool HasMore { get; set; }
}
