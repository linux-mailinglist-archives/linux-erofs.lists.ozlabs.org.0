Return-Path: <linux-erofs+bounces-2761-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPqYNR9euGnXcgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2761-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 20:46:39 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975629FE63
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 20:46:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZQZg3nl8z2yhG;
	Tue, 17 Mar 2026 06:46:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773690395;
	cv=none; b=LGwQhbfO8QTvGLccOswBePfUMvwtLAmLrDIkaHaejU9IZx5Mm2UfbTvags4rGojTY1UkovEmbMma+fT29a2ywjOr0tNnGB2sL3/2IfkxN4k1i6EZw96zmOuMZ0O71nWkyTfmqpY0YsOBN49t4qFglAlf5lWWcU/Kyj36jKq1FVbCZ51QmvrlWivQA4C/GZoODQgV/ghLyxCLXKMjjs4ZBB+QvvGyaunpwBI8oIUQJxN9fGGVntihSCaj2h2aFNsLFg9nInqweSA9FRiK4aer+yUXusexF//8iGGbAFHRJIkWvZ2rnel3BSh074M+PRTRpOrzNMVdihCjQtbxNXdwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773690395; c=relaxed/relaxed;
	bh=4al1fPNce/uIzoJFZ4VoP6/jhUOh50c49ygl9ctUdfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AltucIA1ka6FTUEMWAp5IuURZbztG/tgKWXdFt8wgKRcj1tTqPO5wgg1LYZChFKv28dfMcyxhFLzCdg7wGNWPn1GfHMsgzAv7rlvP0qGRZvE4JKdCO0RQ/CPEV8P8nyzgTnNdneEngJwK6q1mn0bNM58qI4D2dwolLunW+XInpQlHCFSpduwfqXVRNuSXq3BvLZSxRz/x7j/BjIfuSFL92aQ1uOPTrxpmbbq4QCOFzd6pAKz3MIXJFJfFnyvODNh3DAJCtwdOFNkOb+vfVtEvdm/EvZpHeTGGrITWZ3ESEUkNDxqTJu+kHAjsuqcZoGPrdkLF1eyGDtIz1hRsa2Rgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JKVhtowH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JKVhtowH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZQZd6zDWz2ygn
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 06:46:32 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c632ca0c317so232681a12.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773690390; x=1774295190; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4al1fPNce/uIzoJFZ4VoP6/jhUOh50c49ygl9ctUdfE=;
        b=JKVhtowH9m8G9Z6HSCrE98Qr+MUhwHLQidcoKsGZCqOcjPVDKZ1OYedwlXdU/oz3j5
         V4EnBkvE0x/Tq6f4QRVyuegwvHqKQMT15A9srrE6VU4gw1tU1BCOj9qrmCUjZU3Ql4T+
         o42o2zUQLuJ3p8FqR7BxbWRJ3tpZ0Y47OHJ1iiuS61eXqIivvgauhZkh/N4q4dab2G+D
         u1E2rkiMuCiVLGqOINdvXXFDu84Xoh7UnzE332Kq2uXCqibd1PBs2ZIhPPEXXVM+J8/5
         6+D+sM8ALpVoedkfo4lTxldgsdE2U+6A10m4l2KEJVoxyO4n9uhrBttpQPsBBrFgGHtV
         JWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690390; x=1774295190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4al1fPNce/uIzoJFZ4VoP6/jhUOh50c49ygl9ctUdfE=;
        b=c+VUeS42ATfslG3v5CMuFxLr+yqMttjhq4QcXed14V2Kv05tkl4ILabNUXllLdiXky
         2wB4Y3NA4O0kmhXsRk4q4E6FCPdiE1asiZlL7tO0KtNjRIdYUREAMpsriy5BCpMlrC/e
         AB8zR7mWNnNCF27+l4kvvAlWVGTMGkLCPx0H9XApBqxXDfz4+G+JHuyvz+WnwU67qlj9
         7zI00/dUq9ZJIr+tSs/vPZvRVLB0U/AR3cvrtc3+7cKpBDQ7P6MUmEQPDQoFvBCEnofj
         PHwImimKH06z63hex+IVUdLSyORUfifWufbi+C0gLZ5+S1Dg5jcbzGG2oEEUX73MluJe
         48Gg==
