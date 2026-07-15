using System;
using MediatR;
using OrigamiMaster.Application.Features.Categories.DTOs;

namespace OrigamiMaster.Application.Features.Categories.Queries;

public class GetCategoryByIdQuery : IRequest<CategoryDto?>
{
    public Guid Id { get; set; }
}
