Return-Path: <linux-erofs+bounces-2454-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAFvCk2DpWmxCwYAu9opvQ
	(envelope-from <linux-erofs+bounces-2454-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:32:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC51D88B8
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:32:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdbs60YZz3bkL;
	Mon, 02 Mar 2026 23:32:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454729;
	cv=none; b=AXMvi7lIUwQUCx6OIVEz4UBNAlmznPoWPehiMVAvRXqqIj8bLNcdKwXhsZpRhEZnsIKyJy36N1HcLXpy7NH6w0MqTWLAWggeB4bMyWaAD5CiRvrq/T2ZwAkiPFT4SJoEw4m1Pgi1SeuF51YCr8ivUAcYrxzjh7LQVFeYSj7YLDcArv46hXWUfkhfE3DI0A7pdgnaf4KZ/4e283BtgKf9DoI+SsSqEigQkf4QlPQmLsOBRcoMzj44zSq07GSHu1cIL3Fw7HqDZblVFxFkb1mgSA3v7+DvoVT0iIOgre6anWDk30B4C/Qx4j5MaCrF/+9Zg8EhJBXsp3Jbiufflu4ezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454729; c=relaxed/relaxed;
	bh=RofF3lVV2RBE+HwKWB13m+AW1P7Q17gP1XmoXl/xwJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeCYQx49yqiYvexqTJVjNfm4axgzGqfbH4hbPXYDyBLnD6W6N1NXfkc5RBEp+tWKu9EArVXZrpdK9TtbOSVLjrhBMfBhawL+7Mp9b3g00E88poMvgdoid1YbXjqEq88iRQx4rCCaHN2QL9kRX1JSayJpMUS+6C2PGEtDet+6Obs6V8RRhrlEJXRVgqjoFOJdpbJMy7SKbYrY+HoVfer/MwZm3bzE6uGMEt8C3qziOIesaS+pEFpN3kirgO+WIPlooHoGmnryCiOC8pKueLkqsnL8+kuhvrLR5v/lldnIIcut9qu+aAxASh2K0ADFOnOuS6clCJOQ9iuVBn2rTyx2bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CfB8ZSUA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CfB8ZSUA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdbs03swz3bW7
	for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 23:32:08 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2527509a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454727; x=1773059527; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RofF3lVV2RBE+HwKWB13m+AW1P7Q17gP1XmoXl/xwJg=;
        b=CfB8ZSUAN5TRLam9xaf30Yy3i/kO00Gjcw57ZcbttQvlREvxlL07XSoLLPricTGWs8
         O9Zf+4V2K1SMYAb85f9XcYPO+4N9UeqWqN+fqtMoH092pm6s8UkDLwM/CcoiZl5G9BCM
         wqzhuaAKpinZU1V2L+PhDHTomXDcuWZjF06Yhc/W5tMRKrZwlDrM3lH0qTpnuuH54uYJ
         fNOlis2+eml2siUTYv/kOjOScqZqTuBq9GhiiFjeI+1qexKCtEObTjjDaZhTS2aSmtJt
         fxmAuuHkTkVvaBARStHZdSIiILNcwdCM3pcB1k+El7UMAMLAGfG+BeDAt4mhGdsOq6Pj
         2D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454727; x=1773059527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RofF3lVV2RBE+HwKWB13m+AW1P7Q17gP1XmoXl/xwJg=;
        b=plu0iWlt3HpDshhcCC9MAZOtq4nzef4b05wOWeP8MNIB9oMi8f1ZRTNeHlDcaRX8pN
         CeVzkFO8U55Zwmr3wMPTYkBVV99jt7PtrD6mvpwiqsOQGCpG4Hw3hNHSpE9dO82Dd29L
         qNVJPYhsjC/RZ4Sk9VwJ60Af1C8CX6Zp/tgZcN+Cb+Nze8vZysOdznHJjLpDHPxPFOfL
         La9myh+gl68YsTLc9QWXZ9oTiwJjtWL/PLLpZi+nRpbF5yXzLvXBlFs7zqc72bEI1YXR
         FGB99/P7zdpYSZ6VZ+QKPEMPBnAxEIm8sAIFPk6VDgMqFDb+3iOc/PI5SSd+CWGcqOrZ
         4nbg==
X-Gm-Message-State: AOJu0Yzy1Oro2E6Pn2yvtO1jFSEGHlTpOz28GHlszRUNtPbVFloIT4ap
	+n5IFklcUWBluoNj3a+mWzYvjpEckF3ctc/PTFj8P+zagywpQmk3yEsIOnYHgtsf
X-Gm-Gg: ATEYQzzb0B0iSOJxPWn6ReULu7LjLBxuHgKrphYKUJGBt1/0R38aVMtZwv3wZfuZmGd
	Xw1WV6pAfGQ+yPPsapF/pYE+D5crFy2p4/2TEb9y6wDsl6z17Eycl+mTEhCRp4ZPH8JG+Vu9Q9P
	2VUbT2tEVb1V/BSrpx6nICYub/ze2Q/NU/x9NizKji4uFydBna/RwP4OxTCT8seRQATQjTjRbMS
	rNTLf/T/s3hMp7L637E0UpyEOa12an1UXRvm0vMcMwxET4PxrWKMagdcr/Oa5RVf80H46AhAckX
	3EKx0aZcQV3qT8LK6l1eiT6xlOq10KAWNAUE33JJ9ncoB6hxtS3o5F+sKxPKblqa/prLJOotcpB
	BqIPie97mqRJ5LEjjLYFTAW7tOk5zDt6mOOKdFcUdM2dFgHBeap9/MUSIblrGMbJkgO5ZPEYc7B
	0Zu68vwRT9vHC+Fg==
X-Received: by 2002:a17:90b:4c0a:b0:359:8d23:af5f with SMTP id 98e67ed59e1d1-3598d23b324mr2757768a91.35.1772454726653;
        Mon, 02 Mar 2026 04:32:06 -0800 (PST)
Received: from vitap ([2a09:bac6:d866:16aa::242:a3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm10672246a12.11.2026.03.02.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:32:06 -0800 (PST)
From: Hardik <hardikkumarpro0005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: lib: remove shadowed ret variable in compress.c
Date: Mon,  2 Mar 2026 18:02:01 +0530
Message-ID: <20260302123201.1041-1-hardikkumarpro0005@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
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
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-2454-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hardikkumarpro0005@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3DCC51D88B8
X-Rspamd-Action: no action

Signed-off-by: Hardik <hardikkumarpro0005@gmail.com>
---
 lib/compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 4a0d890..7196fc2 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1277,7 +1277,6 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	while (ctx->remaining) {
 		const u64 rx = min_t(u64, ctx->remaining,
 				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
-		int ret;
 
 		ret = (offset == -1 ?
 			erofs_io_read(vf, ctx->queue + ctx->tail, rx) :
-- 
2.53.0.windows.1


