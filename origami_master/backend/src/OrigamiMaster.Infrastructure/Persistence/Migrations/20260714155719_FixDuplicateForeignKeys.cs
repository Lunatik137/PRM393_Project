using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OrigamiMaster.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class FixDuplicateForeignKeys : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Comments_Users_UserId1",
                table: "Comments");

            migrationBuilder.DropForeignKey(
                name: "FK_Creations_Users_UserId1",
                table: "Creations");

            migrationBuilder.DropForeignKey(
                name: "FK_FeedPosts_Users_UserId1",
                table: "FeedPosts");

            migrationBuilder.DropForeignKey(
                name: "FK_ShareLinks_Creations_CreationId1",
                table: "ShareLinks");

            migrationBuilder.DropIndex(
                name: "IX_ShareLinks_CreationId1",
                table: "ShareLinks");

            migrationBuilder.DropIndex(
                name: "IX_FeedPosts_UserId1",
                table: "FeedPosts");

            migrationBuilder.DropIndex(
                name: "IX_Creations_UserId1",
                table: "Creations");

            migrationBuilder.DropIndex(
                name: "IX_Comments_UserId1",
                table: "Comments");

            migrationBuilder.DropColumn(
                name: "CreationId1",
                table: "ShareLinks");

            migrationBuilder.DropColumn(
                name: "UserId1",
                table: "FeedPosts");

            migrationBuilder.DropColumn(
                name: "UserId1",
                table: "Creations");

            migrationBuilder.DropColumn(
                name: "UserId1",
                table: "Comments");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "CreationId1",
                table: "ShareLinks",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId1",
                table: "FeedPosts",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId1",
                table: "Creations",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId1",
                table: "Comments",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_ShareLinks_CreationId1",
                table: "ShareLinks",
                column: "CreationId1");

            migrationBuilder.CreateIndex(
                name: "IX_FeedPosts_UserId1",
                table: "FeedPosts",
                column: "UserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Creations_UserId1",
                table: "Creations",
                column: "UserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_UserId1",
                table: "Comments",
                column: "UserId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Comments_Users_UserId1",
                table: "Comments",
                column: "UserId1",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Creations_Users_UserId1",
                table: "Creations",
                column: "UserId1",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_FeedPosts_Users_UserId1",
                table: "FeedPosts",
                column: "UserId1",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ShareLinks_Creations_CreationId1",
                table: "ShareLinks",
                column: "CreationId1",
                principalTable: "Creations",
                principalColumn: "Id");
        }
    }
}
