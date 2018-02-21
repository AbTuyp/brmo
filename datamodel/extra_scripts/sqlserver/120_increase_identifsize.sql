alter table ander_btnlnds_niet_nat_prs drop constraint ander_btnlnds_niet_nat_prs_pk;
alter table ander_btnlnds_niet_nat_prs drop constraint fk_ann_sc;
alter table ander_nat_prs drop constraint ander_nat_prs_pk;

alter table ander_btnlnds_niet_nat_prs alter column sc_identif varchar(255) not null;
alter table ander_nat_prs alter column sc_identif varchar(255) not null;

alter table app_re alter column fk_2nnp_sc_identif varchar(255);
alter table ingeschr_niet_nat_prs alter column sc_identif varchar(255);
alter table ingeschr_nat_prs alter column sc_identif varchar(255);
alter table ingezetene alter column sc_identif varchar(255);
alter table kad_onrrnd_zk alter column fk_10pes_sc_identif varchar(255);
alter table kad_onrrnd_zk_aantek alter column fk_5pes_sc_identif varchar(255);
alter table maatschapp_activiteit alter column fk_4pes_sc_identif varchar(255);
alter table nat_prs alter column sc_identif varchar(255);
alter table niet_ingezetene alter column sc_identif varchar(255);
alter table niet_nat_prs alter column sc_identif varchar(255);
alter table prs alter column  sc_identif varchar(255);
alter table subject alter column identif varchar(255);
alter table vestg alter column  sc_identif varchar(255);
alter table vestg alter column fk_18ves_sc_identif varchar(255);
alter table zak_recht alter column fk_8pes_sc_identif varchar(255);
alter table zak_recht_aantek alter column fk_6pes_sc_identif varchar(255);
alter table vestg_naam alter column fk_ves_sc_identif varchar(255);
alter table huishoudenrel alter column fk_sc_lh_inp_sc_identif varchar(255);
alter table huw_ger_partn alter column fk_sc_lh_inp_sc_identif varchar(255);
alter table huw_ger_partn alter column fk_sc_rh_inp_sc_identif varchar(255);
alter table ouder_kind_rel alter column fk_sc_lh_inp_sc_identif varchar(255);
alter table ouder_kind_rel alter column fk_sc_rh_inp_sc_identif varchar(255);
alter table rsdoc_ingeschr_nat_prs alter column fk_nn_rh_inp_sc_identif varchar(255);
alter table vestg_benoemd_obj alter column fk_nn_lh_ves_sc_identif varchar(255);

alter table ander_btnlnds_niet_nat_prs add constraint ander_btnlnds_niet_nat_prs_pk primary key clustered(sc_identif);
alter table ander_btnlnds_niet_nat_prs add constraint fk_ann_sc foreign key (sc_identif) references niet_nat_prs (sc_identif) on delete no action;
alter table ander_nat_prs add constraint ander_nat_prs_pk primary key clustered(sc_identif);

GO
