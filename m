Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58165967554
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 08:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725172761;
	bh=L5cj07VjICIGJdU4+Y25/wkmn+x9ZFiaKIEwQ+TZbqA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=oJcrm3VPz2IAnqIHDftPmrT2O8MVIWYXORGAMrx+bL00/Rukr254uwc+XIiLKrB1G
	 qU6PXohEazfBNIIEhKJFh3/GjxHYfPXNF6/vhRuG7xhurevjnHiRXXQw+ywByAg3rz
	 QPK//u6DCpeEAe76Ze/QJjzbKYSvsFyB2BaM50QdnttvEpZTnMPE1hJcAT5vwb8Xoh
	 C8FE9zWNGE46bGLRuQH56kqQzRhvZeaiFUF+JgJPZPrXuyPHylDznba3i8w5w7jdXx
	 BmNNSYWl1u9jcdWv8kqf1akolEodOv4HZL7TM+s56szUzN8PMYsch52mzW2rm4lS2G
	 GH8s9A5ME464A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxMgF2Xdfz3c5F
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 16:39:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.210
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725172756;
	cv=none; b=Ym06KVwzAAvFXPcOeqxxGc5aXXRWqow8NRzS1APE6Drmz1cnLKmg1PemdUshBxg08GgpCYu5PQgwb+k4ddvLV7k4Za6GSGUL6yKA/imDRMqf7fJ1rEFZyWqI5Xbk6clk2ryo6GFD3h/3XZQ3RxCWQE08KUPgRjeiswFiVjswcofBPkgcha1MyHyc18jcQyDsOZKSoPtPnoozTkUYEt1xmaVbThQy5HxmOoLQh1R+VkcjocqzeDtYeU3O3qwN4sJWn8WpYTxQeLO9esjUv4ljOUieUa2yD5j9ymBfLcxc4wZiKFicN6AUu4v6Xd1sO4gfsF3GoC/t4illRLGLiNT4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725172756; c=relaxed/relaxed;
	bh=L5cj07VjICIGJdU4+Y25/wkmn+x9ZFiaKIEwQ+TZbqA=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=mo+6Nw5T+/lBKCAhLxf6TvJBFHK+3dZvcZZv6d+4jcBgYoX+1DEexfVPiB1pBFhfLsfX62C5kqevln7ajbpSPnlmAeAArnLtn9Dkf4QACIFBA07H40iwrOfYLRZPdQyfMHuzJ+In+OER7fGb8+kFYfg3zuu/Ix+wx4wUFLPtGHmbuu/EZ8P4CXlXmWoC+2xRxD3kQJcHCZFyzljiWu1ZPp3KxXKtzhPPIr4F1DiluaxkGsGbYuAcL0bGJORw18L3IMz46fpd2vMqKFLi0enxg0bNHeq2pQl4DURE3rtonjxIyUDomOCmdSgyTvdQ4J2ZumiBrtk2IAF74lr8/H+Aog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hb5M0oTz; dkim-atps=neutral; spf=pass (client-ip=203.205.221.210; helo=out203-205-221-210.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hb5M0oTz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.210; helo=out203-205-221-210.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxMg437vqz2xxt
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 16:39:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725172735; bh=L5cj07VjICIGJdU4+Y25/wkmn+x9ZFiaKIEwQ+TZbqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hb5M0oTzUq8BsnIzpXijxa0jQD1Eev9WTzPcUuosyKPqfmvKgkDPhEN6M0XbDv5c3
	 h7rFlrLW+xx740m44Sj/VouL3bPXWCWG3nEvEq3KKAZc5saPXJKajwihZcMIYslGrW
	 xpp1j0KmD121t/DVgtlXUVi71pa4LlJQmxmdB0Z4=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8F31DEF9; Sun, 01 Sep 2024 14:35:51 +0800
X-QQ-mid: xmsmtpt1725172552to04a2klp
Message-ID: <tencent_FF4DC0AF8AD68C180D18C3FF7CFB6DA5A406@qq.com>
X-QQ-XMAILINFO: N+BV1J6/yX+azuwTuuT70uG2D6uQchi3p50JtmYyoVcuVh6i+t8J2Xpl0pQ0Pv
	 tA57CSyV1PE0+vRqT1OJ2ISoZnj9O056Jpq3JpkMAeE5o86cC6/l+xTpQenX3qvDsCz9JzONu2VL
	 iKEWdnR4mUEuMdamE/tdITEQ01JUjlfAqWftsNM3Zz456E5IILm3UrxV03ugjiI4OBARRKqqKQH4
	 ua3bJsdTZzYpIhTp3NsGLo1pS00atkfvqsdkx04h98I/AH2rA+dwlzkNmkQtYe06LJktgJju62uT
	 lOlBn1BtnUQUrLic8bjpbg6O+jB0FX3tDoucNZxK+EDuvlarKB12BcB7Qhi2wKe8snXTERvwOPuv
	 ISLmioJKDTmmhql8N9tqsPpWUDe/7byueIXSg4tbqK4rJIvOmvjjorT9riaTZ2bT0XTdm6YE/Moe
	 N3zbHuJ4BiJgW97RJMDLkhQ5x/TMGpaBzCOrLNMtEQowm1T/a0pr45oMEEHeDVmeIg2hjOMfqAnw
	 rqWWO1hg2Nzv60vLSXcJ7A78c/UbdUcNWIJzgO5Yyj9zBeGLoIaSyHLk1zt2OfWQc9zA1Ai8RYIm
	 x4fA+E6yHybvKcviZSHzR8e+WosokzOUjuVTOwDA2MWjuc8MOFekpkFLZTfjq8Ja5wjDrwDh6SmD
	 ynEhluBse/GcFG7ZD7KP+1MtxzgZI8MJLdjqNKFMfwR8S6a9DW9VTq31sPpqpj5SFYxRyuTjVn6j
	 wNuybe725PNB9CGLeAdudLW1H6EmMX3naN/pQ9iRTz/WU2W33UofH1VTHUvMWa73iy1Zz5XIu6xf
	 XXDTd853tbT31ZqbqUG7nyYJXCIzS7I83yS+gtGA2y2LMemj2j9GTBjWFhLitkQUcs9jg7wYhlJY
	 yWxlt5xTQq6mODdGZ3BywDcsTBsj1RGklzuQTS6D81DVtocbca5KFS5AOjU6DkQUPnh88MXrvFaw
	 sK7a/KeZrV/EXh0HY98ViHViuDc1KTxVV1IC9CKbMw33hW1WRVjtdXa8ImSyHoYVSNfx87fm0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils:tests: add new test options for stress tests
Date: Sun,  1 Sep 2024 14:35:49 +0800
X-OQ-MSGID: <20240901063549.2134417-2-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901063549.2134417-1-kyr1ewang@qq.com>
References: <20240901063549.2134417-1-kyr1ewang@qq.com>
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

