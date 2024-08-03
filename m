Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9AA9467F8
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2024 08:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722665639;
	bh=G5I/Or90pEnxy6qSY7ZzwlvooYFF5l9rtX2ozxlkuDo=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=KBGrYTa32BDbR+LYQ33+xQ3Oabcq5vY/AOiK7r2hr++77AAkRiWBumKlrdooECrCZ
	 B3Wj9+NEyGzVKvNU2z/9XTKgHQPRvlV2mE1+6klx7QAPeMONm8QpAB9jKZnDL0tSSv
	 S4030e4a8EMylVncXKB6mHPGf/0a29th6+QoDXMYosoCoBw8xfF6+K8WLnnr94mY+E
	 w6G/zrrG28Xh/blJ7Ay2oI+wCdsf1VnlENdNm9UyRyvDBeH3Qce/Vg+Rd9wtmq2Xyp
	 ShNjk34QGPbnAfUBYzmTzwNVKaReNEs0Y+R5BFmEvIyGKl2Fjfo1s66vNF6u2Vq0xe
	 cAERmD3xxSi/A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WbXTM14LRz3fRv
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2024 16:13:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UA6bnivr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.155; helo=out203-205-221-155.mail.qq.com; envelope-from=sa.z@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WbXT75lm7z3cSd
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Aug 2024 16:13:38 +1000 (AEST)
Received: from localhost.localdomain ([183.251.16.112])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 319964E2; Sat, 03 Aug 2024 14:12:25 +0800
X-QQ-mid: xmsmtpt1722665545t235flg13
Message-ID: <tencent_D2D2D1318B8D89A956A20FC7ED85F4778E0A@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zdl6jP6LpETjhfE4OFkLcA+dX64AvtfxyUzok4zYAtYIjmufob2
	 AeWgIDR0rxwhGqWNoA8YMHCcyzxPIr6Gci767Y7zDOgTBGuG4HEU5SkD7KhVrHFQdDB5vrkMl4yg
	 XdIC9kNsYdKkDl0JWJdrkfvJHJDDVfl4XiqfEcuzHZKdA3D2l3uhYXDdbyugx8XLts5C1TPFBfPe
	 Xf3Imv1RuwXwGBEUeQnOHgCxgtk8intUPjgddD+gfJgCoC3aJ/4qnjsW1EWhOc4zC+91/GXkEU8I
	 j2DU65fxF5s5xjKCbJyqShnJ2rNf8mwJ4+wztjl1WXKFmzYDTCzYzesazlJesIZ3u8DsQzE2Xvte
	 Sh6vihLN9/4dWnXWmVfZ88Zc0G2inqzwlG01ImNGVjNz063fPu6vUYKnXot1T0kuHM88gfmyjcpl
	 M/0adUsleGxtZonYs+ddm13ZCampXNDSzeilr6wiJWV9hup5e8ertO9KimOz+1annyDHCMDcqkhc
	 MQz3LFzgC3zJk6Lg4b4DCMpisRIZ5D5nqcBIEMPuh34rgnUYskEHloUgxxij0NFrbpTyNV80idqH
	 398bEFfq+TyNOx3m41zPUTbsIvyExQlkzHefvsy47iT/YJPoP3+0dDwMwshT2YhcXJDPCt+xLqgh
	 x1CqXCU52smR7u5TR7w05xsl9BxLccRh/qgeAkwSYKTk4SUzzynDiHrCp9gDDRWvKBy1jlxas+jW
	 577+R1qkxEfTmHgTJ3stK2x958pq3UjWn9hHv380MWJ/zD/DIwPPt/U93bstWiMhZtyg3jCoFfZJ
	 hIs1r8ZjdItBj4QM4k0hfTgqLe/lvJIbc2zTluxQe1Tm+dXsPPIUbsiqSua1/XzCoEsex5e5GmvN
	 vxlPzkSGbagKqiYyUnfYcGgNSqzQqIc1gz7/ahu5dWsPwqxuaQOK02My/nZeaLWXqSmLUNgObY
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add OCI registry support
Date: Sat,  3 Aug 2024 14:12:06 +0800
X-OQ-MSGID: <20240803061206.1154-1-sa.z@qq.com>
X-Mailer: git-send-email 2.44.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: saz97 via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: saz97 <sa.z@qq.com>
Cc: saz97 <sa.z@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds support for handling OCI registry operations in EROFS.
The following functionalities are included:

 1. `oci_registry_read`: Reads data from the OCI registry.
 2. `oci_registry_pread`: Reads data from a specified offset.
 3. `oci_registry_lseek`: Adjusts the file offset.
 4. `open_oci_registry`: handle the opening of the OCI registry.

