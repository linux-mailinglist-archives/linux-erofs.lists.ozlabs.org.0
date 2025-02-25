Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D766BA433AF
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2025 04:39:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z23JP6rgYz30VZ
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2025 14:39:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740454788;
	cv=none; b=IQaTEi/W/Raf6T2BPNA5kIkwQa53RYKXXPbr0i2mmMUJLweSr9RZ4tuWm34sbItUFjYyWwq9643DsZgtahTBWw66EfS7VeavmPZhuz1Si7VkPaPAr1Qna/xUBwpGYO4TUnYRCbdxapBypYBY5nbzy+VsNEK9LZJr3oh+y9v1bvnES0wOyYhYuzb6dRM54C6E8ZMSq+/V2mFt6zWGKr/hX8lrvRfHueHSJvZrLwDyG1IqLB7+cSibqVUYIdWTpNq/97SEsflJfr0LB8u5Kvg0xwP0XBNtXLziubRW78ttRe/KuslOeabdjIs8qSDRWNX3V+KsXsgQGPiL+rEpprkH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740454788; c=relaxed/relaxed;
	bh=wfIqepXZVUfIjlPUk4Da5gDeRqNF03KNFcNHAJQ76D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxfHY8jLywnrp1IcM+OaQ+Y6csLpi0pSoStGer1FFeYr5mgyPhDQ1NB9gfFuTmVk985NDM6cC/njENZQWE65kWzsd69t1cJkYQRyC85dzrpAMBgtFAL/bz6cbvEpK4GTRdftQDmu0HFLpVztFo91UbOfsi/zKNKITSJcYwhUeXC9+uGgJX7H864gtob7V1pqXvmdk7ygF3JtM+eSgXkPUmSWUq+a0O06H/Yn6a9MWEj4F1jIz+Ah37LEWNZfpr1yJ+nqunYVnxrW789c3tpVTiw8uUKoK45mE+MISj31nYlvTCgj/vO0ZO6qH6g9TuCPQpdWWxBLLzoUJZ3CfU+rAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IYvAUtij; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IYvAUtij;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z23JL625cz2yvv
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2025 14:39:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740454781; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wfIqepXZVUfIjlPUk4Da5gDeRqNF03KNFcNHAJQ76D4=;
	b=IYvAUtij49hY+cBTt4WIBSFYHzvSp37LCF4C+yLuTu9XGmhLKhOtCrDqWcqM5BQCDoOELX2yDvsxahGfDsIzSK/SFv0tx5o5nh5gsBbIcH/kjA+WLWkqtwWwUmESxt4Qn4MVeGfwBYekUk2j1pWPOvVe+mZidbf0cPWTEcTdzKM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQD6RSw_1740454776 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 11:39:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: allow 16-byte volume name again
Date: Tue, 25 Feb 2025 11:39:34 +0800
Message-ID: <20250225033934.2542635-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Actually, volume name doesn't need to include the NIL terminator if
the string length matches the on-disk field size as mentioned in [1].

I tend to relax it together with the upcoming 48-bit block addressing
(or stable kernels which backport this fix) so that we could have a
chance to record a 16-byte volume name like ext4.

Since in-memory `volume_name` has no user, just get rid of the unneeded
check for now.  `sbi->uuid` is useless and avoid it too.

Fixes: a64d9493f587 ("staging: erofs: refuse to mount images with malformed volume name")
[1] https://lore.kernel.org/r/96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 --
 fs/erofs/super.c    | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f955793146f4..b452b6557aa5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -152,8 +152,6 @@ struct erofs_sb_info {
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
-	u8 uuid[16];                    /* 128-bit uuid for volume */
-	u8 volume_name[16];             /* volume name */
 	u32 feature_compat;
 	u32 feature_incompat;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3dc86d931ef1..19e52ffa34c5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -317,14 +317,6 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
 
-	ret = strscpy(sbi->volume_name, dsb->volume_name,
-		      sizeof(dsb->volume_name));
-	if (ret < 0) {	/* -E2BIG */
-		erofs_err(sb, "bad volume name without NIL terminator");
-		ret = -EFSCORRUPTED;
-		goto out;
-	}
-
 	/* parse on-disk compression configurations */
 	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
-- 
2.43.5

