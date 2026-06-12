Return-Path: <linux-erofs+bounces-3572-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NtoWI+ZsK2pX9QMAu9opvQ
	(envelope-from <linux-erofs+bounces-3572-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 04:20:22 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC345676424
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 04:20:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=GjPASVmI;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3572-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3572-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc3Bn53DMz3bpt;
	Fri, 12 Jun 2026 12:20:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781230817;
	cv=none; b=cAr78tQi+9WY+4mJeqJy24mUooXj1pLqWWNsfZ/phlxPKbh7Qlr9TBqAWD1zPxz2UZjisv+YQ6WDXriSGetE1Q/WxESjMX3HDNWwN++l7mh4yTPcdZzEJSLYOKmMuWHYQuUgiGyl8rnFnOdMNc72UIhFc2o8JYTL5G9k/zXw+6nJzfas5eMaODy7U9aFhJCZ6BiDsRxVuNLMplolrzSZbN8+EUACVIIxkN1VHl97V9EuN4Q6vnJZPh02PXQy6SKH/Divb7dKQuGnDTd8nEeW3ccC1ItMYtJelbseIl3exVg5utvwAVESMcMbHZvSeBcp8Vz+M1d9r0W0zC/gKC06pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781230817; c=relaxed/relaxed;
	bh=t1JFkumo67qV11lHrasF7HZqArS3J/+Yk1ryhs3nR/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M74KtorZ4liGEDVI1qIIt7X62wG/ICE5dBcwb7VievuJETWZdFOgjnQ7qxtlBhkuc28DG7i18T+vI/joqWXJ9SdMR/MgAmYH1XgLCBqYUeiTTHkCy0X/69FcP8OyeErK/GXJEe1f0nslBIs6IBcYRqQTMJQ4v2EuwZlgD9B9LsoU+yF7JOPt1RrCtPamO8LPenYgrJPgwLgvYRtIwsZPTnu+nL8VfEc7+rYwYtwfOuP7PYGGoQZYN8n7yvh/2MXlEyDrITCueaSw2FL81LUZP3xvGJ1sJfhST/PfXEq38nBjF2rw4qhagn7pSJLB6aGiJR9vkR3KqUyMeBzJieIQBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GjPASVmI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc3Bl3XCzz2ykX
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 12:20:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781230809; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=t1JFkumo67qV11lHrasF7HZqArS3J/+Yk1ryhs3nR/o=;
	b=GjPASVmIP+QOtXx/IzEhRRihoo2+R+viKkkDTAV+OuIv0aDbeT1yyEnM5BHevBk9HJPep/wcC6N8hbNMnVPUARZO2+9JPgSlNFMkespXPpo1uzieb5AKlGgyr4SddI5NpoIG1bhWAb24haXNPl5iGxUt2x0BlOxykWYCeef/nMo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X4fSh5b_1781230802;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4fSh5b_1781230802 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Jun 2026 10:20:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jonathan Calmels <jcalmels@nvidia.com>
Subject: [PATCH] erofs-utils: lib: separate plain and compressed filesystems formally
Date: Fri, 12 Jun 2026 10:20:01 +0800
Message-ID: <20260612022001.2665293-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260611235404.1620899-1-jcalmels@nvidia.com>
References: <20260611235404.1620899-1-jcalmels@nvidia.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3572-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC345676424

Source kernel commit: 7cef3c8341940febf75db6c25199cd83fb74d52f

!lz4_0padding is simply an ancient layout which is mainly used for
Linux kernels < 5.3 (prior to the initial EROFS formal version) and
generated with the option `-Elegacy-compress` by mkfs.erofs between
1.0 and 1.8.x.

So recently Linux 7.0+ kernels simply use lz4_0padding as another
indicator of whether it's an (LZ4) compressed filesystem.  Follow
the new behavior for erofs-utils too to fix an incremental data
build issue [1].

Reported-by: Jonathan Calmels <jcalmels@nvidia.com>
[1] https://lore.kernel.org/r/20260611235404.1620899-1-jcalmels@nvidia.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Jonathan,

Could you confirm if this issue works for you?

Thanks,
Gao Xiang

 lib/decompress.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index d23135e0cd43..e6d14f4cbd94 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -466,17 +466,12 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 	char *dest = rq->out;
 	char *src = rq->in;
 	char *buff = NULL;
-	bool support_0padding = false;
 	unsigned int inputmargin = 0;
 	struct erofs_sb_info *sbi = rq->sbi;
 
-	if (erofs_sb_has_lz4_0padding(sbi)) {
-		support_0padding = true;
-
-		inputmargin = z_erofs_fixup_insize((u8 *)src, rq->inputsize);
-		if (inputmargin >= rq->inputsize)
-			return -EFSCORRUPTED;
-	}
+	inputmargin = z_erofs_fixup_insize((u8 *)src, rq->inputsize);
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
 
 	if (rq->decodedskip) {
 		buff = malloc(rq->decodedlength);
@@ -485,7 +480,7 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 		dest = buff;
 	}
 
-	if (rq->partial_decoding || !support_0padding)
+	if (rq->partial_decoding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, dest,
 				rq->inputsize - inputmargin,
 				rq->decodedlength, rq->decodedlength);
@@ -589,7 +584,10 @@ static int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
 			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
 	} else {
 		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+		if (!distance && !erofs_sb_has_lz4_0padding(sbi))
+			return 0;
 		sbi->lz4.max_pclusterblks = 1;
+		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
 	}
 	sbi->lz4.max_distance = distance;
 	return 0;
@@ -601,10 +599,8 @@ int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb)
 	erofs_off_t offset;
 	int size, ret = 0;
 
-	if (!erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
+	if (!erofs_sb_has_compr_cfgs(sbi))
 		return z_erofs_load_lz4_config(sbi, dsb, NULL, 0);
-	}
 
 	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
 	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
-- 
2.43.5


