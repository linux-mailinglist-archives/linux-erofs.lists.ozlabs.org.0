Return-Path: <linux-erofs+bounces-279-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8DAAC43A
	for <lists+linux-erofs@lfdr.de>; Tue,  6 May 2025 14:32:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsHq16R9hz2xrL;
	Tue,  6 May 2025 22:32:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.87.244.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746534765;
	cv=none; b=GBEQEDGvr55rmPcStjGJGtUqlV+yAlDL15ra8B3KndnI2QXG6T0jnQVEe9tS24TauKG6++1bNLNUsrQQeLNOhI9nmPT5n+rdnmqq4+g3gUOWliZP2CwbkQpgFtwlkSgCnAaZi57XgiThHNfgbO1lMcMohQ5db+6KyEytdlRSdkxQUJevwleJsGTn1k+QkeL0KRC2RYnzQ1FVffcwfpEVlhYp0tRv/tkSpxGZnTwC3G2vwrjQrDWDP01MIfuo4Wb8vfETLcXhVpbyrns4DGxqkfN5w77acHADPrOut+ANSVdvf/7B9PB9sTNFFZbmqYPwnq5VUPy4loBIz4cIuZWDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746534765; c=relaxed/relaxed;
	bh=bPHNZfrBrMpyyBWxSeLFFLdVPDOsh+0lErIsEFl9zIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VvMi7X/hwKt17Nw/Moe/0Pjk8KFs8FNrVO8qKgKQOXDoyQja1QRjDsbGF4qDoSqART5vh2OA294mox84Nz8iJMv3EnaxAEBBBlH74mX+xKDNTWWGEpG76VVphmzkxqKFXUGkL8SvwVQ9ofmsOLyOcQOlTsSutisODdu+uaHkyAogVqS5QNHbfxC068G+S8Amj0rTcyJ3ShYT9G6r+IF6BBDph1J196HBlc3akVEMYq0x2CShQYbqn0umkdHAyawEJpVpygHtAJvPH/rLvJrAHa2bOybGRZRj/YBrxGTyFpf3jX17sOwbpKlNl97Yysd6w7G6UmjT/qgImwzSrJhroA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arvanta.net; spf=pass (client-ip=93.87.244.166; helo=fx.arvanta.net; envelope-from=mps@arvanta.net; receiver=lists.ozlabs.org) smtp.mailfrom=arvanta.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arvanta.net (client-ip=93.87.244.166; helo=fx.arvanta.net; envelope-from=mps@arvanta.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 1298 seconds by postgrey-1.37 at boromir; Tue, 06 May 2025 22:32:45 AEST
Received: from fx.arvanta.net (93-87-244-166.static.isp.telekom.rs [93.87.244.166])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsHq10lXbz2xjN
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 May 2025 22:32:44 +1000 (AEST)
Received: from m1pro.arvanta.net (m1pro.arvanta.net [10.5.1.11])
	by fx.arvanta.net (Postfix) with SMTP id 036AE12D06;
	Tue, 06 May 2025 14:11:02 +0200 (CEST)
Date: Tue, 6 May 2025 14:11:02 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: linux-erofs@lists.ozlabs.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: build of erofs-utils 1.8.6 fails with musl libc
Message-ID: <20250506121102.GA15164@m1pro.arvanta.net>
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
Content-Type: multipart/mixed; boundary="9TaaRju0Leuc0oCB"
Content-Disposition: inline
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


--9TaaRju0Leuc0oCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm maintainer of erofs-utils for Alpine linux, distribution which use
musl libc instead of glibc.

Building version 1.8.6 gives error:
------------------
Making all in contrib
make[2]: Entering directory '/home/mps/aports/community/erofs-utils/src/erofs-utils-1.8.6/contrib'
cc -DHAVE_CONFIG_H -I. -I..   -DNDEBUG -Wall -I../include -Os -fstack-clash-protection -Wformat -Werror=format-security -fno-plt -MT stress-stress.o -MD -MP -MF .deps/stress-stress.Tpo -c -o stress-stress.o `test -f 'stress.c' || echo './'`stress.c
stress.c: In function '__getdents_f':
stress.c:274:16: error: implicit declaration of function 'readdir64'; did you mean 'readdir_r'? [-Wimplicit-function-declaration]
  274 |         while (readdir64(dir) != NULL)
      |                ^~~~~~~~~
      |                readdir_r
stress.c:274:31: warning: comparison between pointer and integer
  274 |         while (readdir64(dir) != NULL)
      |                               ^~
stress.c: In function '__read_f':
stress.c:431:17: error: implicit declaration of function 'pread64'; did you mean 'pread'? [-Wimplicit-function-declaration]
  431 |         nread = pread64(fe->fd, buf, len, off);
      |                 ^~~~~~~
      |                 pread
stress.c: In function 'read_f':
stress.c:480:15: error: implicit declaration of function 'lseek64'; did you mean 'lseek'? [-Wimplicit-function-declaration]
  480 |         fsz = lseek64(fe->fd, 0, SEEK_END);
      |               ^~~~~~~
      |               lseek
make[2]: *** [Makefile:420: stress-stress.o] Error 1
make[2]: Leaving directory '/home/mps/aports/community/erofs-utils/src/erofs-utils-1.8.6/contrib'
make[1]: *** [Makefile:447: all-recursive] Error 1
make[1]: Leaving directory '/home/mps/aports/community/erofs-utils/src/erofs-utils-1.8.6'
make: *** [Makefile:379: all] Error 2
>>> ERROR: erofs-utils: build failed
>>> erofs-utils: Uninstalling dependencies...
(1/19) Purging .makedepends-erofs-utils (20250506.063719)
------------------

This is because musl use readdir, pread and lseek instead of readdir64,
pread64 and lseek64.
(IMO musl does this properly)

Natanael Copa <ncopa@alpinelinux.org> created patch with which I build
erofs-utils successfully. I'm attaching patch to this mail.

Feel free to contact me if you more information or to try some new
patches.

-- 
Kind regards


--9TaaRju0Leuc0oCB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename=fix-read-pread-seek-64.patch

diff --git a/contrib/stress.c b/contrib/stress.c
index d8def6a..0593d71 100644
--- a/contrib/stress.c
+++ b/contrib/stress.c
@@ -271,7 +271,7 @@ static int __getdents_f(unsigned int sn, struct fent *fe)
 	}
 
 	dir = fdopendir(dfd);
