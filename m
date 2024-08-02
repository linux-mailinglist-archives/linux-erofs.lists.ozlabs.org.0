Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F786945625
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 03:56:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wauqxh8m;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZpp82LXlz3dTm
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 11:56:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wauqxh8m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZpnm6m8gz3d9g
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2024 11:55:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722563736; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lCkFEkeGkuj6Zmm0KfVmWqJ7/lKSBVZP6JUeSEXtu2o=;
	b=wauqxh8mUO8CQ0KMGBGiygNze3SRDtEPnBNf6Ci5QY8+trwt9gDFtnHa0Nh8cH35ukPY74LWGAFhbBU76617LxSSfEHi0Ne1bD5AY/D9hPYUJnjn3yKeRLkpFeYUrfgzZgzvrM829r0Kagai+u8w1Qt/E+0zdtBvboXq+2/2mzA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WBvVrAW_1722563733;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBvVrAW_1722563733)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 09:55:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: lib: fix out-of-bounds in erofs_io_xcopy()
Date: Fri,  2 Aug 2024 09:55:26 +0800
Message-ID: <20240802015527.2113797-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240802015527.2113797-1-hsiangkao@linux.alibaba.com>
References: <20240802015527.2113797-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Coverity-id: 502334
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/io.h | 4 ++--
 lib/io.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index f53abed..d9b33d2 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -34,7 +34,7 @@ struct erofs_vfops {
 	off_t (*lseek)(struct erofs_vfile *vf, u64 offset, int whence);
 	int (*fstat)(struct erofs_vfile *vf, struct stat *buf);
 	int (*xcopy)(struct erofs_vfile *vout, off_t pos,
-		     struct erofs_vfile *vin, int len, bool noseek);
+		     struct erofs_vfile *vin, unsigned int len, bool noseek);
 };
 
 /* don't extend this; instead, use payload for any extra information */
@@ -61,7 +61,7 @@ off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence);
 ssize_t erofs_copy_file_range(int fd_in, u64 *off_in, int fd_out, u64 *off_out,
 			      size_t length);
 int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
-		   struct erofs_vfile *vin, int len, bool noseek);
+		   struct erofs_vfile *vin, unsigned int len, bool noseek);
 
 #ifdef __cplusplus
 }
diff --git a/lib/io.c b/lib/io.c
index 9167321..4937db5 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -490,7 +490,7 @@ off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence)
 }
 
 int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
-		   struct erofs_vfile *vin, int len, bool noseek)
+		   struct erofs_vfile *vin, unsigned int len, bool noseek)
 {
 	if (vout->ops)
 		return vout->ops->xcopy(vout, pos, vin, len, noseek);
@@ -519,7 +519,7 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 
 	do {
 		char buf[32768];
-		int ret = min_t(int, len, sizeof(buf));
+		int ret = min_t(unsigned int, len, sizeof(buf));
 
 		ret = erofs_io_read(vin, buf, ret);
 		if (ret < 0)
-- 
2.43.5

