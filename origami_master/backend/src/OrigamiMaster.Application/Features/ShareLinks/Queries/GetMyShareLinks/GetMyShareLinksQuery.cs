using MediatR;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.ShareLinks.Queries.GetMyShareLinks;

public class GetMyShareLinksQuery : IRequest<List<ShareLinkDto>>
{
}