-	while (readdir64(dir) != NULL)
+	while (readdir(dir) != NULL)
 		continue;
 	closedir(dir);
 	return 0;
@@ -428,7 +428,7 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
 
 	printf("%d[%u]/%u read_f: %llu bytes @ %llu of %s\n", getpid(), procid,
 	       sn, len | 0ULL, off | 0ULL, fe->subpath);
-	nread = pread64(fe->fd, buf, len, off);
+	nread = pread(fe->fd, buf, len, off);
 	if (nread != trimmed) {
 		fprintf(stderr, "%d[%u]/%u read_f: failed to read %llu bytes @ %llu of %s\n",
 			getpid(), procid, sn, len | 0ULL, off | 0ULL,
@@ -439,7 +439,7 @@ static int __read_f(unsigned int sn, struct fent *fe, uint64_t filesize)
 	if (fe->chkfd < 0)
 		return 0;
 
-	nread2 = pread64(fe->chkfd, chkbuf, len, off);
+	nread2 = pread(fe->chkfd, chkbuf, len, off);
 	if (nread2 <= 0) {
 		fprintf(stderr, "%d[%u]/%u read_f: failed to check %llu bytes @ %llu of %s\n",
 			getpid(), procid, sn, len | 0ULL, off | 0ULL,
@@ -477,14 +477,14 @@ static int read_f(int op, unsigned int sn)
 	if (ret)
 		return ret;
 
-	fsz = lseek64(fe->fd, 0, SEEK_END);
+	fsz = lseek(fe->fd, 0, SEEK_END);
 	if (fsz <= 0) {
 		if (!fsz) {
 			printf("%d[%u]/%u %s: zero size @ %s\n",
 			       getpid(), procid, sn, __func__, fe->subpath);
 			return 0;
 		}
-		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
+		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
 			getpid(), procid, sn, __func__, fe->subpath, errno);
 		return -errno;
 	}
@@ -504,7 +504,7 @@ static int __doscan_f(unsigned int sn, const char *op, struct fent *fe,
 	for (pos = 0; pos < filesize; pos += chunksize) {
 		ssize_t nread, nread2;
 
-		nread = pread64(fe->fd, buf, chunksize, pos);
+		nread = pread(fe->fd, buf, chunksize, pos);
 
 		if (nread <= 0)
 			return -errno;
@@ -515,7 +515,7 @@ static int __doscan_f(unsigned int sn, const char *op, struct fent *fe,
 		if (fe->chkfd < 0)
 			continue;
 
-		nread2 = pread64(fe->chkfd, chkbuf, chunksize, pos);
+		nread2 = pread(fe->chkfd, chkbuf, chunksize, pos);
 		if (nread2 <= 0)
 			return -errno;
 
@@ -547,14 +547,14 @@ static int doscan_f(int op, unsigned int sn)
 	if (ret)
 		return ret;
 
-	fsz = lseek64(fe->fd, 0, SEEK_END);
+	fsz = lseek(fe->fd, 0, SEEK_END);
 	if (fsz <= 0) {
 		if (!fsz) {
 			printf("%d[%u]/%u %s: zero size @ %s\n",
 			       getpid(), procid, sn, __func__, fe->subpath);
 			return 0;
 		}
-		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
+		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
 			getpid(), procid, sn, __func__, fe->subpath, errno);
 		return -errno;
 	}
@@ -576,7 +576,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
 	ret = tryopen(sn, __func__, fe);
 	if (ret)
 		return ret;
-	fsz = lseek64(fe->fd, 0, SEEK_END);
+	fsz = lseek(fe->fd, 0, SEEK_END);
 	if (fsz <= psz) {
 		if (fsz >= 0) {
 			printf("%d[%u]/%u %s: size too small %lld @ %s\n",
@@ -584,7 +584,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
 			       fe->subpath);
 			return 0;
 		}
-		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
+		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
 			getpid(), procid, sn, __func__, fe->subpath, errno);
 		return -errno;
 	}

--9TaaRju0Leuc0oCB--

