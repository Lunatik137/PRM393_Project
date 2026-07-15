using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Profile.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Profile.Queries.GetCurrentProfile;

public class GetCurrentProfileQueryHandler : IRequestHandler<GetCurrentProfileQuery, UserProfileDto>
{
    private readonly IUserRepository _userRepository;
    private readonly ILearningProgressRepository _learningProgressRepository;
    private readonly ICreationRepository _creationRepository;
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly IFollowRepository _followRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public GetCurrentProfileQueryHandler(
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

    public async Task<UserProfileDto> Handle(GetCurrentProfileQuery request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();
        var user = await _userRepository.GetByIdAsync(currentUserId);

        if (user == null)
            throw new System.Exception("USER_NOT_FOUND");

        var dto = _mapper.Map<UserProfileDto>(user);

        dto.Statistics = new ProfileStatisticsDto
        {
            CompletedFolds = await _creationRepository.GetCompletedFoldsCountAsync(currentUserId),
            PublicPosts = await _feedPostRepository.CountByUserIdAsync(currentUserId),
            Followers = await _followRepository.GetFollowersCountAsync(currentUserId),
            Following = await _followRepository.GetFollowingCountAsync(currentUserId)
        };

        return dto;
    }
}
