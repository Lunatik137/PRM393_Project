using MediatR;
using OrigamiMaster.Application.Features.Feed.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Feed.Queries.GetFeedPost;

public class GetFeedPostQuery : IRequest<FeedPostDto>
{
    public Guid Id { get; set; }
}
