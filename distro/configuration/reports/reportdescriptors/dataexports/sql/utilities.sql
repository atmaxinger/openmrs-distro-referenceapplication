DELIMITER $$
CREATE PROCEDURE my_del_concept (IN tb_deleted_id int)
BEGIN
DELETE FROM concept_numeric       WHERE concept_id = tb_deleted_id ;
DELETE FROM concept_complex       WHERE concept_id = tb_deleted_id ;
DELETE FROM concept_proposal      WHERE concept_id = tb_deleted_id ;
DELETE FROM concept_set           WHERE concept_id = tb_deleted_id  OR concept_set = tb_deleted_id ;
DELETE FROM concept_name          WHERE concept_id = tb_deleted_id ;
DELETE FROM concept_description               WHERE concept_id = tb_deleted_id ;
DELETE FROM concept               WHERE concept_id = tb_deleted_id ;
END $$
DELIMITER ;


