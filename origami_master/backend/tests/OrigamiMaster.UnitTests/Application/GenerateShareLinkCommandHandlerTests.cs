using FluentAssertions;
using Moq;
using OrigamiMaster.Application.Features.ShareLinks.Commands.GenerateShareLink;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;
using Xunit;

namespace OrigamiMaster.UnitTests.Application;

public class GenerateShareLinkCommandHandlerTests
{
    [Fact]
    public async Task Handle_ValidRequest_ShouldReturnResponse()
    {
        // Arrange
        var currentUserId = Guid.NewGuid();
        var creationId = Guid.NewGuid();

        var mockShareLinkRepo = new Mock<IShareLinkRepository>();
        var mockCreationRepo = new Mock<ICreationRepository>();
        var mockCurrentUser = new Mock<ICurrentUserService>();
        var mockUnitOfWork = new Mock<IUnitOfWork>();

        var creation = new Creation { Id = creationId, UserId = currentUserId };

        mockCurrentUser.Setup(s => s.GetUserId()).Returns(currentUserId);
        mockCreationRepo.Setup(r => r.GetByIdAsync(creationId)).ReturnsAsync(creation);
        mockShareLinkRepo.Setup(r => r.TokenExistsAsync(It.IsAny<string>())).ReturnsAsync(false);

        var handler = new GenerateShareLinkCommandHandler(
            mockShareLinkRepo.Object,
            mockCreationRepo.Object,
            mockCurrentUser.Object,
            mockUnitOfWork.Object);

        var command = new GenerateShareLinkCommand { CreationId = creationId };

        // Act
        var result = await handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.Url.Should().Contain("https://origamimaster.app/share/");
        mockShareLinkRepo.Verify(r => r.AddAsync(It.IsAny<ShareLink>()), Times.Once);
        mockUnitOfWork.Verify(u => u.SaveChangesAsync(It.IsAny<CancellationToken>()), Times.Once);
    }

    [Fact]
    public async Task Handle_CreationNotOwnedByUser_ShouldThrowException()
    {
        // Arrange
        var currentUserId = Guid.NewGuid();
        var creationId = Guid.NewGuid();

        var mockShareLinkRepo = new Mock<IShareLinkRepository>();
        var mockCreationRepo = new Mock<ICreationRepository>();
        var mockCurrentUser = new Mock<ICurrentUserService>();
        var mockUnitOfWork = new Mock<IUnitOfWork>();

        // Different User ID
        var creation = new Creation { Id = creationId, UserId = Guid.NewGuid() };

        mockCurrentUser.Setup(s => s.GetUserId()).Returns(currentUserId);
        mockCreationRepo.Setup(r => r.GetByIdAsync(creationId)).ReturnsAsync(creation);

        var handler = new GenerateShareLinkCommandHandler(
            mockShareLinkRepo.Object,
            mockCreationRepo.Object,
            mockCurrentUser.Object,
            mockUnitOfWork.Object);

        var command = new GenerateShareLinkCommand { CreationId = creationId };

        // Act & Assert
        await FluentActions.Invoking(() => handler.Handle(command, CancellationToken.None))
            .Should().ThrowAsync<Exception>().WithMessage("FORBIDDEN_ACTION");
    }
}
