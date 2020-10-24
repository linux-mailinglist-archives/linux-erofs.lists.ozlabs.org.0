Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD1297C8D
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 15:12:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJM2K1R70zDqsb
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 00:12:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603545129;
	bh=B1fCVbDnwbWDbm1Wy6ZDAaBJJmgCmqr6FLTnX6DYyB0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KLohgLDrCHzqWHtqHUpZwH4NHWjenP8UqEuUUTlUlzmgxwKDYGuXdn6l7FYDs7kG3
	 6Rrq3oguiqvTD5Q4nEdxZb0poT39v8A962OtpNRg9bibU7cHnOzVQQFSFcTlWLz5ZR
	 I0YzKiNQ6kKKyu3HTKbmgTeDhQj1ltZEVcMfIZts0aI5lk/fKa/rw7M/VNOsYsm+xQ
	 oGaPRULSUd4iwD/el5/+j36qUPOFyFB9416DcoCuL338wb9gtQwZvTVU0OIumrK+H1
	 lDQGw76n1DqOaM4+SnpcUCljMgiOw+zTa4mOBknIqh+6ryChk+MN2HIIceX+JU5BYd
	 z4fMim/taAoLw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.83; helo=sonic306-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=gqmFsG9Y; dkim-atps=neutral
Received: from sonic306-20.consmr.mail.gq1.yahoo.com
 (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJM156QKZzDqsZ
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 00:11:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603545062; bh=KY/S1RnRDhyj54YPvKXritDReprk6S7QXHoHcu6SGO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=gqmFsG9YoiCwlH9NyU/5YDzQ25CdaUNWY0/BV6D7nMJp6oGVuITkbANsIgxx6waxa+iyMLCGAbEip3Ax8K5A98TkPhnTf+DDPp5Faw7TX8cGXflGP1sLxR2jUQD3+2LRDqz3+X5DjY/wYWO8ZAP4S2j+sddVFzpfqmI7267GWR939iCZXcGI0YgmysSF70LsNsvX8/njI4ZcsuNri2y1qOs66ThsDmUnZQsyR1Z4iArIg3Ko66vu3WsHtumPp9DgS4AyRRf3cfX8v03ZzqeiWGRnKZt7uVg+Swrd3j5tHPJLw9n9/ZzbP3y1j5tCdtZxloxH4dQsE2CscvWCj/d1Dw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603545062; bh=cpriRn+53FZ4Sx7YnOOUBtnR1OIJGnchq6OKMZU5D8n=;
 h=From:To:Subject:Date;
 b=d8i1C1AvpSpHn1Iz67bjuhkw2txjcpv6Tt1qdB9skYOfSQGOkXu5Al8F266VznQWHGEIvHd8HQ6GWeOS7799qtJvRtU3oZaOwgMV+fw5qkeUxYsbjzvEtK1b7ljXnsQPtK7jCP+yyNCTOTliYh+ioOo1xj9lk1LGcYEr0vEyeiH9TwcSoc/dnXDNQzIjq2Et7NKIb9QVcMkC7g4eb6Qmi5+dY+knzr1pVnHMIcNbgzfMnbl4392eI+5LwKQPFvM0X3GhlOHPG99i0qMKHouIG/DQtg395Fh6eqOowIjBX+ceVmxdeiZpLscHYkioM4IPl4f08EHmrUGLRh2WLuBeMg==
X-YMail-OSG: Inv5LTcVM1kZV9_wM_dq6mFzaPydcIywET9vLULKKw6oq0fu25teKYJ5MraS3RH
 jvabc63mFUlFgWAIZmfLxcUzjFtetb1bE0euurVgdEy0vIh9T3B0rwtaUCcK0Q76K_GfZipZzCHB
 9wpOm6ykzsU2VoNDnV8.4ta1gJWZ4_dR.S4EHWmT.pJLTgLLFXua722ciV5j.um2JkjLaPS7FFYR
 h.ZyspbkaOTHb231sZdjAQOyW10pkWIS0H4T48zLtPcrfrtjE3aCRSfqdeknVkBy6C9K6QtyuSR9
 RNQ5piGlcrbCs_rMn2YWGPXGd7L3m_fjWrZoX5jUL_HmoW_u2KWuSMrGEyneg17z6r20qqVgdXmp
 xq0a1kG7wM9lL2gKwUqQsOBz.O2VM9usjpKtg3s7hMNFgQtphfZ0jubnzyO8YlLD1Lloyr9l6STy
 py1t6rd7_2enQjx8rotzFMngy1I3k6me03u853ObuQZHrKO7EN9zaj8Eno1dmk1FqSLHP7C0gi.M
 tA5gKnOr.ZozI1xA9e1WUuZtfY1tiiyxoIwynd8onK6gx2dhyE52mwjWtLKIi6OUCkU9ET3ay4oO
 .02qjs.radkrjavdBxJjmTHxLkIOkYR0aY62Y5J.UAhoJDZD53jjCPeA9ubSBThpXZYgkgTDECVn
 MYoyYpQrMd2pbTH6C7HI5UT2imQKI.ANJaCjUI7D3ER_TnWEGdmQU9oWhqFzUcLc5QrfZs4nRKfI
 WaRMvWS3be.34xvOOl1mQSyvLqhQWoIZUZmOHL7bqo8Z7JxVPz5DWZV5MMt5gGtaHe6GaqzalJ3i
 Y7w0FN7tR4wjFsx8XkoW0uZWu1TzQYCx08mwSGj4sd.gKKT1iVS1EExhtVKihuWOa_UGAd3OOHsq
 Yuipf0Z4.emmcZl8Wyxp3r.HW8ViZTWDomkzXDp..8WbFd6X8R3kjVVru0TwkrB4B_ZlAmRZTn_m
 m8XobCZvPCtE7XKWtA02BdB.g_vQIVMxhNHPxDtEL1S1ecGrTq3kdRe_d5Q9BO7K46lQ5HUON_my
 2K24v_h_ihRPPMfHayWCsywsQ6fP4.Rpd70c97Q5LmySPf5AP_Rl7L0e5eEyyYldwALjwWAi05NH
 0XVWLl.2SzJmaSrncKEfC6cKW9wgTnWNfKCR6QSMp7d0bv8hx477p3DG68dZNJmzU7dHPut07Arb
 c_4hmCiIOF8x2GUv52hdGrjDg96RV7E9kUSFvHDLcKEQKzSgJ9WyV2yZhkobCOonHQYi0kh074ZN
 2dACaNZ2skAJ3n8SAkMGpRzV1RCLMMJ2DLAurobu43Cp4HDyTfg2oB9ZtOaLcbr59k1CvuEN37kD
 90YmCldGGR5RXmIV4dFn3H6xtucTzwx7mxAZShcbVjo93wu4pwNjk92ubPVlSnwa2Rz1.uWdPbey
 d0bDvPv_A8DrJR7ioZW2V0oynrWIvB03fs_Zm8979lNoOcQHeamg2ZpuQEIuvDHj8vnfSXRXyemv
 ouypQOaMMAENWp46BhaANkDijwCoHfv0LDg67LrZXezBsRbGwTmwlKBxPa9cxdnmUpCCw7a6ItG2
 zFmdNnl.TPdjR9X5uZCR_CfvlLId4oYPtjORLdiWx7oygaRmDEpdCVoxOhL6xlC3JRiOtjBLdC2A
 LjVWZGQwLzsjdlvvIA4_whUsDGh3TJK84MUC9Pm0Knc8fulGMK3Uka4coqTlW08YqfauTIB31Wg6
 D8KUuASyyKZotfZlxP3MICMkqVUl60eNzRGnUKsl1FlGbdu1K.XWxb4y2LQGqM24o4hC5CRWCrOO
 H3Yeq5nmgQe_QHfVpaOpc84Vco7cRU5vq94HRBy8c6xDGNJt_OQNSsBoO8FuD7A6Q_quMPraIS4B
 kSjrjsTk6nmuEOTA2AQWzcgw6ZmTeo.l7pudRoFNaoDaP_7BiFsWDX1ONxqscKPV82A.TPwbwF2n
 bQyunn4sbBL9izTyNhzA1Uga_nMkU8igCrrCIw_xu93QNW2ktvorhVYkSsYJc3pLyjC7VE9I0WoO
 cp8ZN5l6l.FoA9xYmN_AI7H575VxzD3Q4uYBUOqWYXhNeRSyOlTL5iO79eZoewe3wo3QjUxAoJ5X
 S_DOUTUwweiNTr.gYIKNg83XRXsfrVwxHgU4ZGNd.wnxJkOkpkRfoF_hbqZCUXber6thRGEhBHB6
 Nd0da7Igrw9hFpN8aBN8g7eAHekHJZMTjUDJeAUuIcxbvvHFGBvaHClzga4vnY5Z3xBrxrG.YHOZ
 6I963C4Z_oQGsH77vgrBkN.pvpqbe4zzKkhhfdwBpvowHppST6zA6Z.rOf2jfkxQFXy1t_PP4_cr
 WY_qPfUpRtgf08a0BybixX_PAh.ctf5xpFoq4D3bPt7eeDCL7QqqSnjp0Sro.OVhwgugBUzEG52W
 QGt9KqRtGbfU.9u.5gGmE0HSBBi7xqCZuDd.bQuJ0Oh4we8Fee1UuSYOF7Yp4iUBQrTW4dFWLjkl
 WhitbP49gFQt66MSwSf8B.WcBQ_kgZRKWuHLdaoRpjl8qoXzteMth0JxQXFXE8X1ctEnyGLWrkfn
 fin4IKHEbFbQjOL4xBOW0tn_sfrOtkvC7TC1bfdnocQiwcGGXCkZ9EAIywnNzPYUJss.3T8lnW8M
 LbEF5z5msa3bAE49jIeatvpzX4wjvZOxjWon.Ivk.EvLyX.HfAezkdNzRmLU8lNkPbL3zWVS0rhl
 eRkWtQVuEtJZqB9YKJB8XUmXxsQNOywlv6h2sh6sHiQWEerllv0Df4xuut8q6lnyVXh4.xYNdSht
 lZGZWTi2bKBePDBmNMblgYl4VF6qS_3KOJeFLeysc4_Sp8D.2UlJjweHk6o8bnalkXokylOX7YfD
 oE2kdfvQqQit_6._YY0KlFvpqlH87KZXBNU8luZkRk5vAuk1jWxsCM.pckVG_s2eP9FTJgGegHbT
 S8P._thHk5Ca1nC1S3vA-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 13:11:02 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID afd45167a3858f59b7d63d6cfac9db14; 
 Sat, 24 Oct 2020 13:10:55 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v2 5/5] erofs-utils: fuse: get rid of duplicated logging
 code
