Return-Path: <linux-erofs+bounces-73-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C935A634BA
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 09:45:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFsBg4G4Xz2yMh;
	Sun, 16 Mar 2025 19:45:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742114747;
	cv=none; b=LMLzNbG5e+y7SmCL04UwhXP84dKJNrMpHWlmfjI23fbGebxBMejq7AdIMlPAZ6ILbcLBiRB/evPt/9hc5IyqjsX4GchsgLUD9awRIvE1kuMoSqc5ATYmvEWTD2IBL+SOoVZBIGFsMeUzB38H76FzC22aF9C+/3YjZbWhTne+MBXi6DWRu/WxNuG3GfLfwj6fYzge99Qa3fEIBXLRokdKRkOF95D0HBTcdDNC8B3cxkpKjodqjZB3VfN0rNwJGIDBt/IzE3BaheQmdnUteO2YStCuZSeXptPwswBTorDFfJ5H4ZaC3HKZPf7CVR/c/FWrLi0T80iGkZ2+9l8tnMkV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742114747; c=relaxed/relaxed;
	bh=8c/oFrBwpsKv3i/7iAxLSIuNfJ6Q6hnw99sRJIvftao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlw2gO+bBDTZPbNngwrUy8yTqFabesgdv1Cpz7deNTxNSKAzTSGTJ6pyfgYeL3i+A+4fOdN5SefjjmLdknk2s7wMgYNk2hbShS4DwIiaKvhbujlVGYN/cVoLZ70DTtMlUgWD1TDkuQMFRqUvIy9EO+iMw4CxZ4rtNRDDF6qsVHiZtL1epfYaXEx34DY6q1MoPGMnm/aEoWGL6y/Z8Hqptmgsr+jQZHTd/ex9fCrg5uTwjxzCOoKUVCDCIYsAUG9O1liZk30EVaSRpZ2CN+qxPp2C8hyMjAT9vCFrOaoo380AeYF72G/AMZBf4tAEKJRcDwkJg753EnDxJbhwt+DTWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eNpDngHi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eNpDngHi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFsBd4rz6z2yFQ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 19:45:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742114739; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8c/oFrBwpsKv3i/7iAxLSIuNfJ6Q6hnw99sRJIvftao=;
	b=eNpDngHiBxq19SQACcXWcA6pABvap6pscdSHTxm36E4nbuXBJzPGg6raOQOASresRnbDHX4sGJriijQ/2Z/S8clZwT/v54b/wcDbdVBwaFKTa4ElfNOrYrU1sRUZ93yUW1BG7czF2Thz76XWYXsJ6GXHWElMkA7gHpJYLeAdR5Q=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRTtS4j_1742114734 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 16:45:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: stress: add support for dumping inconsistent data
Date: Sun, 16 Mar 2025 16:45:33 +0800
Message-ID: <20250316084533.1446186-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

... dump inconsistent data for further analysis during stress tests.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 contrib/stress.c | 65 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/contrib/stress.c b/contrib/stress.c
index eedd9b9..27d5133 100644
--- a/contrib/stress.c
+++ b/contrib/stress.c
@@ -256,6 +256,7 @@ static struct fent *getfent(int which, int r)
 }
 
 static int testdir_fd = -1, chkdir_fd = -1;
+static char *dumpfile;
 
 static int __getdents_f(unsigned int sn, struct fent *fe)
 {
@@ -288,6 +289,47 @@ static int getdents_f(int op, unsigned int sn)
 	return __getdents_f(sn, fe);
 }
 
