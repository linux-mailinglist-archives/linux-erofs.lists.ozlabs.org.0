Return-Path: <linux-erofs+bounces-1390-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73241C63F6C
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 12:57:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d95pl22yrz2yvM;
	Mon, 17 Nov 2025 22:57:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763380671;
	cv=none; b=dCZwH47LTmQwvtINxvch0nBRV0miV6w99WVJ4l/p0N6I+E8Bhz6tiF90Xul9vtMzBLArlAThcbAMqYsmKWfH49xZvi89hJPEGXe68qQltQRtjYSWDMo1XGgCZJzY6iRbIx7wvG8bZESYyzIlGCmqxy36Ylh1fXu+G4nLSt2IHKcx/dcqy0YefQwcMl6O/mQBZqwQQhE6TW+hbwdRJgjk4N63mOciAcUScPZhMpuWNWZ2EYPWAMdjtf8rixktEKE/ASUPnwPsdjKHzere9z7SNYKTL/FBjxUMQcUkDfyn9N5gomG1ie4evPNt2/qAXYxNhAM9xtcBdagNI9DCQ3fukA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763380671; c=relaxed/relaxed;
	bh=v0wEwbBITgaXOrGzJ60sclrLTHa0QY/zRQTEJSVjsA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FprY2xHZ89V6vljiGBldxlbaSBZX0zRJf5g68Cn9OoyH339RcLkwiiIcX2NxsbEWJ9asx+H4gzuxFgmNslz4Dl2owOI4es+f0PM9sCZ7qjtbn0zDNjSzrn91vbmUeimYvCRh0DoK+1FQQPPfc5QRkQqIAinsfPivi/9gUKgjCXQX/4XarPeTgUwzmVtHhZ6b4DOOcXto5QNDFKGs34mLqfRxwDt4lTOTQFkyyX8UTzT+Cd8qZvlj5iyS/5GEKgcPmsulZK9kcVR7R0loPEwJNtgb5277D0a6SVCRcWNy5zGfKTH14r6R5GeY4kxgyatMz6f/vxngTOqvHNcmcLD85w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=in2FvwQQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=in2FvwQQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d95ph4gPPz2yv6
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 22:57:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763380658; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v0wEwbBITgaXOrGzJ60sclrLTHa0QY/zRQTEJSVjsA4=;
	b=in2FvwQQuiTcamyDW6RxOlBbEgtZ2e9ABJ0zaDLTgmFxi3qJNoJLtJhUyEG2G1pxxqehjIfSYvNeKPOc+9J1yNWIDmrkNHCjS/slgqgF0BtyTOBHY8RK/W/22XI1RFZBn+Qhxhit4JzqdWV5kYAGt5uQcuIVojPb5WYuMuD2frQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsZmeTQ_1763380651 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 19:57:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH] erofs: correct FSDAX detection
Date: Mon, 17 Nov 2025 19:57:29 +0800
Message-ID: <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
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

The detection of the primary device is skipped incorrectly
if the multiple or flattened feature is enabled.

It also fixes the FSDAX misdetection for non-block extra blobs.

Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supported on extra device")
Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@google.com
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f3f8d8c066e4..cd8ff98c2938 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -174,15 +174,15 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
-			if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
-				erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
-					   dif->path);
-				clear_opt(&sbi->opt, DAX_ALWAYS);
-			}
 		} else if (!S_ISREG(file_inode(file)->i_mode)) {
 			fput(file);
 			return -EINVAL;
 		}
+		if (!dif->dax_dev && test_opt(&sbi->opt, DAX_ALWAYS)) {
+			erofs_info(sb, "DAX unsupported by %s. Turning off DAX.",
+				   dif->path);
+			clear_opt(&sbi->opt, DAX_ALWAYS);
+		}
 		dif->file = file;
 	}
 
@@ -215,13 +215,13 @@ static int erofs_scan_devices(struct super_block *sb,
 			  ondisk_extradevs, sbi->devs->extra_devices);
 		return -EINVAL;
 	}
-	if (!ondisk_extradevs) {
-		if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
-			erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
-			clear_opt(&sbi->opt, DAX_ALWAYS);
-		}
-		return 0;
+
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && !sbi->dif0.dax_dev) {
+		erofs_info(sb, "DAX unsupported by block device. Turning off DAX.");
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
+	if (!ondisk_extradevs)
+		return 0;
 
 	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
 		sbi->devs->flatdev = true;
-- 
2.43.5