Date: Sat, 24 Oct 2020 21:09:59 +0800
Message-Id: <20201024130959.23720-6-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024130959.23720-1-hsiangkao@aol.com>
References: <20201024130959.23720-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ will be folded to the original patch. ]

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am  |  2 +-
 fuse/decompress.c |  1 -
 fuse/dentry.c     |  7 ++--
 fuse/disk_io.c    | 10 +++---
 fuse/getattr.c    |  4 +--
 fuse/init.c       | 39 +++++++++++------------
 fuse/logging.c    | 81 -----------------------------------------------
 fuse/logging.h    | 55 --------------------------------
 fuse/main.c       | 52 ++++++++++++++----------------
 fuse/namei.c      |  6 ++--
 fuse/open.c       |  4 +--
 fuse/read.c       | 22 ++++++-------
 fuse/readir.c     |  8 ++---
 fuse/zmap.c       | 35 ++++++++++----------
 14 files changed, 93 insertions(+), 233 deletions(-)
 delete mode 100644 fuse/logging.c
 delete mode 100644 fuse/logging.h

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index a50d2c4d0ab3..8b8c4e10d90d 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c getattr.c logging.c namei.c read.c disk_io.c init.c open.c readir.c zmap.c
+erofsfuse_SOURCES = main.c dentry.c getattr.c namei.c read.c disk_io.c init.c open.c readir.c zmap.c
 if ENABLE_LZ4
 erofsfuse_SOURCES += decompress.c
 endif
