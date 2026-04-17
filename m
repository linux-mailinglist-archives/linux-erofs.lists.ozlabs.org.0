Return-Path: <linux-erofs+bounces-3322-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH/wDRAJ4mna0QAAu9opvQ
	(envelope-from <linux-erofs+bounces-3322-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 12:18:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94541A06D
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Apr 2026 12:18:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxrSl32Ngz2xc8;
	Fri, 17 Apr 2026 20:18:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776421127;
	cv=none; b=UIZLDn2SfAEZ1A+J9/g4ILGPSRgukJT6xeZz+C14QZQKqYueQu+SR5So63S+HnL2dSi4qdvc3dcwjPd8QJ9R0OB+/JPTITPrtS7SThvLeGBwQGSh5v+ELN3n4rBn0cTpR6tY1O8y0R+/9CGHBv+zPWI0jQdgczHNNrO5Tjb5wBsmA3vRKNxuTF9x63qCMQsArqKJf42OSGxYmmdV4u/5ev/0SrEPapp0/iTqU1rjBE3lzCqahvIleu7KJA7Oht2B2hYEvy1BVTS2/mAnk4g3t64/6fB1ynu62MeEkmoCAwJWaB6tmn+pdBs6GdcBTSb7e9CrCvO+RdFILbkN3ribSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776421127; c=relaxed/relaxed;
	bh=UkCGoEEBWplVQdH5j9OsybtWgDyQuIxKBJdnnteoNPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsLhzwy2hxmUq/U7IHiU3hDub6Tl43uz2CAYp3Lg49MYMIQYI5OmERORWvf2NAoj03Ud1zPMIHt29bgcqtRgXddP4yGBOogK+rXvrbbNeaww4nCu+dnz+Xpa9DAfsvvtySdVF5OfAT3WecK0TMyzSM0dQ9YWP5AqSYyynUdxy709SmVEgOulEwrkV2JqxhUbBsxqRJDc4pjahhk0m2hFfW+pZvJLE13g/OGSfoY2V9g/L2Js9/5q/TYIbo5bmUmvZq3Umy+98eeZ3ReX7kjbwMpSXJarnEr+o+8LlcmIaHiGfrtPB06KnF6NVyRT9HqpzOTo5ICN1r4WS7oSngc6ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OYB3ba2u; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OYB3ba2u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxrSg34FFz2xpt
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Apr 2026 20:18:41 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776421116; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UkCGoEEBWplVQdH5j9OsybtWgDyQuIxKBJdnnteoNPY=;
	b=OYB3ba2uHfUvVFszM8ZCGZ74A2TPW+ohi0jyiMktC74nO0SDXlyez9WPQt0T6Bo2j6WMaZZhztveFh040rvsyMT/nx4KL0eQ6+T3X+PoesdSZR1AIaALgJxZfyq39kkfHn9zBQhgp78yZloCr8iZm4ifYbOVd3N74eXxsqCQMsk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X1B1iAx_1776421110;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1B1iAx_1776421110 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Apr 2026 18:18:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yuxuan Liu <cdjddzy@foxmail.com>
Subject: [PATCH 1/2] erofs-utils: mount: support mounting EROFS stored as an AWS S3 object
Date: Fri, 17 Apr 2026 18:18:28 +0800
Message-ID: <20260417101829.1214550-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3322-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,foxmail.com:email,amazonaws.com:url]
X-Rspamd-Queue-Id: 6D94541A06D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow mount.erofs to directly mount an EROFS filesystem stored as
an AWS S3 object without downloading it first: (meta)data is fetched
on demand via HTTP range requests.

The source argument takes the form "bucket/key", e.g.:

 $ mount.erofs -t erofs.nbd \
    -o s3.endpoint=s3.amazonaws.com,s3.passwd_file=/path/to/passwd \
    my-bucket/dir/foo.erofs mnt

In addition, AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment
variables are also honored as fallback credentials.

Assisted-by: qoder:(unknown)
Cc: Yuxuan Liu <cdjddzy@foxmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/liberofs_s3.h |   5 +
 lib/remotes/s3.c  | 303 ++++++++++++++++++++++++++++++++++++++++++++--
 mkfs/main.c       |  71 +----------
 mount/main.c      | 237 ++++++++++++++++++++++++++++++------
 4 files changed, 495 insertions(+), 121 deletions(-)

diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
index c81834785c5f..3d2b2727b3b6 100644
--- a/lib/liberofs_s3.h
+++ b/lib/liberofs_s3.h
@@ -35,8 +35,13 @@ struct erofs_s3 {
 	enum s3erofs_signature_version sig;
 };
 
+struct erofs_vfile;
+
 int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 			const char *path, bool fillzero);
