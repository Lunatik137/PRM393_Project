using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OrigamiMaster.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class DecoupleFeedPostFromCreation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FeedPosts_Creations_CreationId",
                table: "FeedPosts");

            migrationBuilder.DropForeignKey(
                name: "FK_FeedPosts_Creations_CreationId1",
                table: "FeedPosts");

            migrationBuilder.DropIndex(
                name: "IX_FeedPosts_CreationId",
                table: "FeedPosts");

            migrationBuilder.DropIndex(
                name: "IX_FeedPosts_CreationId1",
                table: "FeedPosts");

            migrationBuilder.DropColumn(
                name: "CreationId",
                table: "FeedPosts");

            migrationBuilder.DropColumn(
                name: "CreationId1",
                table: "FeedPosts");

            migrationBuilder.AddColumn<string>(
                name: "ImageUrl",
                table: "FeedPosts",
                type: "nvarchar(2048)",
                maxLength: 2048,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ImageUrl",
                table: "FeedPosts");

            migrationBuilder.AddColumn<Guid>(
                name: "CreationId",
                table: "FeedPosts",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<Guid>(
                name: "CreationId1",
                table: "FeedPosts",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_FeedPosts_CreationId",
                table: "FeedPosts",
                column: "CreationId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_FeedPosts_CreationId1",
                table: "FeedPosts",
                column: "CreationId1");

            migrationBuilder.AddForeignKey(
                name: "FK_FeedPosts_Creations_CreationId",
                table: "FeedPosts",
                column: "CreationId",
                principalTable: "Creations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_FeedPosts_Creations_CreationId1",
                table: "FeedPosts",
                column: "CreationId1",
                principalTable: "Creations",
                principalColumn: "Id");
        }
    }
}