diff --git a/fuse/decompress.c b/fuse/decompress.c
index f2aa84146946..e32a27017a45 100644
--- a/fuse/decompress.c
+++ b/fuse/decompress.c
@@ -11,7 +11,6 @@
 #include "erofs/internal.h"
 #include "erofs/err.h"
 #include "decompress.h"
-#include "logging.h"
 #include "init.h"
 
 static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
diff --git a/fuse/dentry.c b/fuse/dentry.c
index 1ae37e3abc86..0f722294d530 100644
--- a/fuse/dentry.c
+++ b/fuse/dentry.c
@@ -4,9 +4,10 @@
  *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
+#include <stdlib.h>
 #include "dentry.h"
 #include "erofs/internal.h"
-#include "logging.h"
+#include "erofs/print.h"
 
 #define DCACHE_ENTRY_CALLOC()   calloc(1, sizeof(struct dcache_entry))
 #define DCACHE_ENTRY_LIFE       8
@@ -21,7 +22,7 @@ int dcache_init_root(uint32_t nid)
 	/* Root entry doesn't need most of the fields. Namely, it only uses the
 	 * nid field and the subdirs pointer.
 	 */
-	logi("Initializing root_entry dcache entry");
+	erofs_info("Initializing root_entry dcache entry");
 	root_entry.nid = nid;
 	root_entry.subdirs = NULL;
 	root_entry.siblings = NULL;
