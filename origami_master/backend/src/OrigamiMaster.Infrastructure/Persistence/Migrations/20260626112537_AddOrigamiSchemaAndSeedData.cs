using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace OrigamiMaster.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class AddOrigamiSchemaAndSeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "LearningSteps");

            migrationBuilder.AddColumn<Guid>(
                name: "CreationId1",
                table: "ShareLinks",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "CategoryId",
                table: "OrigamiModels",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<string>(
                name: "CoverImageUrl",
                table: "OrigamiModels",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Materials",
                table: "OrigamiModels",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Slug",
                table: "OrigamiModels",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "UpdatedAt",
                table: "OrigamiModels",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<Guid>(
                name: "CreationId1",
                table: "FeedPosts",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "UserId1",
                table: "FeedPosts",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "OrigamiModelId1",
                table: "Creations",
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

            migrationBuilder.CreateTable(
                name: "Categories",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Slug = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    Icon = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Categories", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "CompletedModels",
                columns: table => new
                {
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    OrigamiModelId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CompletedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CompletedModels", x => new { x.UserId, x.OrigamiModelId });
                    table.ForeignKey(
                        name: "FK_CompletedModels_OrigamiModels_OrigamiModelId",
                        column: x => x.OrigamiModelId,
                        principalTable: "OrigamiModels",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CompletedModels_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Favorites",
                columns: table => new
                {
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    OrigamiModelId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Favorites", x => new { x.UserId, x.OrigamiModelId });
                    table.ForeignKey(
                        name: "FK_Favorites_OrigamiModels_OrigamiModelId",
                        column: x => x.OrigamiModelId,
                        principalTable: "OrigamiModels",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Favorites_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "OrigamiSteps",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    OrigamiModelId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    StepNumber = table.Column<int>(type: "int", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrigamiSteps", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OrigamiSteps_OrigamiModels_OrigamiModelId",
                        column: x => x.OrigamiModelId,
                        principalTable: "OrigamiModels",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RecentViews",
                columns: table => new
                {
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    OrigamiModelId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ViewedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RecentViews", x => new { x.UserId, x.OrigamiModelId });
                    table.ForeignKey(
                        name: "FK_RecentViews_OrigamiModels_OrigamiModelId",
                        column: x => x.OrigamiModelId,
                        principalTable: "OrigamiModels",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RecentViews_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Tags",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tags", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "OrigamiTags",
                columns: table => new
                {
                    OrigamiModelId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    TagId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrigamiTags", x => new { x.OrigamiModelId, x.TagId });
                    table.ForeignKey(
                        name: "FK_OrigamiTags_OrigamiModels_OrigamiModelId",
                        column: x => x.OrigamiModelId,
                        principalTable: "OrigamiModels",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OrigamiTags_Tags_TagId",
                        column: x => x.TagId,
                        principalTable: "Tags",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Categories",
                columns: new[] { "Id", "Description", "Icon", "Name", "Slug" },
                values: new object[,]
                {
                    { new Guid("00746163-0000-0000-0000-000000000000"), "Beautiful origami models in the Animals category.", "category_icon_animals", "Animals", "animals" },
                    { new Guid("00746163-0000-0000-0000-000001000000"), "Beautiful origami models in the Birds category.", "category_icon_birds", "Birds", "birds" },
                    { new Guid("00746163-0000-0000-0000-000002000000"), "Beautiful origami models in the Flowers category.", "category_icon_flowers", "Flowers", "flowers" },
                    { new Guid("00746163-0000-0000-0000-000003000000"), "Beautiful origami models in the Insects category.", "category_icon_insects", "Insects", "insects" },
                    { new Guid("00746163-0000-0000-0000-000004000000"), "Beautiful origami models in the Dinosaurs category.", "category_icon_dinosaurs", "Dinosaurs", "dinosaurs" },
                    { new Guid("00746163-0000-0000-0000-000005000000"), "Beautiful origami models in the Modular category.", "category_icon_modular", "Modular", "modular" },
                    { new Guid("00746163-0000-0000-0000-000006000000"), "Beautiful origami models in the Boxes category.", "category_icon_boxes", "Boxes", "boxes" },
                    { new Guid("00746163-0000-0000-0000-000007000000"), "Beautiful origami models in the Airplanes category.", "category_icon_airplanes", "Airplanes", "airplanes" },
                    { new Guid("00746163-0000-0000-0000-000008000000"), "Beautiful origami models in the Boats category.", "category_icon_boats", "Boats", "boats" },
                    { new Guid("00746163-0000-0000-0000-000009000000"), "Beautiful origami models in the Holidays category.", "category_icon_holidays", "Holidays", "holidays" }
                });

            migrationBuilder.InsertData(
                table: "Tags",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { new Guid("00676174-0000-0000-0000-000000000000"), "Tag 1" },
                    { new Guid("00676174-0000-0000-0000-000001000000"), "Tag 2" },
                    { new Guid("00676174-0000-0000-0000-000002000000"), "Tag 3" },
                    { new Guid("00676174-0000-0000-0000-000003000000"), "Tag 4" },
                    { new Guid("00676174-0000-0000-0000-000004000000"), "Tag 5" },
                    { new Guid("00676174-0000-0000-0000-000005000000"), "Tag 6" },
                    { new Guid("00676174-0000-0000-0000-000006000000"), "Tag 7" },
                    { new Guid("00676174-0000-0000-0000-000007000000"), "Tag 8" },
                    { new Guid("00676174-0000-0000-0000-000008000000"), "Tag 9" },
                    { new Guid("00676174-0000-0000-0000-000009000000"), "Tag 10" },
                    { new Guid("00676174-0000-0000-0000-00000a000000"), "Tag 11" },
                    { new Guid("00676174-0000-0000-0000-00000b000000"), "Tag 12" },
                    { new Guid("00676174-0000-0000-0000-00000c000000"), "Tag 13" },
                    { new Guid("00676174-0000-0000-0000-00000d000000"), "Tag 14" },
                    { new Guid("00676174-0000-0000-0000-00000e000000"), "Tag 15" },
                    { new Guid("00676174-0000-0000-0000-00000f000000"), "Tag 16" },
                    { new Guid("00676174-0000-0000-0000-000010000000"), "Tag 17" },
                    { new Guid("00676174-0000-0000-0000-000011000000"), "Tag 18" },
                    { new Guid("00676174-0000-0000-0000-000012000000"), "Tag 19" },
                    { new Guid("00676174-0000-0000-0000-000013000000"), "Tag 20" },
                    { new Guid("00676174-0000-0000-0000-000014000000"), "Tag 21" },
                    { new Guid("00676174-0000-0000-0000-000015000000"), "Tag 22" },
                    { new Guid("00676174-0000-0000-0000-000016000000"), "Tag 23" },
                    { new Guid("00676174-0000-0000-0000-000017000000"), "Tag 24" },
                    { new Guid("00676174-0000-0000-0000-000018000000"), "Tag 25" },
                    { new Guid("00676174-0000-0000-0000-000019000000"), "Tag 26" },
                    { new Guid("00676174-0000-0000-0000-00001a000000"), "Tag 27" },
                    { new Guid("00676174-0000-0000-0000-00001b000000"), "Tag 28" },
                    { new Guid("00676174-0000-0000-0000-00001c000000"), "Tag 29" },
                    { new Guid("00676174-0000-0000-0000-00001d000000"), "Tag 30" },
                    { new Guid("00676174-0000-0000-0000-00001e000000"), "Tag 31" },
                    { new Guid("00676174-0000-0000-0000-00001f000000"), "Tag 32" },
                    { new Guid("00676174-0000-0000-0000-000020000000"), "Tag 33" },
                    { new Guid("00676174-0000-0000-0000-000021000000"), "Tag 34" },
                    { new Guid("00676174-0000-0000-0000-000022000000"), "Tag 35" },
                    { new Guid("00676174-0000-0000-0000-000023000000"), "Tag 36" },
                    { new Guid("00676174-0000-0000-0000-000024000000"), "Tag 37" },
                    { new Guid("00676174-0000-0000-0000-000025000000"), "Tag 38" },
                    { new Guid("00676174-0000-0000-0000-000026000000"), "Tag 39" },
                    { new Guid("00676174-0000-0000-0000-000027000000"), "Tag 40" },
                    { new Guid("00676174-0000-0000-0000-000028000000"), "Tag 41" },
                    { new Guid("00676174-0000-0000-0000-000029000000"), "Tag 42" },
                    { new Guid("00676174-0000-0000-0000-00002a000000"), "Tag 43" },
                    { new Guid("00676174-0000-0000-0000-00002b000000"), "Tag 44" },
                    { new Guid("00676174-0000-0000-0000-00002c000000"), "Tag 45" },
                    { new Guid("00676174-0000-0000-0000-00002d000000"), "Tag 46" },
                    { new Guid("00676174-0000-0000-0000-00002e000000"), "Tag 47" },
                    { new Guid("00676174-0000-0000-0000-00002f000000"), "Tag 48" },
                    { new Guid("00676174-0000-0000-0000-000030000000"), "Tag 49" },
                    { new Guid("00676174-0000-0000-0000-000031000000"), "Tag 50" }
                });

            migrationBuilder.InsertData(
                table: "OrigamiModels",
                columns: new[] { "Id", "CategoryId", "CoverImageUrl", "CreatedAt", "Description", "Difficulty", "EstimatedMinutes", "Materials", "Name", "Slug", "ThumbnailUrl", "UpdatedAt" },
                values: new object[,]
                {
                    { new Guid("00646f6d-0000-0000-0000-000000000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Animals 1. This tutorial is perfect for everyone.", 0, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Animals 1", "classic-animals-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000001000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Animals 2. This tutorial is perfect for everyone.", 1, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Animals 2", "simple-animals-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000002000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Animals 3. This tutorial is perfect for everyone.", 2, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Animals 3", "complex-animals-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000003000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Animals 4. This tutorial is perfect for everyone.", 3, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Animals 4", "modern-animals-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000004000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Animals 5. This tutorial is perfect for everyone.", 0, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Animals 5", "traditional-animals-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000005000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Animals 6. This tutorial is perfect for everyone.", 1, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Animals 6", "elegant-animals-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000006000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Animals 7. This tutorial is perfect for everyone.", 2, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Animals 7", "geometric-animals-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000007000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Animals 8. This tutorial is perfect for everyone.", 3, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Animals 8", "minimalist-animals-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000008000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Animals 9. This tutorial is perfect for everyone.", 0, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Animals 9", "advanced-animals-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000009000000"), new Guid("00746163-0000-0000-0000-000000000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Animals 10. This tutorial is perfect for everyone.", 1, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Animals 10", "origami-animals-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00000a000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Birds 1. This tutorial is perfect for everyone.", 2, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Birds 1", "classic-birds-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00000b000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Birds 2. This tutorial is perfect for everyone.", 3, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Birds 2", "simple-birds-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00000c000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Birds 3. This tutorial is perfect for everyone.", 0, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Birds 3", "complex-birds-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00000d000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Birds 4. This tutorial is perfect for everyone.", 1, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Birds 4", "modern-birds-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00000e000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Birds 5. This tutorial is perfect for everyone.", 2, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Birds 5", "traditional-birds-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00000f000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Birds 6. This tutorial is perfect for everyone.", 3, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Birds 6", "elegant-birds-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000010000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Birds 7. This tutorial is perfect for everyone.", 0, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Birds 7", "geometric-birds-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000011000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Birds 8. This tutorial is perfect for everyone.", 1, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Birds 8", "minimalist-birds-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000012000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Birds 9. This tutorial is perfect for everyone.", 2, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Birds 9", "advanced-birds-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000013000000"), new Guid("00746163-0000-0000-0000-000001000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Birds 10. This tutorial is perfect for everyone.", 3, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Birds 10", "origami-birds-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000014000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Flowers 1. This tutorial is perfect for everyone.", 0, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Flowers 1", "classic-flowers-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000015000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Flowers 2. This tutorial is perfect for everyone.", 1, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Flowers 2", "simple-flowers-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000016000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Flowers 3. This tutorial is perfect for everyone.", 2, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Flowers 3", "complex-flowers-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000017000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Flowers 4. This tutorial is perfect for everyone.", 3, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Flowers 4", "modern-flowers-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000018000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Flowers 5. This tutorial is perfect for everyone.", 0, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Flowers 5", "traditional-flowers-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000019000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Flowers 6. This tutorial is perfect for everyone.", 1, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Flowers 6", "elegant-flowers-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00001a000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Flowers 7. This tutorial is perfect for everyone.", 2, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Flowers 7", "geometric-flowers-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00001b000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Flowers 8. This tutorial is perfect for everyone.", 3, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Flowers 8", "minimalist-flowers-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00001c000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Flowers 9. This tutorial is perfect for everyone.", 0, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Flowers 9", "advanced-flowers-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00001d000000"), new Guid("00746163-0000-0000-0000-000002000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Flowers 10. This tutorial is perfect for everyone.", 1, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Flowers 10", "origami-flowers-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00001e000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Insects 1. This tutorial is perfect for everyone.", 2, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Insects 1", "classic-insects-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00001f000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Insects 2. This tutorial is perfect for everyone.", 3, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Insects 2", "simple-insects-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000020000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Insects 3. This tutorial is perfect for everyone.", 0, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Insects 3", "complex-insects-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000021000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Insects 4. This tutorial is perfect for everyone.", 1, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Insects 4", "modern-insects-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000022000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Insects 5. This tutorial is perfect for everyone.", 2, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Insects 5", "traditional-insects-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000023000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Insects 6. This tutorial is perfect for everyone.", 3, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Insects 6", "elegant-insects-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000024000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Insects 7. This tutorial is perfect for everyone.", 0, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Insects 7", "geometric-insects-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000025000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Insects 8. This tutorial is perfect for everyone.", 1, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Insects 8", "minimalist-insects-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000026000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Insects 9. This tutorial is perfect for everyone.", 2, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Insects 9", "advanced-insects-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000027000000"), new Guid("00746163-0000-0000-0000-000003000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Insects 10. This tutorial is perfect for everyone.", 3, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Insects 10", "origami-insects-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000028000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Dinosaurs 1. This tutorial is perfect for everyone.", 0, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Dinosaurs 1", "classic-dinosaurs-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000029000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Dinosaurs 2. This tutorial is perfect for everyone.", 1, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Dinosaurs 2", "simple-dinosaurs-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00002a000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Dinosaurs 3. This tutorial is perfect for everyone.", 2, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Dinosaurs 3", "complex-dinosaurs-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00002b000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Dinosaurs 4. This tutorial is perfect for everyone.", 3, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Dinosaurs 4", "modern-dinosaurs-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00002c000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Dinosaurs 5. This tutorial is perfect for everyone.", 0, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Dinosaurs 5", "traditional-dinosaurs-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00002d000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Dinosaurs 6. This tutorial is perfect for everyone.", 1, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Dinosaurs 6", "elegant-dinosaurs-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00002e000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Dinosaurs 7. This tutorial is perfect for everyone.", 2, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Dinosaurs 7", "geometric-dinosaurs-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00002f000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Dinosaurs 8. This tutorial is perfect for everyone.", 3, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Dinosaurs 8", "minimalist-dinosaurs-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000030000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Dinosaurs 9. This tutorial is perfect for everyone.", 0, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Dinosaurs 9", "advanced-dinosaurs-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000031000000"), new Guid("00746163-0000-0000-0000-000004000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Dinosaurs 10. This tutorial is perfect for everyone.", 1, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Dinosaurs 10", "origami-dinosaurs-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000032000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Modular 1. This tutorial is perfect for everyone.", 2, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Modular 1", "classic-modular-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000033000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Modular 2. This tutorial is perfect for everyone.", 3, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Modular 2", "simple-modular-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000034000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Modular 3. This tutorial is perfect for everyone.", 0, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Modular 3", "complex-modular-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000035000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Modular 4. This tutorial is perfect for everyone.", 1, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Modular 4", "modern-modular-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000036000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Modular 5. This tutorial is perfect for everyone.", 2, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Modular 5", "traditional-modular-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000037000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Modular 6. This tutorial is perfect for everyone.", 3, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Modular 6", "elegant-modular-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000038000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Modular 7. This tutorial is perfect for everyone.", 0, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Modular 7", "geometric-modular-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000039000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Modular 8. This tutorial is perfect for everyone.", 1, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Modular 8", "minimalist-modular-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00003a000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Modular 9. This tutorial is perfect for everyone.", 2, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Modular 9", "advanced-modular-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00003b000000"), new Guid("00746163-0000-0000-0000-000005000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Modular 10. This tutorial is perfect for everyone.", 3, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Modular 10", "origami-modular-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00003c000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Boxes 1. This tutorial is perfect for everyone.", 0, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Boxes 1", "classic-boxes-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00003d000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Boxes 2. This tutorial is perfect for everyone.", 1, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Boxes 2", "simple-boxes-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00003e000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Boxes 3. This tutorial is perfect for everyone.", 2, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Boxes 3", "complex-boxes-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00003f000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Boxes 4. This tutorial is perfect for everyone.", 3, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Boxes 4", "modern-boxes-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000040000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Boxes 5. This tutorial is perfect for everyone.", 0, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Boxes 5", "traditional-boxes-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000041000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Boxes 6. This tutorial is perfect for everyone.", 1, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Boxes 6", "elegant-boxes-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000042000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Boxes 7. This tutorial is perfect for everyone.", 2, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Boxes 7", "geometric-boxes-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000043000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Boxes 8. This tutorial is perfect for everyone.", 3, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Boxes 8", "minimalist-boxes-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000044000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Boxes 9. This tutorial is perfect for everyone.", 0, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Boxes 9", "advanced-boxes-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000045000000"), new Guid("00746163-0000-0000-0000-000006000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Boxes 10. This tutorial is perfect for everyone.", 1, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Boxes 10", "origami-boxes-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000046000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Airplanes 1. This tutorial is perfect for everyone.", 2, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Airplanes 1", "classic-airplanes-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000047000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Airplanes 2. This tutorial is perfect for everyone.", 3, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Airplanes 2", "simple-airplanes-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000048000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Airplanes 3. This tutorial is perfect for everyone.", 0, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Airplanes 3", "complex-airplanes-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000049000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Airplanes 4. This tutorial is perfect for everyone.", 1, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Airplanes 4", "modern-airplanes-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00004a000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Airplanes 5. This tutorial is perfect for everyone.", 2, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Airplanes 5", "traditional-airplanes-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00004b000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Airplanes 6. This tutorial is perfect for everyone.", 3, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Airplanes 6", "elegant-airplanes-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00004c000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Airplanes 7. This tutorial is perfect for everyone.", 0, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Airplanes 7", "geometric-airplanes-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00004d000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Airplanes 8. This tutorial is perfect for everyone.", 1, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Airplanes 8", "minimalist-airplanes-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00004e000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Airplanes 9. This tutorial is perfect for everyone.", 2, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Airplanes 9", "advanced-airplanes-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00004f000000"), new Guid("00746163-0000-0000-0000-000007000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Airplanes 10. This tutorial is perfect for everyone.", 3, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Airplanes 10", "origami-airplanes-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000050000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Boats 1. This tutorial is perfect for everyone.", 0, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Boats 1", "classic-boats-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000051000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Boats 2. This tutorial is perfect for everyone.", 1, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Boats 2", "simple-boats-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000052000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Boats 3. This tutorial is perfect for everyone.", 2, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Boats 3", "complex-boats-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000053000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Boats 4. This tutorial is perfect for everyone.", 3, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Boats 4", "modern-boats-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000054000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Boats 5. This tutorial is perfect for everyone.", 0, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Boats 5", "traditional-boats-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000055000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Boats 6. This tutorial is perfect for everyone.", 1, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Boats 6", "elegant-boats-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000056000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Boats 7. This tutorial is perfect for everyone.", 2, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Boats 7", "geometric-boats-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000057000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Boats 8. This tutorial is perfect for everyone.", 3, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Boats 8", "minimalist-boats-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000058000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Boats 9. This tutorial is perfect for everyone.", 0, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Boats 9", "advanced-boats-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000059000000"), new Guid("00746163-0000-0000-0000-000008000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Boats 10. This tutorial is perfect for everyone.", 1, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Boats 10", "origami-boats-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00005a000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Classic Holidays 1. This tutorial is perfect for everyone.", 2, 10, "[\"1x Square Paper 15x15cm\"]", "Classic Holidays 1", "classic-holidays-1", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00005b000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Simple Holidays 2. This tutorial is perfect for everyone.", 3, 20, "[\"1x Square Paper 15x15cm\"]", "Simple Holidays 2", "simple-holidays-2", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00005c000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Complex Holidays 3. This tutorial is perfect for everyone.", 0, 30, "[\"1x Square Paper 15x15cm\"]", "Complex Holidays 3", "complex-holidays-3", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00005d000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Modern Holidays 4. This tutorial is perfect for everyone.", 1, 40, "[\"1x Square Paper 15x15cm\"]", "Modern Holidays 4", "modern-holidays-4", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00005e000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Traditional Holidays 5. This tutorial is perfect for everyone.", 2, 50, "[\"1x Square Paper 15x15cm\"]", "Traditional Holidays 5", "traditional-holidays-5", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-00005f000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Elegant Holidays 6. This tutorial is perfect for everyone.", 3, 10, "[\"1x Square Paper 15x15cm\"]", "Elegant Holidays 6", "elegant-holidays-6", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000060000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Geometric Holidays 7. This tutorial is perfect for everyone.", 0, 20, "[\"1x Square Paper 15x15cm\"]", "Geometric Holidays 7", "geometric-holidays-7", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000061000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Minimalist Holidays 8. This tutorial is perfect for everyone.", 1, 30, "[\"1x Square Paper 15x15cm\"]", "Minimalist Holidays 8", "minimalist-holidays-8", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000062000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Advanced Holidays 9. This tutorial is perfect for everyone.", 2, 40, "[\"1x Square Paper 15x15cm\"]", "Advanced Holidays 9", "advanced-holidays-9", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) },
                    { new Guid("00646f6d-0000-0000-0000-000063000000"), new Guid("00746163-0000-0000-0000-000009000000"), "https://example.com/cover.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc), "Learn how to fold a Origami Holidays 10. This tutorial is perfect for everyone.", 3, 50, "[\"1x Square Paper 15x15cm\"]", "Origami Holidays 10", "origami-holidays-10", "https://example.com/thumb.jpg", new DateTime(2025, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc) }
                });

            migrationBuilder.InsertData(
                table: "OrigamiSteps",
                columns: new[] { "Id", "Description", "ImageUrl", "OrigamiModelId", "StepNumber", "Title" },
                values: new object[,]
                {
                    { new Guid("70657473-0000-0000-0000-000000000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000000000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000000010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002a000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000000020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000055000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000001000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000000000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000001010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002a000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000001020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000055000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000002000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000000000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000002010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002b000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000002020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000055000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000003000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000000000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000003010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002b000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000003020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000055000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000004000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000000000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000004010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002b000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000004020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000056000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000005000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000000000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000005010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002b000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000005020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000056000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000006000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000001000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000006010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002b000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000006020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000056000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000007000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000001000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000007010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002b000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000007020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000056000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000008000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000001000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000008010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002c000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000008020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000056000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000009000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000001000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000009010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002c000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000009020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000056000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00000a000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000001000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00000a010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002c000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00000a020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000057000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00000b000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000001000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00000b010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002c000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00000b020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000057000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00000c000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000002000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00000c010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002c000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00000c020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000057000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00000d000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000002000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00000d010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002c000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00000d020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000057000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00000e000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000002000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00000e010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002d000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00000e020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000057000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00000f000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000002000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00000f010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002d000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00000f020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000057000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000010000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000002000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000010010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002d000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000010020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000058000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000011000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000002000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000011010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002d000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000011020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000058000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000012000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000003000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000012010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002d000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000012020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000058000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000013000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000003000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000013010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002d000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000013020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000058000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000014000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000003000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000014010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002e000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000014020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000058000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000015000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000003000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000015010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002e000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000015020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000058000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000016000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000003000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000016010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002e000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000016020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000059000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000017000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000003000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000017010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002e000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000017020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000059000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000018000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000004000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000018010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002e000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000018020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000059000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000019000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000004000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000019010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002e000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000019020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000059000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00001a000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000004000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00001a010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002f000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00001a020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000059000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00001b000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000004000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00001b010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002f000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00001b020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000059000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00001c000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000004000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00001c010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002f000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00001c020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005a000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00001d000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000004000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00001d010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002f000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00001d020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005a000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00001e000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000005000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00001e010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002f000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00001e020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005a000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00001f000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000005000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00001f010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002f000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00001f020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005a000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000020000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000005000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000020010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000030000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000020020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005a000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000021000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000005000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000021010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000030000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000021020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005a000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000022000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000005000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000022010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000030000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000022020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005b000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000023000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000005000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000023010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000030000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000023020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005b000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000024000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000006000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000024010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000030000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000024020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005b000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000025000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000006000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000025010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000030000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000025020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005b000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000026000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000006000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000026010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000031000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000026020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005b000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000027000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000006000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000027010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000031000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000027020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005b000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000028000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000006000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000028010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000031000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000028020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005c000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000029000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000006000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000029010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000031000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000029020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005c000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00002a000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000007000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00002a010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000031000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00002a020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005c000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00002b000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000007000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00002b010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000031000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00002b020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005c000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00002c000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000007000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00002c010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000032000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00002c020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005c000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00002d000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000007000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00002d010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000032000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00002d020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005c000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00002e000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000007000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00002e010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000032000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00002e020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005d000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00002f000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000007000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00002f010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000032000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00002f020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005d000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000030000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000008000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000030010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000032000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000030020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005d000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000031000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000008000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000031010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000032000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000031020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005d000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000032000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000008000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000032010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000033000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000032020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005d000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000033000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000008000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000033010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000033000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000033020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005d000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000034000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000008000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000034010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000033000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000034020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005e000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000035000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000008000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000035010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000033000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000035020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005e000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000036000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000009000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000036010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000033000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000036020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005e000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000037000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000009000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000037010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000033000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000037020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005e000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000038000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000009000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000038010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000034000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000038020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005e000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000039000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000009000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000039010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000034000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000039020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005e000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00003a000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000009000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00003a010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000034000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00003a020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005f000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00003b000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000009000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00003b010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000034000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00003b020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005f000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00003c000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000a000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00003c010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000034000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00003c020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005f000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00003d000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000a000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00003d010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000034000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00003d020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005f000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00003e000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000a000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00003e010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000035000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00003e020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005f000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00003f000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000a000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00003f010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000035000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00003f020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00005f000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000040000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000a000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000040010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000035000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000040020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000060000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000041000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000a000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000041010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000035000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000041020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000060000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000042000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000b000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000042010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000035000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000042020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000060000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000043000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000b000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000043010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000035000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000043020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000060000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000044000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000b000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000044010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000036000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000044020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000060000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000045000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000b000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000045010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000036000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000045020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000060000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000046000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000b000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000046010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000036000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000046020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000061000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000047000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000b000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000047010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000036000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000047020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000061000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000048000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000c000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000048010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000036000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000048020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000061000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000049000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000c000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000049010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000036000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000049020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000061000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00004a000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000c000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00004a010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000037000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00004a020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000061000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00004b000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000c000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00004b010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000037000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00004b020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000061000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00004c000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000c000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00004c010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000037000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00004c020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000062000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00004d000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000c000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00004d010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000037000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00004d020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000062000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00004e000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000d000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00004e010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000037000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00004e020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000062000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00004f000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000d000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00004f010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000037000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00004f020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000062000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000050000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000d000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000050010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000038000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000050020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000062000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000051000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000d000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000051010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000038000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000051020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000062000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000052000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000d000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000052010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000038000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000052020000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000063000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000053000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000d000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000053010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000038000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000053020000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000063000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000054000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000e000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000054010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000038000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000054020000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000063000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000055000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000e000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000055010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000038000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000055020000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000063000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000056000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000e000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000056010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000039000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000056020000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000063000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000057000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000e000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000057010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000039000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000057020000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000063000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000058000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000e000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000058010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000039000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000059000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000e000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000059010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000039000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00005a000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000f000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00005a010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000039000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00005b000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000f000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00005b010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000039000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00005c000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000f000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00005c010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003a000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00005d000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000f000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00005d010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003a000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00005e000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000f000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00005e010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003a000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00005f000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00000f000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00005f010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003a000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000060000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000010000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000060010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003a000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000061000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000010000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000061010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003a000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000062000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000010000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000062010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003b000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000063000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000010000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000063010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003b000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000064000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000010000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000064010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003b000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000065000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000010000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000065010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003b000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000066000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000011000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000066010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003b000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000067000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000011000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000067010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003b000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000068000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000011000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000068010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003c000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000069000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000011000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000069010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003c000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00006a000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000011000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00006a010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003c000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00006b000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000011000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00006b010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003c000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00006c000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000012000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00006c010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003c000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00006d000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000012000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00006d010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003c000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00006e000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000012000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00006e010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003d000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00006f000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000012000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00006f010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003d000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000070000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000012000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000070010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003d000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000071000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000012000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000071010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003d000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000072000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000013000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000072010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003d000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000073000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000013000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000073010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003d000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000074000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000013000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000074010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003e000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000075000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000013000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000075010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003e000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000076000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000013000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000076010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003e000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000077000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000013000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000077010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003e000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000078000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000014000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000078010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003e000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000079000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000014000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000079010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003e000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00007a000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000014000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00007a010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003f000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00007b000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000014000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00007b010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003f000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00007c000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000014000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00007c010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003f000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00007d000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000014000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00007d010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003f000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00007e000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000015000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00007e010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003f000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00007f000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000015000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00007f010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00003f000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000080000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000015000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000080010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000040000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000081000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000015000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000081010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000040000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000082000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000015000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000082010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000040000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000083000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000015000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000083010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000040000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000084000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000016000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000084010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000040000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000085000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000016000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000085010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000040000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000086000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000016000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000086010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000041000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000087000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000016000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000087010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000041000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000088000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000016000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000088010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000041000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000089000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000016000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000089010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000041000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00008a000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000017000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00008a010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000041000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00008b000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000017000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00008b010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000041000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00008c000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000017000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00008c010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000042000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00008d000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000017000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00008d010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000042000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00008e000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000017000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00008e010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000042000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00008f000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000017000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00008f010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000042000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000090000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000018000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000090010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000042000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000091000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000018000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000091010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000042000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000092000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000018000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000092010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000043000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000093000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000018000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000093010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000043000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000094000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000018000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000094010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000043000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000095000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000018000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000095010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000043000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000096000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000019000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000096010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000043000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-000097000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000019000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-000097010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000043000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-000098000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000019000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-000098010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000044000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-000099000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000019000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-000099010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000044000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00009a000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000019000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00009a010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000044000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00009b000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000019000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00009b010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000044000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00009c000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001a000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00009c010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000044000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-00009d000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001a000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-00009d010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000044000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-00009e000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001a000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-00009e010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000045000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-00009f000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001a000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-00009f010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000045000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000a0000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001a000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000a0010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000045000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000a1000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001a000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000a1010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000045000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000a2000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001b000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000a2010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000045000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000a3000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001b000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000a3010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000045000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000a4000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001b000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000a4010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000046000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000a5000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001b000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000a5010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000046000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000a6000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001b000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000a6010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000046000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000a7000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001b000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000a7010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000046000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000a8000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001c000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000a8010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000046000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000a9000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001c000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000a9010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000046000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000aa000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001c000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000aa010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000047000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000ab000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001c000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000ab010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000047000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000ac000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001c000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000ac010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000047000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000ad000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001c000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000ad010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000047000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000ae000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001d000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000ae010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000047000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000af000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001d000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000af010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000047000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000b0000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001d000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000b0010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000048000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000b1000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001d000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000b1010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000048000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000b2000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001d000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000b2010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000048000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000b3000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001d000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000b3010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000048000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000b4000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001e000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000b4010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000048000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000b5000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001e000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000b5010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000048000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000b6000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001e000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000b6010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000049000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000b7000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001e000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000b7010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000049000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000b8000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001e000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000b8010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000049000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000b9000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001e000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000b9010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000049000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000ba000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001f000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000ba010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000049000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000bb000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001f000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000bb010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000049000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000bc000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001f000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000bc010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004a000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000bd000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001f000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000bd010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004a000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000be000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001f000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000be010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004a000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000bf000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00001f000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000bf010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004a000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000c0000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000020000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000c0010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004a000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000c1000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000020000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000c1010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004a000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000c2000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000020000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000c2010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004b000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000c3000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000020000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000c3010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004b000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000c4000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000020000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000c4010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004b000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000c5000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000020000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000c5010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004b000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000c6000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000021000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000c6010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004b000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000c7000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000021000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000c7010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004b000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000c8000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000021000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000c8010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004c000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000c9000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000021000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000c9010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004c000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000ca000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000021000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000ca010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004c000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000cb000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000021000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000cb010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004c000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000cc000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000022000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000cc010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004c000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000cd000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000022000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000cd010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004c000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000ce000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000022000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000ce010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004d000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000cf000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000022000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000cf010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004d000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000d0000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000022000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000d0010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004d000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000d1000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000022000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000d1010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004d000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000d2000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000023000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000d2010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004d000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000d3000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000023000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000d3010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004d000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000d4000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000023000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000d4010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004e000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000d5000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000023000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000d5010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004e000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000d6000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000023000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000d6010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004e000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000d7000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000023000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000d7010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004e000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000d8000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000024000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000d8010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004e000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000d9000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000024000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000d9010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004e000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000da000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000024000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000da010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004f000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000db000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000024000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000db010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004f000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000dc000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000024000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000dc010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004f000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000dd000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000024000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000dd010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004f000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000de000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000025000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000de010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004f000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000df000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000025000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000df010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00004f000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000e0000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000025000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000e0010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000050000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000e1000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000025000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000e1010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000050000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000e2000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000025000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000e2010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000050000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000e3000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000025000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000e3010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000050000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000e4000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000026000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000e4010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000050000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000e5000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000026000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000e5010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000050000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000e6000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000026000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000e6010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000051000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000e7000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000026000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000e7010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000051000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000e8000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000026000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000e8010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000051000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000e9000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000026000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000e9010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000051000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000ea000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000027000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000ea010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000051000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000eb000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000027000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000eb010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000051000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000ec000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000027000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000ec010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000052000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000ed000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000027000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000ed010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000052000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000ee000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000027000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000ee010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000052000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000ef000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000027000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000ef010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000052000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000f0000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000028000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000f0010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000052000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000f1000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000028000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000f1010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000052000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000f2000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000028000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000f2010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000053000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000f3000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000028000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000f3010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000053000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000f4000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000028000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000f4010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000053000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000f5000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000028000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000f5010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000053000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000f6000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000029000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000f6010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000053000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000f7000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000029000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000f7010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000053000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000f8000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000029000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000f8010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000054000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000f9000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000029000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000f9010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000054000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000fa000000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000029000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000fa010000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000054000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000fb000000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000029000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000fb010000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000054000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000fc000000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002a000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000fc010000"), "Fold along the crease as shown in the diagram for step 5.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000054000000"), 5, "Step 5" },
                    { new Guid("70657473-0000-0000-0000-0000fd000000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002a000000"), 2, "Step 2" },
                    { new Guid("70657473-0000-0000-0000-0000fd010000"), "Fold along the crease as shown in the diagram for step 6.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000054000000"), 6, "Step 6" },
                    { new Guid("70657473-0000-0000-0000-0000fe000000"), "Fold along the crease as shown in the diagram for step 3.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002a000000"), 3, "Step 3" },
                    { new Guid("70657473-0000-0000-0000-0000fe010000"), "Fold along the crease as shown in the diagram for step 1.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000055000000"), 1, "Step 1" },
                    { new Guid("70657473-0000-0000-0000-0000ff000000"), "Fold along the crease as shown in the diagram for step 4.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-00002a000000"), 4, "Step 4" },
                    { new Guid("70657473-0000-0000-0000-0000ff010000"), "Fold along the crease as shown in the diagram for step 2.", "https://example.com/step.jpg", new Guid("00646f6d-0000-0000-0000-000055000000"), 2, "Step 2" }
                });

            migrationBuilder.InsertData(
                table: "OrigamiTags",
                columns: new[] { "OrigamiModelId", "TagId" },
                values: new object[,]
                {
                    { new Guid("00646f6d-0000-0000-0000-000000000000"), new Guid("00676174-0000-0000-0000-000000000000") },
                    { new Guid("00646f6d-0000-0000-0000-000000000000"), new Guid("00676174-0000-0000-0000-000001000000") },
                    { new Guid("00646f6d-0000-0000-0000-000001000000"), new Guid("00676174-0000-0000-0000-000001000000") },
                    { new Guid("00646f6d-0000-0000-0000-000001000000"), new Guid("00676174-0000-0000-0000-000002000000") },
                    { new Guid("00646f6d-0000-0000-0000-000002000000"), new Guid("00676174-0000-0000-0000-000002000000") },
                    { new Guid("00646f6d-0000-0000-0000-000002000000"), new Guid("00676174-0000-0000-0000-000003000000") },
                    { new Guid("00646f6d-0000-0000-0000-000003000000"), new Guid("00676174-0000-0000-0000-000003000000") },
                    { new Guid("00646f6d-0000-0000-0000-000003000000"), new Guid("00676174-0000-0000-0000-000004000000") },
                    { new Guid("00646f6d-0000-0000-0000-000004000000"), new Guid("00676174-0000-0000-0000-000004000000") },
                    { new Guid("00646f6d-0000-0000-0000-000004000000"), new Guid("00676174-0000-0000-0000-000005000000") },
                    { new Guid("00646f6d-0000-0000-0000-000005000000"), new Guid("00676174-0000-0000-0000-000005000000") },
                    { new Guid("00646f6d-0000-0000-0000-000005000000"), new Guid("00676174-0000-0000-0000-000006000000") },
                    { new Guid("00646f6d-0000-0000-0000-000006000000"), new Guid("00676174-0000-0000-0000-000006000000") },
                    { new Guid("00646f6d-0000-0000-0000-000006000000"), new Guid("00676174-0000-0000-0000-000007000000") },
                    { new Guid("00646f6d-0000-0000-0000-000007000000"), new Guid("00676174-0000-0000-0000-000007000000") },
                    { new Guid("00646f6d-0000-0000-0000-000007000000"), new Guid("00676174-0000-0000-0000-000008000000") },
                    { new Guid("00646f6d-0000-0000-0000-000008000000"), new Guid("00676174-0000-0000-0000-000008000000") },
                    { new Guid("00646f6d-0000-0000-0000-000008000000"), new Guid("00676174-0000-0000-0000-000009000000") },
                    { new Guid("00646f6d-0000-0000-0000-000009000000"), new Guid("00676174-0000-0000-0000-000009000000") },
                    { new Guid("00646f6d-0000-0000-0000-000009000000"), new Guid("00676174-0000-0000-0000-00000a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000a000000"), new Guid("00676174-0000-0000-0000-00000a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000a000000"), new Guid("00676174-0000-0000-0000-00000b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000b000000"), new Guid("00676174-0000-0000-0000-00000b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000b000000"), new Guid("00676174-0000-0000-0000-00000c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000c000000"), new Guid("00676174-0000-0000-0000-00000c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000c000000"), new Guid("00676174-0000-0000-0000-00000d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000d000000"), new Guid("00676174-0000-0000-0000-00000d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000d000000"), new Guid("00676174-0000-0000-0000-00000e000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000e000000"), new Guid("00676174-0000-0000-0000-00000e000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000e000000"), new Guid("00676174-0000-0000-0000-00000f000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000f000000"), new Guid("00676174-0000-0000-0000-00000f000000") },
                    { new Guid("00646f6d-0000-0000-0000-00000f000000"), new Guid("00676174-0000-0000-0000-000010000000") },
                    { new Guid("00646f6d-0000-0000-0000-000010000000"), new Guid("00676174-0000-0000-0000-000010000000") },
                    { new Guid("00646f6d-0000-0000-0000-000010000000"), new Guid("00676174-0000-0000-0000-000011000000") },
                    { new Guid("00646f6d-0000-0000-0000-000011000000"), new Guid("00676174-0000-0000-0000-000011000000") },
                    { new Guid("00646f6d-0000-0000-0000-000011000000"), new Guid("00676174-0000-0000-0000-000012000000") },
                    { new Guid("00646f6d-0000-0000-0000-000012000000"), new Guid("00676174-0000-0000-0000-000012000000") },
                    { new Guid("00646f6d-0000-0000-0000-000012000000"), new Guid("00676174-0000-0000-0000-000013000000") },
                    { new Guid("00646f6d-0000-0000-0000-000013000000"), new Guid("00676174-0000-0000-0000-000013000000") },
                    { new Guid("00646f6d-0000-0000-0000-000013000000"), new Guid("00676174-0000-0000-0000-000014000000") },
                    { new Guid("00646f6d-0000-0000-0000-000014000000"), new Guid("00676174-0000-0000-0000-000014000000") },
                    { new Guid("00646f6d-0000-0000-0000-000014000000"), new Guid("00676174-0000-0000-0000-000015000000") },
                    { new Guid("00646f6d-0000-0000-0000-000015000000"), new Guid("00676174-0000-0000-0000-000015000000") },
                    { new Guid("00646f6d-0000-0000-0000-000015000000"), new Guid("00676174-0000-0000-0000-000016000000") },
                    { new Guid("00646f6d-0000-0000-0000-000016000000"), new Guid("00676174-0000-0000-0000-000016000000") },
                    { new Guid("00646f6d-0000-0000-0000-000016000000"), new Guid("00676174-0000-0000-0000-000017000000") },
                    { new Guid("00646f6d-0000-0000-0000-000017000000"), new Guid("00676174-0000-0000-0000-000017000000") },
                    { new Guid("00646f6d-0000-0000-0000-000017000000"), new Guid("00676174-0000-0000-0000-000018000000") },
                    { new Guid("00646f6d-0000-0000-0000-000018000000"), new Guid("00676174-0000-0000-0000-000018000000") },
                    { new Guid("00646f6d-0000-0000-0000-000018000000"), new Guid("00676174-0000-0000-0000-000019000000") },
                    { new Guid("00646f6d-0000-0000-0000-000019000000"), new Guid("00676174-0000-0000-0000-000019000000") },
                    { new Guid("00646f6d-0000-0000-0000-000019000000"), new Guid("00676174-0000-0000-0000-00001a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001a000000"), new Guid("00676174-0000-0000-0000-00001a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001a000000"), new Guid("00676174-0000-0000-0000-00001b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001b000000"), new Guid("00676174-0000-0000-0000-00001b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001b000000"), new Guid("00676174-0000-0000-0000-00001c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001c000000"), new Guid("00676174-0000-0000-0000-00001c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001c000000"), new Guid("00676174-0000-0000-0000-00001d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001d000000"), new Guid("00676174-0000-0000-0000-00001d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001d000000"), new Guid("00676174-0000-0000-0000-00001e000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001e000000"), new Guid("00676174-0000-0000-0000-00001e000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001e000000"), new Guid("00676174-0000-0000-0000-00001f000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001f000000"), new Guid("00676174-0000-0000-0000-00001f000000") },
                    { new Guid("00646f6d-0000-0000-0000-00001f000000"), new Guid("00676174-0000-0000-0000-000020000000") },
                    { new Guid("00646f6d-0000-0000-0000-000020000000"), new Guid("00676174-0000-0000-0000-000020000000") },
                    { new Guid("00646f6d-0000-0000-0000-000020000000"), new Guid("00676174-0000-0000-0000-000021000000") },
                    { new Guid("00646f6d-0000-0000-0000-000021000000"), new Guid("00676174-0000-0000-0000-000021000000") },
                    { new Guid("00646f6d-0000-0000-0000-000021000000"), new Guid("00676174-0000-0000-0000-000022000000") },
                    { new Guid("00646f6d-0000-0000-0000-000022000000"), new Guid("00676174-0000-0000-0000-000022000000") },
                    { new Guid("00646f6d-0000-0000-0000-000022000000"), new Guid("00676174-0000-0000-0000-000023000000") },
                    { new Guid("00646f6d-0000-0000-0000-000023000000"), new Guid("00676174-0000-0000-0000-000023000000") },
                    { new Guid("00646f6d-0000-0000-0000-000023000000"), new Guid("00676174-0000-0000-0000-000024000000") },
                    { new Guid("00646f6d-0000-0000-0000-000024000000"), new Guid("00676174-0000-0000-0000-000024000000") },
                    { new Guid("00646f6d-0000-0000-0000-000024000000"), new Guid("00676174-0000-0000-0000-000025000000") },
                    { new Guid("00646f6d-0000-0000-0000-000025000000"), new Guid("00676174-0000-0000-0000-000025000000") },
                    { new Guid("00646f6d-0000-0000-0000-000025000000"), new Guid("00676174-0000-0000-0000-000026000000") },
                    { new Guid("00646f6d-0000-0000-0000-000026000000"), new Guid("00676174-0000-0000-0000-000026000000") },
                    { new Guid("00646f6d-0000-0000-0000-000026000000"), new Guid("00676174-0000-0000-0000-000027000000") },
                    { new Guid("00646f6d-0000-0000-0000-000027000000"), new Guid("00676174-0000-0000-0000-000027000000") },
                    { new Guid("00646f6d-0000-0000-0000-000027000000"), new Guid("00676174-0000-0000-0000-000028000000") },
                    { new Guid("00646f6d-0000-0000-0000-000028000000"), new Guid("00676174-0000-0000-0000-000028000000") },
                    { new Guid("00646f6d-0000-0000-0000-000028000000"), new Guid("00676174-0000-0000-0000-000029000000") },
                    { new Guid("00646f6d-0000-0000-0000-000029000000"), new Guid("00676174-0000-0000-0000-000029000000") },
                    { new Guid("00646f6d-0000-0000-0000-000029000000"), new Guid("00676174-0000-0000-0000-00002a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002a000000"), new Guid("00676174-0000-0000-0000-00002a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002a000000"), new Guid("00676174-0000-0000-0000-00002b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002b000000"), new Guid("00676174-0000-0000-0000-00002b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002b000000"), new Guid("00676174-0000-0000-0000-00002c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002c000000"), new Guid("00676174-0000-0000-0000-00002c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002c000000"), new Guid("00676174-0000-0000-0000-00002d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002d000000"), new Guid("00676174-0000-0000-0000-00002d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002d000000"), new Guid("00676174-0000-0000-0000-00002e000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002e000000"), new Guid("00676174-0000-0000-0000-00002e000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002e000000"), new Guid("00676174-0000-0000-0000-00002f000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002f000000"), new Guid("00676174-0000-0000-0000-00002f000000") },
                    { new Guid("00646f6d-0000-0000-0000-00002f000000"), new Guid("00676174-0000-0000-0000-000030000000") },
                    { new Guid("00646f6d-0000-0000-0000-000030000000"), new Guid("00676174-0000-0000-0000-000030000000") },
                    { new Guid("00646f6d-0000-0000-0000-000030000000"), new Guid("00676174-0000-0000-0000-000031000000") },
                    { new Guid("00646f6d-0000-0000-0000-000031000000"), new Guid("00676174-0000-0000-0000-000000000000") },
                    { new Guid("00646f6d-0000-0000-0000-000031000000"), new Guid("00676174-0000-0000-0000-000031000000") },
                    { new Guid("00646f6d-0000-0000-0000-000032000000"), new Guid("00676174-0000-0000-0000-000000000000") },
                    { new Guid("00646f6d-0000-0000-0000-000032000000"), new Guid("00676174-0000-0000-0000-000001000000") },
                    { new Guid("00646f6d-0000-0000-0000-000033000000"), new Guid("00676174-0000-0000-0000-000001000000") },
                    { new Guid("00646f6d-0000-0000-0000-000033000000"), new Guid("00676174-0000-0000-0000-000002000000") },
                    { new Guid("00646f6d-0000-0000-0000-000034000000"), new Guid("00676174-0000-0000-0000-000002000000") },
                    { new Guid("00646f6d-0000-0000-0000-000034000000"), new Guid("00676174-0000-0000-0000-000003000000") },
                    { new Guid("00646f6d-0000-0000-0000-000035000000"), new Guid("00676174-0000-0000-0000-000003000000") },
                    { new Guid("00646f6d-0000-0000-0000-000035000000"), new Guid("00676174-0000-0000-0000-000004000000") },
                    { new Guid("00646f6d-0000-0000-0000-000036000000"), new Guid("00676174-0000-0000-0000-000004000000") },
                    { new Guid("00646f6d-0000-0000-0000-000036000000"), new Guid("00676174-0000-0000-0000-000005000000") },
                    { new Guid("00646f6d-0000-0000-0000-000037000000"), new Guid("00676174-0000-0000-0000-000005000000") },
                    { new Guid("00646f6d-0000-0000-0000-000037000000"), new Guid("00676174-0000-0000-0000-000006000000") },
                    { new Guid("00646f6d-0000-0000-0000-000038000000"), new Guid("00676174-0000-0000-0000-000006000000") },
                    { new Guid("00646f6d-0000-0000-0000-000038000000"), new Guid("00676174-0000-0000-0000-000007000000") },
                    { new Guid("00646f6d-0000-0000-0000-000039000000"), new Guid("00676174-0000-0000-0000-000007000000") },
                    { new Guid("00646f6d-0000-0000-0000-000039000000"), new Guid("00676174-0000-0000-0000-000008000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003a000000"), new Guid("00676174-0000-0000-0000-000008000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003a000000"), new Guid("00676174-0000-0000-0000-000009000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003b000000"), new Guid("00676174-0000-0000-0000-000009000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003b000000"), new Guid("00676174-0000-0000-0000-00000a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003c000000"), new Guid("00676174-0000-0000-0000-00000a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003c000000"), new Guid("00676174-0000-0000-0000-00000b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003d000000"), new Guid("00676174-0000-0000-0000-00000b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003d000000"), new Guid("00676174-0000-0000-0000-00000c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003e000000"), new Guid("00676174-0000-0000-0000-00000c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003e000000"), new Guid("00676174-0000-0000-0000-00000d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003f000000"), new Guid("00676174-0000-0000-0000-00000d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00003f000000"), new Guid("00676174-0000-0000-0000-00000e000000") },
                    { new Guid("00646f6d-0000-0000-0000-000040000000"), new Guid("00676174-0000-0000-0000-00000e000000") },
                    { new Guid("00646f6d-0000-0000-0000-000040000000"), new Guid("00676174-0000-0000-0000-00000f000000") },
                    { new Guid("00646f6d-0000-0000-0000-000041000000"), new Guid("00676174-0000-0000-0000-00000f000000") },
                    { new Guid("00646f6d-0000-0000-0000-000041000000"), new Guid("00676174-0000-0000-0000-000010000000") },
                    { new Guid("00646f6d-0000-0000-0000-000042000000"), new Guid("00676174-0000-0000-0000-000010000000") },
                    { new Guid("00646f6d-0000-0000-0000-000042000000"), new Guid("00676174-0000-0000-0000-000011000000") },
                    { new Guid("00646f6d-0000-0000-0000-000043000000"), new Guid("00676174-0000-0000-0000-000011000000") },
                    { new Guid("00646f6d-0000-0000-0000-000043000000"), new Guid("00676174-0000-0000-0000-000012000000") },
                    { new Guid("00646f6d-0000-0000-0000-000044000000"), new Guid("00676174-0000-0000-0000-000012000000") },
                    { new Guid("00646f6d-0000-0000-0000-000044000000"), new Guid("00676174-0000-0000-0000-000013000000") },
                    { new Guid("00646f6d-0000-0000-0000-000045000000"), new Guid("00676174-0000-0000-0000-000013000000") },
                    { new Guid("00646f6d-0000-0000-0000-000045000000"), new Guid("00676174-0000-0000-0000-000014000000") },
                    { new Guid("00646f6d-0000-0000-0000-000046000000"), new Guid("00676174-0000-0000-0000-000014000000") },
                    { new Guid("00646f6d-0000-0000-0000-000046000000"), new Guid("00676174-0000-0000-0000-000015000000") },
                    { new Guid("00646f6d-0000-0000-0000-000047000000"), new Guid("00676174-0000-0000-0000-000015000000") },
                    { new Guid("00646f6d-0000-0000-0000-000047000000"), new Guid("00676174-0000-0000-0000-000016000000") },
                    { new Guid("00646f6d-0000-0000-0000-000048000000"), new Guid("00676174-0000-0000-0000-000016000000") },
                    { new Guid("00646f6d-0000-0000-0000-000048000000"), new Guid("00676174-0000-0000-0000-000017000000") },
                    { new Guid("00646f6d-0000-0000-0000-000049000000"), new Guid("00676174-0000-0000-0000-000017000000") },
                    { new Guid("00646f6d-0000-0000-0000-000049000000"), new Guid("00676174-0000-0000-0000-000018000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004a000000"), new Guid("00676174-0000-0000-0000-000018000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004a000000"), new Guid("00676174-0000-0000-0000-000019000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004b000000"), new Guid("00676174-0000-0000-0000-000019000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004b000000"), new Guid("00676174-0000-0000-0000-00001a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004c000000"), new Guid("00676174-0000-0000-0000-00001a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004c000000"), new Guid("00676174-0000-0000-0000-00001b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004d000000"), new Guid("00676174-0000-0000-0000-00001b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004d000000"), new Guid("00676174-0000-0000-0000-00001c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004e000000"), new Guid("00676174-0000-0000-0000-00001c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004e000000"), new Guid("00676174-0000-0000-0000-00001d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004f000000"), new Guid("00676174-0000-0000-0000-00001d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00004f000000"), new Guid("00676174-0000-0000-0000-00001e000000") },
                    { new Guid("00646f6d-0000-0000-0000-000050000000"), new Guid("00676174-0000-0000-0000-00001e000000") },
                    { new Guid("00646f6d-0000-0000-0000-000050000000"), new Guid("00676174-0000-0000-0000-00001f000000") },
                    { new Guid("00646f6d-0000-0000-0000-000051000000"), new Guid("00676174-0000-0000-0000-00001f000000") },
                    { new Guid("00646f6d-0000-0000-0000-000051000000"), new Guid("00676174-0000-0000-0000-000020000000") },
                    { new Guid("00646f6d-0000-0000-0000-000052000000"), new Guid("00676174-0000-0000-0000-000020000000") },
                    { new Guid("00646f6d-0000-0000-0000-000052000000"), new Guid("00676174-0000-0000-0000-000021000000") },
                    { new Guid("00646f6d-0000-0000-0000-000053000000"), new Guid("00676174-0000-0000-0000-000021000000") },
                    { new Guid("00646f6d-0000-0000-0000-000053000000"), new Guid("00676174-0000-0000-0000-000022000000") },
                    { new Guid("00646f6d-0000-0000-0000-000054000000"), new Guid("00676174-0000-0000-0000-000022000000") },
                    { new Guid("00646f6d-0000-0000-0000-000054000000"), new Guid("00676174-0000-0000-0000-000023000000") },
                    { new Guid("00646f6d-0000-0000-0000-000055000000"), new Guid("00676174-0000-0000-0000-000023000000") },
                    { new Guid("00646f6d-0000-0000-0000-000055000000"), new Guid("00676174-0000-0000-0000-000024000000") },
                    { new Guid("00646f6d-0000-0000-0000-000056000000"), new Guid("00676174-0000-0000-0000-000024000000") },
                    { new Guid("00646f6d-0000-0000-0000-000056000000"), new Guid("00676174-0000-0000-0000-000025000000") },
                    { new Guid("00646f6d-0000-0000-0000-000057000000"), new Guid("00676174-0000-0000-0000-000025000000") },
                    { new Guid("00646f6d-0000-0000-0000-000057000000"), new Guid("00676174-0000-0000-0000-000026000000") },
                    { new Guid("00646f6d-0000-0000-0000-000058000000"), new Guid("00676174-0000-0000-0000-000026000000") },
                    { new Guid("00646f6d-0000-0000-0000-000058000000"), new Guid("00676174-0000-0000-0000-000027000000") },
                    { new Guid("00646f6d-0000-0000-0000-000059000000"), new Guid("00676174-0000-0000-0000-000027000000") },
                    { new Guid("00646f6d-0000-0000-0000-000059000000"), new Guid("00676174-0000-0000-0000-000028000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005a000000"), new Guid("00676174-0000-0000-0000-000028000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005a000000"), new Guid("00676174-0000-0000-0000-000029000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005b000000"), new Guid("00676174-0000-0000-0000-000029000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005b000000"), new Guid("00676174-0000-0000-0000-00002a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005c000000"), new Guid("00676174-0000-0000-0000-00002a000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005c000000"), new Guid("00676174-0000-0000-0000-00002b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005d000000"), new Guid("00676174-0000-0000-0000-00002b000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005d000000"), new Guid("00676174-0000-0000-0000-00002c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005e000000"), new Guid("00676174-0000-0000-0000-00002c000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005e000000"), new Guid("00676174-0000-0000-0000-00002d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005f000000"), new Guid("00676174-0000-0000-0000-00002d000000") },
                    { new Guid("00646f6d-0000-0000-0000-00005f000000"), new Guid("00676174-0000-0000-0000-00002e000000") },
                    { new Guid("00646f6d-0000-0000-0000-000060000000"), new Guid("00676174-0000-0000-0000-00002e000000") },
                    { new Guid("00646f6d-0000-0000-0000-000060000000"), new Guid("00676174-0000-0000-0000-00002f000000") },
                    { new Guid("00646f6d-0000-0000-0000-000061000000"), new Guid("00676174-0000-0000-0000-00002f000000") },
                    { new Guid("00646f6d-0000-0000-0000-000061000000"), new Guid("00676174-0000-0000-0000-000030000000") },
                    { new Guid("00646f6d-0000-0000-0000-000062000000"), new Guid("00676174-0000-0000-0000-000030000000") },
                    { new Guid("00646f6d-0000-0000-0000-000062000000"), new Guid("00676174-0000-0000-0000-000031000000") },
                    { new Guid("00646f6d-0000-0000-0000-000063000000"), new Guid("00676174-0000-0000-0000-000000000000") },
                    { new Guid("00646f6d-0000-0000-0000-000063000000"), new Guid("00676174-0000-0000-0000-000031000000") }
                });

            migrationBuilder.CreateIndex(
                name: "IX_ShareLinks_CreationId1",
                table: "ShareLinks",
                column: "CreationId1");

            migrationBuilder.CreateIndex(
                name: "IX_OrigamiModels_CategoryId",
                table: "OrigamiModels",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_OrigamiModels_Slug",
                table: "OrigamiModels",
                column: "Slug",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_FeedPosts_CreationId1",
                table: "FeedPosts",
                column: "CreationId1");

            migrationBuilder.CreateIndex(
                name: "IX_FeedPosts_UserId1",
                table: "FeedPosts",
                column: "UserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Creations_OrigamiModelId1",
                table: "Creations",
                column: "OrigamiModelId1");

            migrationBuilder.CreateIndex(
                name: "IX_Creations_UserId1",
                table: "Creations",
                column: "UserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_UserId1",
                table: "Comments",
                column: "UserId1");

            migrationBuilder.CreateIndex(
                name: "IX_Categories_Slug",
                table: "Categories",
                column: "Slug",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CompletedModels_OrigamiModelId",
                table: "CompletedModels",
                column: "OrigamiModelId");

            migrationBuilder.CreateIndex(
                name: "IX_Favorites_OrigamiModelId",
                table: "Favorites",
                column: "OrigamiModelId");

            migrationBuilder.CreateIndex(
                name: "IX_OrigamiSteps_OrigamiModelId",
                table: "OrigamiSteps",
                column: "OrigamiModelId");

            migrationBuilder.CreateIndex(
                name: "IX_OrigamiTags_TagId",
                table: "OrigamiTags",
                column: "TagId");

            migrationBuilder.CreateIndex(
                name: "IX_RecentViews_OrigamiModelId",
                table: "RecentViews",
                column: "OrigamiModelId");

            migrationBuilder.CreateIndex(
                name: "IX_Tags_Name",
                table: "Tags",
                column: "Name",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Comments_Users_UserId1",
                table: "Comments",
                column: "UserId1",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId1",
                table: "Creations",
                column: "OrigamiModelId1",
                principalTable: "OrigamiModels",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Creations_Users_UserId1",
                table: "Creations",
                column: "UserId1",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_FeedPosts_Creations_CreationId1",
                table: "FeedPosts",
                column: "CreationId1",
                principalTable: "Creations",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_FeedPosts_Users_UserId1",
                table: "FeedPosts",
                column: "UserId1",
                principalTable: "Users",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_OrigamiModels_Categories_CategoryId",
                table: "OrigamiModels",
                column: "CategoryId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_ShareLinks_Creations_CreationId1",
                table: "ShareLinks",
                column: "CreationId1",
                principalTable: "Creations",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Comments_Users_UserId1",
                table: "Comments");

            migrationBuilder.DropForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId1",
                table: "Creations");

            migrationBuilder.DropForeignKey(
                name: "FK_Creations_Users_UserId1",
                table: "Creations");

            migrationBuilder.DropForeignKey(
                name: "FK_FeedPosts_Creations_CreationId1",
                table: "FeedPosts");

            migrationBuilder.DropForeignKey(
                name: "FK_FeedPosts_Users_UserId1",
                table: "FeedPosts");

            migrationBuilder.DropForeignKey(
                name: "FK_OrigamiModels_Categories_CategoryId",
                table: "OrigamiModels");

            migrationBuilder.DropForeignKey(
                name: "FK_ShareLinks_Creations_CreationId1",
                table: "ShareLinks");

            migrationBuilder.DropTable(
                name: "Categories");

            migrationBuilder.DropTable(
                name: "CompletedModels");

            migrationBuilder.DropTable(
                name: "Favorites");

            migrationBuilder.DropTable(
                name: "OrigamiSteps");

            migrationBuilder.DropTable(
                name: "OrigamiTags");

            migrationBuilder.DropTable(
                name: "RecentViews");

            migrationBuilder.DropTable(
                name: "Tags");

            migrationBuilder.DropIndex(
                name: "IX_ShareLinks_CreationId1",
                table: "ShareLinks");

            migrationBuilder.DropIndex(
                name: "IX_OrigamiModels_CategoryId",
                table: "OrigamiModels");

            migrationBuilder.DropIndex(
                name: "IX_OrigamiModels_Slug",
                table: "OrigamiModels");

            migrationBuilder.DropIndex(
                name: "IX_FeedPosts_CreationId1",
                table: "FeedPosts");

            migrationBuilder.DropIndex(
                name: "IX_FeedPosts_UserId1",
                table: "FeedPosts");

            migrationBuilder.DropIndex(
                name: "IX_Creations_OrigamiModelId1",
                table: "Creations");

            migrationBuilder.DropIndex(
                name: "IX_Creations_UserId1",
                table: "Creations");

            migrationBuilder.DropIndex(
                name: "IX_Comments_UserId1",
                table: "Comments");

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000000000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000001000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000002000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000003000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000004000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000005000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000006000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000007000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000008000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000009000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00000a000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00000b000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00000c000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00000d000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00000e000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00000f000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000010000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000011000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000012000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000013000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000014000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000015000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000016000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000017000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000018000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000019000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00001a000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00001b000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00001c000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00001d000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00001e000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00001f000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000020000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000021000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000022000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000023000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000024000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000025000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000026000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000027000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000028000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000029000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00002a000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00002b000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00002c000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00002d000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00002e000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00002f000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000030000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000031000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000032000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000033000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000034000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000035000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000036000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000037000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000038000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000039000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00003a000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00003b000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00003c000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00003d000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00003e000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00003f000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000040000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000041000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000042000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000043000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000044000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000045000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000046000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000047000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000048000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000049000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00004a000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00004b000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00004c000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00004d000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00004e000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00004f000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000050000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000051000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000052000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000053000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000054000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000055000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000056000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000057000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000058000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000059000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00005a000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00005b000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00005c000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00005d000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00005e000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-00005f000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000060000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000061000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000062000000"));

            migrationBuilder.DeleteData(
                table: "OrigamiModels",
                keyColumn: "Id",
                keyValue: new Guid("00646f6d-0000-0000-0000-000063000000"));

            migrationBuilder.DropColumn(
                name: "CreationId1",
                table: "ShareLinks");

            migrationBuilder.DropColumn(
                name: "CategoryId",
                table: "OrigamiModels");

            migrationBuilder.DropColumn(
                name: "CoverImageUrl",
                table: "OrigamiModels");

            migrationBuilder.DropColumn(
                name: "Materials",
                table: "OrigamiModels");

            migrationBuilder.DropColumn(
                name: "Slug",
                table: "OrigamiModels");

            migrationBuilder.DropColumn(
                name: "UpdatedAt",
                table: "OrigamiModels");

            migrationBuilder.DropColumn(
                name: "CreationId1",
                table: "FeedPosts");

            migrationBuilder.DropColumn(
                name: "UserId1",
                table: "FeedPosts");

            migrationBuilder.DropColumn(
                name: "OrigamiModelId1",
                table: "Creations");

            migrationBuilder.DropColumn(
                name: "UserId1",
                table: "Creations");

            migrationBuilder.DropColumn(
                name: "UserId1",
                table: "Comments");

            migrationBuilder.CreateTable(
                name: "LearningSteps",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ImageUrl = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    Instruction = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OrigamiModelId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    StepNumber = table.Column<int>(type: "int", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LearningSteps", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LearningSteps_OrigamiModels_OrigamiModelId",
                        column: x => x.OrigamiModelId,
                        principalTable: "OrigamiModels",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_LearningSteps_OrigamiModelId_StepNumber",
                table: "LearningSteps",
                columns: new[] { "OrigamiModelId", "StepNumber" },
                unique: true);
        }
    }
}
