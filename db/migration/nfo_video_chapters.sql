--------------------------------------------------------------------------------
-- Sprungmarken der Release-Videos (Anf. 220)
--
-- GENERIERT von md_chapters_to_sql.ps1 aus apex-new-features.md, nicht von
-- Hand aendern. Wiederholbar: vorhandene Sprungmarken (Link) werden
-- aktualisiert.
-- Voraussetzung: Videos sind geladen (nfo_release_videos.sql).
--------------------------------------------------------------------------------

whenever sqlerror exit failure
set define off
set serveroutput on size unlimited

-- ADB (Service HIGH): sonst ORA-12839 bei mehreren DML in einer Transaktion
alter session disable parallel dml;

declare
   procedure mrg_chapter (p_key in varchar2, p_seconds in number, p_title in varchar2) is
      l_rec v_nfo_ui_video_chapters%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.chap_link_url := 'https://youtu.be/' || p_key || '?t=' || p_seconds;
      begin
         select chap_id into l_rec.chap_id from t_nfo_video_chapters where chap_link_url = l_rec.chap_link_url;
         pkg_nfo_chap_dml.get(l_rec, l_md5);
      exception
         when no_data_found then
            null;
      end;
      select vid_id into l_rec.chap_vid_id from t_nfo_release_videos where vid_youtube_key = p_key;
      l_rec.chap_start_seconds := p_seconds;
      l_rec.chap_title         := p_title;
      pkg_nfo_chap_dml.mrg(l_rec, l_md5);
   exception
      when no_data_found then
         raise_application_error(-20100, 'Video ' || p_key || ' fehlt fuer Sprungmarke ' || p_seconds);
   end mrg_chapter;