@@ -44,7 +45,7 @@ struct dcache_entry *dcache_insert(struct dcache_entry *parent,
 {
 	struct dcache_entry *new_entry;
 
-	logd("Inserting %s,%d to dcache", name, namelen);
+	erofs_dbg("Inserting %s,%d to dcache", name, namelen);
 
 	/* TODO: Deal with names that exceed the allocated size */
 	if (namelen + 1 > DCACHE_ENTRY_NAME_LEN)
diff --git a/fuse/disk_io.c b/fuse/disk_io.c
index 3fc087699dc9..bb1ee9a202db 100644
--- a/fuse/disk_io.c
+++ b/fuse/disk_io.c
@@ -14,7 +14,7 @@
 #include <pthread.h>
 #include <errno.h>
 
-#include "logging.h"
+#include "erofs/print.h"
 
 #ifdef __FreeBSD__
 #include <string.h>
@@ -47,18 +47,18 @@ int dev_read(void *buf, size_t count, off_t offset)
 	ssize_t pread_ret;
 	int lerrno;
 
-	ASSERT(erofs_devfd >= 0);
+	DBG_BUGON(erofs_devfd < 0);
 
 	pthread_mutex_lock(&read_lock);
 	pread_ret = pread_wrapper(erofs_devfd, buf, count, offset);
 	lerrno = errno;
-	logd("Disk Read: offset[0x%jx] count[%zd] pread_ret=%zd %s",
+	erofs_dbg("Disk Read: offset[0x%jx] count[%zd] pread_ret=%zd %s",
 	     offset, count, pread_ret, strerror(lerrno));
 	pthread_mutex_unlock(&read_lock);
 	if (count == 0)
-		logw("Read operation with 0 size");
+		erofs_warn("Read operation with 0 size");
 
-	ASSERT((size_t)pread_ret == count);
+	DBG_BUGON((size_t)pread_ret != count);
 
 	return pread_ret;
 }
diff --git a/fuse/getattr.c b/fuse/getattr.c
index e5200ebeef1a..4c5991e7e487 100644
--- a/fuse/getattr.c
+++ b/fuse/getattr.c
@@ -14,8 +14,8 @@
 #include "erofs/defs.h"
 #include "erofs/internal.h"
 #include "erofs_fs.h"
+#include "erofs/print.h"
 
-#include "logging.h"
 #include "namei.h"
 
 extern struct erofs_super_block super;
@@ -44,7 +44,7 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 	struct erofs_vnode v;
 	int ret;
 
-	logd("getattr(%s)", path);
+	erofs_dbg("getattr(%s)", path);
 	memset(&v, 0, sizeof(v));
 	ret = erofs_iget_by_path(path, &v);
 	if (ret)
diff --git a/fuse/init.c b/fuse/init.c
index 48125c5791fa..6917e995370b 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -6,11 +6,12 @@
  */
 #include "init.h"
 #include <string.h>
+#include <stdlib.h>
 #include <asm-generic/errno-base.h>
 
 #include "namei.h"
 #include "disk_io.h"
-#include "logging.h"
+#include "erofs/print.h"
 
 #define STR(_X) (#_X)
 #define SUPER_MEM(_X) (super._X)
@@ -28,8 +29,8 @@ static bool check_layout_compatibility(struct erofs_super_block *sb,
 
 	/* check if current kernel meets all mandatory requirements */
 	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
-		loge("unidentified incompatible feature %x, please upgrade kernel version",
-		     feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+		erofs_err("unidentified incompatible feature %x, please upgrade kernel version",
+			  feature & ~EROFS_ALL_FEATURE_INCOMPAT);
 		return false;
 	}
 	return true;
@@ -44,15 +45,15 @@ int erofs_init_super(void)
 	memset(buf, 0, sizeof(buf));
 	ret = dev_read_blk(buf, 0);
 	if (ret != EROFS_BLKSIZ) {
-		logi("Failed to read super block ret=%d", ret);
+		erofs_err("Failed to read super block ret=%d", ret);
 		return -EINVAL;
 	}
 
 	sb = (struct erofs_super_block *) (buf + BOOT_SECTOR_SIZE);
 	sbk->magic = le32_to_cpu(sb->magic);
 	if (sbk->magic != EROFS_SUPER_MAGIC_V1) {
-		logi("EROFS magic[0x%X] NOT matched to [0x%X] ",
-		     super.magic, EROFS_SUPER_MAGIC_V1);
+		erofs_err("EROFS magic[0x%X] NOT matched to [0x%X] ",
+			  super.magic, EROFS_SUPER_MAGIC_V1);
 		return -EINVAL;
 	}
 
@@ -62,7 +63,6 @@ int erofs_init_super(void)
 	sbk->checksum = le32_to_cpu(sb->checksum);
 	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
 	sbk->blkszbits = sb->blkszbits;
-	ASSERT(sbk->blkszbits != 32);
 
 	sbk->inos = le64_to_cpu(sb->inos);
 	sbk->build_time = le64_to_cpu(sb->build_time);
@@ -74,15 +74,14 @@ int erofs_init_super(void)
 	memcpy(sbk->volume_name, sb->volume_name, 16);
 	sbk->root_nid = le16_to_cpu(sb->root_nid);
 
-	logp("%-15s:0x%X", STR(magic), SUPER_MEM(magic));
-	logp("%-15s:0x%X", STR(feature_incompat), SUPER_MEM(feature_incompat));
-	logp("%-15s:0x%X", STR(feature_compat), SUPER_MEM(feature_compat));
-	logp("%-15s:%u",   STR(blkszbits), SUPER_MEM(blkszbits));
-	logp("%-15s:%u",   STR(root_nid), SUPER_MEM(root_nid));
-	logp("%-15s:%ul",  STR(inos), SUPER_MEM(inos));
-	logp("%-15s:%d",   STR(meta_blkaddr), SUPER_MEM(meta_blkaddr));
-	logp("%-15s:%d",   STR(xattr_blkaddr), SUPER_MEM(xattr_blkaddr));
-
+	erofs_dump("%-15s:0x%X\n", STR(magic), SUPER_MEM(magic));
+	erofs_dump("%-15s:0x%X\n", STR(feature_incompat), SUPER_MEM(feature_incompat));
+	erofs_dump("%-15s:0x%X\n", STR(feature_compat), SUPER_MEM(feature_compat));
+	erofs_dump("%-15s:%u\n",   STR(blkszbits), SUPER_MEM(blkszbits));
+	erofs_dump("%-15s:%u\n",   STR(root_nid), SUPER_MEM(root_nid));
+	erofs_dump("%-15s:%llu\n",  STR(inos), (unsigned long long)SUPER_MEM(inos));
+	erofs_dump("%-15s:%d\n",   STR(meta_blkaddr), SUPER_MEM(meta_blkaddr));
+	erofs_dump("%-15s:%d\n",   STR(xattr_blkaddr), SUPER_MEM(xattr_blkaddr));
 	return 0;
 }
 
@@ -95,7 +94,7 @@ erofs_nid_t addr2nid(erofs_off_t addr)
 {
 	erofs_nid_t offset = (erofs_nid_t)sbk->meta_blkaddr * EROFS_BLKSIZ;
 
-	ASSERT(IS_SLOT_ALIGN(addr));
+	DBG_BUGON(!IS_SLOT_ALIGN(addr));
 	return (addr - offset) >> EROFS_ISLOTBITS;
 }
 
@@ -108,11 +107,11 @@ erofs_off_t nid2addr(erofs_nid_t nid)
 
 void *erofs_init(struct fuse_conn_info *info)
 {
-	logi("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
+	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
 
 	if (inode_init(erofs_get_root_nid()) != 0) {
-		loge("inode initialization failed")
-		ABORT();
+		erofs_err("inode initialization failed");
+		abort();
 	}
 	return NULL;
 }
diff --git a/fuse/logging.c b/fuse/logging.c
deleted file mode 100644
index 192f546b94ec..000000000000
--- a/fuse/logging.c
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * erofs-utils/fuse/logging.c
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#include "logging.h"
-
-#include <stdio.h>
-#include <stdarg.h>
-#include <pthread.h>
-
-static int loglevel = DEFAULT_LOG_LEVEL;
-static FILE *logfile;
-static const char * const loglevel_str[] = {
-	[LOG_EMERG]     = "[emerg]",
-	[LOG_ALERT]     = "[alert]",
-	[LOG_DUMP]      = "[dump] ",
-	[LOG_ERR]       = "[err]  ",
-	[LOG_WARNING]   = "[warn] ",
-	[LOG_NOTICE]    = "[notic]",
-	[LOG_INFO]      = "[info] ",
-	[LOG_DEBUG]     = "[debug]",
-};
-
-void __LOG(int level, const char *func, int line, const char *format, ...)
-{
-	static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
-	va_list ap;
-	FILE *fp = logfile ? logfile : stdout;
-
-	if (!fp)
-		return;
-	if (level < 0 || level > loglevel)
-		return;
-
-	/* We have a lock here so different threads don interleave the log
-	 * output
-	 */
-	pthread_mutex_lock(&lock);
-	va_start(ap, format);
-	fprintf(fp, "%s", loglevel_str[level]);
-	if (func)
-		fprintf(fp, "%s", func);
-	if (line >= 0)
-		fprintf(fp, "(%d):", line);
-	vfprintf(fp, format, ap);
-	fprintf(fp, "\n");
-	va_end(ap);
-	fflush(fp);
-	pthread_mutex_unlock(&lock);
-}
-
-inline void logging_setlevel(int new_level)
-{
-	loglevel = new_level;
-}
-
-int logging_open(const char *path)
-{
-	if (path == NULL)
-		return 0;
-
-	logfile = fopen(path, "w");
-	if (logfile == NULL) {
-		perror("open");
-		return -1;
-	}
-
-	return 0;
-}
-
-void logging_close(void)
-{
-	if (logfile) {
-		fflush(logfile);
-		fclose(logfile);
-		logfile = NULL;
-	}
-}
-
diff --git a/fuse/logging.h b/fuse/logging.h
deleted file mode 100644
index 3aa77ab08107..000000000000
--- a/fuse/logging.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * erofs-utils/fuse/logging.h
- *
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#ifndef __LOGGING_H
-#define __LOGGING_H
-
-#include <assert.h>
-#include <stdlib.h>
-
-#define LOG_EMERG   0
-#define LOG_ALERT   1
-#define LOG_DUMP    2
-#define LOG_ERR     3
-#define LOG_WARNING 4
-#define LOG_NOTICE  5
-#define LOG_INFO    6
-#define LOG_DEBUG   7
-
-#define logem(...)	__LOG(LOG_EMERG, __func__, __LINE__, ##__VA_ARGS__)
-#define loga(...)	__LOG(LOG_ALERT, __func__, __LINE__, ##__VA_ARGS__)
-#define loge(...)	__LOG(LOG_ERR,   __func__, __LINE__, ##__VA_ARGS__)
-#define logw(...)	__LOG(LOG_WARNING, __func__, __LINE__, ##__VA_ARGS__)
-#define logn(...)	__LOG(LOG_NOTICE,  __func__, __LINE__, ##__VA_ARGS__)
-#define logi(...)	__LOG(LOG_INFO,  __func__, __LINE__, ##__VA_ARGS__)
-#define logp(...)	__LOG(LOG_DUMP,  "", -1, ##__VA_ARGS__)
-#define logd(...)	__LOG(LOG_DEBUG, __func__, __LINE__, ##__VA_ARGS__)
-
-#define DEFAULT_LOG_FILE	"fuse.log"
-
-#ifdef _DEBUG
-#define DEFAULT_LOG_LEVEL LOG_DEBUG
-
-#define ASSERT(assertion) ({                            \
-	if (!(assertion)) {                             \
-		logw("ASSERT FAIL: " #assertion);       \
-		assert(assertion);                      \
-	}                                               \
-})
-#define ABORT(_X) abort(_X)
-#else
-#define DEFAULT_LOG_LEVEL LOG_ERR
-#define ASSERT(assertion)
-#define ABORT(_X)
-#endif
-
-void __LOG(int level, const char *func, int line, const char *format, ...);
-void logging_setlevel(int new_level);
-int logging_open(const char *path);
-void logging_close(void);
-
-#endif
-
diff --git a/fuse/main.c b/fuse/main.c
index 9c8169725fa7..9008fea32639 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -11,7 +11,7 @@
 #include <signal.h>
 #include <stddef.h>
 
-#include "logging.h"
+#include "erofs/print.h"
 #include "init.h"
 #include "read.h"
 #include "getattr.h"
@@ -19,6 +19,9 @@
 #include "readir.h"
 #include "disk_io.h"
 
+/* XXX: after liberofs is linked in, it should be removed */
+struct erofs_configure cfg;
+
 enum {
 	EROFS_OPT_HELP,
 	EROFS_OPT_VER,
@@ -30,7 +33,7 @@ struct options {
 	const char *logfile;
 	unsigned int debug_lvl;
 };
-static struct options cfg;
+static struct options fusecfg;
 
 #define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
 
@@ -54,10 +57,10 @@ static void usage(void)
 
 static void dump_cfg(void)
 {
-	fprintf(stderr, "\tdisk :%s\n", cfg.disk);
-	fprintf(stderr, "\tmount:%s\n", cfg.mount);
-	fprintf(stderr, "\tdebug_lvl:%u\n", cfg.debug_lvl);
-	fprintf(stderr, "\tlogfile  :%s\n", cfg.logfile);
+	fprintf(stderr, "\tdisk :%s\n", fusecfg.disk);
+	fprintf(stderr, "\tmount:%s\n", fusecfg.mount);
+	fprintf(stderr, "\tdebug_lvl:%u\n", fusecfg.debug_lvl);
+	fprintf(stderr, "\tlogfile  :%s\n", fusecfg.logfile);
 }
 
 static int optional_opt_func(void *data, const char *arg, int key,
@@ -71,11 +74,11 @@ static int optional_opt_func(void *data, const char *arg, int key,
 		return 1;
 
 	case FUSE_OPT_KEY_NONOPT:
-		if (!cfg.disk) {
-			cfg.disk = strdup(arg);
+		if (!fusecfg.disk) {
+			fusecfg.disk = strdup(arg);
 			return 0;
-		} else if (!cfg.mount)
-			cfg.mount = strdup(arg);
+		} else if (!fusecfg.mount)
+			fusecfg.mount = strdup(arg);
 
 		return 1;
 	case EROFS_OPT_HELP:
@@ -98,16 +101,16 @@ static void signal_handle_sigsegv(int signal)
 	size_t i;
 
 	UNUSED(signal);
-	logd("========================================");
-	logd("Segmentation Fault.  Starting backtrace:");
+	erofs_dbg("========================================");
+	erofs_dbg("Segmentation Fault.  Starting backtrace:");
 	nptrs = backtrace(array, 10);
 	strings = backtrace_symbols(array, nptrs);
 	if (strings) {
 		for (i = 0; i < nptrs; i++)
-			logd("%s", strings[i]);
+			erofs_dbg("%s", strings[i]);
 		free(strings);
 	}
-	logd("========================================");
+	erofs_dbg("========================================");
 
 	abort();
 }
@@ -132,21 +135,16 @@ int main(int argc, char *argv[])
 	}
 
 	/* Parse options */
-	if (fuse_opt_parse(&args, &cfg, option_spec, optional_opt_func) < 0)
+	if (fuse_opt_parse(&args, &fusecfg, option_spec, optional_opt_func) < 0)
 		return 1;
 
 	dump_cfg();
 
-	if (logging_open(cfg.logfile) < 0) {
-		fprintf(stderr, "Failed to initialize logging\n");
-		goto exit;
-	}
+	cfg.c_dbg_lvl = fusecfg.debug_lvl;
 
-	logging_setlevel(cfg.debug_lvl);
-
-	if (dev_open(cfg.disk) < 0) {
-		fprintf(stderr, "Failed to open disk:%s\n", cfg.disk);
-		goto exit_log;
+	if (dev_open(fusecfg.disk) < 0) {
+		fprintf(stderr, "Failed to open disk:%s\n", fusecfg.disk);
+		goto exit;
 	}
 
 	if (erofs_init_super()) {
@@ -154,16 +152,14 @@ int main(int argc, char *argv[])
 		goto exit_dev;
 	}
 
-	logi("fuse start");
+	erofs_info("fuse start");
 
 	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
 
-	logi("fuse done ret=%d", ret);
+	erofs_info("fuse done ret=%d", ret);
 
 exit_dev:
 	dev_close();
-exit_log:
-	logging_close();
 exit:
 	fuse_opt_free_args(&args);
 	return ret;
diff --git a/fuse/namei.c b/fuse/namei.c
index c33af4b04b45..172e1bcdb457 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -14,7 +14,7 @@
 #include <sys/sysmacros.h>
 
 #include "erofs/defs.h"
-#include "logging.h"
+#include "erofs/print.h"
 #include "disk_io.h"
 #include "dentry.h"
 #include "init.h"
@@ -125,7 +125,7 @@ struct dcache_entry *list_name(const char *buf, struct dcache_entry *parent,
 
 			memcpy(debug, d_name, name_len);
 			debug[name_len] = '\0';
-			logi("list entry: %s nid=%u", debug, nid);
+			erofs_info("list entry: %s nid=%u", debug, nid);
 		}
 		#endif
 
@@ -214,7 +214,7 @@ int walk_path(const char *_path, erofs_nid_t *out_nid)
 
 	if (!ret)
 		return -ENOENT;
-	logd("find path = %s nid=%u", _path, ret->nid);
+	erofs_dbg("find path = %s nid=%u", _path, ret->nid);
 
 	*out_nid = ret->nid;
 	return 0;
diff --git a/fuse/open.c b/fuse/open.c
index c219d3870000..beb9a8615512 100644
--- a/fuse/open.c
+++ b/fuse/open.c
@@ -8,11 +8,11 @@
 #include <asm-generic/errno-base.h>
 #include <fuse.h>
 #include <fuse_opt.h>
-#include "logging.h"
+#include "erofs/print.h"
 
 int erofs_open(const char *path, struct fuse_file_info *fi)
 {
-	logi("open path=%s", path);
+	erofs_info("open path=%s", path);
 
 	if ((fi->flags & O_ACCMODE) != O_RDONLY)
 		return -EACCES;
diff --git a/fuse/read.c b/fuse/read.c
index e2f967aefb8a..0969e9ca1caf 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -13,7 +13,7 @@
 
 #include "erofs/defs.h"
 #include "erofs/internal.h"
-#include "logging.h"
+#include "erofs/print.h"
 #include "namei.h"
 #include "disk_io.h"
 #include "init.h"
@@ -37,8 +37,8 @@ size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
 		rdsz += count;
 	}
 
-	logi("nid:%u size=%zd offset=%llu realsize=%zd done",
-	     vnode->nid, size, (long long)offset, rdsz);
+	erofs_info("nid:%llu size=%zd offset=%llu realsize=%zd done",
+	     (unsigned long long)vnode->nid, size, (long long)offset, rdsz);
 	return rdsz;
 
 }
@@ -73,8 +73,8 @@ size_t erofs_read_data_inline(struct erofs_vnode *vnode, char *buffer,
 	rdsz += suminline;
 
 finished:
-	logi("nid:%u size=%zd suminline=%u offset=%llu realsize=%zd done",
-	     vnode->nid, size, suminline, (long long)offset, rdsz);
+	erofs_info("nid:%llu size=%zd suminline=%u offset=%llu realsize=%zd done",
+	     (unsigned long long)vnode->nid, size, (unsigned)suminline, (long long)offset, rdsz);
 	return rdsz;
 
 }
@@ -120,7 +120,7 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 			length = end - map.m_la;
 			partial = true;
 		} else {
-			ASSERT(end == map.m_la + map.m_llen);
+			DBG_BUGON(end != map.m_la + map.m_llen);
 			length = map.m_llen;
 			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
 		}
@@ -146,8 +146,8 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 			return ret;
 	}
 
-	logi("nid:%u size=%zd offset=%llu done",
-	     vnode->nid, size, (long long)offset);
+	erofs_info("nid:%llu size=%zd offset=%llu done",
+	     (unsigned long long)vnode->nid, size, (long long)offset);
 	return size;
 }
 
