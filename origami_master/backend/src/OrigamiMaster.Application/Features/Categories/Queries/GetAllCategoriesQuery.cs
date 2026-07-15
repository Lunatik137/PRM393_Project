using MediatR;
using OrigamiMaster.Application.Features.Categories.DTOs;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Categories.Queries;

public class GetAllCategoriesQuery : IRequest<IEnumerable<CategoryDto>>
{
}
