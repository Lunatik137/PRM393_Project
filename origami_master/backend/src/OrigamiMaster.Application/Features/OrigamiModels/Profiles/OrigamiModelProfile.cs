using System.Linq;
using AutoMapper;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;
using OrigamiMaster.Application.Features.Categories.DTOs;

namespace OrigamiMaster.Application.Features.OrigamiModels.Profiles;

public class OrigamiModelProfile : AutoMapper.Profile
{
    public OrigamiModelProfile()
    {
        CreateMap<OrigamiModel, OrigamiSummaryDto>();

        CreateMap<OrigamiModel, OrigamiDetailDto>()
            .ForMember(d => d.Tags, opt => opt.MapFrom(src => src.OrigamiTags.Select(ot => ot.Tag)));

        CreateMap<OrigamiStep, OrigamiStepDto>();
        
        CreateMap<Tag, TagDto>();
    }
}
