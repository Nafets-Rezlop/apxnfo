create or replace package pkg_nfo_feat_dml is
-- Generiert von pkg_nfo_tapi_gen (Muster: SQL Workshop > Methods on Tables)
--------------------------------------------------------------
-- merge procedure for table t_nfo_features
   procedure mrg (
      p_rec in out v_nfo_ui_features%rowtype,
      p_md5 in out varchar2);
--------------------------------------------------------------
-- delete procedure for table t_nfo_features
   procedure del (
      p_rec in     v_nfo_ui_features%rowtype);
--------------------------------------------------------------
-- get procedure for table t_nfo_features
   procedure get (
      p_rec in out v_nfo_ui_features%rowtype,
      p_md5 out    varchar2);
--------------------------------------------------------------
-- build MD5 function for table t_nfo_features
   function build_md5 (
      p_row in t_nfo_features%rowtype) return varchar2;
--------------------------------------------------------------
end pkg_nfo_feat_dml;
/

create or replace package body pkg_nfo_feat_dml is

--------------------------------------------------------------
-- merge procedure for table t_nfo_features
   procedure mrg (
      p_rec in out v_nfo_ui_features%rowtype,
      p_md5 in out varchar2)
   is
      l_row t_nfo_features%rowtype;
      l_md5 varchar2(32767);
   begin
      if p_rec.feat_id is null then
         -- leerer Primärschlüssel: INSERT (Anf. 1030)
         p_rec.feat_id := s_nfo_features_feat_id.nextval;
      else
         -- vorhandene Zeile sperren und Prüfsumme vergleichen
         begin
            select *
              into l_row
              from t_nfo_features
             where feat_id = p_rec.feat_id
               for update;

            l_md5 := build_md5(l_row);
            if p_md5 is not null and l_md5 != p_md5 then
               raise_application_error(-20001, 'Current version of data in database has changed since user initiated update process. current checksum = "'
                  || l_md5 || '", item checksum = "' || p_md5 || '".');
            end if;
         exception
            when no_data_found then
               null; -- Zeile gibt es noch nicht: MERGE fügt sie ein
         end;
      end if;

      merge into t_nfo_features tgt
      using (select p_rec.feat_id as feat_id from dual) src
         on (tgt.feat_id = src.feat_id)
      when matched then
         update set
            feat_rel_id                  = p_rec.feat_rel_id,
            feat_catg_id                 = p_rec.feat_catg_id,
            feat_chap_id                 = p_rec.feat_chap_id,
            feat_chapter_match_score     = p_rec.feat_chapter_match_score,
            feat_title                   = p_rec.feat_title,
            feat_raw_text_en             = p_rec.feat_raw_text_en,
            feat_summary_en              = p_rec.feat_summary_en,
            feat_summary_de              = p_rec.feat_summary_de,
            feat_link_feature_oracle_doc = p_rec.feat_link_feature_oracle_doc,
            feat_upd_date                = sysdate,
            feat_upd_user                = coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
      when not matched then
         insert (
            feat_id,
            feat_rel_id,
            feat_catg_id,
            feat_chap_id,
            feat_chapter_match_score,
            feat_title,
            feat_raw_text_en,
            feat_summary_en,
            feat_summary_de,
            feat_link_feature_oracle_doc,
            feat_ins_date,
            feat_ins_user
         ) values (
            src.feat_id,
            p_rec.feat_rel_id,
            p_rec.feat_catg_id,
            p_rec.feat_chap_id,
            p_rec.feat_chapter_match_score,
            p_rec.feat_title,
            p_rec.feat_raw_text_en,
            p_rec.feat_summary_en,
            p_rec.feat_summary_de,
            p_rec.feat_link_feature_oracle_doc,
            sysdate,
            coalesce(sys_context('APEX$SESSION', 'APP_USER'), sys_context('USERENV', 'SESSION_USER'))
         );

      select *
        into l_row
        from t_nfo_features
       where feat_id = p_rec.feat_id;
      p_md5 := build_md5(l_row);
   end mrg;

--------------------------------------------------------------
-- delete procedure for table t_nfo_features
   procedure del (
      p_rec in     v_nfo_ui_features%rowtype)
   is
   begin
      delete from t_nfo_features
       where feat_id = p_rec.feat_id;
   end del;

--------------------------------------------------------------
-- get procedure for table t_nfo_features
   procedure get (
      p_rec in out v_nfo_ui_features%rowtype,
      p_md5 out    varchar2)
   is
      l_id  v_nfo_ui_features.feat_id%type := p_rec.feat_id;
      l_row t_nfo_features%rowtype;
   begin
      select *
        into p_rec
        from v_nfo_ui_features
       where feat_id = l_id;

      select *
        into l_row
        from t_nfo_features
       where feat_id = l_id;
      p_md5 := build_md5(l_row);
   exception
      when no_data_found then
         p_md5 := null;
   end get;

--------------------------------------------------------------
-- build MD5 function for table t_nfo_features
   function build_md5 (
      p_row in t_nfo_features%rowtype) return varchar2
   is
   begin
      return apex_util.get_hash(
         p_values => apex_t_varchar2(
            to_char(p_row.feat_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.feat_rel_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.feat_catg_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.feat_chap_id, 'TM9', 'nls_numeric_characters=.,'),
            to_char(p_row.feat_chapter_match_score, 'TM9', 'nls_numeric_characters=.,'),
            p_row.feat_title,
            dbms_lob.getlength(p_row.feat_raw_text_en) || ':' || dbms_lob.substr(p_row.feat_raw_text_en, 8000, 1),
            p_row.feat_summary_en,
            p_row.feat_summary_de,
            p_row.feat_link_feature_oracle_doc,
            to_char(p_row.feat_ins_date, 'yyyymmddhh24miss'),
            p_row.feat_ins_user,
            to_char(p_row.feat_upd_date, 'yyyymmddhh24miss'),
            p_row.feat_upd_user),
         p_salted => true);
   end build_md5;

end pkg_nfo_feat_dml;
/
