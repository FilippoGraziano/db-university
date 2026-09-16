CREATE TABLE `dipartimenti_università`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(255) NOT NULL,
    `edificio` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `dipartimenti_università` ADD INDEX `dipartimenti_università_nome_index`(`nome`);
CREATE TABLE `corsi_per_dipartimento`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(255) NOT NULL,
    `dipartimento_id` BIGINT UNSIGNED NOT NULL
);
ALTER TABLE
    `corsi_per_dipartimento` ADD UNIQUE `corsi_per_dipartimento_dipartimento_id_unique`(`dipartimento_id`);
CREATE TABLE `materie_per_corso`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(255) NOT NULL,
    `CFU` TINYINT NOT NULL,
    `classe` TINYTEXT NOT NULL,
    `corso_id` BIGINT UNSIGNED NOT NULL
);
ALTER TABLE
    `materie_per_corso` ADD INDEX `materie_per_corso_nome_index`(`nome`);
ALTER TABLE
    `materie_per_corso` ADD UNIQUE `materie_per_corso_corso_id_unique`(`corso_id`);
CREATE TABLE `professori`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(255) NOT NULL,
    `stipendio` DECIMAL(4, 2) NOT NULL,
    `corso_id` BIGINT UNSIGNED NOT NULL,
    `materia_id` BIGINT UNSIGNED NOT NULL
);
ALTER TABLE
    `professori` ADD INDEX `professori_nome_index`(`nome`);
ALTER TABLE
    `professori` ADD UNIQUE `professori_corso_id_unique`(`corso_id`);
ALTER TABLE
    `professori` ADD UNIQUE `professori_materia_id_unique`(`materia_id`);
CREATE TABLE `esami`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `data_inizio` DATE NOT NULL,
    `data_fine` DATE NOT NULL,
    `materia_id` BIGINT UNSIGNED NOT NULL,
    `professore_id` BIGINT UNSIGNED NOT NULL
);
ALTER TABLE
    `esami` ADD UNIQUE `esami_materia_id_unique`(`materia_id`);
ALTER TABLE
    `esami` ADD UNIQUE `esami_professore_id_unique`(`professore_id`);
CREATE TABLE `studenti`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `borsa_di_studio` BOOLEAN NOT NULL DEFAULT 0,
    `telefono` VARCHAR(20) NOT NULL,
    `data_di_nascita` DATE NOT NULL,
    `anno_del_corso` TINYINT NOT NULL,
    `corso_id` BIGINT UNSIGNED NOT NULL
);
ALTER TABLE
    `studenti` ADD INDEX `studenti_nome_index`(`nome`);
ALTER TABLE
    `studenti` ADD INDEX `studenti_borsa_di_studio_index`(`borsa_di_studio`);
ALTER TABLE
    `studenti` ADD UNIQUE `studenti_corso_id_unique`(`corso_id`);
CREATE TABLE `appello_1`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `data_inzio` DATE NOT NULL,
    `data_fine` DATE NOT NULL,
    `esame_id` BIGINT UNSIGNED NOT NULL,
    `studente_id` BIGINT UNSIGNED NOT NULL,
    `voto` TINYINT NOT NULL
);
ALTER TABLE
    `appello_1` ADD UNIQUE `appello_1_esame_id_unique`(`esame_id`);
ALTER TABLE
    `appello_1` ADD UNIQUE `appello_1_studente_id_unique`(`studente_id`);
CREATE TABLE `appello_2`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `data_inzio` DATE NOT NULL,
    `data_fine` DATE NOT NULL,
    `esame_id` BIGINT UNSIGNED NOT NULL,
    `studente_id` BIGINT UNSIGNED NOT NULL,
    `voto` TINYINT NOT NULL
);
ALTER TABLE
    `appello_2` ADD UNIQUE `appello_2_esame_id_unique`(`esame_id`);
ALTER TABLE
    `appello_2` ADD UNIQUE `appello_2_studente_id_unique`(`studente_id`);
