BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "activity" (
    "id" bigserial PRIMARY KEY,
    "boardId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "cardId" bigint NOT NULL,
    "description" text NOT NULL,
    "dateCreated" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "attachment" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "cardId" bigint NOT NULL,
    "attachment" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "board" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "visibility" text NOT NULL,
    "background" text,
    "starred" boolean,
    "enableCover" boolean,
    "watch" boolean,
    "availableOffline" boolean,
    "label" text,
    "emailAddress" text,
    "commenting" bigint,
    "memberType" boolean,
    "pinned" boolean,
    "selfJoin" boolean,
    "close" boolean
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "card" (
    "id" bigserial PRIMARY KEY,
    "listId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "startDate" timestamp without time zone,
    "dueDate" timestamp without time zone,
    "attachment" boolean,
    "archived" boolean,
    "checklist" boolean,
    "comments" boolean
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "checklist" (
    "id" bigserial PRIMARY KEY,
    "cardId" bigint NOT NULL,
    "name" text NOT NULL,
    "status" boolean NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment" (
    "id" bigserial PRIMARY KEY,
    "cardId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "description" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "listboard" (
    "id" bigserial PRIMARY KEY,
    "boardId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "archived" boolean
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mobile_auth" (
    "id" bigserial PRIMARY KEY,
    "phone" text,
    "otp" text,
    "token" text,
    "otpExpiration" timestamp without time zone,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "table" (
    "id" bigserial PRIMARY KEY,
    "workspaceId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "role" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "password" text NOT NULL,
    "handle" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workspace" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "handle" text NOT NULL,
    "visibility" text NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "activity"
    ADD CONSTRAINT "activity_fk_0"
    FOREIGN KEY("boardId")
    REFERENCES "board"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "activity"
    ADD CONSTRAINT "activity_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "activity"
    ADD CONSTRAINT "activity_fk_2"
    FOREIGN KEY("cardId")
    REFERENCES "card"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "attachment"
    ADD CONSTRAINT "attachment_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "attachment"
    ADD CONSTRAINT "attachment_fk_1"
    FOREIGN KEY("cardId")
    REFERENCES "card"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "board"
    ADD CONSTRAINT "board_fk_0"
    FOREIGN KEY("workspaceId")
    REFERENCES "workspace"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "board"
    ADD CONSTRAINT "board_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "card"
    ADD CONSTRAINT "card_fk_0"
    FOREIGN KEY("listId")
    REFERENCES "listboard"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "card"
    ADD CONSTRAINT "card_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "checklist"
    ADD CONSTRAINT "checklist_fk_0"
    FOREIGN KEY("cardId")
    REFERENCES "card"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_0"
    FOREIGN KEY("cardId")
    REFERENCES "card"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "listboard"
    ADD CONSTRAINT "listboard_fk_0"
    FOREIGN KEY("boardId")
    REFERENCES "board"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "listboard"
    ADD CONSTRAINT "listboard_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "table"
    ADD CONSTRAINT "table_fk_0"
    FOREIGN KEY("workspaceId")
    REFERENCES "workspace"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "table"
    ADD CONSTRAINT "table_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "workspace"
    ADD CONSTRAINT "workspace_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR my_store_serverpod_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('my_store_serverpod_backend', '20250128112710770', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250128112710770', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
