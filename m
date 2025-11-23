Return-Path: <linux-erofs+bounces-1425-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACAC7E375
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Nov 2025 17:24:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dDvS55rQxz2xPy;
	Mon, 24 Nov 2025 03:24:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763915093;
	cv=none; b=h91IITKIUj6bnihIdhBcN1J2tEM/G3GBJlvcb4ccUa+liqJ8Mk53cFrIpNK6U79xqg/AiiK/Y2zjqtfqiMerogURK20ZOGDhoHzx+CBNXASxGMjZqim8Sp68PUADPBIq9p3Yid6OwKWivRPXTbfaI9XaOpJoo8K3C5cR12mHRVPcAcG/za9dc6n5Jo05hvgVARhBOqxsM6xwC3NzJ3LEIPnMRNg7OQTBgnwRSrFQ4T3K8rFIpzxO8Oz/BZBmUGXZusgZWSoW7xhr8qaLKuKIPnx2Bo2jhxyjUfvq7ztW3/JyCfFqRhm2S6sE+LHrYRjAyYBiGNYx58PyqgpUO9sXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763915093; c=relaxed/relaxed;
	bh=Tw9zp88GcXSfl0OIlLTPuwvLHfxrmUE4h8kl4kK0Ts0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcgDscVRThw2LKneXDZcZ/a+OUDCSeNDLFuH7xCI8XmwnllU+phxD1CRVO/sNuTxKUk7DCnDtTd6KVNKdt6NESKARNNAmpsUmBHAZWOcQHDKbpO/lt6ZZxfpolcUWjGKBUPdoC+0nukohmK3MtduhanWWCCdEP3ahz1J2mOzhFEGUFJjHk9arisozFNF4/YzH6w8uDVPwWABvyZX01h2IU2pqgWfHGPkiIrk/YjxiGjYyuPr0Ze+dhgh5DHIiZB/yRXs7Yx7vZ9LYeNU92sV7ksetj5i6b8V0duGKqR6GeiYNpjKhWXLR6Xa8OtRfqKXcpKRE1AHkpAp9KGr/J7TcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o7A1Fqu0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o7A1Fqu0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dDvS323pxz2xPB
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 03:24:49 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763915084; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Tw9zp88GcXSfl0OIlLTPuwvLHfxrmUE4h8kl4kK0Ts0=;
	b=o7A1Fqu0sNBC5vhzcjYNVv3VnnTmeLHmPXMx6HTUfC4FpXw75HnEtIm/voAzdg43GqzZaElSsefpSwighIJCinJGnt9GAL8IRRKtckHCKVxbh3iw0qKZkAae3uWgnDjzZNQaEoUMGBq7DDCB05IlGteF66gUlmMrWHl7Ycn62Co=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt8FJM3_1763915078 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Nov 2025 00:24:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: avoid malformed metabox metadata
Date: Mon, 24 Nov 2025 00:24:37 +0800
Message-ID: <20251123162437.4041035-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

 - If metadata compression is off, images shouldn't have
   METABOX-marked NIDs;

 - `metabox_nid` itself shouldn't be METABOX-marked.

Fixes: 7928074b7643 ("erofs-utils: introduce metadata compression [metabox]")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/data.c  | 3 +++
 lib/super.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/lib/data.c b/lib/data.c
index 1e5113406512..6fd1389cc09f 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -30,6 +30,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 		 *       cache to improve userspace metadata performance.
 		 */
 		if (!vf) {
+			if (!erofs_sb_has_metabox(sbi))
+				return ERR_PTR(-EFSCORRUPTED);
+
 			vi = (struct erofs_inode) { .sbi = sbi,
 						    .nid = sbi->metabox_nid };
 			err = erofs_read_inode_from_disk(&vi);
diff --git a/lib/super.c b/lib/super.c
index d626c7cdc76f..5b4a2eb2470d 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -133,6 +133,8 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 					     metabox_nid))
 			return -EFSCORRUPTED;
 		sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
+		if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
+			return -EFSCORRUPTED;	/* self-loop detection */
 	}
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
-- 
2.43.5