@@ -159,7 +159,7 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	struct erofs_vnode v;
 
 	UNUSED(fi);
-	logi("path:%s size=%zd offset=%llu", path, size, (long long)offset);
+	erofs_info("path:%s size=%zd offset=%llu", path, size, (long long)offset);
 
 	ret = walk_path(path, &nid);
 	if (ret)
@@ -169,7 +169,7 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	if (ret)
 		return ret;
 
-	logi("path:%s nid=%llu mode=%u", path, nid, v.datalayout);
+	erofs_info("path:%s nid=%llu mode=%u", path, (unsigned long long)nid, v.datalayout);
 	switch (v.datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
 		return erofs_read_data(&v, buffer, size, offset);
@@ -208,6 +208,6 @@ int erofs_readlink(const char *path, char *buffer, size_t size)
 	if (ret != (int)lnksz)
 		return ret;
 
-	logi("path:%s link=%s size=%llu", path, buffer, lnksz);
+	erofs_info("path:%s link=%s size=%llu", path, buffer, (unsigned long long)lnksz);
 	return 0;
 }
diff --git a/fuse/readir.c b/fuse/readir.c
index b00274dad9f4..0fefcd8fd0cb 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -14,7 +14,7 @@
 #include "erofs_fs.h"
 #include "namei.h"
 #include "disk_io.h"
