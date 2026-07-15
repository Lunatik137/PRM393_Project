using FluentAssertions;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Enums;
using System;
using Xunit;

namespace OrigamiMaster.UnitTests.Domain;

public class DomainTests
{
    [Fact]
    public void ShareLink_Disable_ShouldSetIsActiveToFalseAndSetDisabledAt()
    {
        // Arrange
        var link = new ShareLink
        {
            Id = Guid.NewGuid(),
            Token = "abc",
            IsActive = true
        };

        // Act
        link.Disable();

        // Assert
        link.IsActive.Should().BeFalse();
        link.DisabledAt.Should().NotBeNull();
    }

    [Fact]
    public void Creation_Publish_ShouldSetIsPublishedAndMakePublic()
    {
        // Arrange
        var creation = new Creation
        {
            Id = Guid.NewGuid(),
            IsPublished = false,
            Visibility = CreationVisibility.Private
        };

        // Act
        creation.Publish();

        // Assert
        creation.IsPublished.Should().BeTrue();
        creation.PublishedAt.Should().NotBeNull();
        creation.Visibility.Should().Be(CreationVisibility.Public);
    }
}
