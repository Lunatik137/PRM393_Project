using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Profile.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Profile.Queries.GetUserProfile;

public class GetUserProfileQueryHandler : IRequestHandler<GetUserProfileQuery, UserProfileDto>
{
    private readonly IUserRepository _userRepository;
    private readonly ILearningProgressRepository _learningProgressRepository;
    private readonly ICreationRepository _creationRepository;
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly IFollowRepository _followRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public GetUserProfileQueryHandler(
        IUserRepository userRepository,
        ILearningProgressRepository learningProgressRepository,
        ICreationRepository creationRepository,
        IFeedPostRepository feedPostRepository,
        IFollowRepository followRepository,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _userRepository = userRepository;
        _learningProgressRepository = learningProgressRepository;
        _creationRepository = creationRepository;
        _feedPostRepository = feedPostRepository;
        _followRepository = followRepository;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<UserProfileDto> Handle(GetUserProfileQuery request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(request.UserId);

        if (user == null)
            throw new System.Exception("USER_NOT_FOUND");

        var dto = _mapper.Map<UserProfileDto>(user);

        dto.Statistics = new ProfileStatisticsDto
        {
            CompletedFolds = await _creationRepository.GetCompletedFoldsCountAsync(request.UserId),
            PublicPosts = await _feedPostRepository.CountByUserIdAsync(request.UserId),
            Followers = await _followRepository.GetFollowersCountAsync(request.UserId),
            Following = await _followRepository.GetFollowingCountAsync(request.UserId)
        };

        if (_currentUserService.IsAuthenticated())
        {
            var currentUserId = _currentUserService.GetUserId();
            dto.IsFollowing = await _followRepository.IsFollowingAsync(currentUserId, request.UserId);
        }

        return dto;
    }
}
