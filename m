Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693D979C5E
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 10:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726473667;
	bh=L5cj07VjICIGJdU4+Y25/wkmn+x9ZFiaKIEwQ+TZbqA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hI0RBHAoSZA+Ieq04QwW8cr9XsqaPIhWLWL0FQPqHelrLYm61XkzrLvTe3hzV42H5
	 HBTYqUqqHb0/zg2Lg/8GNjZjffZNFhzba/75xhxAxKUrSJVhB3HMn7phfrDuAKDLHs
	 GmKd7gIbZ0XcwmxcShv1AQpqpHUAqs8N0tSZS5U7kccfiarh1zckSrdUXdciIZTTsg
	 FLMQuTc9nTe5az5Hl0kplo0ApIGcR2KaeL5Lpv7pDj3UryafIJmVeYoPCkPCNEPFek
	 5EOsSKWbAkabwrl/DrdtKXJOrz5EJ55w6O+fGvgkWo+Fy8oiNJ1SwUnW2Xu6IF602p
	 RTAuX9AVB9qxA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6cmg5YlWz2yY1
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 18:01:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726473665;
	cv=none; b=n4D97Lj17/L036AONvAodFQO6t0oWUNwLvn99t0O4pVkYhjUOIGvdoRFtls+TXIlG1YxID99v08WxfIL9CprjXgx1+6N87VHz+EgLSUNpdMsw6Hcwf2XMcIlRRhxe3tO84Tf70GIPrvb6S6XjZ58EjMaH8uVfbKZEgzF09GQ5BMTKQk43Vp6Zte9Hcp+PNQEY85lpbb5aeWbryye3q/FgqMe5UVV0qwe3Xl15IFDjrtgCVVrmxpFUw12+vmGpd05sDpWyYJ0UbUKM15mAPoU5xHQZ/gRklmRbofVqY9KhqL0RQ1EOWEqQpeafR7Uh44KRQ9LOvHQAJ8tGr25HNLf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726473665; c=relaxed/relaxed;
	bh=L5cj07VjICIGJdU4+Y25/wkmn+x9ZFiaKIEwQ+TZbqA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gB/PNRcTMi0+GSKgFKC9WSqE6zVN/XVHT7NWT+L/Z/JmmSi5IpZQxW1agDO1OUyEpz5nJH0Y0Hu6ccfcfn5ai7hypPoHJgfyuqeB/SCYQBsW2SoG0jWnD9qF6rKsfU6lgX0VORYWMCi6AdD63h+IG9CJwQpULse+EkuKEVUdbEA3OHHiY90iU8yrNzoZ9yXzlhVnkDlRPUaL7onoSgyZXGkfy5m44hdejPRe8c7qU2jdadTGfyLh88ivkN8c5Khev5jhjZOa/wOPgDtbs8c8w6IVdwBepL0oNwXzRhwzFNky4Hm5XSh1GprmfT3PXXdgs2Gbnk6RqFXfbgZmE6lmSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Vm6JIGTa; dkim-atps=neutral; spf=pass (client-ip=203.205.221.153; helo=out203-205-221-153.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Vm6JIGTa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.153; helo=out203-205-221-153.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4X6cmc5MC9z2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 18:01:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726473660; bh=L5cj07VjICIGJdU4+Y25/wkmn+x9ZFiaKIEwQ+TZbqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vm6JIGTaQW3iUTMY27+zl6vqkL11nJb2Q2oZCO+6urlMfQw/MKVi1XOS2TW4O/FCh
	 KDbeJLIVg3tquKrfmWZkmjW9bwl4k+O7lbA1lP2/xrISB9dN7oSf0xX4WGSs/vQZAe
	 nsqi1kuCKWKwKKZEtXBH3GYaOT3qj0gVcz3+ozjs=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id D7406224; Mon, 16 Sep 2024 15:53:52 +0800
X-QQ-mid: xmsmtpt1726473233t4cc1x9oe
Message-ID: <tencent_9AF319B7B192C501062AAA339534DC0C4408@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTq01UExEAd02tNLb8W8i5EiotTZO5kQZ4BdHWcUI/LkmwSXGYZ7
	 mem630OUnEhuI8ynwLU64AXA8rS0zMeN4Dxhtzarp20TDFg61k3M2cwNfjODT1y0PA4ytf0rbWWB
	 rHZ/aJOkQPcJCVJrBk2dCPP506HWiOa8Ks0hEnjzEcV6CEEXmiC9peFmG3UTxGqOpsto1YMkeeHj
	 OnUo1aTlFbX37oF1VmX3Qe2pFoURoyTR7LUXP5l5WdO0MsAZjs5txz3XFP+tci1g2P1Y/Cn0pKYl
	 UuCPX15rRuajubynlEzwJICrB2nNuHEKH1gIiZUxsfH1uJ2MDjDgUV8wNkrGxSt3NPc0gu9C0EYP
	 ReiHZBIWyqF3fv4/Pr8MtXQJFmTxyGYib9ZGpx06rX46eG9GxUWlZOjgu6ibG8NJpc/Im4XNJl/U
	 GTy54pq6Jisqo1eg8rQunVP8xH7VNzOeh8EUa5sxqJUdgTWb2cfeGCHKqhHsNaCSh3FmBtEB0WiO
	 EPaOcB8PD3uEcOGL2nMfNvcCVMX7vDfPeraBk2xNpQ+ny9VSBHNnYEPHZrIt2wmpsvMqD2AHabCK
	 H8HMaxyJOCVHVl0F0YxP5GTVgXWzrCVNDQWjeBVl6bfc69qhEoha9BnxXTOhspAgKxcwokrnE56J
	 QgfFK8JKZ7RJzGVyUvsFXH9YQrHpY6561h7+sZ/awBJfZCZQubaZT3UH6jp4+sceU2GWobCbTN2x
	 TjSiYRGg3LRkj1/VhUZM4j3QWaOrobIjmgSWbsVDO12kerOTjuQO7OjnYOxXbVitmSAgVftH4PlL
	 J6YrzK6HR0i7btw3hErnCD9DNu4vqJ/ntriAkXB5Hfccfjgzmr/8EdbuQ0v3oKGol9m4RTQpok2D
	 huxsxQg3C7d3oRoK/ZIjmrX/qf1uo+IXq+wKYHh78d62bNPdiWZkf6d1wT//I5bfq4GXWY9aBDiU
	 R04DrejS23Wiz9Tl07Akyx8YX66quWNSCmXvmCmQz0SKn6leXH1YnfhdaWzBoeu2SYfppRQenNU0
	 nr1wUPvQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils:tests: add new test options for stress tests
Date: Mon, 16 Sep 2024 15:53:51 +0800
X-OQ-MSGID: <20240916075351.2448016-2-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916075351.2448016-1-kyr1ewang@qq.com>
References: <20240916075351.2448016-1-kyr1ewang@qq.com>
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
Cc: lyr1ewang@qq.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch add some new test options (direct_io, mmap and fadvise) for
stress test.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 tests/erofsstress/stress.c | 459 +++++++++++++++++++++++++++++++++----
 1 file changed, 418 insertions(+), 41 deletions(-)

diff --git a/tests/erofsstress/stress.c b/tests/erofsstress/stress.c
index 4dfe489..84a665c 100644
--- a/tests/erofsstress/stress.c
+++ b/tests/erofsstress/stress.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/mman.h>
 #include <time.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -27,6 +28,9 @@
 #define MAX_SCAN_CHUNKSIZE	(256 * 1024)
 
 bool superuser;
+bool direct_io = false;
+bool mmap_flag = false;
+bool fadvise_flag = false;
 unsigned int nprocs = 1, loops = 1, r_seed;
 sig_atomic_t should_stop = 0;
 
@@ -114,6 +118,8 @@ int drop_file_cache(int fd, int mode)
 
 struct fent {
 	char *subpath;
+	void *fd_ptr;
+	void *chkfd_ptr;
 	int  fd, chkfd;
 };
 
@@ -282,60 +288,276 @@ static int testdir_fd = -1, chkdir_fd = -1;
 
 int tryopen(struct fent *fe)
 {
+	int err;
+	uint64_t filesize;
+	
 	if (fe->fd < 0) {
-		fe->fd = openat(testdir_fd, fe->subpath, O_RDONLY);
+		fe->fd = openat(testdir_fd, fe->subpath, direct_io ? O_RDONLY | O_DIRECT : O_RDONLY);
 		if (fe->fd < 0)
 			return -errno;
 
 		/* use force_page_cache_readahead for every read request */
 		posix_fadvise(fe->fd, 0, 0, POSIX_FADV_RANDOM);
+		
+		filesize = lseek64(fe->fd, 0, SEEK_END);
+		if (mmap_flag) {
+			fe->fd_ptr = mmap(NULL, filesize, PROT_READ, MAP_PRIVATE, fe->fd, 0);
+			if (fe->fd_ptr == MAP_FAILED) {
+				fprintf(stderr, "%s failed mmap\n", __func__);
+				return -errno;
+			}
+		}
 	}
 
-	if (chkdir_fd >= 0 && fe->chkfd < 0)
-		fe->chkfd = openat(chkdir_fd, fe->subpath, O_RDONLY);
+	if (chkdir_fd >= 0 && fe->chkfd < 0) {
+		fe->chkfd = openat(chkdir_fd, fe->subpath, direct_io ? O_RDONLY | O_DIRECT : O_RDONLY);
+		
+		if (fe->chkfd > 0) {
+			filesize = lseek64(fe->chkfd, 0, SEEK_END);
+			if (mmap_flag) {
+				fe->chkfd_ptr = mmap(NULL, filesize, PROT_READ, MAP_PRIVATE, fe->chkfd, 0);
+				if (fe->chkfd_ptr == MAP_FAILED) {
+					fprintf(stderr, "%s failed mmap\n", __func__);
+					return -errno;
+				}
+			}
+		} else
+			fe->chkfd_ptr = NULL;
+	}
 	return 0;
 }
 
-int doscan(int fd, int chkfd, uint64_t filesize, uint64_t chunksize)
+void mismatch_output(struct  fent *ent, uint64_t pos, uint64_t chunksize)
+{
+	int fd, ret;
+	ssize_t nread, nread2;
+	char filename[20];
+	char *buf, *chkbuf;
+	
+	ret = posix_memalign(&buf, PAGE_SIZE, MAX_SCAN_CHUNKSIZE);
+	if (ret) {
+		fprintf(stderr, "posix_memalign failed: %s\n", strerror(ret));
+		goto cleanup;
+	}
+	nread = pread64(ent->fd, buf, chunksize, pos);
+	if (nread <= 0) {
+		fprintf(stderr, "read file failed");
+		goto cleanup;
+	}
+	
+	ret = posix_memalign(&chkbuf, PAGE_SIZE, MAX_SCAN_CHUNKSIZE);
+	if (ret) {
+		fprintf(stderr, "posix_memalign failed: %s\n", strerror(ret));
+		goto cleanup;
+	}
+	nread2 = pread64(ent->chkfd, chkbuf, chunksize, pos);
+	if (nread2 <=0) {
+		fprintf(stderr, "read file failed");
+		goto cleanup;
+	}
+	
+	sprintf(filename, "%d", getpid());
+	strcat(filename, "_mismatch");
+	fd = open(filename, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
+	if (fd == -1) {
+		fprintf(stderr, "error opening file");
+		goto cleanup;
+	}
+	
+	ret = write(fd, ent->subpath, strlen(ent->subpath));
+	if (ret == -1) {
+		fprintf(stderr, "error writing file");
+		goto cleanup;
+	}
+	write(fd, "\n", 1);
+	
+	ret = write(fd, buf, nread);
+	if (ret == -1) {
+		fprintf(stderr, "error writing file");
+		goto cleanup;
+	}
+	write(fd, "\n", 1);
+	ret = write(fd, chkbuf, nread2);
+	if (ret == -1) {
+		fprintf(stderr, "error writing file");
+		goto cleanup;
+	}
+cleanup:
+	free(buf);
+	free(chkbuf);
+}
+
+int doscan(struct fent *ent, uint64_t filesize, uint64_t chunksize)
 {
-	static char buf[MAX_SCAN_CHUNKSIZE], chkbuf[MAX_SCAN_CHUNKSIZE];
+	char *buf, *chkbuf;
 	uint64_t pos;
+	int err = 0;
 
 	printf("doscan(%u): filesize: %llu, chunksize: %llu\n",
 	       getpid(), (unsigned long long)filesize,
 	       (unsigned long long)chunksize);
-
+	
+	err = posix_memalign(&buf, PAGE_SIZE, MAX_SCAN_CHUNKSIZE);
+	if (err) {
+		fprintf(stderr, "posix_memalign failed: %s\n", strerror(err));
+		goto cleanup;
+	}
+	
+	err = posix_memalign(&chkbuf, PAGE_SIZE, MAX_SCAN_CHUNKSIZE);
+	if (err) {
+		fprintf(stderr, "posix_memalign failed: %s\n", strerror(err));
+		goto cleanup;
+	}
+	
 	for (pos = 0; pos < filesize; pos += chunksize) {
 		ssize_t nread, nread2;
+		
+		nread = pread64(ent->fd, buf, chunksize, pos);
+		if (nread <= 0) {
+			err = -errno;
+			goto cleanup;
+		}
 
-		nread = pread64(fd, buf, chunksize, pos);
-
-		if (nread <= 0)
-			return -errno;
-
-		if (nread < chunksize && nread != filesize - pos)
-			return -ERANGE;
+		if (nread < chunksize && nread != filesize - pos) {
+			err = -ERANGE;
+			goto cleanup;
+		}
 
-		if (chkfd < 0)
+		if (ent->chkfd < 0)
 			continue;
 
-		nread2 = pread64(chkfd, chkbuf, chunksize, pos);
-		if (nread2 <= 0)
-			return -errno;
+		nread2 = pread64(ent->chkfd, chkbuf, chunksize, pos);
+		if (nread2 <= 0) {
+			err = -errno;
+			goto cleanup;
+		}
 
-		if (nread != nread2)
-			return -EFBIG;
+		if (nread != nread2) {
+			err = -EFBIG;
+			goto cleanup;
+		}
 
 		if (memcmp(buf, chkbuf, nread)) {
 			fprintf(stderr, "doscan: %llu bytes mismatch @ %llu\n",
 				(unsigned long long)chunksize,
 				(unsigned long long)pos);
+			mismatch_output(ent, pos, chunksize);
+			err = -EBADMSG;
+			goto cleanup;
+		}
+	}
+	
+cleanup:
+	free(buf);
+	free(chkbuf);
+	return err;
+}
+
+int doscan_mmap(struct fent *ent, uint64_t filesize, uint64_t chunksize)
+{
+	uint64_t pos, nread;
+
+	printf("doscan_mmap(%u): filesize: %llu, chunksize: %llu\n",
+	       getpid(), (unsigned long long)filesize,
+	       (unsigned long long)chunksize);
+	       
+	if (ent->chkfd >= 0 && lseek(ent->chkfd, 0, SEEK_END) != filesize)
+		return -EFBIG;
+	
+	for (pos = 0; pos < filesize; pos += chunksize) {
+		
+		if (pos + chunksize < filesize)
+			nread = chunksize;
+		else
+			nread = filesize - pos;
+		
+		if (ent->chkfd < 0)
+			continue;
+			
+		if (memcmp(ent->fd_ptr + pos, ent->chkfd_ptr + pos, nread)) {
+			fprintf(stderr, "doscan_mmap: %llu bytes mismatch @ %llu\n",
+				(unsigned long long)chunksize,
+				(unsigned long long)pos);
+			mismatch_output(ent, pos, chunksize);
 			return -EBADMSG;
 		}
 	}
 	return 0;
 }
 
+int doscan_fadvise(struct fent *ent, uint64_t filesize, uint64_t chunksize)
+{
+	int err;
+	uint64_t pos, nread;
+
+	printf("doscan_fadvise(%u): filesize: %llu, chunksize: %llu\n",
+	       getpid(), (unsigned long long)filesize,
+	       (unsigned long long)chunksize);
+	       
+	if (ent->chkfd >= 0 && lseek(ent->chkfd, 0, SEEK_END) != filesize)
+		return -EFBIG;
+	
+	for (pos = 0; pos < filesize; pos += chunksize) {
+		
+		if (pos + chunksize < filesize)
+			nread = chunksize;
+		else
+			nread = filesize - pos;
+		
+		err = posix_fadvise(ent->fd, pos, nread, POSIX_FADV_WILLNEED);
+		if (err) {
+			perror("posix_fadvise");
+			return -errno;;
+		}
+		
+		if (ent->chkfd < 0)
+			continue;
+			
+		err = posix_fadvise(ent->chkfd, pos, nread, POSIX_FADV_WILLNEED);
+		if (err) {
+			perror("posix_fadvise");
+			return -errno;
+		}
+	}
+	return 0;
+}
+
+int doscan_random(struct fent *ent, uint64_t filesize, uint64_t chunksize)
+{
+	bool flag = false;
+	int err;
+	int randnum;
+	
+	srand(time(NULL));
+	while(true) {
+		if (flag)
+			break;
+		
+		randnum = rand() % 3 + 1;
+		switch(randnum) {
+		case 1:
+			flag = true;
+			err = doscan(ent, filesize, chunksize);
+			break;
+		case 2:
+			if (mmap_flag) {
+				flag = true;
+				err = doscan_mmap(ent, filesize, chunksize);
+			}
+			break;
+		case 3:
+			if (fadvise_flag) {
+				flag = true;
+				err = doscan_fadvise(ent, filesize, chunksize);
+			}
+			break;
+		default:
+			break;
+		}
+	}
+	return err;
+}
+
 int getdents_f(struct fent *fe)
 {
 	int dfd;
@@ -379,17 +601,30 @@ int readlink_f(struct fent *fe)
 	return 0;
 }
 
-int read_f(int fd, int chkfd, uint64_t filesize)
+int read_f(struct fent *ent, uint64_t filesize)
 {
-	static char buf[MAX_CHUNKSIZE], chkbuf[MAX_CHUNKSIZE];
+	char *buf, *chkbuf;
 	uint64_t lr, off, len, trimmed;
 	size_t nread, nread2;
+	int err = 0;
 
 	lr = ((uint64_t) random() << 32) + random();
 	off = lr % filesize;
 	len = (random() % MAX_CHUNKSIZE) + 1;
 	trimmed = len;
-
+	
+	err = posix_memalign(&buf, PAGE_SIZE, MAX_SCAN_CHUNKSIZE);
+	if (err) {
+		fprintf(stderr, "posix_memalign failed: %s\n", strerror(err));
+		goto cleanup;
+	}
+	
+	err = posix_memalign(&chkbuf, PAGE_SIZE, MAX_SCAN_CHUNKSIZE);
+	if (err) {
+		fprintf(stderr, "posix_memalign failed: %s\n", strerror(err));
+		goto cleanup;
+	}
+	
 	if (off + len > filesize) {
 		uint64_t a = filesize - off + 16 * getpagesize();
 
@@ -397,44 +632,175 @@ int read_f(int fd, int chkfd, uint64_t filesize)
 			len %= a;
 		trimmed = len <= filesize - off ? len : filesize - off;
 	}
-
+	
+	if (direct_io) {
+		off = (((off - 1) >> PAGE_SHIFT) + 1)
+			<< PAGE_SHIFT;
+		trimmed = len = (((len - 1) >> PAGE_SHIFT) + 1)
+			<< PAGE_SHIFT;
+		if (!len || off + len > filesize)
+			goto cleanup;
+	}
+	
 	printf("read_f(%u): %llu bytes @ %llu\n", getpid(),
-	       len | 0ULL, off | 0ULL);
+	       len | 0ULL, off | 0ULL);	
 
-	nread = pread64(fd, buf, len, off);
+	nread = pread64(ent->fd, buf, len, off);
 	if (nread != trimmed) {
 		fprintf(stderr, "read_f(%d, %u): failed to read %llu bytes @ %llu\n",
 			__LINE__, getpid(), len | 0ULL, off | 0ULL);
-		return -errno;
+		err = -errno;
+		goto cleanup;
 	}
 
-	if (chkfd < 0)
-		return 0;
+	if (ent->chkfd < 0)
+		goto cleanup;
 
-	nread2 = pread64(chkfd, chkbuf, len, off);
+	nread2 = pread64(ent->chkfd, chkbuf, len, off);
 	if (nread2 <= 0) {
 		fprintf(stderr, "read_f(%d, %u): failed to read %llu bytes @ %llu\n",
 			__LINE__, getpid(), len | 0ULL, off | 0ULL);
-		return -errno;
+		err = -errno;
+		goto cleanup;
 	}
 
 	if (nread != nread2) {
 		fprintf(stderr, "read_f(%d, %u): size mismatch %llu bytes @ %llu\n",
 			__LINE__, getpid(), len | 0ULL, off | 0ULL);
-		return -EFBIG;
+		mismatch_output(ent, off, len);
+		err = -EFBIG;
+		goto cleanup;
 	}
 
 	if (memcmp(buf, chkbuf, nread)) {
 		fprintf(stderr, "read_f(%d, %u): data mismatch %llu bytes @ %llu\n",
 			__LINE__, getpid(), len | 0ULL, off | 0ULL);
+		mismatch_output(ent, off, len);
+		err = -EBADMSG;
+		goto cleanup;
+	}
+	
+cleanup:
+	free(buf);
+	free(chkbuf);
+	return err;
+}
+
+int read_f_mmap(struct fent *ent, uint64_t filesize)
+{
+	uint64_t lr, off, len, trimmed;
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
+	printf("read_f_mmap(%u): %llu bytes @ %llu\n", getpid(),
+	       len | 0ULL, off | 0ULL);
+	
+	if (ent->chkfd >= 0 && lseek(ent->chkfd, 0, SEEK_END) != filesize)
+		return -EFBIG;
+	
+	if (ent->chkfd < 0)
+		return 0;
+		
+	if (memcmp(ent->fd_ptr + off, ent->chkfd_ptr + off, trimmed)) {
+		fprintf(stderr, "read_f_mmap(%d, %u): data mismatch %llu bytes @ %llu\n",
+			__LINE__, getpid(), len | 0ULL, off | 0ULL);
+		mismatch_output(ent, off, len);
 		return -EBADMSG;
 	}
 	return 0;
 }
 
-int testfd(int fd, int chkfd, int mode)
+int read_f_fadvise(struct fent *ent, uint64_t filesize)
 {
-	const off64_t filesize = lseek64(fd, 0, SEEK_END);
+	int err;
+	uint64_t lr, off, len, trimmed;
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
+	printf("read_f_fadvise(%u): %llu bytes @ %llu\n", getpid(),
+	       len | 0ULL, off | 0ULL);
+	
+	err = posix_fadvise(ent->fd, off, trimmed, POSIX_FADV_WILLNEED);
+	if (err) {
+		perror("posix_fadvise");
+		return -errno;
+	}
+	
+	if (ent->chkfd >= 0 && lseek(ent->chkfd, 0, SEEK_END) != filesize)
+		return -EFBIG;
+	
+	if (ent->chkfd < 0)
+		return 0;
+		
+	err = posix_fadvise(ent->chkfd, off, trimmed, POSIX_FADV_WILLNEED);
+	if (err) {
+		perror("posix_fadvise");
+		return -errno;
+	}
+	return 0;
+}
+
+int read_f_random(struct fent * ent, uint64_t filesize)
+{
+	bool flag = false;
+	int err;
+	int randnum;
+	
+	srand(time(NULL));
+	while(true) {
+		if (flag)
+			break;
+		
+		randnum = rand() % 3 + 1;
+		switch(randnum) {
+		case 1:
+			flag = true;
+			err = read_f(ent, filesize);
+			break;
+		case 2:
+			if (mmap_flag) {
+				flag = true;
+				err = read_f_mmap(ent, filesize);
+			}
+			break;
+		case 3:
+			if (fadvise_flag) {
+				flag = true;
+				err = read_f_fadvise(ent, filesize);
+			}
+			break;
+		default:
+			break;
+		}
+	}
+	return err;
+}
+
+int testfd(struct fent *ent, int mode)
+{
+	const off64_t filesize = lseek64(ent->fd, 0, SEEK_END);
 	uint64_t chunksize, maxchunksize;
 	int err;
 
@@ -450,16 +816,16 @@ int testfd(int fd, int chkfd, int mode)
 			<< PAGE_SHIFT;
 		if (!chunksize)
 			chunksize = PAGE_SIZE;
-		err = doscan(fd, chkfd, filesize, chunksize);
+		err = doscan_random(ent, filesize, chunksize);
 		if (err)
 			return err;
-	} else if (mode == RANDSCAN_UNALIGNED) {
+	} else if (mode == RANDSCAN_UNALIGNED && !direct_io) {
 		chunksize = (random() * random() % MAX_SCAN_CHUNKSIZE) + 1;
-		err = doscan(fd, chkfd, filesize, chunksize);
+		err = doscan_random(ent, filesize, chunksize);
 		if (err)
 			return err;
 	} else if (mode == RANDREAD) {
-		err = read_f(fd, chkfd, filesize);
+		err = read_f_random(ent, filesize);
 		if (err)
 			return err;
 	}
@@ -470,7 +836,6 @@ int doproc(int mode)
 {
 	struct fent *fe;
 	int ret;
-
 	if (mode <= GETDENTS) {
 		fe = getfent(FT_DIRm, random());
 		if (!fe)
@@ -492,7 +857,7 @@ int doproc(int mode)
 	ret = tryopen(fe);
 	if (ret)
 		return ret;
-	return testfd(fe->fd, fe->chkfd, mode);
+	return testfd(fe, mode);
 }
 
 void randomdelay(void)
@@ -522,7 +887,7 @@ static int parse_options(int argc, char *argv[])
 	char *testdir, *chkdir;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "l:p:s:")) != -1) {
+	while ((opt = getopt(argc, argv, "l:p:s:dmf")) != -1) {
 		switch (opt) {
 		case 'l':
 			loops = atoi(optarg);
@@ -547,6 +912,15 @@ static int parse_options(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 'd':
+			direct_io = true;
+			break;
+		case 'm':
+			mmap_flag = true;
+			break;
+		case 'f':
+			fadvise_flag = true;
+			break;
 		default: /* '?' */
 			return -EINVAL;
 		}
@@ -585,7 +959,10 @@ void usage(void)
 	      " -l#     specifies the no. of times the testrun should loop.\n"
 	      "         *use 0 for infinite (default 1)\n"
 	      " -p#     specifies the no. of processes (default 1)\n"
-	      " -s#     specifies the seed for the random generator (default random)\n",
+	      " -s#     specifies the seed for the random generator (default random)\n"
+	      " -d      using direct_io to start stress test\n"
+	      " -m      using mmap to start stress test\n"
+	      " -f      using fadvise to start stress test\n",
 	      stderr);
 }
 
-- 
2.34.1

