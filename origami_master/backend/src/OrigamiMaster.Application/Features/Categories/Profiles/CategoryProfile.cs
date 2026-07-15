using AutoMapper;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Application.Features.Categories.DTOs;

namespace OrigamiMaster.Application.Features.Categories.Profiles;

public class CategoryProfile : AutoMapper.Profile
{
    public CategoryProfile()
    {
        CreateMap<Category, CategoryDto>();
    }
}
