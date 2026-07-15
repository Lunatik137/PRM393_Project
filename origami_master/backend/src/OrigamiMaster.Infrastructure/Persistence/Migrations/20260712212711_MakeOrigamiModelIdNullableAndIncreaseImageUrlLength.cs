using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OrigamiMaster.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class MakeOrigamiModelIdNullableAndIncreaseImageUrlLength : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId",
                table: "Creations");

            migrationBuilder.DropForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId1",
                table: "Creations");

            migrationBuilder.DropIndex(
                name: "IX_Creations_OrigamiModelId1",
                table: "Creations");

            migrationBuilder.DropColumn(
                name: "OrigamiModelId1",
                table: "Creations");

            migrationBuilder.AlterColumn<Guid>(
                name: "OrigamiModelId",
                table: "Creations",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AlterColumn<string>(
                name: "ImageUrl",
                table: "Creations",
                type: "nvarchar(2048)",
                maxLength: 2048,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(500)",
                oldMaxLength: 500);

            migrationBuilder.AddForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId",
                table: "Creations",
                column: "OrigamiModelId",
                principalTable: "OrigamiModels",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId",
                table: "Creations");

            migrationBuilder.AlterColumn<Guid>(
                name: "OrigamiModelId",
                table: "Creations",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ImageUrl",
                table: "Creations",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(2048)",
                oldMaxLength: 2048);

            migrationBuilder.AddColumn<Guid>(
                name: "OrigamiModelId1",
                table: "Creations",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Creations_OrigamiModelId1",
                table: "Creations",
                column: "OrigamiModelId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId",
                table: "Creations",
                column: "OrigamiModelId",
                principalTable: "OrigamiModels",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_Creations_OrigamiModels_OrigamiModelId1",
                table: "Creations",
                column: "OrigamiModelId1",
                principalTable: "OrigamiModels",
                principalColumn: "Id");
        }
    }
}