Signed-off-by: Changzhi Xie <sa.z@qq.com>
---
 lib/oci_registry.c | 595 +++++++++++++++++++++++++++++++++++++++++++++
 lib/oci_registry.h |  17 ++
 2 files changed, 612 insertions(+)
 create mode 100644 lib/oci_registry.c
 create mode 100644 lib/oci_registry.h

diff --git a/lib/oci_registry.c b/lib/oci_registry.c
new file mode 100644
index 0000000..fd4f6d5
--- /dev/null
+++ b/lib/oci_registry.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+
+#include "oci_registry.h"
+
+#define erofs_token_mode 1
+#define erofs_image_index_mode 2
+#define erofs_manifest_mode 3
+#define erofs_blob_mode 4
+
+#define docker_auth_url \
+"https://auth.docker.io/token?service=registry.docker.io&scope=repository:library/%s:pull"
+
+struct erofs_oci_registry_memory {
+	char *memory;
+	size_t size;
+};
+
+static CURLM *erofs_oci_registry_multi_handle(void)
+{
+	static CURLM *multi_handle;
+
+	if (!multi_handle)
+		multi_handle = curl_multi_init();
+
+	return multi_handle;
+}
+
+static size_t erofs_oci_registry_callback(void *contents, size_t size,
+					  size_t nmemb, void *userp)
+{
+	size_t real_size = size * nmemb;
+	struct erofs_oci_registry_memory *mem =
+		(struct erofs_oci_registry_memory *)userp;
+	char *ptr = realloc(mem->memory, mem->size + real_size + 1);
+
+	if (!ptr) {
+		fprintf(stderr, "realloc failed\n");
+		return 0;
+	}
+
+	mem->memory = ptr;
+	memcpy(&(mem->memory[mem->size]), contents, real_size);
+	mem->size += real_size;
+	mem->memory[mem->size] = 0;
+	return real_size;
+}
+
+ssize_t erofs_oci_registry_read(struct erofs_vfile *vf, void *buf, size_t len)
+{
+	struct erofs_oci_registry_memory *memory_struct =
+		(struct erofs_oci_registry_memory *)(vf->payload);
+
+	if (vf->offset >= memory_struct->size)
+		return 0;
+
+	if (len > memory_struct->size - vf->offset)
+		len = memory_struct->size - vf->offset;
+
+	memcpy(buf, memory_struct->memory + vf->offset, len);
+	vf->offset += len;
+
+	return len;
+}
+
+ssize_t erofs_oci_registry_pread(struct erofs_vfile *vf, void *buf,
+				 u64 offset, size_t len)
+{
+	struct erofs_oci_registry_memory *memory_struct =
+		(struct erofs_oci_registry_memory *)(vf->payload);
+
+	if (offset >= memory_struct->size)
+		return 0;
+
+	if (offset + len > memory_struct->size)
+		len = memory_struct->size - offset;
+
+	memcpy(buf, memory_struct->memory + offset, len);
+
+	return len;
+}
+
+off_t erofs_oci_registry_lseek(struct erofs_vfile *vf, u64 offset, int whence)
+{
+	struct erofs_oci_registry_memory *memory_struct =
+		(struct erofs_oci_registry_memory *)(vf->payload);
+	u64 new_offset = 0;
+
+	switch (whence) {
+	case SEEK_SET:
+		new_offset = offset;
+		break;
+	case SEEK_CUR:
+		new_offset = vf->offset + offset;
+		break;
+	case SEEK_END:
+		new_offset = memory_struct->size + offset;
+		break;
+	default:
+		return -1;
+	}
+
+	if (new_offset > memory_struct->size)
+		return -1;
+
+	vf->offset = new_offset;
+
+	return new_offset;
+}
+
+static char *erofs_get_authorization_header(struct erofs_oci_registry_memory *data)
+{
+	json_object *parsed_json, *token_json;
+	const char *token;
+	char *auth_header;
+
+	if (!data->memory) {
+		fprintf(stderr, "No data received\n");
+		return NULL;
+	}
+	parsed_json = json_tokener_parse(data->memory);
+
+	if (!parsed_json) {
+		fprintf(stderr, "Failed to parse JSON\n");
+		return NULL;
+	}
+
+	if (!json_object_object_get_ex(parsed_json, "token", &token_json)) {
+		fprintf(stderr, "Token not found in JSON\n");
+		json_object_put(parsed_json);
+		return NULL;
+	}
+	token = json_object_get_string(token_json);
+	auth_header = malloc(strlen("Authorization: Bearer ") + strlen(token) + 1);
+
+	if (!auth_header) {
+		fprintf(stderr, "Failed to allocate memory for authorization header\n");
+		json_object_put(parsed_json);
+		return NULL;
+	}
+
+	strscpy(auth_header, "Authorization: Bearer ", sizeof(auth_header));
+	strcat(auth_header, token);
+
+	json_object_put(parsed_json);
+	free(data->memory);
+
+	data->memory = NULL;
+	data->size = 0;
+
+	return auth_header;
+}
+
+static char *erofs_get_manifest_digest(struct erofs_oci_registry_memory *data,
+				       const char *arch, const char *os, char *media_type)
+{
+	json_object *parsed_json, *manifests_array;
+	int len;
+
+	if (!data->memory) {
+		fprintf(stderr, "No data received\n");
+		return NULL;
+	}
+
+	parsed_json = json_tokener_parse(data->memory);
+
+	if (!parsed_json) {
+		fprintf(stderr, "Failed to parse JSON\n");
+		return NULL;
+	}
+
+	if (!json_object_object_get_ex(parsed_json,
+							"manifests", &manifests_array)) {
+		fprintf(stderr, "Cannot find manifests in JSON\n");
+		json_object_put(parsed_json);
+		return NULL;
+	}
+
+	len = json_object_array_length(manifests_array);
+
+	for (int i = 0; i < len; i++) {
+		json_object *manifest = json_object_array_get_idx(manifests_array, i);
+		json_object *platform_json;
+
+		if (json_object_object_get_ex(manifest, "platform", &platform_json)) {
+			json_object *arch_json, *os_json, *digest_json, *media_type_json;
+
+			if (json_object_object_get_ex(platform_json,
+										"architecture", &arch_json) &&
+			    json_object_object_get_ex(platform_json, "os", &os_json) &&
+			    json_object_object_get_ex(manifest, "digest", &digest_json)) {
+
+				const char *manifest_arch = json_object_get_string(arch_json);
+				const char *manifest_os = json_object_get_string(os_json);
+
+				if (strcmp(manifest_arch, arch) == 0 &&
+				    strcmp(manifest_os, os) == 0) {
+					char *digest = strdup(json_object_get_string(digest_json));
+
+					if (json_object_object_get_ex(manifest,
+										"mediaType", &media_type_json)) {
+						const char *manifest_media_type =
+							json_object_get_string(media_type_json);
+
+						sprintf(media_type, "Accept: %s", manifest_media_type);
+					}
+
+					json_object_put(parsed_json);
+					free(data->memory);
+
+					data->memory = NULL;
+					data->size = 0;
+
+					return digest;
+				}
+			}
+		}
+	}
+
+	json_object_put(parsed_json);
+	free(data->memory);
+
+	data->memory = NULL;
+	data->size = 0;
+
+	fprintf(stderr, "No matching arch and os found\n");
+	return NULL;
+}
+
+static char *erofs_get_layer_digest(struct erofs_oci_registry_memory *data,
+				     char *media_type, int count)
+{
+	json_object *parsed_json, *layers_array;
+	json_object *layer, *digest_json, *media_type_json;
+	int len;
+	char *digest = NULL;
+
+	parsed_json = json_tokener_parse(data->memory);
+
+	if (!parsed_json) {
+		fprintf(stderr, "Failed to parse JSON\n");
+		return NULL;
+	}
+
+	if (!json_object_object_get_ex(parsed_json, "layers", &layers_array) ||
+	    json_object_get_type(layers_array) != json_type_array) {
+		fprintf(stderr, "Layers key not found or is not an array in JSON\n");
+		json_object_put(parsed_json);
+		return NULL;
+	}
+
+	len = json_object_array_length(layers_array);
+
+	if (count < 0 || count >= len) {
+		fprintf(stderr, "Count %d is out of bounds (0-%d)\n", count, len - 1);
+		json_object_put(parsed_json);
+		return NULL;
+	}
+
+	layer = json_object_array_get_idx(layers_array, count);
+
+	if (!json_object_object_get_ex(layer, "digest", &digest_json))
+		fprintf(stderr, "Digest not found in layer #%d\n", count);
+	else {
+		digest = strdup(json_object_get_string(digest_json));
+		if (json_object_object_get_ex(layer, "mediaType", &media_type_json)) {
+			const char *manifest_media_type =
+				json_object_get_string(media_type_json);
+
+			sprintf(media_type, "Accept: %s", manifest_media_type);
+		}
+	}
+
+	json_object_put(parsed_json);
+	return digest;
+}
+
+static void erofs_curl_io(CURLM *multi_handle, int *still_running)
+{
+	CURLMcode mc;
+
+	do {
+		mc = curl_multi_perform(multi_handle, still_running);
+
+		if (mc != CURLM_OK) {
+			fprintf(stderr, "curl_multi_perform() failed: %s\n",
+				curl_multi_strerror(mc));
+			break;
+		}
+
+		if (*still_running) {
+			int numfds;
+
+			mc = curl_multi_poll(multi_handle, NULL, 0, 1000, &numfds);
+			if (mc != CURLM_OK) {
+				fprintf(stderr, "curl_multi_poll failed: %s\n",
+					curl_multi_strerror(mc));
+				break;
+			}
+		}
+
+	} while (*still_running > 0);
+}
+
+static struct erofs_oci_registry_memory *erofs_curl_setopt(
+	CURLM *multi_handle, CURL *curl, const char *auth_header,
+	const char *media_type, const char *url, int mode)
+{
+	struct erofs_oci_registry_memory *data =
+		malloc(sizeof(struct erofs_oci_registry_memory));
+	struct curl_slist *headers = NULL;
+
+	if (!data) {
+		fprintf(stderr,
+			"Failed to allocate memory for erofs_oci_registry_memory\n");
+		return NULL;
+	}
+	data->memory = NULL;
+	data->size = 0;
+
+	switch (mode) {
+	case erofs_token_mode:
+		curl_easy_setopt(curl,
+						CURLOPT_WRITEFUNCTION, erofs_oci_registry_callback);
+		curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
+		curl_easy_setopt(curl, CURLOPT_URL, url);
+		curl_multi_add_handle(multi_handle, curl);
+		break;
+	case erofs_image_index_mode:
+		curl_easy_setopt(curl,
+						CURLOPT_WRITEFUNCTION, erofs_oci_registry_callback);
+		curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
+		headers = curl_slist_append(headers, auth_header);
+		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
+		curl_easy_setopt(curl, CURLOPT_URL, url);
+		curl_multi_add_handle(multi_handle, curl);
+		break;
+	case erofs_manifest_mode:
+		curl_easy_setopt(curl,
+						CURLOPT_WRITEFUNCTION, erofs_oci_registry_callback);
+		curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
+		headers = curl_slist_append(headers, auth_header);
+		headers = curl_slist_append(headers, media_type);
+		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
+		curl_easy_setopt(curl, CURLOPT_URL, url);
+		curl_multi_add_handle(multi_handle, curl);
+		break;
+	case erofs_blob_mode:
+		curl_easy_setopt(curl,
+						CURLOPT_WRITEFUNCTION, erofs_oci_registry_callback);
+		curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)data);
+		headers = curl_slist_append(headers, auth_header);
+		headers = curl_slist_append(headers, media_type);
+		curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
+		curl_easy_setopt(curl, CURLOPT_URL, url);
+		curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
+		curl_multi_add_handle(multi_handle, curl);
+		break;
+	default:
+		break;
+	}
+
+	return data;
+}
+
+static void erofs_extract_urlfront_repository(const char *url, char *repo_end,
+					      char *repository, char *url_front)
+{
+	const char *repo_start = strstr(url, "/library/");
+
+	if (!repo_start)
+		return;
+	repo_start += strlen("/library/");
+	repo_end = strchr(repo_start, '/');
+
+	if (!repo_end)
+		return;
+	strscpy(repository, repo_start, repo_end - repo_start + 1);
+	strscpy(url_front, url, repo_start - url + 1);
+}
+
+static void erofs_token_header(const char *repository,
+			       char **token_header, int still_running)
+{
+	char url_token[512];
+
+	snprintf(url_token, sizeof(url_token), docker_auth_url, repository);
+	CURL *curl_token = curl_easy_init();
+	struct erofs_oci_registry_memory *data_token =
+		erofs_curl_setopt(erofs_oci_registry_multi_handle(),
+				  curl_token, NULL, NULL, url_token, erofs_token_mode);
+
+	erofs_curl_io(erofs_oci_registry_multi_handle(), &still_running);
+	*token_header = erofs_get_authorization_header(data_token);
+
+	curl_multi_remove_handle(erofs_oci_registry_multi_handle(), curl_token);
+	curl_easy_cleanup(curl_token);
+
+	if (data_token)
+		free(data_token);
+}
+
+static void erofs_blob_info(char *blob_start, const char *url_front,
+			    const char *repository, char *digest_value,
+			    char *media_type_value, char *url_blob)
+{
+	const char *digest_start = blob_start + strlen("/blobs/");
+	const char *digest_end = strchr(digest_start, '/');
+
+	if (!digest_end)
+		digest_end = digest_start + strlen(digest_start);
+	strscpy(digest_value, digest_start, digest_end - digest_start + 1);
+
+	const char *media_type_start = strstr(digest_end, "Accept: ");
+
+	if (media_type_start)
+		strscpy(media_type_value, media_type_start, sizeof(media_type_value));
+	else
+		strscpy(media_type_value, "", sizeof(media_type_value));
+
+	snprintf(url_blob, 512, "%s%s/blobs/%s",
+		 url_front, repository, digest_value);
+}
+
+static void erofs_parse_params(const char *repo_end,
+			       char *arch, char *os, int *digest)
+{
+	const char *params = repo_end + 1;
+
+	while (params && *params != '\0') {
+		if (strncmp(params, "arch-", 5) == 0) {
+			params += 5;
+			const char *param_end = strchr(params, '/');
+
+			if (param_end) {
+				strscpy(arch, params, param_end - params + 1);
+				params = param_end + 1;
+			} else {
+				strscpy(arch, params, sizeof(arch));
+				break;
+			}
+		} else if (strncmp(params, "os-", 3) == 0) {
+			params += 3;
+			const char *param_end = strchr(params, '/');
+
+			if (param_end) {
+				strscpy(os, params, param_end - params + 1);
+				params = param_end + 1;
+			} else {
+				strscpy(os, params, sizeof(os));
+				break;
+			}
+		} else if (strncmp(params, "digest-", 7) == 0) {
+			params += 7;
+			*digest = atoi(params) - 1;
+			break;
+		}
+
+		params = strchr(params, '/');
+		if (params)
+			params++;
+	}
+}
+
+static void erofs_manifest(const char *url_front, const char *repository,
+			   const char *token_header, const char *arch,
+			   const char *os, char *media_type_blob, int *digest,
+			   int *still_running, char *media_type, char *url_blob)
+{
+	char url_image_index[512];
+
+	snprintf(url_image_index, sizeof(url_image_index),
+		 "%s%s/manifests/latest", url_front, repository);
+
+	CURL *curl_image_index = curl_easy_init();
+	struct erofs_oci_registry_memory *data_image_index =
+		erofs_curl_setopt(erofs_oci_registry_multi_handle(),
+				  curl_image_index, token_header,
+				  NULL, url_image_index, erofs_image_index_mode);
+	erofs_curl_io(erofs_oci_registry_multi_handle(), still_running);
+	char *digest_image_index = erofs_get_manifest_digest(data_image_index,
+							    arch, os, media_type);
+	if (data_image_index)
+		free(data_image_index);
+
+	curl_multi_remove_handle(erofs_oci_registry_multi_handle(),
+							curl_image_index);
+	curl_easy_cleanup(curl_image_index);
+
+	char url_manifest[512];
+
+	snprintf(url_manifest, sizeof(url_manifest), "%s%s/manifests/%s",
+		 url_front, repository, digest_image_index);
+
+	if (digest_image_index)
+		free(digest_image_index);
+
+	CURL *curl_manifest = curl_easy_init();
+	struct erofs_oci_registry_memory *data_manifest =
+		erofs_curl_setopt(erofs_oci_registry_multi_handle(),
+				  curl_manifest, token_header, media_type,
+				  url_manifest, erofs_manifest_mode);
+	erofs_curl_io(erofs_oci_registry_multi_handle(), still_running);
+	char *digest_manifest = erofs_get_layer_digest(data_manifest,
+						      media_type_blob, *digest);
+
+	if (data_manifest)
+		free(data_manifest);
+
+	curl_multi_remove_handle(erofs_oci_registry_multi_handle(), curl_manifest);
+	curl_easy_cleanup(curl_manifest);
+	snprintf(url_blob, 512, "%s%s/blobs/%s",
+			url_front, repository, digest_manifest);
+}
+
+struct erofs_vfile *open_oci_registry(const char *url)
+{
+	char *url_front = (char *)malloc(256 * sizeof(char));
+	char *repository = (char *)malloc(256 * sizeof(char));
+	char *arch = (char *)malloc(256 * sizeof(char));
+	char *os = (char *)malloc(256 * sizeof(char));
+	char *media_type_value = (char *)malloc(512 * sizeof(char));
+	char *media_type_blob = (char *)malloc(512 * sizeof(char));
+	char *url_blob = (char *)malloc(512 * sizeof(char));
+	char *repo_end = (char *)malloc(256 * sizeof(char));
+	char **token_header = NULL;
+	char *media_type = (char *)malloc(512 * sizeof(char));
+	char *blob_start = NULL;
+	CURL *curl_blob = NULL;
+	struct erofs_oci_registry_memory *data_blob = NULL;
+	struct erofs_vfile *vf =
+		(struct erofs_vfile *)malloc(sizeof(struct erofs_vfile));
+
+	int digest = 0;
+	int still_running = 0;
+	int mode = 0;
+
+	erofs_extract_urlfront_repository(url, repo_end, repository, url_front);
+	erofs_token_header(repository, &token_header, still_running);
+
+	blob_start = strstr(repo_end, "/blobs/");
+
+	if (blob_start) {
+		char *digest_value = (char *)malloc(128 * sizeof(char));
+
+		erofs_blob_info(blob_start, url_front, repository,
+				digest_value, media_type_value, url_blob);
+		free(blob_start);
+
+		mode = 1;
+
+		goto pull_blob_mode;
+	} else {
+		strscpy(arch, "amd64", sizeof(arch));
+		strscpy(os, "linux", sizeof(os));
+		digest = 0;
+
+		erofs_parse_params(repo_end, arch, os, &digest);
+		erofs_manifest(url_front, repository, token_header, arch, os,
+			       media_type_blob, &digest,
+				   &still_running, media_type, url_blob);
+	}
+
+	free(url_front);
+	free(arch);
+	free(os);
+	free(media_type);
+
+pull_blob_mode:
+
+	curl_blob = curl_easy_init();
+
+	if (mode == 1) {
+		data_blob = erofs_curl_setopt(erofs_oci_registry_multi_handle(),
+					      curl_blob, token_header,
+					      media_type_value,
+					      url_blob, erofs_blob_mode);
+	} else {
+		data_blob = erofs_curl_setopt(erofs_oci_registry_multi_handle(),
+					      curl_blob, token_header,
+					      media_type_blob,
+					      url_blob, erofs_blob_mode);
+	}
+
+	erofs_curl_io(erofs_oci_registry_multi_handle(), &still_running);
+	curl_multi_remove_handle(erofs_oci_registry_multi_handle(), curl_blob);
+	curl_easy_cleanup(curl_blob);
+
+	vf->ops = malloc(sizeof(struct erofs_vfops));
+	vf->ops->read = erofs_oci_registry_read;
+	vf->ops->pread = erofs_oci_registry_pread;
+	vf->ops->lseek = erofs_oci_registry_lseek;
+	*((struct erofs_oci_registry_memory **)(vf->payload)) = data_blob;
+
+	return vf;
+}
diff --git a/lib/oci_registry.h b/lib/oci_registry.h
new file mode 100644
index 0000000..ba6a08b
--- /dev/null
+++ b/lib/oci_registry.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+
+
+#include <stdio.h>
+#include <curl/curl.h>
+#include <json-c/json.h>
+#include <stdlib.h>
+#include <string.h>
+#include "erofs/io.h"
+
+struct erofs_vfile *erofs_open_oci_registry(const char *url);
+ssize_t erofs_oci_registry_read(struct erofs_vfile *vf,
+				void *buf, size_t len);
+ssize_t erofs_oci_registry_pread(struct erofs_vfile *vf, void *buf,
+				u64 offset, size_t len);
+off_t erofs_oci_registry_lseek(struct erofs_vfile *vf,
+				u64 offset, int whence);
-- 
2.44.0.windows.1