+static void baddump(unsigned int sn, char *buf1, char *buf2, unsigned int sz)
+{
+	int fd, err, i;
+	char *fn = dumpfile;
+
+	if (!fn)
+		return;
+	for (i = 0;;) {
+		fd = open(fn, O_CREAT | O_EXCL | O_WRONLY, 0644);
+		if (fd >= 0) {
+			printf("%d[%u]/%u: dump inconsistent data to \"%s\"\n",
+			       getpid(), procid, sn, fn);
+			if (fn != dumpfile)
+				free(fn);
+			break;
+		}
+		if (fd < 0 && errno != EEXIST) {
+			fprintf(stderr, "%d[%u]/%u: failed to create dumpfile %s\n",
+				getpid(), procid, sn, fn);
+			if (fn != dumpfile)
+				free(fn);
+			return;
+		}
+		if (fn != dumpfile)
+			free(fn);
+		err = asprintf(&fn, "%s.%d", dumpfile, ++i);
+		if (err < 0) {
+			fprintf(stderr, "%d[%u]/%u: failed to allocate filename\n",
+				getpid(), procid, sn);
+			return;
+		}
+	}
+	if (write(fd, buf1, sz) != sz)
+		fprintf(stderr, "%d[%u]/%u: failed to write buffer1 @ %u",
+			getpid(), procid, sn, sz);
+	if (write(fd, buf2, sz) != sz)
+		fprintf(stderr, "%d[%u]/%u: failed to write buffer2 @ %u",
+			getpid(), procid, sn, sz);
+	close(fd);
+}
+
 static int readlink_f(int op, unsigned int sn)
 {
 	char buf1[PATH_MAX], buf2[PATH_MAX];
@@ -317,6 +359,7 @@ static int readlink_f(int op, unsigned int sn)
 		if (memcmp(buf1, buf2, sz)) {
 			fprintf(stderr, "%d[%u]/%u %s: symlink mismatch @%s\n",
 				getpid(), procid, sn, __func__, fe->subpath);
+			baddump(sn, buf1, buf2, sz);
 			return -EBADMSG;
 		}
 	}
@@ -382,8 +425,8 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
 		trimmed = len <= filesize - off ? len : filesize - off;
 	}
 
-	printf("%d[%u]/%u read_f: %llu bytes @ %llu\n", getpid(), procid, sn,
-	       len | 0ULL, off | 0ULL);
+	printf("%d[%u]/%u read_f: %llu bytes @ %llu of %s\n", getpid(), procid,
+	       sn, len | 0ULL, off | 0ULL, fe->subpath);
 	nread = pread64(fe->fd, buf, len, off);
 	if (nread != trimmed) {
 		fprintf(stderr, "%d[%u]/%u read_f: failed to read %llu bytes @ %llu of %s\n",
@@ -414,6 +457,7 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
 		fprintf(stderr, "%d[%u]/%u read_f: data mismatch %llu bytes @ %llu of %s\n",
 			getpid(), procid, sn, len | 0ULL, off | 0ULL,
 			fe->subpath);
+		baddump(sn, buf, chkbuf, nread);
 		return -EBADMSG;
 	}
 	return 0;
@@ -481,6 +525,7 @@ static int __doscan_f(unsigned int sn, const char *op, struct fent *fe,
 			fprintf(stderr, "%d[%u]/%u %s: %llu bytes mismatch @ %llu of %s\n",
 				getpid(), procid, sn, op, chunksize | 0ULL,
 				pos | 0ULL, fe->subpath);
+			baddump(sn, buf, chkbuf, nread);
 			return -EBADMSG;
 		}
 	}
@@ -589,7 +634,7 @@ static int parse_options(int argc, char *argv[])
 	char *testdir, *chkdir;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "l:p:s:")) != -1) {
+	while ((opt = getopt(argc, argv, "d:l:p:s:")) != -1) {
 		switch (opt) {
 		case 'l':
 			loops = atoi(optarg);
@@ -614,6 +659,13 @@ static int parse_options(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 'd':
+			if (!*optarg) {
+				fprintf(stderr, "invalid dump file\n");
+				return -EINVAL;
+			}
+			dumpfile = optarg;
+			break;
 		default: /* '?' */
 			return -EINVAL;
 		}
@@ -650,9 +702,10 @@ static void usage(void)
 	fputs("usage: [options] TESTDIR [COMPRDIR]\n\n"
 	      "Stress test for EROFS filesystem, where TESTDIR is the directory to test and\n"
 	      "COMPRDIR (optional) serves as a directory for data comparison.\n"
-	      " -l#     Number of times each worker should loop (0 for infinite, default: 1)\n"
-	      " -p#     Number of parallel worker processes (default: 1)\n"
-	      " -s#     Seed for random generator (default: random)\n",
+	      " -l#             Number of times each worker should loop (0 for infinite, default: 1)\n"
+	      " -p#             Number of parallel worker processes (default: 1)\n"
+	      " -s#             Seed for random generator (default: random)\n"
+	      " -d<file>        Specify a dumpfile for the inconsistent data\n",
 	      stderr);
 }
 
-- 
2.43.5


