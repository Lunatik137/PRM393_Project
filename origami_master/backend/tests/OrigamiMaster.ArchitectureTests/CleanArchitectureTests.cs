using FluentAssertions;
using NetArchTest.Rules;
using Xunit;

namespace OrigamiMaster.ArchitectureTests;

public class CleanArchitectureTests
{
    private const string DomainNamespace = "OrigamiMaster.Domain";
    private const string ApplicationNamespace = "OrigamiMaster.Application";
    private const string InfrastructureNamespace = "OrigamiMaster.Infrastructure";
    private const string ApiNamespace = "OrigamiMaster.API";

    [Fact]
    public void Domain_Should_Not_HaveDependencyOnOtherProjects()
    {
        // Arrange
        var assembly = typeof(OrigamiMaster.Domain.Entities.User).Assembly;

        var otherProjects = new[]
        {
            ApplicationNamespace,
            InfrastructureNamespace,
            ApiNamespace
        };

        // Act
        var result = Types
            .InAssembly(assembly)
            .ShouldNot()
            .HaveDependencyOnAny(otherProjects)
            .GetResult();

        // Assert
        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void Application_Should_Not_HaveDependencyOnInfrastructureOrApi()
    {
        // Arrange
        var assembly = typeof(OrigamiMaster.Application.DependencyInjection).Assembly;

        var otherProjects = new[]
        {
            InfrastructureNamespace,
            ApiNamespace
        };

        // Act
        var result = Types
            .InAssembly(assembly)
            .ShouldNot()
            .HaveDependencyOnAny(otherProjects)
            .GetResult();

        // Assert
        result.IsSuccessful.Should().BeTrue();
    }

    [Fact]
    public void Controllers_Should_Not_DependOnRepositoriesDirectly()
    {
        // Arrange
        var assembly = typeof(OrigamiMaster.API.Controllers.AuthController).Assembly;

        // Act
        var result = Types
            .InAssembly(assembly)
            .That()
            .ResideInNamespace("OrigamiMaster.API.Controllers")
            .ShouldNot()
            .HaveDependencyOn("OrigamiMaster.Domain.Repositories")
            .GetResult();

        // Assert
        result.IsSuccessful.Should().BeTrue();
    }
}
