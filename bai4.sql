CREATE DATABASE ss11;
USE ss11;

DELIMITER //

CREATE PROCEDURE GetPatientDebt(
    IN p_patient_id INT,
    IN p_phone VARCHAR(20),
    OUT p_total_debt DECIMAL(12,2),
    OUT p_message VARCHAR(100)
)

BEGIN

    IF p_patient_id IS NULL AND p_phone IS NULL THEN

        SET p_total_debt = 0;
        SET p_message = 'Lỗi: Vui lòng nhập ID hoặc số điện thoại';

    ELSE

        IF p_patient_id IS NOT NULL THEN

            SELECT total_debt
            INTO p_total_debt
            FROM Patients
            WHERE patient_id = p_patient_id
            LIMIT 1;

        ELSE

            SELECT total_debt
            INTO p_total_debt
            FROM Patients
            WHERE phone = p_phone
            LIMIT 1;

        END IF;

        IF p_total_debt IS NULL THEN

            SET p_total_debt = 0;
            SET p_message = 'Không tìm thấy bệnh nhân';

        ELSE

            SET p_message = 'Tra cứu thành công';

        END IF;

    END IF;

END //

CALL GetPatientDebt(
    1,
    NULL,
    @debt,
    @msg
);

CALL GetPatientDebt(
    NULL,
    '0912222333',
    @debt,
    @msg
);

SELECT @debt, @msg;

CALL GetPatientDebt(
    NULL,
    NULL,
    @debt,
    @msg
);

SELECT @debt, @msg;

CALL GetPatientDebt(
    999,
    NULL,
    @debt,
    @msg
);

SELECT @debt, @msg;