-#include "logging.h"
+#include "erofs/print.h"
 #include "init.h"
 
 erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name,
@@ -72,14 +72,14 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	char dirsbuf[EROFS_BLKSIZ];
 	uint32_t dir_nr, dir_off, nr_cnt;
 
-	logd("readdir:%s offset=%llu", path, (long long)offset);
+	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
 	UNUSED(fi);
 
 	ret = walk_path(path, &nid);
 	if (ret)
 		return ret;
 
-	logd("path=%s nid = %u", path, nid);
+	erofs_dbg("path=%s nid = %llu", path, (unsigned long long)nid);
 	ret = erofs_iget_by_nid(nid, &v);
 	if (ret)
 		return ret;
@@ -94,7 +94,7 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	dir_off = erofs_blkoff(v.i_size);
 	nr_cnt = 0;
 
-	logd("dir_size=%u dir_nr = %u dir_off=%u", v.i_size, dir_nr, dir_off);
+	erofs_dbg("dir_size=%u dir_nr = %u dir_off=%u", v.i_size, dir_nr, dir_off);
 
 	while (nr_cnt < dir_nr) {
 		memset(dirsbuf, 0, sizeof(dirsbuf));
diff --git a/fuse/zmap.c b/fuse/zmap.c
index 8ec0a7707fd6..85034d385c58 100644
--- a/fuse/zmap.c
+++ b/fuse/zmap.c
@@ -11,7 +11,7 @@
  */
 #include "init.h"
 #include "disk_io.h"
-#include "logging.h"
+#include "erofs/print.h"
 
 int z_erofs_fill_inode(struct erofs_vnode *vi)
 {
@@ -52,8 +52,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
-		loge("unknown compression format %u for nid %llu",
-		     vi->z_algorithmtype[0], vi->nid);
+		erofs_err("unknown compression format %u for nid %llu",
+			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
 		return -EOPNOTSUPP;
 	}
 
@@ -62,8 +62,8 @@ static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
 					((h->h_clusterbits >> 3) & 3);
 
 	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
-		loge("unsupported physical clusterbits %u for nid %llu",
-		     vi->z_physical_clusterbits[0], vi->nid);
+		erofs_err("unsupported physical clusterbits %u for nid %llu",
+			  vi->z_physical_clusterbits[0], (unsigned long long)vi->nid);
 		return -EOPNOTSUPP;
 	}
 
@@ -301,7 +301,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	int err;
 
 	if (lcn < lookback_distance) {
-		loge("bogus lookback distance @ nid %llu", vi->nid);
+		erofs_err("bogus lookback distance @ nid %llu",
+			  (unsigned long long)vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
@@ -315,8 +316,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	switch (m->type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		if (!m->delta[0]) {
-			loge("invalid lookback distance 0 @ nid %llu",
-				  vi->nid);
+			erofs_err("invalid lookback distance 0 @ nid %llu",
+				  (unsigned long long)vi->nid);
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
@@ -327,8 +328,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
 	default:
-		loge("unknown type %u @ lcn %lu of nid %llu",
-		     m->type, lcn, vi->nid);
+		erofs_err("unknown type %u @ lcn %lu of nid %llu",
+			  m->type, lcn, (unsigned long long)vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
@@ -381,8 +382,8 @@ int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
 		}
 		/* m.lcn should be >= 1 if endoff < m.clusterofs */
 		if (!m.lcn) {
-			loge("invalid logical cluster 0 at nid %llu",
-			     vi->nid);
+			erofs_err("invalid logical cluster 0 at nid %llu",
+				  (unsigned long long)vi->nid);
 			err = -EFSCORRUPTED;
 			goto out;
 		}
@@ -396,8 +397,8 @@ int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
 			goto out;
 		break;
 	default:
-		loge("unknown type %u @ offset %llu of nid %llu",
-		     m.type, ofs, vi->nid);
+		erofs_err("unknown type %u @ offset %llu of nid %llu",
+			  m.type, ofs, (unsigned long long)vi->nid);
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -408,9 +409,9 @@ int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
 	map->m_flags |= EROFS_MAP_MAPPED;
 
 out:
-	logd("m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-	     map->m_la, map->m_pa,
-	     map->m_llen, map->m_plen, map->m_flags);
+	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
+		  map->m_la, map->m_pa,
+		  map->m_llen, map->m_plen, map->m_flags);
 
 	DBG_BUGON(err < 0 && err != -ENOMEM);
 	return err;
-- 
2.24.0

