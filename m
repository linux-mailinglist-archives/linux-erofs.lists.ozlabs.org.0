Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACA96755A
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 08:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725172988;
	bh=XWDF4DK1jpYKo5Zpql1RY94BmdMG/vS7KQDO6GHiK6U=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=HfDrtjOqrPsFulksgXwP3aeECXnBUNzAS8dT/NUHA8r6q6jSiK3Y1KSTF7z9n+mD6
	 gx5XOyIkUz/87LHJ2lpQlIMtg+dpbQhFQgPVWMFkkCAwNn45k483A/LLxtDBcys371
	 imlrsQuGNlNAEwnyRiYMXD7SyzS9NZDWcBgV0wBdMXTxlMk8GVke8Wknb58BEP4GYL
	 Z1Nrbt/nKKx0LuWGw8sp6PrqxJb/hO0Tsh4wawxyWrs52JB5qJ7VnLBu/kUejnHCTM
	 zHTz8LD6dDQilbpIk6RQ8I6Va/aBn7gqZHOIFQ1jxVo1MQmhAxNh5cVkLMGrHTjoAj
	 +4L6vQ9Zvv8iw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxMlc25wGz3c5F
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 16:43:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725172986;
	cv=none; b=hly7IpZJN80IqWKSCs9HmWo+bcS7rCV+DhSDntOMR2BSbGKaNmYWMHrX3k8vu+GOw8ZPqnN2UsTnaX2R0Kwape9cP+IPDr9k6cXq73uWsinpvMgQN+9k9MCqUrDxpf1J9Ik009CVFbl3ZJSZer1Vpje/PcdLO2WfIxez6FlxWJZrqtFHHmkVlNOV5rs4rLkl9tVozLGkYSyYnkPMP84+Cyu5R8qqNEs/b4qjKp40CneQLZ1jAQwuS22OsqxihJLdgJPWtuMgWjy7Vhg2PZBxwSL8PGRPzUC8uEaiZKHQUUkE7IV2x7SGN71H2WN9GY+OPpsejhEoM9e+zBs0zrxP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725172986; c=relaxed/relaxed;
	bh=XWDF4DK1jpYKo5Zpql1RY94BmdMG/vS7KQDO6GHiK6U=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=OJtfSLPjSl/fh+OIvvFXgH1uFWsNRrp5ydDvBs8px1Nz8bNZIAlUiMPI/pbo+J4hKQBZ52RQJSD8RXis2jjccC8jaySDt165QXpf4mp+4WnsaXzxv6KtcjPLSYiGwgV4PmU+XIcXNGueRQNORkMRUAM+i/ebNaXWgaQB50QqZ/5L1mbhPtb0awaS2Kv8Do9bxYcso6t2pvQJS8zRygETS+QDALMvu+aeX2gpnAkbA+JA93s7JomIXU4o5T6ERYOcRVXuFd8EUXn/xz879Tc58+PcT+dS1BWar151cUK89O1wCaSiF2rBQ/VTQFBFp1pNgU4bS2gmDoVnDgInAxA8Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=y7D0n+20; dkim-atps=neutral; spf=pass (client-ip=203.205.221.233; helo=out203-205-221-233.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=y7D0n+20;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.233; helo=out203-205-221-233.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxMlY5cdhz2xxy
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 16:43:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725172982; bh=XWDF4DK1jpYKo5Zpql1RY94BmdMG/vS7KQDO6GHiK6U=;
	h=From:To:Cc:Subject:Date;
	b=y7D0n+20l3Znx+sVdcOSHx3wLaNIsIHeOuHqKtHb/sT/HOHQ/EZWugSX+pbMB9MSg
	 oZUdh2XTatqwBE2y5azdntx0DYoCuPONeNRnWxmsFHSWT7yCbnQRX6L8csPqXsijBx
	 5XdhtBKWmKz/GXb4Jca2CNMIHRdNoATTuUiuaitc=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8F31DEF9; Sun, 01 Sep 2024 14:35:51 +0800
X-QQ-mid: xmsmtpt1725172551tfj2h4wgz
Message-ID: <tencent_4A38E7296EF52417020255BC66C869CE1909@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyKcCkvGgqjFzMMYIJr1GukoOkcFrZtXYtYr9vN+3cOElZtkG/jV
	 kl6YDqjpj/GSgS6UmJrtW3KMe0pQmJotDwZpGGyOoxc5QCYAev8rPwfObijjaUcYBSWlrccTWbyo
	 TTJJmV/Y1Ss3OU+jgqmm3U+o2/AGnNXiXL4dww2hNyGwEtPfzeVpV+M0vHvWrCViKvig8Vawfr09
	 GgdwA70qXPZ7xcWdhqy3FBQ8xR+5tHnnLYqxGrh6QTXhZakd20bIjNe35F6EfdOk7kMeJJHqm3WF
	 ZkG9ZCtbQsKoy19G7K6T1m9MFZAp5z9ABSdE8LFPXcu8xTONBK2oCnLGhroa860e5BIk+dY1SDAS
	 RqJH3cADq24ObH7KNAPxk5cvMtn0F0OeLlxXm5AKYb3DW858mLqHSeLPVI3GYQKgIfWdjVdjPsQa
	 F4CS12kC0MNW5/N9ZafqxfKS4OGZc11flUYy/dEBu19+snx3zrvXVXtz5C6Rpf8bs5C1ShNj7XZL
	 3INIYS0U1VBk4CwDrgHnapUVvQcodXyOd2jD8OAwQZFxy+482MXG5GRteDDVrlqF1IyO7TM2Gx9M
	 5wW4Zoftm4Hjwc0m9acbF4WC4AAMRzgTV6n4+MfpOYz7drDCzkSfkz4uDQRQwT1zAFjoGKk4wIqM
	 /whBrPJdbCB/lE2UoVImdyWluwQ9SjVxkX0T7Lh516YUCeC1W5YgEIcuVbu7HPBJEw5Fcu7p1yiI
	 BGT0lGSQI3sld1SaUoAKxvxvopIuoG3XaJkA5fUGY3tVNMlHXC4iCGXd4ngd7C37boB/yzjnAdGy
	 IAP49fYhVUiIYy3oL7ZiddbcudbQljfrVBRBUxR1uWtZLk0kwzedQU8IKLLGa+FsrtzZFl5DztdY
	 fM1DYg5R8JJWwhG4tl93T/mzGznvKoe9DlS5Iv1DzIq/iPCx5abgISegXzWxjknRIb32DEPYGR0s
	 6VhCx/8iC/dSfAvqiQoOHzgeo0f5QoFN1cCGhM8THBuPCkdqdyPpUBBAuzPRA+nyfX+txaN8BSwW
	 CvU2Oe8g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofsd-utils: tests: add stress test
Date: Sun,  1 Sep 2024 14:35:48 +0800
X-OQ-MSGID: <20240901063549.2134417-1-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
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
From: Jiawei Wang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jiawei Wang <kyr1ewang@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch add stress test for erofs utils.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 configure.ac                  |   1 +
 tests/Makefile.am             |   2 +-
 tests/erofsstress/Makefile.am |   7 +
 tests/erofsstress/stress.c    | 684 ++++++++++++++++++++++++++++++++++
 4 files changed, 693 insertions(+), 1 deletion(-)
 create mode 100644 tests/erofsstress/Makefile.am
 create mode 100644 tests/erofsstress/stress.c

diff --git a/configure.ac b/configure.ac
index 055b485..9145e4d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -635,5 +635,6 @@ AC_CONFIG_FILES([Makefile
 		 fuse/Makefile
 		 fsck/Makefile
 		 tests/Makefile
+		 tests/erofsstress/Makefile
 		 tests/src/Makefile])
 AC_OUTPUT
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 93016e5..e9f6a6d 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -2,7 +2,7 @@
 # Makefile.am
 
 AUTOMAKE_OPTIONS = serial-tests
-SUBDIRS = src
+SUBDIRS = src erofsstress
 
 TESTS =
 
diff --git a/tests/erofsstress/Makefile.am b/tests/erofsstress/Makefile.am
new file mode 100644
index 0000000..2a2c464
--- /dev/null
+++ b/tests/erofsstress/Makefile.am
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS	= foreign
+noinst_PROGRAMS		= stress
+
+stress_SOURCES = stress.c
diff --git a/tests/erofsstress/stress.c b/tests/erofsstress/stress.c
new file mode 100644
index 0000000..4dfe489
--- /dev/null
+++ b/tests/erofsstress/stress.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * stress test for EROFS filesystem
+ * based on https://lore.kernel.org/r/20200206135631.1491-1-hsiangkao@aol.com
+ *
+ * Copyright (C) 2019-2022 Gao Xiang <xiang@kernel.org>
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdbool.h>
+#include <dirent.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#define PAGE_SHIFT	12
+#define PAGE_SIZE	(1 << PAGE_SHIFT)
+#define MAX_CHUNKSIZE	(4 * 1024 * 1024)
+#define MAX_SCAN_CHUNKSIZE	(256 * 1024)
+
+bool superuser;
+unsigned int nprocs = 1, loops = 1, r_seed;
+sig_atomic_t should_stop = 0;
+
+enum {
+	GETDENTS,
+	READLINK,
+	RANDSCAN_ALIGNED,
+	RANDSCAN_UNALIGNED,
+	RANDREAD,		/* oneshot randread */
+	DROP_FILE_CACHE_RAND,
+	DROP_FILE_CACHE_ALL,
+	DROP_PAGE_CACHE,
+	DROP_SLAB_CACHE,
+	COMPACT_MEMORY,
+};
+
+const int globalop[] = {
+	GETDENTS,
+	GETDENTS,
+	GETDENTS,
+	READLINK,
+	READLINK,
+	READLINK,
+	RANDSCAN_ALIGNED,
+	RANDSCAN_UNALIGNED,
+	RANDSCAN_UNALIGNED,
+	RANDREAD,
+	RANDREAD,
+	RANDREAD,
+	DROP_FILE_CACHE_ALL,
+	DROP_PAGE_CACHE,
+	DROP_SLAB_CACHE,
+	COMPACT_MEMORY,
+};
+
+#define GLOBALOPS	(sizeof(globalop) / sizeof(globalop[0]))
+
+int drop_caches(int mode)
+{
+	static const char *procfile[] = {
+		[DROP_PAGE_CACHE] = "/proc/sys/vm/drop_caches",
+		[DROP_SLAB_CACHE] = "/proc/sys/vm/drop_caches",
+		[COMPACT_MEMORY] = "/proc/sys/vm/compact_memory",
+	};
+	static const char *val[] = {
+		[DROP_PAGE_CACHE] = "1\n",
+		[DROP_SLAB_CACHE] = "2\n",
+		[COMPACT_MEMORY] = "1\n",
+	};
+	FILE *f;
+	clock_t start;
+
+	if (!superuser)
+		return 0;
+	if (!procfile[mode])
+		return -EINVAL;
+
+	printf("drop_caches(%u): %s=%s", getpid(), procfile[mode], val[mode]);
+
+	f = fopen(procfile[mode], "w");
+	if (!f)
+		return -errno;
+
+	start = clock();
+	while (clock() < start + CLOCKS_PER_SEC) {
+		fputs(val[mode], f);
+		(void)sched_yield();
+	}
+	fclose(f);
+	return 0;
+}
+
+int drop_file_cache(int fd, int mode)
+{
+	clock_t start;
+
+	printf("drop_file_cache(%u)\n", getpid());
+	start = clock();
+	while (clock() < start + CLOCKS_PER_SEC / 2) {
+		posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
+		(void)sched_yield();
+	}
+	return 0;
+}
+
+struct fent {
+	char *subpath;
+	int  fd, chkfd;
+};
+
+#define FT_DIR	0
+#define FT_DIRm	(1 << FT_DIR)
+#define FT_REG	1
+#define FT_REGm	(1 << FT_REG)
+#define FT_SYM	2
+#define FT_SYMm	(1 << FT_SYM)
+#define FT_DEV	3
+#define FT_DEVm	(1 << FT_DEV)
+#define FT_nft	4
+#define FT_ANYm	((1 << FT_nft) - 1)
+
+#define	FLIST_SLOT_INCR	16
+
+struct flist {
+	int nfiles, nslots;
+	struct fent *fents;
+} flists[FT_nft];
+
+struct fent *add_to_flist(int type, char *subpath)
+{
+	struct fent *fep;
+	struct flist *ftp;
+
+	ftp = &flists[type];
+	if (ftp->nfiles >= ftp->nslots) {
+		ftp->nslots += FLIST_SLOT_INCR;
+		ftp->fents = realloc(ftp->fents,
+				     ftp->nslots * sizeof(struct fent));
+		if (!ftp->fents)
+			return NULL;
+	}
+	fep = &ftp->fents[ftp->nfiles++];
+	fep->subpath = strdup(subpath);
+	fep->fd = -1;
+	fep->chkfd = -1;
+	return fep;
+}
+
+static inline bool is_dot_dotdot(const char *name)
+{
+	if (name[0] != '.')
+		return false;
+
+	return name[1] == '\0' || (name[1] == '.' && name[2] == '\0');
+}
+
+int walkdir(struct fent *ent)
+{
+	const char *dirpath = ent->subpath;
+	int ret = 0;
+	struct dirent *dp;
+	DIR *_dir;
+
+	_dir = opendir(dirpath);
+	if (!_dir) {
+		fprintf(stderr, "failed to opendir at %s: %d",
+			dirpath, strerror(errno));
+		return -errno;
+	}
+
+	while (1) {
+		char subpath[PATH_MAX];
+		struct stat st;
+
+		/*
+		 * set errno to 0 before calling readdir() in order to
+		 * distinguish end of stream and from an error.
+		 */
+		errno = 0;
+		dp = readdir(_dir);
+		if (!dp)
+			break;
+
+		if (is_dot_dotdot(dp->d_name))
+			continue;
+
+		sprintf(subpath, "%s/%s", dirpath, dp->d_name);
+
+		if (lstat(subpath, &st))
+			continue;
+
+		switch (st.st_mode & S_IFMT) {
+		case S_IFDIR:
+			ent = add_to_flist(FT_DIR, subpath);
+			if (ent == NULL) {
+				ret = -ENOMEM;
+				goto err_closedir;
+			}
+			ret = walkdir(ent);
+			if (ret)
+				goto err_closedir;
+			break;
+		case S_IFREG:
+			ent = add_to_flist(FT_REG, subpath);
+			if (ent == NULL) {
+				ret = -ENOMEM;
+				goto err_closedir;
+			}
+			break;
+		case S_IFLNK:
+			ent = add_to_flist(FT_SYM, subpath);
+			if (ent == NULL) {
+				ret = -ENOMEM;
+				goto err_closedir;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+	if (errno)
+		ret = -errno;
+err_closedir:
+	closedir(_dir);
+	return ret;
+}
+
+int init_filetable(int testdir_fd)
+{
+	struct fent *fent;
+
+	fent = add_to_flist(FT_DIR, ".");
+	if (!fent)
+		return -ENOMEM;
+	fchdir(testdir_fd);
+	return walkdir(fent);
+}
+
+struct fent *getfent(int which, int r)
+{
+	int		totalsum = 0; /* total number of matching files */
+	int		partialsum = 0; /* partial sum of matching files */
+	struct flist	*flp;
+	int		i, x;
+
+	totalsum = 0;
+	for (i = 0, flp = flists; i < FT_nft; ++i, ++flp)
+		if (which & (1 << i))
+			totalsum += flp->nfiles;
+
+	if (!totalsum)
+		return NULL;
+
+	/*
+	 * Now we have possible matches between 0..totalsum-1.
+	 * And we use r to help us choose which one we want,
+	 * which when bounded by totalsum becomes x.
+	 */
+	x = (int)(r % totalsum);
+
+	for (i = 0, flp = flists; i < FT_nft; i++, flp++) {
+		if (which & (1 << i)) {
+			if (x < partialsum + flp->nfiles)
+				return &flp->fents[x - partialsum];
+			partialsum += flp->nfiles;
+		}
+	}
+	fprintf(stderr, "%s failure\n", __func__);
+	return NULL;
+}
+
+static int testdir_fd = -1, chkdir_fd = -1;
+
+int tryopen(struct fent *fe)
+{
+	if (fe->fd < 0) {
+		fe->fd = openat(testdir_fd, fe->subpath, O_RDONLY);
+		if (fe->fd < 0)
+			return -errno;
+
+		/* use force_page_cache_readahead for every read request */
+		posix_fadvise(fe->fd, 0, 0, POSIX_FADV_RANDOM);
+	}
+
+	if (chkdir_fd >= 0 && fe->chkfd < 0)
+		fe->chkfd = openat(chkdir_fd, fe->subpath, O_RDONLY);
+	return 0;
+}
+
+int doscan(int fd, int chkfd, uint64_t filesize, uint64_t chunksize)
+{
+	static char buf[MAX_SCAN_CHUNKSIZE], chkbuf[MAX_SCAN_CHUNKSIZE];
+	uint64_t pos;
+
+	printf("doscan(%u): filesize: %llu, chunksize: %llu\n",
+	       getpid(), (unsigned long long)filesize,
+	       (unsigned long long)chunksize);
+
+	for (pos = 0; pos < filesize; pos += chunksize) {
+		ssize_t nread, nread2;
+
+		nread = pread64(fd, buf, chunksize, pos);
+
+		if (nread <= 0)
+			return -errno;
+
+		if (nread < chunksize && nread != filesize - pos)
+			return -ERANGE;
+
+		if (chkfd < 0)
+			continue;
+
+		nread2 = pread64(chkfd, chkbuf, chunksize, pos);
+		if (nread2 <= 0)
+			return -errno;
+
+		if (nread != nread2)
+			return -EFBIG;
+
+		if (memcmp(buf, chkbuf, nread)) {
+			fprintf(stderr, "doscan: %llu bytes mismatch @ %llu\n",
+				(unsigned long long)chunksize,
+				(unsigned long long)pos);
+			return -EBADMSG;
+		}
+	}
+	return 0;
+}
+
+int getdents_f(struct fent *fe)
+{
+	int dfd;
+	DIR *dir;
+
+	printf("getdents_f(%u): @ %s\n", getpid(), fe->subpath);
+	dfd = openat(testdir_fd, fe->subpath, O_DIRECTORY);
+	if (dfd < 0)
+		return -errno;
+	dir = fdopendir(dfd);
+
+	while (readdir64(dir) != NULL)
+		continue;
+	closedir(dir);
+	return 0;
+}
+
+int readlink_f(struct fent *fe)
+{
+	char buf1[PATH_MAX], buf2[PATH_MAX];
+	ssize_t sz;
+
+	printf("readlink_f(%u): @ %s\n", getpid(), fe->subpath);
+	sz = readlinkat(testdir_fd, fe->subpath, buf1, PATH_MAX - 1);
+	if (sz < 0)
+		return -errno;
+
+	if (chkdir_fd >= 0) {
+		if (sz != readlinkat(testdir_fd, fe->subpath, buf2,
+				     PATH_MAX - 1)) {
+			fprintf(stderr, "doscan: symlink length mismatch @%s\n",
+				fe->subpath);
+			return -E2BIG;
+		}
+		if (memcmp(buf1, buf2, sz)) {
+			fprintf(stderr, "doscan: symlink mismatch @%s\n",
+				fe->subpath);
+			return -EBADMSG;
+		}
+	}
+	return 0;
+}
+
+int read_f(int fd, int chkfd, uint64_t filesize)
+{
+	static char buf[MAX_CHUNKSIZE], chkbuf[MAX_CHUNKSIZE];
+	uint64_t lr, off, len, trimmed;
+	size_t nread, nread2;
+
+	lr = ((uint64_t) random() << 32) + random();
+	off = lr % filesize;
+	len = (random() % MAX_CHUNKSIZE) + 1;
+	trimmed = len;
+
+	if (off + len > filesize) {
+		uint64_t a = filesize - off + 16 * getpagesize();
+
+		if (len > a)
+			len %= a;
+		trimmed = len <= filesize - off ? len : filesize - off;
+	}
+
+	printf("read_f(%u): %llu bytes @ %llu\n", getpid(),
+	       len | 0ULL, off | 0ULL);
+
+	nread = pread64(fd, buf, len, off);
+	if (nread != trimmed) {
+		fprintf(stderr, "read_f(%d, %u): failed to read %llu bytes @ %llu\n",
+			__LINE__, getpid(), len | 0ULL, off | 0ULL);
+		return -errno;
+	}
+
+	if (chkfd < 0)
+		return 0;
+
+	nread2 = pread64(chkfd, chkbuf, len, off);
+	if (nread2 <= 0) {
+		fprintf(stderr, "read_f(%d, %u): failed to read %llu bytes @ %llu\n",
+			__LINE__, getpid(), len | 0ULL, off | 0ULL);
+		return -errno;
+	}
+
+	if (nread != nread2) {
+		fprintf(stderr, "read_f(%d, %u): size mismatch %llu bytes @ %llu\n",
+			__LINE__, getpid(), len | 0ULL, off | 0ULL);
+		return -EFBIG;
+	}
+
+	if (memcmp(buf, chkbuf, nread)) {
+		fprintf(stderr, "read_f(%d, %u): data mismatch %llu bytes @ %llu\n",
+			__LINE__, getpid(), len | 0ULL, off | 0ULL);
+		return -EBADMSG;
+	}
+	return 0;
+}
+
+int testfd(int fd, int chkfd, int mode)
+{
+	const off64_t filesize = lseek64(fd, 0, SEEK_END);
+	uint64_t chunksize, maxchunksize;
+	int err;
+
+	if (!filesize)
+		return 0;
+
+	if (mode == RANDSCAN_ALIGNED && filesize > PAGE_SIZE) {
+		maxchunksize = (filesize - PAGE_SIZE > MAX_SCAN_CHUNKSIZE ?
+				MAX_SCAN_CHUNKSIZE : filesize - PAGE_SIZE);
+
+		chunksize = random() * random() % maxchunksize;
+		chunksize = (((chunksize - 1) >> PAGE_SHIFT) + 1)
+			<< PAGE_SHIFT;
+		if (!chunksize)
+			chunksize = PAGE_SIZE;
+		err = doscan(fd, chkfd, filesize, chunksize);
+		if (err)
+			return err;
+	} else if (mode == RANDSCAN_UNALIGNED) {
+		chunksize = (random() * random() % MAX_SCAN_CHUNKSIZE) + 1;
+		err = doscan(fd, chkfd, filesize, chunksize);
+		if (err)
+			return err;
+	} else if (mode == RANDREAD) {
+		err = read_f(fd, chkfd, filesize);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+int doproc(int mode)
+{
+	struct fent *fe;
+	int ret;
+
+	if (mode <= GETDENTS) {
+		fe = getfent(FT_DIRm, random());
+		if (!fe)
+			return 0;
+
+		if (mode == GETDENTS)
+			return getdents_f(fe);
+	} else if (mode <= READLINK) {
+		fe = getfent(FT_SYMm, random());
+		if (!fe)
+			return 0;
+
+		if (mode == READLINK)
+			return readlink_f(fe);
+	}
+	fe = getfent(FT_REGm, random());
+	if (!fe)
+		return 0;
+	ret = tryopen(fe);
+	if (ret)
+		return ret;
+	return testfd(fe->fd, fe->chkfd, mode);
+}
+
+void randomdelay(void)
+{
+	uint64_t lr = ((uint64_t) random() << 32) + random();
+	clock_t start;
+	clock_t length = (lr % CLOCKS_PER_SEC) >> 1;
+
+	start = clock();
+	while (clock() < start + length)
+		(void)sched_yield();
+}
+
+void sg_handler(int signum)
+{
+	switch (signum) {
+	case SIGTERM:
+		should_stop = 1;
+		break;
+	default:
+		break;
+	}
+}
+
+static int parse_options(int argc, char *argv[])
+{
+	char *testdir, *chkdir;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "l:p:s:")) != -1) {
+		switch (opt) {
+		case 'l':
+			loops = atoi(optarg);
+			if (loops < 0) {
+				fprintf(stderr, "invalid loops %d\n", loops);
+				return -EINVAL;
+			}
+			break;
+		case 'p':
+			nprocs = atoi(optarg);
+			if (nprocs < 0) {
+				fprintf(stderr, "invalid workers %d\n",
+					nprocs);
+				return -EINVAL;
+			}
+			break;
+		case 's':
+			r_seed = atoi(optarg);
+			if (r_seed < 0) {
+				fprintf(stderr, "invalid random seed %d\n",
+					r_seed);
+				return -EINVAL;
+			}
+			break;
+		default: /* '?' */
+			return -EINVAL;
+		}
+	}
+
+	if (optind >= argc)
+		return -EINVAL;
+
+	testdir = argv[optind++];
+	if (testdir) {
+		testdir_fd = open(testdir, O_PATH);
+		if (testdir_fd < 0) {
+			fprintf(stderr, "cannot open testdir fd @ %s: %s\n",
+				testdir, strerror(errno));
+			return 1;
+		}
+	}
+
+	if (argc > optind) {
+		chkdir = argv[optind++];
+
+		chkdir_fd = open(chkdir, O_PATH);
+		if (chkdir_fd < 0) {
+			fprintf(stderr, "cannot open checkdir fd @ %s: %s\n",
+				chkdir, strerror(errno));
+			return 1;
+		}
+	}
+	return 0;
+}
+
+void usage(void)
+{
+	fputs("usage: [options] TESTDIR [COMPRDIR]\n\n"
+	      "stress test for EROFS filesystem\n"
+	      " -l#     specifies the no. of times the testrun should loop.\n"
+	      "         *use 0 for infinite (default 1)\n"
+	      " -p#     specifies the no. of processes (default 1)\n"
+	      " -s#     specifies the seed for the random generator (default random)\n",
+	      stderr);
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int i;
+	int err, stat;
+	int fd, chkfd;
+	struct sigaction action;
+
+	err = parse_options(argc, argv);
+	if (err) {
+		if (err == -EINVAL)
+			usage();
+		return 1;
+	}
+
+	err = init_filetable(testdir_fd);
+	if (err) {
+		fprintf(stderr, "cannot initialize file table: %s\n",
+			strerror(errno));
+		return 1;
+	}
+
+	superuser = (geteuid() == 0);
+	setpgid(0, 0);
+	action.sa_handler = sg_handler;
+	action.sa_flags = 0;
+
+	if (sigaction(SIGTERM, &action, 0)) {
+		perror("sigaction failed");
+		exit(1);
+	}
+
+	/* spawn nprocs processes */
+	for (i = 0; i < nprocs; ++i) {
+		if (fork() == 0) {
+			bool infinite_loop = !loops;
+
+			sigemptyset(&action.sa_mask);
+			if (sigaction(SIGTERM, &action, 0)) {
+				perror("sigaction failed");
+				exit(1);
+			}
+
+			srandom((r_seed ? :
+				 (time(NULL) ? : 1) * getpid()) * (i + 1));
+
+			while (!should_stop && (infinite_loop || loops)) {
+				int op = globalop[random() % GLOBALOPS];
+
+				if (op == DROP_FILE_CACHE_RAND ||
+				    op == DROP_FILE_CACHE_ALL) {
+					err = drop_file_cache(fd, op);
+				} else if (op <= RANDREAD) {
+					randomdelay();
+					err = doproc(op);
+				} else {
+					err = drop_caches(op);
+				}
+
+				if (err) {
+					fprintf(stderr, "test failed (%u): %s\n",
+						getpid(), strerror(-err));
+					exit(1);
+				}
+				--loops;
+			}
+			return 0;
+		}
+	}
+
+	err = 0;
+	while (wait(&stat) > 0 && !should_stop) {
+		if (!WIFEXITED(stat)) {
+			err = 1;
+			break;
+		}
+
+		if (WEXITSTATUS(stat)) {
+			err = WEXITSTATUS(stat);
+			break;
+		}
+	}
+	action.sa_flags = SA_RESTART;
+	sigaction(SIGTERM, &action, 0);
+	kill(-getpid(), SIGTERM);
+	/* wait until all children exit */
+	while (wait(&stat) > 0)
+		continue;
+
+	if (chkfd >= 0)
+		close(chkfd);
+	close(fd);
+	return err;
+}
-- 
2.34.1

