Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DCE154590
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2020 14:57:34 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48D0P830WWzDqb0
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2020 00:57:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1580997452;
	bh=gmWol/M6q9n4oFuinyAZ7jwKPLgVq7VonxO5dEz8m2M=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Mzz++hLFGfslXfJSifo710bJKW1o9dsMHUaCDe6v9VgLqnvk1jPEfmaDstpFSBy9O
	 Usga9MXiUsqL5f8FhJDwfuddJioOdgMj9znROhMDVOU6k/pGGGKqRCRMRx7KwG3lQg
	 F2UFhXVNpDj4kpZwOcV90jWKbr6y9EEOFu8iDR8rGnIDzZzk6/UI83DgmlMFsJkGNe
	 yjVWtOoUa+En7Lk4s2orpRIlJofZBGqsjOobLkXnjvwCy8z1NcUiq8ZmAZzfe1+JSc
	 Brfb8+xmJJJ8zIw68rhK4EjYgbI2ZWbPiy0sduDrTt7zt1Gdv/7yngorGcQ86M0fcg
	 yqNyUEfG6nIZQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.146; helo=sonic310-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=E/N/XAdz; dkim-atps=neutral
Received: from sonic310-20.consmr.mail.gq1.yahoo.com
 (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48D0Ns4MsJzDqHl
 for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2020 00:57:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1580997431; bh=i1sn/TvdxM54bMv0W1iJmMWh38GcbOjE02j9YFbl0Gg=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=E/N/XAdzA8AoOTOvel5dCb+DtHdotmy3HxwGACzLjz3OTIgfPvT4EnXaqziGsYU8Crbmq8YKncqlHxxuSqDODr0d7Txc3xuCUTy8b7kxsOzfAGsMs4ReY8uWbWhVBku5AibJVrlkrjUJ7gtASW5V7xmoRIs7pYH4CFJndQGXak1RtjNMKNPENKE2GpClVWH9ynhnqvf6Sv+JugnkNjAeMV/E6wXOBTRmNrZHpYvZ0zWPVywkMWBfrUZdVE4GrdzVuJJQjHtkKyOkm+yC5eN70l0BEE7gYUpC2bW1eviVhl6gpb6MmgjgzkyEtFbELk8EcLg6XbOehbJmY+B6B0qQzg==
X-YMail-OSG: E9._pEYVM1kITE9NuanNd3KPyDaBurE9F5aM0bz2nmeRh1t.CZor2p6B7NMd0tA
 z1q4KUgrrCAsgrbOA3MKUSiawpwvCTQ81gQd4GYqRVyw1c8jmTFuzOp4iRMEMG6PxFfTiBR2dZjD
 S2PXig4MPZrEQ6QdD7bPahUQhBmU0xTpeB48P0H_JSZkX_65PBwowK9O1NvcY1A4b2FyGoNQTddI
 8MDsu.tV6qYl2Z25pfmrqWCJte0B7R4psyGHj.Cf5nx.X20MRECg6o2HqSc4bMFX416Ih9PyEtvM
 P4Lx2bu4CgCgCorZ2pEv7EcM6Vf9sSerp5awBPiWi2JU.dEMt1U4U4xL58pbw4Q5hmqwrLPG8ULU
 5UoQTx0MDB4wiZYUwmcxIfWRSh4_9mTs6WR8OPx624TEXwzfhuBtfpf6et4kjvGMGz0CeDPwq9Di
 37nG2ZmJhgFEJmotpw7o2y0qK9B2F.mu4HiCMDicTpL9DPd_Fwq12awWDrzMfPdBeaMFjVOMyZuc
 SQ_ECChNf3kjN9ab3RQLP6pRGH9ZyZCAOBQ99Ltyp0ulS6l0tnaIn29ibowle5LPfwH0kj4uF5Ux
 sFhqbMkciFsUVnB8e1rigv8folphH.XcbINWWs9n2MKEcqiPqMszk1MizfTY1WaNhR8_iUodFkhk
 7k3AfOBXYBrXAYtgBPw50iFjCrGl0VOyuLn0lsym7exiEyTDnxB1na89dRHRxAcpNhZXdE7BKQMQ
 vmQ5hhUw9sWRIUojvJGqjoZ7aDA4o7FBoi.ksuEh1zluQRuORMM2Z..C3CLdvX_SDe6oXyRPxSaG
 aiQ7tOUN475OIBb.UPKDIpCoEcqru2J5jEbK9B8NAZ_ecJZWIzUV90IufTYKOK4V5kaUHiWLEhUf
 EwNbIhi2ZaPP3Z4sFX1Z5d.nWZ3klSVAfmE8ZnPVfWJfNHxpB4kQ.nfjEkBsm.JDZb46hfUtCsxa
 bfIlua_rGEC59qRW8I1wecTRY3ToSbLY3DjHjWtqT2GGcsWAQpLPVoYKxP1iZjFTmkrSN.9TEgUs
 7PJjgvrbvi2xOfHNC6rlz4iFlhYxAIvrQZFbrSU0WlTBsUyIN36bC7lQYAED.a2jAZ6AZp3om6n3
 6kJ_QOAtY7_IDrYMFCA0CNxCJspUuSp_w__Jh7iRTQwFTHxIg_PUsXIr6OsW4JclunXE4cTB7PF2
 5Bm32sNe_BnnLgZZIMWc3bE091.oTLyRX93Lpe.r6Ghtozz2nH50MjI3s8dRUhe.Ea6pAggSRW.U
 EPyVLNTXP5H50WHZCewBFBUXTw5JrLOXxi1EMBb4NJkFW608nZ.A1eJ7WxHWzRVrMjaonB5zrv5q
 u0cDwqTqJyiYaS97c6kGMitWelVPOW9N82aE5r.St.FCMLjCI8I812byil39K1cFKfC9kiz2zQQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Feb 2020 13:57:11 +0000
Received: by smtp428.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 10d08d27efeaae2667e2dd114f65b35a; 
 Thu, 06 Feb 2020 13:57:04 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] stress tester for EROFS filesystem