CREATE TABLE `appello_3`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `data_inizio` DATE NOT NULL,
    `data_fine` DATE NOT NULL,
    `esame_id` BIGINT UNSIGNED NOT NULL,
    `studente_id` BIGINT UNSIGNED NOT NULL,
    `voto` TINYINT NOT NULL
);
ALTER TABLE
    `appello_3` ADD UNIQUE `appello_3_esame_id_unique`(`esame_id`);
ALTER TABLE
    `appello_3` ADD UNIQUE `appello_3_studente_id_unique`(`studente_id`);
CREATE TABLE `studente_materia`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `studente_id` BIGINT UNSIGNED NOT NULL,
    `materia_id` BIGINT UNSIGNED NOT NULL
);
ALTER TABLE
    `studente_materia` ADD UNIQUE `studente_materia_studente_id_unique`(`studente_id`);
ALTER TABLE
    `studente_materia` ADD UNIQUE `studente_materia_materia_id_unique`(`materia_id`);
ALTER TABLE
    `professori` ADD CONSTRAINT `professori_id_foreign` FOREIGN KEY(`id`) REFERENCES `esami`(`professore_id`);
ALTER TABLE
    `corsi_per_dipartimento` ADD CONSTRAINT `corsi_per_dipartimento_dipartimento_id_foreign` FOREIGN KEY(`dipartimento_id`) REFERENCES `dipartimenti_università`(`id`);
ALTER TABLE
    `esami` ADD CONSTRAINT `esami_materia_id_foreign` FOREIGN KEY(`materia_id`) REFERENCES `materie_per_corso`(`id`);
ALTER TABLE
    `studenti` ADD CONSTRAINT `studenti_id_foreign` FOREIGN KEY(`id`) REFERENCES `appello_3`(`id`);
ALTER TABLE
    `professori` ADD CONSTRAINT `professori_corso_id_foreign` FOREIGN KEY(`corso_id`) REFERENCES `corsi_per_dipartimento`(`id`);
ALTER TABLE
    `studenti` ADD CONSTRAINT `studenti_id_foreign` FOREIGN KEY(`id`) REFERENCES `appello_1`(`studente_id`);
ALTER TABLE
    `studente_materia` ADD CONSTRAINT `studente_materia_studente_id_foreign` FOREIGN KEY(`studente_id`) REFERENCES `studenti`(`id`);
ALTER TABLE
    `professori` ADD CONSTRAINT `professori_materia_id_foreign` FOREIGN KEY(`materia_id`) REFERENCES `materie_per_corso`(`id`);
ALTER TABLE
    `esami` ADD CONSTRAINT `esami_id_foreign` FOREIGN KEY(`id`) REFERENCES `appello_2`(`esame_id`);
ALTER TABLE
    `esami` ADD CONSTRAINT `esami_id_foreign` FOREIGN KEY(`id`) REFERENCES `appello_1`(`esame_id`);
ALTER TABLE
    `studente_materia` ADD CONSTRAINT `studente_materia_materia_id_foreign` FOREIGN KEY(`materia_id`) REFERENCES `materie_per_corso`(`id`);
ALTER TABLE
    `studenti` ADD CONSTRAINT `studenti_id_foreign` FOREIGN KEY(`id`) REFERENCES `appello_2`(`id`);
ALTER TABLE
    `studenti` ADD CONSTRAINT `studenti_corso_id_foreign` FOREIGN KEY(`corso_id`) REFERENCES `corsi_per_dipartimento`(`id`);
ALTER TABLE
    `esami` ADD CONSTRAINT `esami_id_foreign` FOREIGN KEY(`id`) REFERENCES `appello_3`(`esame_id`);
ALTER TABLE
    `materie_per_corso` ADD CONSTRAINT `materie_per_corso_corso_id_foreign` FOREIGN KEY(`corso_id`) REFERENCES `corsi_per_dipartimento`(`id`);