Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988279DBB7
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 00:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694556746;
	bh=59zuDAzq0ZtpuHw9ci+ZLGOAB1aJduEQseITGta0/qs=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=RDFg3E4zc5tAy8JZG9VK3nrwmd2zDQNovgufqWIXrf42rknEACAsuzavpQjikkuQY
	 Ii1MvrAuKl1OyXar+szVmeVW+42EafModvGb2Sq2HjaPLAvOtTNqcDTdIjFHRIsAjM
	 nAIvpG6vQw+Jo1+eoIspfFJGORxKZl3XLa3RbDGtjzQsfMKJefMsQld1hwSMmiaOxt
	 T5bkb7Ytb4uD/V83Oc0Sv03FuNnX9HCC3SIhdyotdPRpw83yN0+M4aWoOmO5stZC31
	 cwhma9sgZhx8JDsHLnCcCknNuwaN4RX4V1sx5TDYDZOzeRAAruw7YUbn78NaEGfmz+
	 eccTTb6MPZgYg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rld9k5g2hz3cP3
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 08:12:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=0BGnKSRh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3puiazqckczuuyrmrcvxffxcv.tfdczelo-vifwjczjkj.fqcrsj.fix@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rld9b2c0dz309t
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 08:12:17 +1000 (AEST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-57787e29037so2332103a12.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 12 Sep 2023 15:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556735; x=1695161535;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59zuDAzq0ZtpuHw9ci+ZLGOAB1aJduEQseITGta0/qs=;
        b=q6v2/Ep211uIsYqQXhenEsAgiSDTdRgAkXR05X6G4wGLfX9GYux9i3ec2baIume5qe
         PXp0GZQEMReXTGlaYGUWmDZUE1dRe1j9MuMCVmos94R18Hkw6fF4UMEktAQvRGbkktyr
         Ie9PYx6BRscfjUGPmEeK6kNhwodAwuq7TkthvppMkoCmHdGcaJTYWweXRkcFFnhDSSd6
         qApL8BX6AfzUOgv5PBfJrFtWV+BTJdj4S4xD6BOo5Pz+TntenVHEp8gut44NutPt9GF9
         H9s8JBBpiQ/ZDaugPTCzVMzDrRVBTNoKuH2fTMicN6oGTf2+7E/krpoJhzw26KLwgCNA
         eQxQ==
X-Gm-Message-State: AOJu0YzHy+//W/Sk1kLvKYeLC97w2fDd/rfB629VXTrtXjaqKjgx0cUv
	Yit5Ju1nprgct9gWj92QVq6r9fAftCAbalYzh3pyO/s9F/sxnKEIGGCzP1QWq4dtU6FYrfFvt4Q
	SXRpAuK3AQ5+JX89K61x6cuKlIoEn/U3xeKmvkXfuPT5t/HET1EtRMV+AEQkxP5qKmp3d1cE+
X-Google-Smtp-Source: AGHT+IHgLY2t8ZGds18cNulk3vGxWZaL/Hw6dwSeYYLM7yY3ZP1wCPXDUDoXYasAuN8oi8nW6NjE5/Ph0PVF
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a63:7e58:0:b0:565:dddd:1f65 with SMTP id
 o24-20020a637e58000000b00565dddd1f65mr14797pgn.7.1694556734509; Tue, 12 Sep
 2023 15:12:14 -0700 (PDT)
Date: Tue, 12 Sep 2023 15:12:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912221204.52184-1-dhavale@google.com>
Subject: [PATCH v1] erofs-utils: fsck: fix support for 16k block size
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This basically follows the fix in kernel commit
001b8ccd0650 (erofs: fix compact 4B support for 16k
block size).

Without this patch fsck on images with 16k block size
reports corruption which is not correct.

Fixes: 76b822726ff8 ("erofs-utils: introduce compacted compression
indexes")

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/zmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index cd91ca5..81fa22b 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -244,7 +244,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	u8 *in, type;
 	bool big_pcluster;
 
-	if (1 << amortizedshift == 4)
+	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits == 12)
 		vcnt = 16;
@@ -346,7 +346,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = m->inode;
 	struct erofs_sb_info *sbi = vi->sbi;
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = round_up(erofs_iloc(vi) + vi->inode_isize +
 					   vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
@@ -356,9 +355,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	erofs_off_t pos;
 	int err;
 
-	if (lclusterbits != 12)
-		return -EOPNOTSUPP;
-
 	if (lcn >= totalidx)
 		return -EINVAL;
 
-- 
2.42.0.283.g2d96d420d3-goog