Date: Thu,  6 Feb 2020 21:56:31 +0800
Message-Id: <20200206135631.1491-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200206135631.1491-1-hsiangkao.ref@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce an open-source stress tester for EROFS to
do kernel regression test since fsstress cannot be
used in all read-only filesystems.

When it runs, given workers are spawned and read data
in different patterns. At the same time, stress tester
automatically drops page/slab caches and triggers page
compaction as well. Therefore, root permission is required.

Take a regression for example, revert

commit a112152f6f3a ("staging: erofs: fix mis-acted TAIL merging behavior")

will cause corrupted data due to bad tail-merging.

The issue can also be simply caused by killing
the following 2 lines in z_erofs_do_read_page():

if (cur)
	tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);

With enwik9 [1] dataset, it can then be observed by
using stress tester:

$ sudo ./stress testdir/enwik9 enwik9 > /dev/null

and output such messages:

doscan: 118784 bytes mismatch @ 9383936
test failed (17673): Bad message
...

[1] https://cs.fit.edu/~mmahoney/compression/textdata.html
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 stress.c | 385 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 385 insertions(+)
 create mode 100644 stress.c

diff --git a/stress.c b/stress.c
new file mode 100644
index 0000000..de23580
--- /dev/null
+++ b/stress.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * stress test for EROFS read-only filesystem
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#define _LARGEFILE64_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#define PAGE_SHIFT	12
+#define PAGE_SIZE	(1 << PAGE_SHIFT)
+#define MAX_CHUNKSIZE	(4 * 1024 * 1024)
+#define MAX_SCAN_CHUNKSIZE	(256 * 1024)
+
+unsigned int nprocs = 512;
+sig_atomic_t should_stop = 0;
+
+enum {
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
+		sleep(0);
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
+		sleep(0);
+	}
+	return 0;
+}
+
+int tryopen(char *filename)
+{
+	int fd = open(filename, O_RDONLY);
+
+	if (fd < 0)
+		return -errno;
+
+	/* use force_page_cache_readahead for every read request */
+	posix_fadvise(fd, 0, 0, POSIX_FADV_RANDOM);
+	return fd;
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
+int randread(int fd, int chkfd, uint64_t filesize)
+{
+	static char buf[MAX_CHUNKSIZE], chkbuf[MAX_CHUNKSIZE];
+
+	uint64_t start = (random() * random()) % filesize;
+	uint64_t length, count;
+	size_t nread, nread2;
+
+	count = 0;
+	do {
+		length = (random() * random()) % MAX_CHUNKSIZE;
+		if (++count > 1000 && length)
+			break;
+	} while (start + length > filesize || !length);
+
+	if (start + length > filesize)
+		length = filesize - start;
+
+	printf("randread(%u): %llu bytes @ %llu\n",
+	       getpid(), (unsigned long long)length,
+	       (unsigned long long)start);
+
+	nread = pread64(fd, buf, length, start);
+
+	if (nread != length)
+		return -errno;
+
+	if (chkfd < 0)
+		return 0;
+
+	nread2 = pread64(chkfd, chkbuf, length, start);
+	if (nread2 <= 0)
+		return -errno;
+
+	if (nread != nread2)
+		return -EFBIG;
+
+	if (memcmp(buf, chkbuf, nread)) {
+		fprintf(stderr, "randread: %llu bytes mismatch @ %llu\n",
+			(unsigned long long)length,
+			(unsigned long long)start);
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
+	if (mode == RANDSCAN_ALIGNED) {
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
+		err = randread(fd, chkfd, filesize);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+void randomdelay(void)
+{
+	clock_t start;
+	clock_t length = (random() * random() % CLOCKS_PER_SEC) >> 1;
+
+	start = clock();
+	while (clock() < start + length)
+		sleep(0);
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
+static char *testfile, *comprfile;
+
+static int parse_options(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "p:")) != -1) {
+		switch (opt) {
+		case 'p':
+			nprocs = atoi(optarg);
+			if (nprocs < 0) {
+				fprintf(stderr, "invalid workers %d\n",
+					nprocs);
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
+	testfile = argv[optind++];
+
+	if (argc > optind)
+		comprfile = argv[optind++];
+	return 0;
+}
+
+void usage(void)
+{
+	fputs("usage: [options] TESTFILE [COMPRFILE]\n\n"
+	      "stress tester for read-only filesystems\n"
+	      " -p#     set workers to #\n", stderr);
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
+	if (testfile) {
+		fd = tryopen(testfile);
+		if (fd < 0) {
+			fprintf(stderr, "cannot open testfile %s: %s\n",
+				testfile, strerror(errno));
+			return 1;
+		}
+	}
+
+	chkfd = -1;
+	if (comprfile) {
+		chkfd = tryopen(comprfile);
+		if (chkfd < 0) {
+			fprintf(stderr, "cannot open comprfile %s: %s\n",
+				comprfile, strerror(errno));
+			return 1;
+		}
+	}
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
+			sigemptyset(&action.sa_mask);
+			if (sigaction(SIGTERM, &action, 0)) {
+				perror("sigaction failed");
+				exit(1);
+			}
+
+			srandom(clock() * i);
+			while (!should_stop) {
+				int op = globalop[random() % GLOBALOPS];
+
+				if (op == DROP_FILE_CACHE_RAND ||
+				    op == DROP_FILE_CACHE_ALL) {
+					err = drop_file_cache(fd, op);
+				} else if (op <= RANDREAD) {
+					randomdelay();
+					err = testfd(fd, chkfd, op);
+				} else {
+					err = drop_caches(op);
+				}
+
+				if (err) {
+					fprintf(stderr, "test failed (%u): %s\n",
+						getpid(), strerror(-err));
+					exit(1);
+				}
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
+
-- 
2.20.1

