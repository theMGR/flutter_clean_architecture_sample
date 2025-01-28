BEGIN;


--
-- MIGRATION VERSION FOR my_store_serverpod_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('my_store_serverpod_backend', '20250128132410453', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250128132410453', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