X-Gm-Message-State: AOJu0YzhsZZLOo3dvuKQEfKCax335aYFUtbMgKbDZfV8+Kfqb/431eWj
	FxAft+aFUQxBe82SLWKUdHoKeyXAK1YO9Vd8G6ljMWC5fc6cSHCduOFn5lx6Rdna
X-Gm-Gg: ATEYQzzQ3A9Rvk/rYk8dr+MywHhPMC21y7+DMxpQaQx9jZbCIQ0gljNQaqR6cQCcjng
	qTs+zy2DK2Akv+vrudKP7/RcQc7Hursk0v0BVUbv6XBQc3R2vTBClW/v2ibaSmR6z098Fyod0xo
	j3X4Qy0hfAiY6Z+KsPDQk69bgddGheqnvG6F+66mWhz7iX2zoBS+PXDmsQfkY0ILgKY+z2E1Hk6
	ACU/Q9o6gMLNmpnNHnG03wtF053sFAfLp057IdMQgw4unxE6Ef5QR7PDbIC0S4JWJfbfdpsBnQh
	I/OZ/YUcGKrrUo2zyrHavyhHFEDGlY2fLOKHQeId4q04T/0MLEP0017WI3iSiEy4xeleWi1bIYQ
	FyL4kBIQ/fP9ntRiwl0MeJliNE00H4nlzghHNcHHKjMZiZ/VBxGZcVXfmvrCkpubra9tgiQnlnS
	w1M33/fRkMtlTbOI3hEo/W8lKL+ovB5bSw5pW3QRtyoY+kTNny6iOw9LxBXrvARR0p8fzMLQakB
	N5OHN0zgK3xrvZsRSsM7DQBc+Yitvvpxqun
X-Received: by 2002:aa7:8f98:0:b0:824:3b85:ef89 with SMTP id d2e1a72fcca58-82a198e6a67mr5091253b3a.5.1773690389917;
        Mon, 16 Mar 2026 12:46:29 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a13a2f112sm14257571b3a.12.2026.03.16.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:46:29 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] fsck.erofs: fix xattr verification being skipped during extraction
Date: Mon, 16 Mar 2026 19:45:51 +0000
Message-ID: <20260316194551.32141-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2761-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2975629FE63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When fsck.erofs is invoked with both --extract and --xattrs,
erofs_verify_xattr() is currently skipped due to a logic error:

  if (!(fsckcfg.check_decomp && fsckcfg.dump_xattrs))
          erofs_verify_xattr(&inode);

This means xattr integrity is never verified when the user requests
xattr extraction, which defeats the purpose of the check.

Additionally, erofsfsck_dump_xattrs() is unnecessarily gated on
check_decomp, so --xattrs has no effect unless --check is also
passed, which is wrong.

Fix by always running erofs_verify_xattr() unconditionally, and
decouple erofsfsck_dump_xattrs() from check_decomp so that
--xattrs works correctly in both extraction and dump-only modes.

The ordering is preserved: file creation, then xattr application,
then permission/ownership restoration via erofsfsck_set_attributes().

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 fsck/main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index cf07829..1d50aed 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -990,18 +990,17 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 		goto out;
 	}
 
-	if (!(fsckcfg.check_decomp && fsckcfg.dump_xattrs)) {
-		/* verify xattr field */
-		ret = erofs_verify_xattr(&inode);
-		if (ret)
-			goto out;
-	}
+	/* always verify xattr integrity regardless of dump mode */
+	ret = erofs_verify_xattr(&inode);
+	if (ret)
+		goto out;
 
 	ret = erofsfsck_extract_inode(&inode);
 	if (ret && ret != -ECANCELED)
 		goto out;
 
-	if (fsckcfg.check_decomp && fsckcfg.dump_xattrs) {
+	/* apply xattrs after file creation but before permission restoration */
+	if (fsckcfg.dump_xattrs) {
 		ret = erofsfsck_dump_xattrs(&inode);
 		if (ret)
 			return ret;
-- 
2.43.0


