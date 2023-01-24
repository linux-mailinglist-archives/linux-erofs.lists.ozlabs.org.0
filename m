Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2BD6799C9
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Jan 2023 14:42:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P1SnX0MN3z3bT4
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jan 2023 00:42:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kQ/XkeBH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kQ/XkeBH;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P1SnT4YHVz3cDT
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jan 2023 00:42:05 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 22B2AB811D6;
	Tue, 24 Jan 2023 13:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878B6C433A0;
	Tue, 24 Jan 2023 13:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674567722;
	bh=3KKifScuk1hhvnnfmlwGuRuD5jQ4e0Nucu2H8lY9BBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQ/XkeBHLv9it+1z4dw0NjGVvkYjlKf8h3awo5XZlX9U+vmlWtwAyilHa+3jLGJmd
	 ByWBvvy4IrTp8ZEP9DmExC4Q46F5tpT7IrC3qVgM0ToCs1Uj4aTsa9ugUivXGHq5P0
	 FNDbL0JSgAqzSAVN2b8hhbmQocQhZnxCP1yvG3jcTM54HI+faeIf4s88/x3yrA72Al
	 kL0EsZsYYhw3cRuh8Khc9h9gQ16UJFGombplMJ7lAuI1eKhgzIQlXTBF/OpSfiz5C/
	 0QggT+0FkZ+aDlRCyJ4txtQwEvfTEiEzaun+HUcOD4qO76Wme/YRuQ652b95zwGndM
	 df+OQGHpNG4UQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/35] erofs: clean up parsing of fscache related options
Date: Tue, 24 Jan 2023 08:41:09 -0500
Message-Id: <20230124134131.637036-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124134131.637036-1-sashal@kernel.org>
References: <20230124134131.637036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Yue Hu <huyue2@coolpad.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit e02ac3e7329f76c5de40cba2746cbe165f571dff ]

... to avoid the mess of conditional preprocessing as we are continually
adding fscache related mount options.

Reviewd-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230112065431.124926-3-jefflexu@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.39.0

