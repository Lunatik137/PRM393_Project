using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OrigamiMaster.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class UpdateFollowNavigation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Follows_Users_FollowerUserId1",
                table: "Follows");

            migrationBuilder.DropForeignKey(
                name: "FK_Follows_Users_FollowingUserId1",
                table: "Follows");

            migrationBuilder.DropIndex(
                name: "IX_Follows_FollowerUserId1",
                table: "Follows");

            migrationBuilder.DropIndex(
                name: "IX_Follows_FollowingUserId1",
                table: "Follows");

            migrationBuilder.DropColumn(
                name: "FollowerUserId1",
                table: "Follows");

            migrationBuilder.DropColumn(
                name: "FollowingUserId1",
                table: "Follows");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "FollowerUserId1",
                table: "Follows",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "FollowingUserId1",
                table: "Follows",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Follows_FollowerUserId1",
                table: "Follows",
                column: "FollowerUserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Follows_FollowingUserId1",
                table: "Follows",
                column: "FollowingUserId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Follows_Users_FollowerUserId1",
                table: "Follows",
                column: "FollowerUserId1",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Follows_Users_FollowingUserId1",
                table: "Follows",
                column: "FollowingUserId1",
                principalTable: "Users",
                principalColumn: "Id");
        }
    }
}
