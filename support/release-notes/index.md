# AuraTrace Release Notes

A summary of the major highlights for First Release of AuraTrace Platform (AuraTrace v1.0.0) is displayed below.

| Module | Feature | Description |
| :--- | :--- | :--- |
| **QMS** | Document | **Documents Module** provides below capabilities:<ul><li>Create Document</li><li>Upload Document Versions</li><li>Document Workflow Approval</li><li>Upload Attachments & Download</li><li>View Workflow Timeline</li><li>Discussions & chat</li><li>Email Notifications at document level (for admin)</li><li>Workflow plan</li><li>Relationships & hierarchy</li><li>Annotations</li><li>Linked Docs</li></ul> |
| **LMS** | Courses & Curriculum | **Courses Module** provide below capabilities:<ul><li>Create Course<ul><li>Upload docs, Videos, SCORM content</li></ul></li><li>Workflow approvals</li><li>Create Assessments for course</li><li>Assign Courses</li><li>Relationships and hierarchy</li></ul>**Curriculum Module** provide below capabilities:<ul><li>Create Curriculum</li><li>Assign Curriculum</li></ul>**Learning Dashboard**<ul><li>Monitor progress of the courses assigned</li><li>Play courses, finish and review certificates</li></ul> |
| **Global** | Settings & Notifications | **User profile Settings**<ul><li>Set Time Zone</li><li>Set Language preference</li></ul>**Notifications Module**<br><br>**Login Page**<ul><li>Login with User credentials</li><li>Login with Azure Credentials</li></ul> |
| **Administration** | Admin | Administration Tab should allow for below features:<ul><li>**Users Tab**<ul><li>add / update Users</li><li>assign roles</li></ul></li><li>**Organizations Tab**<ul><li>add / update Organizations</li><li>assign users to organizations</li></ul></li><li>**Audit Trail**<ul><li>Display Audit trail for administration functions</li></ul></li><li>**Master Setup**<br>Display Master setup screens for:<ul><li>Global Master</li><li>Document Type Master</li><li>Product Type Master</li><li>Study Details Master</li><li>Regulatory Mapping Master</li></ul></li></ul>

## Notes for Release v1.0.1

The following changes, fixes, and features have been added since the initial v1.0.0 release.

| Module | Feature | Description |
| :--- | :--- | :--- |
| **QMS** | Document | **Feature:** While publishing a document, the **Effective Date** field is mandatory. When captured, Effective Date is shown on document download for published documents. For all published documents, Effective Date appears on the Document Detail page at the top of the document preview. |
| **LMS** | Courses & Curriculum | **Change:** Course description length corrected to accept longer course descriptions (1000+). |
| **LMS** | Courses & Curriculum | **Fix:** Course assignment date displays the correct selected date without timestamp or timezone discrepancy. |
| **QMS** | Document | **Change:** Document ID generation is performed at **Document Type** level, not **Document SubType** level. |
| **QMS** | Document | **Change:** A published document displays status as **Published**, and documents can be filtered by status **Published**. |
| **QMS** | Document | **Fix:** The **Notes** field in Document Edit mode is optional and does not show a required-field asterisk. |
| **QMS** | Document | **Change:** Attachment file name length corrected to accept longer names (200 characters). |
| **Administration** | Master Setup | **Change:** The Master Data screen displays **Department Code** when the field name is department. |
| **QMS** | Document | **Change:** The duplicate document warning toast message closes automatically. |
| **LMS** | Courses & Curriculum | **Fix:** SQL in the deployment pipeline corrected so GRANT permissions apply properly to LMS tables and functions. |
| **Administration** | Document Type Master | **Fix:** Document Type Master UI enforces **Doc Category code** as a mandatory field. |
| **Global** | Settings & Notifications | **Fix:** Users who do not have **Quality/documents** access cannot open the Quality tab or Documents tab from the menu. |
| **QMS** | Document | **Fix:** Improved PDF rendering in the UI when a large PDF file is uploaded. |
| **Global** | Approvals | **Fix:** Verdict option during Document Approval workflow and Course Approval workflow is **Approve** instead of **Approve Document**. |
| **Global** | Settings & Notifications | **Fix:** Organization switch from inside Documents or Courses shows a valid error message when the switch cannot complete. |
| **LMS** | Courses & Curriculum | **Fix:** On course assignment, an email using the correct template is sent to all assignees. |
| **QMS** | Document | **Feature:** Admin users can use **Republish** on an already published document that has a valid signature. The new Effective Date chosen during Republish appears on the document detail page and on the downloaded copy. The signature captured during Republish is not shown on the downloaded copy. |
| **QMS** | Document | **Fix:** **File Created Date** and **File Modified Date** in Document Edit mode do not show a required-field asterisk. |
| **LMS** | Courses & Curriculum | **Fix:** List-of-values options on the Course creation page can be controlled from the Admin master page. |
| **Administration** | Master Setup | **Fix:** When an administrator deletes records on master screens, document and course creation pages reflect the updated lists. |
