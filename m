Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D26655C7
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 09:16:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsL9H44s6z3c8Z
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 19:16:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsL970k1Wz3bhW
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 19:15:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VZMLdbC_1673424949;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMLdbC_1673424949)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:15:50 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: clean up parsing of fscache related options
Date: Wed, 11 Jan 2023 16:15:47 +0800
Message-Id: <20230111081547.126322-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230111081547.126322-1-jefflexu@linux.alibaba.com>
References: <20230111081547.126322-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

... to avoid the mess of conditional preprocessing as we are continually
adding fscache related mount options.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 481788c24a68..626a615dafc2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -577,26 +577,25 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		}
 		++ctx->devs->extra_devices;
 		break;
-	case Opt_fsid:
 #ifdef CONFIG_EROFS_FS_ONDEMAND
+	case Opt_fsid:
 		kfree(ctx->fsid);
 		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
 		if (!ctx->fsid)
 			return -ENOMEM;
-#else
-		errorfc(fc, "fsid option not supported");
-#endif
 		break;
 	case Opt_domain_id:
-#ifdef CONFIG_EROFS_FS_ONDEMAND
 		kfree(ctx->domain_id);
 		ctx->domain_id = kstrdup(param->string, GFP_KERNEL);
 		if (!ctx->domain_id)
 			return -ENOMEM;
+		break;
 #else
-		errorfc(fc, "domain_id option not supported");
-#endif
+	case Opt_fsid:
+	case Opt_domain_id:
+		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 		break;
+#endif
 	default:
 		return -ENOPARAM;
 	}
-- 
2.19.1.6.gb485710b

