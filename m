Return-Path: <linux-erofs+bounces-1292-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89938C0C9D9
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Oct 2025 10:21:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cw7LL674mz2yw7;
	Mon, 27 Oct 2025 20:21:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761556906;
	cv=none; b=oHx0eL86M9NhPh7H3fvzIHrg1icQ4Vxg+IqgdYH/Xxo30ot79p6CKQek/NFgwWlzCZZQTkDt0yOH1ykmR7/YdEEQ9ljcDCEFFE3VD6QZaJqB0bZfGcAEC6X3BonyEk6XI1TOHLZCnF1IieKDxiDboPpvinEtLPPPX8wj2kgy1U0ORZkl/H47a3a8cic5RmU+SyoMoJSpf9Y3sN9bqWweCXAH6Gs7X+Iqx4i4cLVJ4Tn0tuuoKKrjucU3iylVEv2qVkCco/7Wcp9iZ7i32CPb3w8MTGbZp5apsYgVjlpjd7Fp4WheiYye+48PFL2gPFY6dKEih5aR+WGGnDvmm2B1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761556906; c=relaxed/relaxed;
	bh=grijIxM0hWIV0GgjZAEHltIIIMeToxq4pLTIcX3MZck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBEVi8OdbWJ8/iv3Z1NoVfQGMMRJqO3NZnNY1n61hpoVieqYoZvdTqWvI0u1XFv+GbAy0QipCLEy0GUieftjdZSYWBHBRI/hlrwuW0jqpMWUdk8cRJS9WartfhOsrIVIGJbUiMd8qAxMa6V3nak8WLC4LWhydE+sy62dxIcF4z52ydi6AUkpjnqYd8+SKJqOV/Loxl7IZKde73qdhDnFr48PmFwP9z/UnkrIxuP1vw+TziZBCkFAzxlOa7/oOUvj3I9bZCrlR/J4PySebUVHEtx8TXkgMP3ClVKTDTilAixGRkL34NnKzVfC0Dik6CuZ+NR49pcshhPCYpUAhBXKuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t3Cvgnt1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t3Cvgnt1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cw7LJ1ZYLz2yjs
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Oct 2025 20:21:42 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761556898; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=grijIxM0hWIV0GgjZAEHltIIIMeToxq4pLTIcX3MZck=;
	b=t3Cvgnt1NQiH1l+0CyO7zXOjAMQigYjo1a1na7Ec/Od81z2Sr4uIrEacbxIyzCitcJTAAKEPYA8GNYaHHZqMewSjWHk+owHi94hNfGavA8SzLmVaHVfUgV/sow1fdDmKgUzkt65i0Mfk2GP9FsfoJwxk1VsKSbrKffX9cyjKTCk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wr2mRmN_1761556896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 17:21:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: lib: add test for s3erofs_prepare_url()
Date: Mon, 27 Oct 2025 17:21:31 +0800
Message-ID: <20251027092131.348527-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251027092131.348527-1-hsiangkao@linux.alibaba.com>
References: <20251027092131.348527-1-hsiangkao@linux.alibaba.com>
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

From: Yifan Zhao <zhaoyifan28@huawei.com>

To avoid future regressions.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/Makefile.am  |   4 +-
 fsck/Makefile.am  |   8 +-
 fuse/Makefile.am  |   4 +-
 lib/Makefile.am   |  13 +++-
 lib/remotes/s3.c  | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 mkfs/Makefile.am  |   5 +-
 mount/Makefile.am |   4 +-
 7 files changed, 211 insertions(+), 20 deletions(-)

diff --git a/dump/Makefile.am b/dump/Makefile.am
index c56e19f..c2e0c74 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -6,6 +6,4 @@ bin_PROGRAMS     = dump.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index a1b4623..488b401 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -6,16 +6,12 @@ bin_PROGRAMS     = fsck.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
+fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la
 
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
 fuzz_erofsfsck_SOURCES = main.c
 fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
-fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
+fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la
 endif
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index cddfc7a..1e8f518 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -6,9 +6,7 @@ bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
-	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
-	${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS}
 
 if ENABLE_STATIC_FUSE
 lib_LTLIBRARIES = liberofsfuse.la
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 286932d..a792ccb 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -44,7 +44,9 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      vmdk.c metabox.c global.c importer.c base64.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
-liberofs_la_LDFLAGS =
+liberofs_la_LDFLAGS = ${libselinux_LIBS} ${libuuid_LIBS} ${liblz4_LIBS} \
+	${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
+	${libqpl_LIBS} ${libxxhash_LIBS}
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${liblz4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
@@ -74,6 +76,7 @@ endif
 liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${openssl_CFLAGS} ${libxml2_CFLAGS}
 if ENABLE_S3
 liberofs_la_SOURCES += remotes/s3.c
+liberofs_la_LDFLAGS += ${libxml2_LIBS} ${openssl_LIBS}
 endif
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS += -lpthread
@@ -81,9 +84,17 @@ liberofs_la_SOURCES += workqueue.c
 endif
 if OS_LINUX
 liberofs_la_CFLAGS += ${libnl3_CFLAGS}
+liberofs_la_LDFLAGS += ${libnl3_LIBS}
 liberofs_la_SOURCES += backends/nbd.c
 endif
 liberofs_la_SOURCES += remotes/oci.c
 liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${json_c_CFLAGS}
 liberofs_la_LDFLAGS += ${libcurl_LIBS} ${json_c_LIBS}
 liberofs_la_SOURCES += gzran.c
+
+if ENABLE_S3
+noinst_PROGRAMS  = s3erofs_test
+s3erofs_test_SOURCES = remotes/s3.c
+s3erofs_test_CFLAGS = -Wall -I$(top_srcdir)/include ${libxml2_CFLAGS} ${openssl_CFLAGS} -DTEST
+s3erofs_test_LDADD = liberofs.la
+endif
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 3675ab6..74cae8b 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -766,3 +766,196 @@ err_global:
 	s3erofs_curl_easy_exit(s3);
 	return ret;
 }
+
+#ifdef TEST
+struct s3erofs_prepare_utl_testcase {
+	const char *name;
+	const char *endpoint;
+	const char *bucket;
+	const char *key;
+	enum s3erofs_url_style url_style;
+	const char *expected_url;
+	const char *expected_canonical;
+	int expected_ret;
+};
+
+static bool run_s3erofs_prepare_url_test(const struct s3erofs_prepare_utl_testcase *tc)
+{
+	struct s3erofs_curl_request req = { .method = "GET" };
+	struct s3erofs_query_params params = { .num = 0 };
+	int ret;
+
+	printf("Running test: %s\n", tc->name);
+
+	ret = s3erofs_prepare_url(&req, tc->endpoint, tc->bucket, tc->key, &params,
+				  tc->url_style);
+
+	if (ret != tc->expected_ret) {
+		printf("  FAILED: expected return %d, got %d\n", tc->expected_ret, ret);
+		return false;
+	}
+
+	if (ret < 0) {
+		printf("  PASSED (expected error)\n");
+		return true;
+	}
+
+	if (tc->expected_url && strcmp(req.url, tc->expected_url) != 0) {
+		printf("  FAILED: URL mismatch\n");
+		printf("    Expected: %s\n", tc->expected_url);
+		printf("    Got:      %s\n", req.url);
+		return false;
+	}
+
+	if (tc->expected_canonical &&
+	    strcmp(req.canonical_query, tc->expected_canonical) != 0) {
+		printf("  FAILED: Canonical query mismatch\n");
+		printf("    Expected: %s\n", tc->expected_canonical);
+		printf("    Got:      %s\n", req.canonical_query);
+		return false;
+	}
+
+	printf("  PASSED\n");
+	printf("    URL: %s\n", req.url);
+	printf("    Canonical: %s\n", req.canonical_query);
+	return true;
+}
+
+static bool test_s3erofs_prepare_url(void)
+{
+	struct s3erofs_prepare_utl_testcase tests[] = {
+		{
+			.name = "Virtual-hosted style with https",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = "path/to/object.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://my-bucket.s3.amazonaws.com/path/to/object.txt",
+			.expected_canonical = "/my-bucket/path/to/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style with https",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = "path/to/object.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"https://s3.amazonaws.com/my-bucket/path/to/object.txt",
+			.expected_canonical = "/my-bucket/path/to/object.txt",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted with explicit https://",
+			.endpoint = "https://s3.us-west-2.amazonaws.com",
+			.bucket = "test-bucket",
+			.key = "file.bin",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://test-bucket.s3.us-west-2.amazonaws.com/file.bin",
+			.expected_canonical = "/test-bucket/file.bin",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style with explicit http://",
+			.endpoint = "http://localhost:9000",
+			.bucket = "local-bucket",
+			.key = "data/file.dat",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"http://localhost:9000/local-bucket/data/file.dat",
+			.expected_canonical = "/local-bucket/data/file.dat",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted style with key ends with slash",
+			.endpoint = "http://localhost:9000",
+			.bucket = "local-bucket",
+			.key = "data/file.dat/",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"http://local-bucket.localhost:9000/data/file.dat/",
+			.expected_canonical = "/local-bucket/data/file.dat/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style with key ends with slash",
+			.endpoint = "http://localhost:9000",
+			.bucket = "local-bucket",
+			.key = "data/file.dat/",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url =
+				"http://localhost:9000/local-bucket/data/file.dat/",
+			.expected_canonical = "/local-bucket/data/file.dat/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Virtual-hosted without key",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = NULL,
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url = "https://my-bucket.s3.amazonaws.com/",
+			.expected_canonical = "/my-bucket/",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Path style without key",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "my-bucket",
+			.key = NULL,
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = "https://s3.amazonaws.com/my-bucket",
+			.expected_canonical = "/my-bucket",
+			.expected_ret = 0,
+		},
+		{
+			.name = "Error: NULL endpoint",
+			.endpoint = NULL,
+			.bucket = "my-bucket",
+			.key = "file.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = NULL,
+			.expected_canonical = NULL,
+			.expected_ret = -EINVAL,
+		},
+		{
+			.name = "Error: NULL bucket",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = NULL,
+			.key = "file.txt",
+			.url_style = S3EROFS_URL_STYLE_PATH,
+			.expected_url = NULL,
+			.expected_canonical = NULL,
+			.expected_ret = -EINVAL,
+		},
+		{
+			.name = "Key with special characters",
+			.endpoint = "s3.amazonaws.com",
+			.bucket = "bucket",
+			.key = "path/to/file-name_v2.0.txt",
+			.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST,
+			.expected_url =
+				"https://bucket.s3.amazonaws.com/path/to/file-name_v2.0.txt",
+			.expected_canonical = "/bucket/path/to/file-name_v2.0.txt",
+			.expected_ret = 0,
+		}
+	};
+	bool succ = true;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		succ &= run_s3erofs_prepare_url_test(&tests[i]);
+		putc('\n', stdout);
+	}
+
+	printf("Run all %d tests\n", i);
+	return succ;
+}
+
+int main(int argc, char *argv[])
+{
+	exit(test_s3erofs_prepare_url() ? EXIT_SUCCESS : EXIT_FAILURE);
+}
+#endif
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index b84b4c1..aaefc11 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -5,7 +5,4 @@ bin_PROGRAMS     = mkfs.erofs
 AM_CPPFLAGS = ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
-	${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} \
-	${libcurl_LIBS} ${openssl_LIBS} ${libxml2_LIBS}
+mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la
diff --git a/mount/Makefile.am b/mount/Makefile.am
index 0b4447f..7f6efd8 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -7,7 +7,5 @@ sbin_PROGRAMS    = mount.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 mount_erofs_SOURCES = main.c
 mount_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
-mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${libnl3_LIBS} ${openssl_LIBS}
+mount_erofs_LDADD = $(top_builddir)/lib/liberofs.la
 endif
-- 
2.43.5