begin
   mrg_chapter('ZbwxbnOhvG0', 0, q'[Welcome and Oracle APEX 26.2 overview]');
   mrg_chapter('ZbwxbnOhvG0', 420, q'[APEXlang enhancements]');
   mrg_chapter('ZbwxbnOhvG0', 1290, q'[Interactive Reports Modernization]');
   mrg_chapter('ZbwxbnOhvG0', 2235, q'[Chart performance and accessibility enhancements]');
   mrg_chapter('ZbwxbnOhvG0', 3600, q'[Closing remarks]');
   mrg_chapter('w31Et4XFq7g', 11, q'[Announcing Oracle APEX 26.1 - Marc Sewtz]');
   mrg_chapter('w31Et4XFq7g', 375, q'[Open Application Specification Language (APEXlang) - Marc Sewtz]');
   mrg_chapter('w31Et4XFq7g', 1081, q'[Natural Language Reporting with AI Interactive Reporting - Zed Ali]');
   mrg_chapter('w31Et4XFq7g', 1601, q'[Data Reporter - Christina Cho]');
   mrg_chapter('w31Et4XFq7g', 2039, q'[AI Agents and Tools - Stefan Dobre]');
   mrg_chapter('w31Et4XFq7g', 2581, q'[Redesigned Builder Interface and Universal Theme 26.1 - Paige Hanssen]');
   mrg_chapter('w31Et4XFq7g', 2875, q'[More on APEX 26.1 - Shakeeb Rahman]');
   mrg_chapter('w31Et4XFq7g', 3213, q'[Oracle APEX 26.1 - Getting Started - Marc Sewtz]');
   mrg_chapter('NNmUMd6c1-s', 228, q'[Introduction, Announcements and Updates - Jayson Hanes]');
   mrg_chapter('NNmUMd6c1-s', 375, q'[Getting Started with APEXlang - Scott Spendolini]');
   mrg_chapter('NNmUMd6c1-s', 2193, q'[Conclusion. Explore APEX Ideas and More Features in APEX 26.1 - Jayson Hanes]');
   mrg_chapter('Di3XLa9fjuA', 11, q'[Introduction, Announcements and Updates – Jayson Hanes]');
   mrg_chapter('Di3XLa9fjuA', 276, q'[Defining AI Agents and Configuring Them in APEX 26.1 – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 350, q'[Attachment Support and New Ability to Include File Attachments in AI Calls for Various Use Cases – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 599, q'[Demonstration – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 749, q'[Response Format for AI Agents – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 975, q'[Demonstration – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 1142, q'[AI Tools. Enhanced System Request Tools and New On-Demand Tools – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 1143, q'[AI Tools. Enhanced System Request Tools, Execution Points, On-Demand Parameters, Implementation and Tool Types, Architecture, User Confirmation and Notifications – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 2224, q'[Demonstration – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 3094, q'[AI Agents. Advanced: Request and Response Handlers – Stefan Dobre]');
   mrg_chapter('Di3XLa9fjuA', 3294, q'[Conclusion. Explore APEX Ideas and More Features in APEX 26.1 – Jayson Hanes]');
   mrg_chapter('P0kTt9agzG4', 43, q'[Announcements and Updates]');
   mrg_chapter('P0kTt9agzG4', 256, q'[What's New in Oracle APEX 24.2 - Marc Sewtz]');
   mrg_chapter('P0kTt9agzG4', 691, q'[Vector Search Support in Search Configurations - Roopesh Thokala]');
   mrg_chapter('P0kTt9agzG4', 1645, q'[AI Configuration with RAG Sources - Toufiq Mohammed]');
   mrg_chapter('P0kTt9agzG4', 2666, q'[Dynamic Action Generate Text With Gen AI - Alexis Galdamez]');
   mrg_chapter('P0kTt9agzG4', 3295, q'[Create Custom Data Models Using AI - Paige Hanssen]');
   mrg_chapter('Ue2YwUGoJIQ', 43, q'[Announcements and Updates]');
   mrg_chapter('Ue2YwUGoJIQ', 374, q'[Application Object Dependencies - Jeff Kemp]');
   mrg_chapter('Ue2YwUGoJIQ', 903, q'[Oracle Fusion Cloud Applications - Sonali Inamdar]');
   mrg_chapter('Ue2YwUGoJIQ', 1635, q'[REST Source Enhancements - Carsten Czarski]');
   mrg_chapter('Ue2YwUGoJIQ', 2342, q'[Select Many Improvements - Alexis Galdamez]');
   mrg_chapter('_mJ3rvAelPc', 38, q'[Announcements and Updates]');
   mrg_chapter('_mJ3rvAelPc', 251, q'[Document Generator Service Integration Enhancements - Menno Hoogendijk]');
   mrg_chapter('_mJ3rvAelPc', 556, q'[Faceted Search Enhancements - Ronny Weiss]');
   mrg_chapter('_mJ3rvAelPc', 1005, q'[Template Component Grouped Headers - Ronny Weiss]');
   mrg_chapter('_mJ3rvAelPc', 1369, q'[Workflow & Human Tasks Enhancements - Ananya Chatterjee]');
   mrg_chapter('_mJ3rvAelPc', 2361, q'[Delivered APEX Ideas- Vincent Morneau]');
   mrg_chapter('MbD8-ZBoCdE', 31, q'[Announcements and Updates]');
   mrg_chapter('MbD8-ZBoCdE', 286, q'[JSON Overview - Beda Hammerschmidt]');
   mrg_chapter('MbD8-ZBoCdE', 878, q'[JSON Demo - Julian Dontcheff]');
   mrg_chapter('MbD8-ZBoCdE', 1330, q'[APEX + JSON Demo - Carsten Czarski]');
   mrg_chapter('0F5Tu7xQuXE', 0, q'[Announcements and Updates]');
   mrg_chapter('0F5Tu7xQuXE', 360, q'[What's New in Oracle APEX 24.1 - Marc Sewtz]');
   mrg_chapter('0F5Tu7xQuXE', 1070, q'[Demo: AI-Assisted App Dev & AI-Powered Apps - Stefan Dobre]');
   mrg_chapter('0F5Tu7xQuXE', 1523, q'[Demo: Create Apps using Natural Language - Christina Cho]');
   mrg_chapter('0F5Tu7xQuXE', 2520, q'[Demo: Native DA & APIs - Stefan Dobre]');
   mrg_chapter('0F5Tu7xQuXE', 3786, q'[Roadmap - Ralf Müller]');
   mrg_chapter('i4y0BzPOfrs', 0, q'[Announcements & Updates]');
   mrg_chapter('i4y0BzPOfrs', 193, q'[Vector Search in 23ai - Toufiq Mohammed]');
   mrg_chapter('i4y0BzPOfrs', 1587, q'[New Select One and Select Many Item Types - Alexis Galdamez]');
   mrg_chapter('i4y0BzPOfrs', 2630, q'[Working Copies Enhancements - Paige Hanssen]');
   mrg_chapter('1vlp3DN1WlU', 0, q'[Announcements & Updates]');
   mrg_chapter('1vlp3DN1WlU', 248, q'[Improved Shared Component Subscriptions and Component Groups - Srihari Ravva]');
   mrg_chapter('1vlp3DN1WlU', 1377, q'[Workflow & Approval Enhancements - Ananya Chatterjee]');
   mrg_chapter('1vlp3DN1WlU', 2598, q'[Builder Extensions Enhancements - Christian Rokitta]');
   mrg_chapter('MCc3Z0FJado', 0, q'[Announcements & Updates]');
   mrg_chapter('MCc3Z0FJado', 368, q'[Generate PDF documents using the natively integrated Document Generator Service - Menno Hoogendijk]');
   mrg_chapter('MCc3Z0FJado', 1294, q'[Date Picker Support in Faceted Search and Smart Filters - Ronnie Weiss]');
   mrg_chapter('MCc3Z0FJado', 1758, q'[REST Souce Infrastructure: Support Nested JSON responses - Carsten Czarski]');
   mrg_chapter('JyY3p1R_ThQ', 310, q'[Introduction]');
   mrg_chapter('JyY3p1R_ThQ', 886, q'[Overview]');
   mrg_chapter('JyY3p1R_ThQ', 1762, q'[New Combobox]');
   mrg_chapter('JyY3p1R_ThQ', 2223, q'[Faceted Search Enhancements]');
   mrg_chapter('JyY3p1R_ThQ', 3034, q'[Custom Backgrounds for Maps]');
   mrg_chapter('JyY3p1R_ThQ', 3050, q'[Q&A]');
   mrg_chapter('eGfyj6zPkCM', 206, q'[Introduction]');
   mrg_chapter('eGfyj6zPkCM', 2692, q'[Workflow]');
   mrg_chapter('eGfyj6zPkCM', 2970, q'[Workflow Roadmap & Resources]');
   mrg_chapter('eGfyj6zPkCM', 3017, q'[Q&A]');
   mrg_chapter('5cmT8dFJkz0', 138, q'[Introduction]');
   mrg_chapter('5cmT8dFJkz0', 147, q'[Working Copy]');
   mrg_chapter('5cmT8dFJkz0', 789, q'[Builder Extensions]');
   mrg_chapter('5cmT8dFJkz0', 1869, q'[Shared Component Subscriptions]');
   mrg_chapter('5cmT8dFJkz0', 2776, q'[REST Data Source Improvements for Fusion Apps Extensions]');
   mrg_chapter('uATRJzB3VPc', 0, q'[Apex 23.2 overview]');
   mrg_chapter('uATRJzB3VPc', 224, q'[Universal theme updates]');
   mrg_chapter('uATRJzB3VPc', 1141, q'[Image upload component]');
   mrg_chapter('uATRJzB3VPc', 1617, q'[Static files in storage]');
   mrg_chapter('uATRJzB3VPc', 2448, q'[Rest Source catalog setup]');
   mrg_chapter('mBhGBjFa1V8', 0, q'[Introduction and updates]');
   mrg_chapter('mBhGBjFa1V8', 105, q'[Session agenda]');
   mrg_chapter('mBhGBjFa1V8', 190, q'[Team growth and events]');
   mrg_chapter('mBhGBjFa1V8', 350, q'[Resources and community]');
   mrg_chapter('mBhGBjFa1V8', 487, q'[Apex platform stats]');
   mrg_chapter('mBhGBjFa1V8', 612, q'[New object browser demo]');
   mrg_chapter('mBhGBjFa1V8', 742, q'[Database actions demo]');
   mrg_chapter('mBhGBjFa1V8', 1151, q'[Template components]');
   mrg_chapter('mBhGBjFa1V8', 1278, q'[PWA push notifications]');
   mrg_chapter('mBhGBjFa1V8', 1341, q'[Background page processing]');
   mrg_chapter('mBhGBjFa1V8', 1431, q'[REST and API improvements]');
   mrg_chapter('mBhGBjFa1V8', 1632, q'[General builder updates]');
   mrg_chapter('mBhGBjFa1V8', 1784, q'[Administration enhancements]');
   mrg_chapter('mBhGBjFa1V8', 1893, q'[Universal theme updates]');
   mrg_chapter('mBhGBjFa1V8', 1986, q'[Additional enhancements]');
   mrg_chapter('mBhGBjFa1V8', 2059, q'[Platform and library updates]');
   mrg_chapter('mBhGBjFa1V8', 2156, q'[Q&A and wrap up]');
   mrg_chapter('4ZRzLK4I6aY', 230, q'[Push Notifications and PWA Updates - Vincent Morneau]');
   mrg_chapter('4ZRzLK4I6aY', 1600, q'[APEX Administrator Digest - Andreea Munteanu]');
   mrg_chapter('4ZRzLK4I6aY', 2647, q'[Save and Run from Code Editor - Copy Pages from Create Page - Zsolt Angyal]');
   mrg_chapter('EsLoU7Jj-AU', 144, q'[Template Components - Menno Hoogendijk]');
   mrg_chapter('EsLoU7Jj-AU', 1307, q'[Universal Theme Updates - Paige Hanssen]');
   mrg_chapter('EsLoU7Jj-AU', 2564, q'[Upload and Download Themes in Theme Roller - Dalia Vasquez]');
   mrg_chapter('nWcSnj7eisU', 32, q'[Announcements: APEX 22.2 GA, upgrades on Autonomous DB]');
   mrg_chapter('nWcSnj7eisU', 213, q'[Vincent Morneau - PWA Updates: Overview]');
   mrg_chapter('nWcSnj7eisU', 304, q'[New Universal Theme "Item Container" template]');
   mrg_chapter('nWcSnj7eisU', 415, q'[PWA installability across browsers/devices (Firefox example)]');
   mrg_chapter('nWcSnj7eisU', 460, q'[Respecting browser support for PWA install prompts]');
   mrg_chapter('nWcSnj7eisU', 606, q'[PWA Sample App features + Compatibility matrix]');
   mrg_chapter('nWcSnj7eisU', 872, q'[PWA Sharing features (iOS Safari demo)]');
   mrg_chapter('nWcSnj7eisU', 1075, q'[Declarative meta tags for sharing; wrap-up of PWA features]');
   mrg_chapter('nWcSnj7eisU', 1125, q'[Q&A " Dynamic Actions, geolocation, APIs]');
   mrg_chapter('nWcSnj7eisU', 1165, q'[Future of offline features in APEX discussion]');
   mrg_chapter('nWcSnj7eisU', 1265, q'[Transition to Accessibility Features]');
   mrg_chapter('nWcSnj7eisU', 1407, q'[Landmarks (ARIA support, templates)]');
   mrg_chapter('nWcSnj7eisU', 1448, q'[Persisting landmarks across navigation; UT refresh]');
   mrg_chapter('nWcSnj7eisU', 2169, q'[New Template Directive support (reports, cards, IGs)]');
   mrg_chapter('nWcSnj7eisU', 2203, q'[Applying directives in HTML via apex.util.applyTemplate]');
   mrg_chapter('nWcSnj7eisU', 2532, q'[Developer Experience intro]');
   mrg_chapter('nWcSnj7eisU', 2560, q'[Dynamic Actions " naming actions for clarity]');
   mrg_chapter('nWcSnj7eisU', 2734, q'[Example: naming actions (Hide Commissions Chart)]');
   mrg_chapter('aRC6YuIqrUs', 0, q'[Introduction]');
   mrg_chapter('aRC6YuIqrUs', 95, q'[Market insights and growth]');
   mrg_chapter('aRC6YuIqrUs', 143, q'[Learning and certification]');
   mrg_chapter('aRC6YuIqrUs', 266, q'[Getting started with 22.2]');
   mrg_chapter('aRC6YuIqrUs', 339, q'[Application search feature]');
   mrg_chapter('aRC6YuIqrUs', 774, q'[Invoke API process type]');
   mrg_chapter('aRC6YuIqrUs', 868, q'[Approvals component update]');
   mrg_chapter('aRC6YuIqrUs', 1520, q'[Revamped date picker]');
   mrg_chapter('aRC6YuIqrUs', 2203, q'[Dynamic content region]');
   mrg_chapter('aRC6YuIqrUs', 2421, q'[CLOB session state support]');
   mrg_chapter('aRC6YuIqrUs', 2543, q'[PWA and mobile UX updates]');
   mrg_chapter('aRC6YuIqrUs', 3564, q'[Universal theme enhancements]');
   mrg_chapter('aRC6YuIqrUs', 3761, q'[Developer experience updates]');
   mrg_chapter('aRC6YuIqrUs', 4032, q'[Closing and resources]');
   mrg_chapter('wEByBTc_dp0', 0, q'[Welcome and Introduction]');
   mrg_chapter('wEByBTc_dp0', 457, q'[What's new in Oracle APEX 22.1]');
   mrg_chapter('wEByBTc_dp0', 536, q'[Demo: Approvals and Unified Task List]');
   mrg_chapter('wEByBTc_dp0', 851, q'[Flows for APEX - Open Source BPMN 2.0 Workflow (flowsforapex.org)]');
   mrg_chapter('wEByBTc_dp0', 900, q'[MySQL Support]');
   mrg_chapter('wEByBTc_dp0', 950, q'[SQL CL for Application Export and Import]');
   mrg_chapter('wEByBTc_dp0', 1000, q'[Data Generator]');
   mrg_chapter('wEByBTc_dp0', 1027, q'[Demo: Data Generator]');
   mrg_chapter('wEByBTc_dp0', 1387, q'[Developer Experience]');
   mrg_chapter('wEByBTc_dp0', 1571, q'[Demo: Developer Experience]');
   mrg_chapter('wEByBTc_dp0', 2363, q'[New and Updated Components]');
   mrg_chapter('wEByBTc_dp0', 2668, q'[Demo: Faceted Search Improvements]');
   mrg_chapter('wEByBTc_dp0', 2974, q'[Demo: PWA and Mobile Features]');
   mrg_chapter('wEByBTc_dp0', 3151, q'[PWA and Mobile Enhancements]');
   mrg_chapter('wEByBTc_dp0', 3224, q'[Demo: Application Icons and PWA Service Worker Configuration]');
   mrg_chapter('wEByBTc_dp0', 3304, q'[Additional Features]');
   mrg_chapter('wEByBTc_dp0', 3386, q'[JavaScript Library Upgrades]');
   mrg_chapter('wEByBTc_dp0', 3462, q'[Q&A]');
   mrg_chapter('TbBs_ZXro-g', 0, q'[Welcome and Introduction]');
   mrg_chapter('TbBs_ZXro-g', 152, q'[Demo: Approvals Component and Unified Task List]');
   mrg_chapter('TbBs_ZXro-g', 1232, q'[Data Generator – Demo]');
   mrg_chapter('TbBs_ZXro-g', 2006, q'[Faceted Search Enhancements – Demo]');
   mrg_chapter('TbBs_ZXro-g', 2356, q'[Tokenized Row Search & Faceted Search Enhancements]');
   mrg_chapter('TbBs_ZXro-g', 3343, q'[Session closure]');
   mrg_chapter('pbMfCECO3AU', 0, q'[Welcome and Introduction]');
   mrg_chapter('pbMfCECO3AU', 186, q'[Markdown & Rich Text Editor Enhancements]');
   mrg_chapter('pbMfCECO3AU', 1007, q'[Order By Page Item]');
   mrg_chapter('pbMfCECO3AU', 1571, q'[Enhancements for REST Enabled SQL]');
   mrg_chapter('pbMfCECO3AU', 2248, q'[Easy App Installs from the App Gallery]');
   mrg_chapter('pbMfCECO3AU', 3257, q'[Q&A]');
   mrg_chapter('7qklHBqKE3s', 0, q'[Welcome and Introduction]');
   mrg_chapter('7qklHBqKE3s', 91, q'[Useful links & Shortcuts]');
   mrg_chapter('7qklHBqKE3s', 281, q'[Code Editor Improvements]');
   mrg_chapter('7qklHBqKE3s', 816, q'[File URLs Enhancements]');
   mrg_chapter('7qklHBqKE3s', 1291, q'[Readable Export in JSON or YAML]');
   mrg_chapter('7qklHBqKE3s', 2680, q'[List Subscription]');
   mrg_chapter('7qklHBqKE3s', 3120, q'[Streamlined Create Page Wizards]');
   mrg_chapter('7qklHBqKE3s', 3780, q'[Workspace Files in Component Exports]');
   mrg_chapter('7qklHBqKE3s', 3840, q'[Q&A]');
   mrg_chapter('ZU2i9lSgOyk', 0, q'[Welcome and Introduction]');
   mrg_chapter('ZU2i9lSgOyk', 190, q'[Persistent Authentication]');
   mrg_chapter('ZU2i9lSgOyk', 1404, q'[Customizing your PWA Service Worker]');
   mrg_chapter('ZU2i9lSgOyk', 2474, q'[APEX DevTools Updates & Session Overrides]');
   mrg_chapter('ZU2i9lSgOyk', 2899, q'[Application Icons]');
   mrg_chapter('ZU2i9lSgOyk', 3186, q'[Demo: Improvements to Region Images]');
   mrg_chapter('ZU2i9lSgOyk', 4022, q'[Demo: Utility Class u-lineclamp]');
   mrg_chapter('ZU2i9lSgOyk', 4263, q'[Universal Theme Updates]');
   mrg_chapter('9Wt2QtM6SDk', 0, q'[Announcements and updates]');
   mrg_chapter('9Wt2QtM6SDk', 172, q'[Introduction to F1 demo]');
   mrg_chapter('9Wt2QtM6SDk', 308, q'[Building the PWA]');
   mrg_chapter('9Wt2QtM6SDk', 728, q'[PWA runtime and features]');
   mrg_chapter('9Wt2QtM6SDk', 1217, q'[Drawers and UX]');
   mrg_chapter('9Wt2QtM6SDk', 1333, q'[Theme configuration]');
   mrg_chapter('9Wt2QtM6SDk', 1522, q'[New position system]');
   mrg_chapter('9Wt2QtM6SDk', 1825, q'[Smart filters integration]');
   mrg_chapter('9Wt2QtM6SDk', 2020, q'[Page designer improvements]');
   mrg_chapter('9Wt2QtM6SDk', 2499, q'[Maps and spatial features]');
   mrg_chapter('9Wt2QtM6SDk', 3771, q'[Mini-map widget]');
   mrg_chapter('9Wt2QtM6SDk', 4010, q'[PWA caching and offline]');
   mrg_chapter('9Wt2QtM6SDk', 4497, q'[PWA installation demo]');
   mrg_chapter('9Wt2QtM6SDk', 5015, q'[Q&A and conclusion]');
   mrg_chapter('QVPGnb0UsZY', 410, q'[What's New in APEX 21.1]');
   mrg_chapter('QVPGnb0UsZY', 995, q'[UI and Theme Updates]');
   mrg_chapter('QVPGnb0UsZY', 1570, q'[Maps Region]');
   mrg_chapter('QVPGnb0UsZY', 2255, q'[New Application Data Loading]');
   mrg_chapter('QVPGnb0UsZY', 2896, q'[Faceted Search Enhancements]');
   mrg_chapter('QVPGnb0UsZY', 3705, q'[Native Markdown Support]');
   mrg_chapter('QVPGnb0UsZY', 4234, q'[Remembering Joel R. Kallman]');
   mrg_chapter('fYq-6Jd_4No', 0, q'[Introduction and updates]');
   mrg_chapter('fYq-6Jd_4No', 181, q'[Redwood theme style]');
   mrg_chapter('fYq-6Jd_4No', 388, q'[New cards region]');
   mrg_chapter('fYq-6Jd_4No', 1118, q'[Faceted search features]');
   mrg_chapter('fYq-6Jd_4No', 1893, q'[Native report printing]');
   mrg_chapter('fYq-6Jd_4No', 2480, q'[REST data source updates]');
   mrg_chapter('fYq-6Jd_4No', 3720, q'[Conclusion]');
   mrg_chapter('b9MEa5Idd1s', 0, q'[Introduction]');
   mrg_chapter('b9MEa5Idd1s', 147, q'[Fastest search enhancements]');
   mrg_chapter('b9MEa5Idd1s', 623, q'[Friendly URLs]');
   mrg_chapter('b9MEa5Idd1s', 945, q'[URL Filtering]');
   mrg_chapter('b9MEa5Idd1s', 1261, q'[Remote Application Deployment]');
   mrg_chapter('b9MEa5Idd1s', 1660, q'[Export Application as ZIP File]');
   mrg_chapter('b9MEa5Idd1s', 1981, q'[Manage Backups]');
   mrg_chapter('b9MEa5Idd1s', 2273, q'[Object Storage]');
   mrg_chapter('b9MEa5Idd1s', 2331, q'[Load from Cloud]');
   mrg_chapter('b9MEa5Idd1s', 2559, q'[Service Level Control]');
   mrg_chapter('b9MEa5Idd1s', 2648, q'[Region Level Control]');
   mrg_chapter('b9MEa5Idd1s', 3023, q'[Redwood Theme]');
   mrg_chapter('b9MEa5Idd1s', 3498, q'[Outro]');
end;
/

commit;

select v.rel_version, v.vid_youtube_key, count(c.chap_id) as chapters
  from v_nfo_ui_release_videos v
  left join v_nfo_ui_video_chapters c
    on c.chap_vid_id = v.vid_id
 group by v.rel_version, v.vid_youtube_key
 order by v.rel_version desc, v.vid_youtube_key;