+struct erofs_vfile *s3erofs_io_open(struct erofs_s3 *s3, const char *bucket,
+				    const char *key);
+int s3erofs_parse_s3fs_passwd(const char *filepath, char *ak, char *sk);
 
 #ifdef __cplusplus
 }
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 964555d38432..35df935f8328 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -20,6 +20,7 @@
 #include "erofs/importer.h"
 #include "liberofs_rebuild.h"
 #include "liberofs_s3.h"
+#include "liberofs_base64.h"
 
 #define S3EROFS_PATH_MAX		1024
 #define S3EROFS_MAX_QUERY_PARAMS	16
@@ -39,6 +40,7 @@ struct s3erofs_curl_request {
 	char url[S3EROFS_URL_LEN];
 	char canonical_uri[S3EROFS_CANONICAL_URI_LEN];
 	char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
+	const char *method;
 };
 
 static const char *s3erofs_parse_host(const char *endpoint, const char **schema)
@@ -353,6 +355,7 @@ static void s3erofs_to_hex(const u8 *data, size_t len, char *output)
 
 // See: https://docs.aws.amazon.com/AmazonS3/latest/API/RESTAuthentication.html#ConstructingTheAuthenticationHeader
 static char *s3erofs_sigv2_header(const struct curl_slist *headers,
+				  const char *request_method,
 				  const char *content_md5,
 				  const char *content_type, const char *date,
 				  const char *canonical_uri, const char *ak,
@@ -373,8 +376,8 @@ static char *s3erofs_sigv2_header(const struct curl_slist *headers,
 	if (!canonical_uri)
 		canonical_uri = "/";
 
-	pos = asprintf(&str, "GET\n%s\n%s\n%s\n%s%s", content_md5, content_type,
-		       date, "", canonical_uri);
+	pos = asprintf(&str, "%s\n%s\n%s\n%s\n%s%s", request_method,
+		       content_md5, content_type, date, "", canonical_uri);
 	if (pos < 0)
 		return ERR_PTR(-ENOMEM);
 
@@ -401,6 +404,7 @@ free_string:
 
 // See: https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
 static char *s3erofs_sigv4_header(const struct curl_slist *headers,
+				  const char *request_method,
 				  time_t request_time, const char *canonical_uri,
 				  const char *canonical_query, const char *region,
 				  const char *ak, const char *sk)
@@ -430,13 +434,11 @@ static char *s3erofs_sigv4_header(const struct curl_slist *headers,
 
 	// Task 1: Create canonical request
 	if (asprintf(&canonical_request,
-		     "GET\n"
-		     "%s\n"
-		     "%s\n"
-		     "%s\n"
+		     "%s\n%s\n%s\n%s\n"
 		     "host;x-amz-content-sha256;x-amz-date\n"
 		     "UNSIGNED-PAYLOAD",
-		     canonical_uri, canonical_query, canonical_headers) < 0) {
+		     request_method, canonical_uri, canonical_query,
+		     canonical_headers) < 0) {
 		err = -ENOMEM;
 		goto err_canonical_headers;
 	}
@@ -533,7 +535,7 @@ static int s3erofs_request_insert_auth_v2(struct curl_slist **request_headers,
 	s3erofs_format_time(time(NULL), date + sizeof(date_prefix) - 1,
 			    sizeof(date) - sizeof(date_prefix) + 1, S3EROFS_DATE_RFC1123);
 
-	sigv2 = s3erofs_sigv2_header(*request_headers, NULL, NULL,
+	sigv2 = s3erofs_sigv2_header(*request_headers, req->method, NULL, NULL,
 				     date + sizeof(date_prefix) - 1, req->canonical_uri,
 				     s3->access_key, s3->secret_key);
 	if (IS_ERR(sigv2))
@@ -576,7 +578,7 @@ static int s3erofs_request_insert_auth_v4(struct curl_slist **request_headers,
 	*request_headers = curl_slist_append(*request_headers, tmp);
 	free(tmp);
 
-	sigv4 = s3erofs_sigv4_header(*request_headers, request_time,
+	sigv4 = s3erofs_sigv4_header(*request_headers, req->method, request_time,
 				     req->canonical_uri, req->canonical_query,
 				     s3->region, s3->access_key, s3->secret_key);
 	if (IS_ERR(sigv4))
@@ -619,6 +621,13 @@ static int s3erofs_request_perform(struct erofs_s3 *s3,
 	long http_code = 0;
 	int ret;
 
+	if (!strcmp(req->method, "HEAD")) {
+		curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);
+	} else {
+		curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
+		curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);
+	}
+
 	if (s3->access_key[0]) {
 		if (s3->sig == S3EROFS_SIGNATURE_VERSION_4)
 			ret = s3erofs_request_insert_auth_v4(&request_headers, req, s3);
@@ -846,7 +855,7 @@ out:
 
 static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
 {
-	struct s3erofs_curl_request req = {};
+	struct s3erofs_curl_request req = { .method = "GET", };
 	struct s3erofs_curl_response resp = {};
 	struct s3erofs_query_params params;
 	struct erofs_s3 *s3 = it->s3;
@@ -1014,7 +1023,7 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 				    const char *bucket, const char *key)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	struct s3erofs_curl_request req = {};
+	struct s3erofs_curl_request req = { .method = "GET", };
 	struct s3erofs_curl_getobject_resp resp;
 	struct erofs_vfile vf;
 	u64 diskbuf_off;
@@ -1170,6 +1179,276 @@ err_global:
 	return ret;
 }
 
+struct s3erofs_vfile {
+	struct erofs_vfile vf;
+	struct erofs_s3 *s3;
+	char *bucket, *key;
+	u64 offset, size;
+};
+
+struct s3erofs_range_resp {
+	void *buf;
+	size_t len;
+};
+
+static size_t s3erofs_range_write_cb(void *contents, size_t size,
+				     size_t nmemb, void *userp)
+{
+	struct s3erofs_range_resp *resp = userp;
+	size_t realsize = size * nmemb;
+
+	if (realsize > resp->len)
+		return 0;
+
+	memcpy(resp->buf, contents, realsize);
+	resp->buf = (char *)resp->buf + realsize;
+	resp->len -= realsize;
+	return realsize;
+}
+
+static int s3erofs_get_object_range(struct s3erofs_vfile *s3vf,
+				    void *buf, size_t len, u64 offset)
+{
+	struct s3erofs_curl_request req = { .method = "GET", };
+	struct erofs_s3 *s3 = s3vf->s3;
+	struct s3erofs_range_resp resp;
+	CURL *curl = s3->easy_curl;
+	u64 end = offset + len;
+	long http_code = 0;
+	char range[64];
+	int ret;
+
+	if (end > s3vf->size)
+		end = s3vf->size;
+	if (__erofs_unlikely(end <= offset))
+		return 0;
+	resp.buf = buf;
+	resp.len = end - offset;
+
+	ret = s3erofs_prepare_url(&req, s3->endpoint, s3vf->bucket,
+				  s3vf->key, NULL, s3->url_style, s3->sig);
+	if (ret < 0)
+		return ret;
+
+	/* Add Range header for partial content */
+	snprintf(range, sizeof(range), "%llu-%llu", offset | 0ULL, (end - 1) | 0ULL);
+
+	curl_easy_setopt(curl, CURLOPT_RANGE, range);
+	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, s3erofs_range_write_cb);
+
+	ret = s3erofs_request_perform(s3, &req, &resp);
+	if (ret)
+		return ret;
+
+	ret = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
+	if (ret != CURLE_OK) {
+		erofs_err("curl_easy_getinfo() failed: %s",
+			  curl_easy_strerror(ret));
+		return -EIO;
+	}
+
+	if (http_code != 206 && http_code != 200) {
+		erofs_err("S3 range request failed with HTTP code %ld", http_code);
+		return -EIO;
+	}
+	return len - resp.len;  /* actual bytes read */
+}
+
+static ssize_t s3erofs_io_pread(struct erofs_vfile *vf, void *buf,
+				size_t len, u64 offset)
+{
+	struct s3erofs_vfile *s3vf = (struct s3erofs_vfile *)vf;
+	int ret;
+
+	if (offset >= s3vf->size) {
+		memset(buf, 0, len);
+		return len;
+	}
+	ret = s3erofs_get_object_range(s3vf, buf, len, offset);
+	if (ret >= 0 && ret < len) {
+		memset(buf + ret, 0, len - ret);
+		return len;
+	}
+	return ret;
+}
+
+static ssize_t s3erofs_io_read(struct erofs_vfile *vf, void *buf, size_t len)
+{
+	struct s3erofs_vfile *s3vf = (struct s3erofs_vfile *)vf;
+	ssize_t ret;
+
+	ret = s3erofs_io_pread(vf, buf, len, s3vf->offset);
+	if (ret > 0)
+		s3vf->offset += ret;
+	return ret;
+}
+
+static void s3erofs_io_close(struct erofs_vfile *vf)
+{
+	struct s3erofs_vfile *s3vf = (struct s3erofs_vfile *)vf;
+
+	if (!s3vf)
+		return;
+
+	s3erofs_curl_easy_exit(s3vf->s3);
+	free(s3vf->bucket);
+	free(s3vf->key);
+	free(s3vf);
+}
+
+static struct erofs_vfops s3erofs_io_vfops = {
+	.pread = s3erofs_io_pread,
+	.read = s3erofs_io_read,
+	.close = s3erofs_io_close,
+};
+
+static int s3erofs_get_object_size(struct s3erofs_vfile *s3vf)
+{
+	struct s3erofs_curl_request req = { .method = "HEAD", };
+	struct erofs_s3 *s3 = s3vf->s3;
+	CURL *curl = s3->easy_curl;
+	long http_code = 0;
+	double content_length = 0;
+	int ret;
+
+	ret = s3erofs_prepare_url(&req, s3->endpoint, s3vf->bucket,
+				  s3vf->key, NULL, s3->url_style, s3->sig);
+	if (ret < 0)
+		return ret;
+
+	ret = s3erofs_request_perform(s3, &req, NULL);
+	if (ret)
+		return ret;
+
+	ret = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
+	if (ret != CURLE_OK) {
+		erofs_err("curl_easy_getinfo() failed: %s",
+			  curl_easy_strerror(ret));
+		return -EIO;
+	}
+
+	if (http_code != 200) {
+		erofs_err("HEAD request failed with HTTP code %ld", http_code);
+		return -EIO;
+	}
+
+	ret = curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD,
+				&content_length);
+	if (ret != CURLE_OK)
+		return -EIO;
+	s3vf->size = (u64)content_length;
+	return 0;
+}
+
+struct erofs_vfile *s3erofs_io_open(struct erofs_s3 *s3, const char *bucket,
+				    const char *key)
+{
+	struct s3erofs_vfile *s3vf;
+	int ret = -ENOMEM;
+
+	s3vf = calloc(1, sizeof(*s3vf));
+	if (!s3vf)
+		return ERR_PTR(-ENOMEM);
+
+	s3vf->vf = (struct erofs_vfile){.ops = &s3erofs_io_vfops};
+	s3vf->bucket = strdup(bucket);
+	if (!s3vf->bucket)
+		goto err_free;
+	s3vf->key = strdup(key);
+	if (!s3vf->key)
+		goto err_free;
+	s3vf->s3 = s3;
+
+	ret = s3erofs_curl_easy_init(s3vf->s3);
+	if (ret)
+		goto err_free;
+
+	/* Get object size via HEAD request */
+	ret = s3erofs_get_object_size(s3vf);
+	if (ret) {
+		erofs_err("failed to get S3 object size");
+		goto err_curl;
+	}
+
+	erofs_dbg("S3 object (%s) size: %llu", s3vf->key, s3vf->size);
+	return &s3vf->vf;
+
+err_curl:
+	s3erofs_curl_easy_exit(s3);
+err_free:
+	free(s3vf->key);
+	free(s3vf->bucket);
+	free(s3vf);
+	return ERR_PTR(ret);
+}
+
+int s3erofs_parse_s3fs_passwd(const char *filepath, char *ak, char *sk)
+{
+	char buf[S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3];
+	struct stat st;
+	int fd, n, ret;
+	char *colon;
+
+	fd = open(filepath, O_RDONLY);
+	if (fd < 0) {
+		erofs_err("failed to open passwd_file %s", filepath);
+		return -errno;
+	}
+
+	ret = fstat(fd, &st);
+	if (ret) {
+		ret = -errno;
+		goto err;
+	}
+
+	if (!S_ISREG(st.st_mode)) {
+		erofs_err("%s is not a regular file", filepath);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if ((st.st_mode & 077) != 0)
+		erofs_warn("passwd_file %s should not be accessible by group or others",
+			   filepath);
+
+	if (st.st_size >= sizeof(buf)) {
+		erofs_err("passwd_file %s is too large (size: %llu)", filepath,
+			  st.st_size | 0ULL);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	n = read(fd, buf, st.st_size);
+	if (n < 0) {
+		ret = -errno;
+		goto err;
+	}
+	buf[n] = '\0';
+
+	while (n > 0 && (buf[n - 1] == '\n' || buf[n - 1] == '\r'))
+		buf[--n] = '\0';
+
+	colon = strchr(buf, ':');
+	if (!colon) {
+		ret = -EINVAL;
+		goto err;
+	}
+	*colon = '\0';
+
+	if (strlen(buf) > S3_ACCESS_KEY_LEN ||
+	    strlen(colon + 1) > S3_SECRET_KEY_LEN) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	strcpy(ak, buf);
+	strcpy(sk, colon + 1);
+
+err:
+	close(fd);
+	return ret;
+}
+
 #ifdef TEST
 struct s3erofs_prepare_url_testcase {
 	const char *name;
@@ -1186,7 +1465,7 @@ struct s3erofs_prepare_url_testcase {
 static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_url_testcase *tc,
 					 enum s3erofs_signature_version sig)
 {
-	struct s3erofs_curl_request req = {};
+	struct s3erofs_curl_request req = { .method = "GET", };
 	int ret;
 	const char *expected_canonical;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 5006f76fa73b..5de5fbe0c961 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -634,73 +634,6 @@ static void mkfs_parse_tar_cfg(char *cfg)
 }
 
 #ifdef S3EROFS_ENABLED
-static int mkfs_parse_s3_cfg_passwd(const char *filepath, char *ak, char *sk)
-{
-	struct stat st;
-	int fd, n, ret;
-	char buf[S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3];
-	char *colon;
-
-	fd = open(filepath, O_RDONLY);
-	if (fd < 0) {
-		erofs_err("failed to open passwd_file %s", filepath);
-		return -errno;
-	}
-
-	ret = fstat(fd, &st);
-	if (ret) {
-		ret = -errno;
-		goto err;
-	}
-
-	if (!S_ISREG(st.st_mode)) {
-		erofs_err("%s is not a regular file", filepath);
-		ret = -EINVAL;
-		goto err;
-	}
-
-	if ((st.st_mode & 077) != 0)
-		erofs_warn("passwd_file %s should not be accessible by group or others",
-			   filepath);
-
-	if (st.st_size >= sizeof(buf)) {
-		erofs_err("passwd_file %s is too large (size: %llu)", filepath,
-			  st.st_size | 0ULL);
-		ret = -EINVAL;
-		goto err;
-	}
-
-	n = read(fd, buf, st.st_size);
-	if (n < 0) {
-		ret = -errno;
-		goto err;
-	}
-	buf[n] = '\0';
-
-	while (n > 0 && (buf[n - 1] == '\n' || buf[n - 1] == '\r'))
-		buf[--n] = '\0';
-
-	colon = strchr(buf, ':');
-	if (!colon) {
-		ret = -EINVAL;
-		goto err;
-	}
-	*colon = '\0';
-
-	if (strlen(buf) > S3_ACCESS_KEY_LEN ||
-	    strlen(colon + 1) > S3_SECRET_KEY_LEN) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	strcpy(ak, buf);
-	strcpy(sk, colon + 1);
-
-err:
-	close(fd);
-	return ret;
-}
-
 static int mkfs_parse_s3_cfg(char *cfg_str)
 {
 	char *p, *q, *opt;
@@ -734,8 +667,8 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
 
 		if ((p = strstr(opt, "passwd_file="))) {
 			p += sizeof("passwd_file=") - 1;
-			ret = mkfs_parse_s3_cfg_passwd(p, s3cfg.access_key,
-						       s3cfg.secret_key);
+			ret = s3erofs_parse_s3fs_passwd(p, s3cfg.access_key,
+							s3cfg.secret_key);
 			if (ret)
 				return ret;
 		} else if ((p = strstr(opt, "urlstyle="))) {
diff --git a/mount/main.c b/mount/main.c
index e09e58533ecc..bd7beb1fbb13 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -22,6 +22,7 @@
 #ifdef EROFS_FANOTIFY_ENABLED
 #include "../lib/liberofs_fanotify.h"
 #endif
+#include "../lib/liberofs_s3.h"
 
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
@@ -88,13 +89,17 @@ static struct erofsmount_cfg {
 enum erofsmount_source_type {
 	EROFSMOUNT_SOURCE_LOCAL,
 	EROFSMOUNT_SOURCE_OCI,
+	EROFSMOUNT_SOURCE_S3_OBJECT,
 };
 
 static struct erofsmount_source {
 	enum erofsmount_source_type type;
 	union {
-		const char *device_path;
 		struct ocierofs_config ocicfg;
+		struct {
+			const char *device_path;
+			struct erofs_s3 s3cfg;
+		};
 	};
 } mountsrc;
 
@@ -104,27 +109,36 @@ static void usage(int argc, char **argv)
 		"Manage EROFS filesystem.\n"
 		"\n"
 		"General options:\n"
-		" -V, --version         print the version number of mount.erofs and exit\n"
-		" -h, --help            display this help and exit\n"
-		" -d <0-9>              set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
-		" -o options            comma-separated list of mount options\n"
-		" -t type[.subtype]     filesystem type (and optional subtype)\n"
-		"                       subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP "\n"
-		" -u                    unmount the filesystem\n"
-		"    --disconnect       abort an existing NBD device forcibly\n"
-		"    --reattach         reattach to an existing NBD device\n"
+		" -V, --version              print the version number of mount.erofs and exit\n"
+		" -h, --help                 display this help and exit\n"
+		" -d <0-9>                   set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
+		" -o options                 comma-separated list of mount options\n"
+		" -t type[.subtype]          filesystem type (and optional subtype)\n"
+		"                            subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP "\n"
+		" -u                         unmount the filesystem\n"
+		"    --disconnect            abort an existing NBD device forcibly\n"
+		"    --reattach              reattach to an existing NBD device\n"
 #ifdef OCIEROFS_ENABLED
 		"\n"
 		"OCI-specific options (EXPERIMENTAL, with -o):\n"
-		"   oci.blob=<digest>   specify OCI blob digest (sha256:...)\n"
-		"   oci.layer=<index>   specify OCI layer index\n"
-		"   oci.platform=<name> specify platform (default: linux/amd64)\n"
-		"   oci.username=<user> username for authentication (optional)\n"
-		"   oci.password=<pass> password for authentication (optional)\n"
-		"   oci.tarindex=<path> path to tarball index file (optional)\n"
-		"   oci.zinfo=<path>    path to gzip zinfo file (optional)\n"
-		"   oci.insecure        use HTTP instead of HTTPS (optional)\n"
+		"   oci.blob=<digest>        specify OCI blob digest (sha256:...)\n"
+		"   oci.layer=<index>        specify OCI layer index\n"
+		"   oci.platform=<name>      specify platform (default: linux/amd64)\n"
+		"   oci.username=<user>      username for authentication (optional)\n"
+		"   oci.password=<pass>      password for authentication (optional)\n"
+		"   oci.tarindex=<path>      path to tarball index file (optional)\n"
+		"   oci.zinfo=<path>         path to gzip zinfo file (optional)\n"
+		"   oci.insecure             use HTTP instead of HTTPS (optional)\n"
 #endif
+#ifdef S3EROFS_ENABLED
+		"\n"
+		"S3-specific options (EXPERIMENTAL, with -o):\n"
+		"   s3.endpoint=<url>        S3 endpoint URL (e.g., s3.amazonaws.com)\n"
+		"   s3.passwd_file=<path>    specify a s3fs-compatible password file\n"
+		"   s3.region=<region>       region code in which endpoint belongs to (required for sigv4)\n"
+		"   s3.sig=<2,4>             S3 API signature version (default: 2)\n"
+		"   s3.urlstyle=<vhost|path> S3 API calling URL (default: vhost)\n"
+ #endif
 		, argv[0], EROFS_WARN);
 }
 
@@ -210,6 +224,85 @@ static int erofsmount_parse_oci_option(const char *option)
 }
 #endif
 
+#ifdef S3EROFS_ENABLED
+static int erofsmount_parse_s3_option(const char *option, struct erofs_s3 *s3cfg)
+{
+	const char *p;
+	int ret;
+
+	if ((p = strstr(option, "s3.endpoint=")) != NULL) {
+		p += sizeof("s3.endpoint=") - 1;
+		s3cfg->endpoint = strdup(p);
+		if (!s3cfg->endpoint)
+			return -ENOMEM;
+	} else if ((p = strstr(option, "s3.passwd_file=")) != NULL) {
+		p += sizeof("s3.passwd_file=") - 1;
+		ret = s3erofs_parse_s3fs_passwd(p, s3cfg->access_key,
+						s3cfg->secret_key);
+		if (ret)
+			return ret;
+	} else if ((p = strstr(option, "s3.region=")) != NULL) {
+		p += sizeof("s3.region=") - 1;
+		s3cfg->region = strdup(p);
+		if (!s3cfg->region)
+			return -ENOMEM;
+	} else if ((p = strstr(option, "s3.urlstyle=")) != NULL) {
+		p += sizeof("s3.urlstyle=") - 1;
+		if (!strcmp(p, "vhost"))
+			s3cfg->url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST;
+		else if (!strcmp(p, "path"))
+			s3cfg->url_style = S3EROFS_URL_STYLE_PATH;
+		else {
+			erofs_err("invalid S3 URL style %s", p);
+			return -EINVAL;
+		}
+	} else if ((p = strstr(option, "s3.sig=")) != NULL) {
+		p += sizeof("s3.sig=") - 1;
+		if (!strcmp(p, "2"))
+			s3cfg->sig = S3EROFS_SIGNATURE_VERSION_2;
+		else if (!strcmp(p, "4"))
+			s3cfg->sig = S3EROFS_SIGNATURE_VERSION_4;
+		else {
+			erofs_err("invalid S3 signature version %s", p);
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int erofsmount_parse_s3_source(struct erofs_s3 *s3cfg, const char *source,
+				      char **bucket, char **key)
+{
+	const char *slash;
+
+	if (!source || !*source)
+		return -EINVAL;
+
+	slash = strchr(source, '/');
+	if (!slash) {
+		/* No slash: treat entire source as bucket, empty key */
+		*bucket = strdup(source);
+		*key = strdup("");
+	} else {
+		*bucket = strndup(source, slash - source);
+		*key = strdup(slash + 1);
+	}
+	if (!*bucket || !*key) {
+		free(*bucket);
+		free(*key);
+		return -ENOMEM;
+	}
+	return 0;
+}
+#else
+static int erofsmount_parse_s3_option(const char *option, void *s3cfg)
+{
+	return -EINVAL;
+}
+#endif
+
 static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 {
 	static const struct {
@@ -253,6 +346,33 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 			err = erofsmount_parse_oci_option(s);
 			if (err < 0)
 				return err;
+#ifdef S3EROFS_ENABLED
+		} else if (strncmp(s, "s3.", 3) == 0) {
+			/* Initialize s3cfg here iff != EROFSMOUNT_SOURCE_S3_OBJECT */
+			if (mountsrc.type != EROFSMOUNT_SOURCE_S3_OBJECT) {
+				erofs_warn("EXPERIMENTAL S3 mount support in use, use at your own risk.");
+				mountsrc.type = EROFSMOUNT_SOURCE_S3_OBJECT;
+				mountsrc.s3cfg.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST;
+				mountsrc.s3cfg.sig = S3EROFS_SIGNATURE_VERSION_2;
+				mountsrc.s3cfg.access_key[0] = '\0';
+				mountsrc.s3cfg.secret_key[0] = '\0';
+				if (getenv("AWS_ACCESS_KEY_ID")) {
+					strncpy(mountsrc.s3cfg.access_key,
+						getenv("AWS_ACCESS_KEY_ID"),
+						S3_ACCESS_KEY_LEN);
+					mountsrc.s3cfg.access_key[S3_ACCESS_KEY_LEN] = '\0';
+				}
+				if (getenv("AWS_SECRET_ACCESS_KEY")) {
+					strncpy(mountsrc.s3cfg.secret_key,
+						getenv("AWS_SECRET_ACCESS_KEY"),
+						S3_SECRET_KEY_LEN);
+					mountsrc.s3cfg.secret_key[S3_SECRET_KEY_LEN] = '\0';
+				}
+			}
+			err = erofsmount_parse_s3_option(s, &mountsrc.s3cfg);
+			if (err < 0)
+				return err;
+#endif
 		} else {
 			for (i = 0; i < ARRAY_SIZE(opts); ++i) {
 				if (!strcasecmp(s, opts[i].name)) {
@@ -635,8 +755,9 @@ err_out:
 }
 
 struct erofsmount_nbd_ctx {
-	struct erofs_vfile vd;		/* virtual device */
+	struct erofs_vfile _vd;		/* virtual device */
 	struct erofs_vfile sk;		/* socket file */
+	struct erofs_vfile *vd;
 };
 
 static void *erofsmount_nbd_loopfn(void *arg)
@@ -666,7 +787,7 @@ static void *erofsmount_nbd_loopfn(void *arg)
 		erofs_nbd_send_reply_header(ctx->sk.fd, rq.cookie, 0);
 		pos = rq.from;
 		do {
-			written = erofs_io_sendfile(&ctx->sk, &ctx->vd, &pos, rq.len);
+			written = erofs_io_sendfile(&ctx->sk, ctx->vd, &pos, rq.len);
 			if (written == -EINTR) {
 				err = written;
 				goto out;
@@ -680,49 +801,68 @@ static void *erofsmount_nbd_loopfn(void *arg)
 		}
 	}
 out:
-	erofs_io_close(&ctx->vd);
+	erofs_io_close(ctx->vd);
 	erofs_io_close(&ctx->sk);
 	return (void *)(uintptr_t)err;
 }
 
 static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
 {
-	struct erofsmount_nbd_ctx ctx = {};
+	struct erofsmount_nbd_ctx ctx = {.vd = &ctx._vd};
 	uintptr_t retcode;
 	pthread_t th;
 	int err, err2;
 
 	if (source->type == EROFSMOUNT_SOURCE_OCI) {
 		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
-			err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
+			err = erofsmount_tarindex_open(ctx.vd, &source->ocicfg,
 						       source->ocicfg.tarindex_path,
 						       source->ocicfg.zinfo_path);
 			if (err)
 				goto out_closefd;
 		} else {
-			err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
+			err = ocierofs_io_open(ctx.vd, &source->ocicfg);
 			if (err)
 				goto out_closefd;
 		}
+#ifdef S3EROFS_ENABLED
+	} else if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT) {
+		char *bucket = NULL, *key = NULL;
+		struct erofs_vfile *s3vf;
+
+		err = erofsmount_parse_s3_source(&source->s3cfg, source->device_path,
+						 &bucket, &key);
+		if (err)
+			goto out_closefd;
+
+		s3vf = s3erofs_io_open(&source->s3cfg, bucket, key);
+		free(bucket);
+		free(key);
+		if (IS_ERR(s3vf)) {
+			err = PTR_ERR(s3vf);
+			goto out_closefd;
+		}
+		ctx.vd = s3vf;
+#endif
 	} else {
 		err = open(source->device_path, O_RDONLY);
 		if (err < 0) {
 			err = -errno;
 			goto out_closefd;
 		}
-		ctx.vd.fd = err;
+		ctx._vd.fd = err;
 	}
 
 	err = erofs_nbd_connect(nbdfd, 9, EROFSMOUNT_NBD_DISK_SIZE);
 	if (err < 0) {
-		erofs_io_close(&ctx.vd);
+		erofs_io_close(ctx.vd);
 		goto out_closefd;
 	}
 	ctx.sk.fd = err;
 
 	err = -pthread_create(&th, NULL, erofsmount_nbd_loopfn, &ctx);
 	if (err) {
-		erofs_io_close(&ctx.vd);
+		erofs_io_close(ctx.vd);
 		erofs_io_close(&ctx.sk);
 		goto out_closefd;
 	}
@@ -840,7 +980,7 @@ static char *erofsmount_write_recovery_info(struct erofsmount_source *source)
 
 	if (source->type == EROFSMOUNT_SOURCE_OCI)
 		err = erofsmount_write_recovery_oci(f, source);
-	else
+	else if (source->type == EROFSMOUNT_SOURCE_LOCAL)
 		err = erofsmount_write_recovery_local(f, source);
 
 	fclose(f);
@@ -996,12 +1136,12 @@ static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 	if (err < 0)
 		return -ENOMEM;
 
-	err = erofsmount_reattach_oci(&ctx->vd, "OCI_NATIVE_BLOB", oci_source);
+	err = erofsmount_reattach_oci(ctx->vd, "OCI_NATIVE_BLOB", oci_source);
 	free(oci_source);
 	if (err)
 		return err;
 
-	temp_vd = ctx->vd;
+	temp_vd = *ctx->vd;
 	oci_cfg.image_ref = strdup(source);
 	if (!oci_cfg.image_ref) {
 		erofs_io_close(&temp_vd);
@@ -1013,7 +1153,7 @@ static int erofsmount_reattach_gzran_oci(struct erofsmount_nbd_ctx *ctx,
 	if (token_count > 4 && tokens[4] && *tokens[4])
 		zinfo_path = tokens[4];
 
-	err = erofsmount_tarindex_open(&ctx->vd, &oci_cfg,
+	err = erofsmount_tarindex_open(ctx->vd, &oci_cfg,
 				       meta_path, zinfo_path);
 	free(oci_cfg.image_ref);
 	erofs_io_close(&temp_vd);
@@ -1056,7 +1196,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 		return -errno;
 
 	if ((*pid = fork()) == 0) {
-		struct erofsmount_nbd_ctx ctx = {};
+		struct erofsmount_nbd_ctx ctx = {.vd = &ctx._vd};
 		char *recp;
 
 		/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
@@ -1065,25 +1205,42 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 
 		if (source->type == EROFSMOUNT_SOURCE_OCI) {
 			if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
-				err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
+				err = erofsmount_tarindex_open(ctx.vd, &source->ocicfg,
 							       source->ocicfg.tarindex_path,
 							       source->ocicfg.zinfo_path);
 				if (err)
 					exit(EXIT_FAILURE);
 			} else {
-				err = ocierofs_io_open(&ctx.vd, &source->ocicfg);
+				err = ocierofs_io_open(ctx.vd, &source->ocicfg);
 				if (err)
 					exit(EXIT_FAILURE);
 			}
+#ifdef S3EROFS_ENABLED
+		} else if (source->type == EROFSMOUNT_SOURCE_S3_OBJECT) {
+			char *bucket = NULL, *key = NULL;
+			struct erofs_vfile *s3vf;
+
+			err = erofsmount_parse_s3_source(&source->s3cfg, source->device_path,
+							 &bucket, &key);
+			if (err)
+				exit(EXIT_FAILURE);
+
+			s3vf = s3erofs_io_open(&source->s3cfg, bucket, key);
+			free(bucket);
+			free(key);
+			if (IS_ERR(s3vf))
+				exit(EXIT_FAILURE);
+			ctx.vd = s3vf;
+#endif
 		} else {
 			err = open(source->device_path, O_RDONLY);
 			if (err < 0)
 				exit(EXIT_FAILURE);
-			ctx.vd.fd = err;
+			ctx._vd.fd = err;
 		}
 		recp = erofsmount_write_recovery_info(source);
 		if (IS_ERR(recp)) {
-			erofs_io_close(&ctx.vd);
+			erofs_io_close(ctx.vd);
 			exit(EXIT_FAILURE);
 		}
 
@@ -1106,7 +1263,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 				}
 			}
 		}
-		erofs_io_close(&ctx.vd);
+		erofs_io_close(ctx.vd);
 out_fork:
 		(void)unlink(recp);
 		free(recp);
@@ -1186,13 +1343,13 @@ static int erofsmount_reattach(const char *target)
 			err = -errno;
 			goto err_line;
 		}
-		ctx.vd.fd = err;
+		ctx.vd->fd = err;
 	} else if (!strcmp(line, "TARINDEX_OCI_BLOB")) {
 		err = erofsmount_reattach_gzran_oci(&ctx, source);
 		if (err)
 			goto err_line;
 	} else if (!strcmp(line, "OCI_LAYER") || !strcmp(line, "OCI_NATIVE_BLOB")) {
-		err = erofsmount_reattach_oci(&ctx.vd, line, source);
+		err = erofsmount_reattach_oci(ctx.vd, line, source);
 		if (err)
 			goto err_line;
 	} else {
@@ -1214,7 +1371,7 @@ static int erofsmount_reattach(const char *target)
 		erofs_io_close(&ctx.sk);
 		err = 0;
 	}
-	erofs_io_close(&ctx.vd);
+	erofs_io_close(ctx.vd);
 err_line:
 	free(line);
 err_identifier:
-- 
2.43.5


