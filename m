Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476729944E0
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 11:56:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNBHd3v1dz2yXm
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 20:56:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728381388;
	cv=none; b=AxSlq5ONTiPVxhKrvlKatpzQskYyJJqUJnuGH6m5+sB51mreqwfu9alwrVni26L9AF7iJJTJBNB3UwyXkMF+OqexLyQhWhs8rOjAqOU6ZJirUf2l6Vnbol9evL65P7YBK0+3oXVB+hWSqFtxf+zCRJIDmjwN21NgK1XtHkmb2rZsqbQ2Is0DFTruhsh4mP02XgZztaMnSIi+w9czDLRhsYV8xKZVWNW8JSTXNPfPIPLsult3bxLEcPWUIx0jugKmpsCXwW2ITJKmVcz6xauEbyoXWVrH0OlyGcg0d0IMh2Ydg3LcI1TVjFTrkQrdlHXcPveWQMFjdwjGj71BT/LViA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728381388; c=relaxed/relaxed;
	bh=1k0liHka3S7LfAa+7MLacRLt1xutM2cYpmE1M22Izy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl+U+b3K7MwHfje5mhIE8m6M7wxGnzquXi/0TQAbU2cXEPOUH88AzYnfNGjMX7UHuqNTwcWAzzWAFkQpJF/vSiDmwdW8yiBDPWutFp+Xn4NpT82GjXtaXTtqI07ejbIac5mmnJ1IBDlBvEVDfIv6BtV8ND3Lhcb5WR8Ot9NChgcipFxzH9qSxWD/yo5okKqL9ik9mx1W5EAhlRV7TjkLE8bdMJH2eUqKsss2tTAyLhToAtjI8/zEvxbnR2Pe2v+cYTJ1+tgbp8kEIUP9ENkHp1tpM5NSGMVJGNvm59/2cU7Uwjv0zI4apoihtuPpGiUfJT26rJReBwbBWNNm7xqMEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RlcsT7O1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RlcsT7O1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNBHW6vFrz2yN2
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 20:56:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728381377; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1k0liHka3S7LfAa+7MLacRLt1xutM2cYpmE1M22Izy0=;
	b=RlcsT7O1zmVccjYCUsN3JNjcPewAtcPmzkjBNcm/yCVbIin3H9AjV8ErszPGGfGWw21ViWAWjXOS2Ets10XvJW2FIlhijz0xWIOxac2IC/9DqXYdgKewKLoh4Tkxsi6FmWCzCVOiIpY//neidTE+9hjuIGmJBmhlGG7bjAdm/V0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGdZ8t5_1728381374)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 17:56:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] erofs: use get_tree_bdev_by_dev() to avoid misleading messages
Date: Tue,  8 Oct 2024 17:56:06 +0800
Message-ID: <20241008095606.990466-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Users can pass in an arbitrary source path for the proper type of
a mount then without "Can't lookup blockdev" error message.

Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..04a5873c1594 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -700,16 +700,19 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
+	dev_t dev;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
-	ret = get_tree_bdev(fc, erofs_fc_fill_super);
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+	ret = lookup_bdev(fc->source, &dev);
+	if (!ret)
+		return get_tree_bdev_by_dev(fc, erofs_fc_fill_super, dev);
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 	if (ret == -ENOTBLK) {
-		if (!fc->source)
-			return invalf(fc, "No source specified");
 		sbi->fdev = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
 		if (IS_ERR(sbi->fdev))
 			return PTR_ERR(sbi->fdev);
-- 
2.43.5

