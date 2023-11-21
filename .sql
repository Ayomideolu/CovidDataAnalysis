--creating a schema for the covid_data table
CREATE TABLE covid_data(
    sno INT,
    observationdate DATE,
    province VARCHAR(540),
    country VARCHAR(540),
    lastupdate VARCHAR(540),
    confirmed INT,
    deaths INT,
    recovered INT
);
