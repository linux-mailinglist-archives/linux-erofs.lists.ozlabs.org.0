Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CD85E96B
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Feb 2024 22:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1708549446;
	bh=7SrJM1oyxiJBee5rhTbp+mwhYJ/a30jfajx9Ht8Agks=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Msr3vybjSx3nDlzwL3SKAqtR1w0apjsg/jeZVMLN1NsWBOhQwEjAs0Nr22zA/5XRn
	 9OwZZYFrA8epq0oUteux7WOp+o5HSU9Aoo3n6ylFT4fTGDApv0l+lHk+dKu5ueZoG8
	 TCu8a+m0J05Z0P77yWRkeEQ0VMfkit4ZZbYtmPZLe79bSW/XnOI0f9BKEjx7Jmfc6h
	 zbqMuCx3eS1UXP1mbAd7IGSm7bM3g2iSRBFOLVdPqMbYM5LLZDUU01ghppOwGdEjwk
	 cm/f7+HbZlKMm9YlrWxFgbldW106dX2JO6a4FrTq8MJj3zh+PGWu9aTNp1+LQr1k2A
	 /UNiNcwI+S/oQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tg8065lP8z3bmy
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 08:04:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=YfbAZmr5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3omxwzqckc5m04xix813bb381.zb985ahk-1eb2f85fgf.bm8xyf.be3@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tg7zy2dGQz2xWR
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Feb 2024 08:03:57 +1100 (AEDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so8672267276.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Feb 2024 13:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549434; x=1709154234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SrJM1oyxiJBee5rhTbp+mwhYJ/a30jfajx9Ht8Agks=;
        b=r8CZTNR+CnQVGPx6IEU37i76WjGAlM09AxnmuTK/xRIdL4q9e/ZRp1Q5o/CQ8E7aVg
         3R74LIlfR3FqQAahK8amn2QWljA7Af2JHTBJh+oSh0xj86hlRrbZgUu4pwIDO0m8Je7I
         KGcyk0yRjXp/mDg8D0B2jBW3FEXK9JCMjYJl2KgUj4EjD9JHnxUHQqY8Q95zLNKwZwBo
         ze5KnsCbGnlPf5LEK2i6GC48Kp+7h/C8Jq0T2hAa8pbgD0TRkb4K6raS516q0ZAGjwIU
         LvSaf/hJpmMXe+fpqG/U9ElrTPS5Zrpq8BDHVGg+3z8NJ1xNMD/VZX+O6AquGf8zpy2p
         kfUg==
X-Forwarded-Encrypted: i=1; AJvYcCVMWm56mUlISB9qfavNyU2biru9cWrOOp8h2v2AuG77Yw4QbmPBz10urIa0JhcUL9otlcACB8B7ue0LtdrYvrus3D7HPleOUaeiD+xL
X-Gm-Message-State: AOJu0YzqHjiR7QUNeCWa/rkBlEIT7WFtlJarwz3B+yXP+WY0DWU9x8Tz
	j/s7eUBu2fLXvC0LJewEkC1Gq2Sow1TO5BDjsioQBQRmlUB3LYzBMZC4vpdYKod+gRKDx2vzVdq
	ufSWjOw==
X-Google-Smtp-Source: AGHT+IGfQ7tP0IsEPfMeTEUa+hP//eArvfxvolLuo29MkXjSjnUdg2wVPoB/uWCNVbaUgyFPLcxJaw3bv2eA
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:e195:1d33:bc5c:369a])
 (user=dhavale job=sendgmr) by 2002:a05:6902:1505:b0:dc6:c94e:fb85 with SMTP
 id q5-20020a056902150500b00dc6c94efb85mr19718ybu.2.1708549434314; Wed, 21 Feb
 2024 13:03:54 -0800 (PST)
Date: Wed, 21 Feb 2024 13:03:47 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221210348.3667795-1-dhavale@google.com>
Subject: [PATCH v2] erofs: fix refcount on the metabuf used for inode lookup
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, quic_wenjieli@quicinc.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
we do not assign the target metabuf. This causes the caller
erofs_namei()'s erofs_put_metabuf() at the end to be not effective
leaving the refcount on the page.
As the page from metabuf (buf->page) is never put, such page cannot be
migrated or reclaimed. Fix it now by putting the metabuf from
previous loop and assigning the current metabuf to target before
returning so caller erofs_namei() can do the final put as it was
intended.

Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
Changes since v1
- Rearrange the cases as suggested by Gao so there is less duplication
    of the code and it is more readable

 fs/erofs/namei.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index d4f631d39f0f..f0110a78acb2 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -130,24 +130,24 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 			/* string comparison without already matched prefix */
 			diff = erofs_dirnamecmp(name, &dname, &matched);
 
-			if (!diff) {
-				*_ndirents = 0;
-				goto out;
-			} else if (diff > 0) {
-				head = mid + 1;
-				startprfx = matched;
-
-				if (!IS_ERR(candidate))
-					erofs_put_metabuf(target);
-				*target = buf;
-				candidate = de;
-				*_ndirents = ndirents;
-			} else {
+			if (diff < 0) {
 				erofs_put_metabuf(&buf);
-
 				back = mid - 1;
 				endprfx = matched;
+				continue;
+			}
+
+			if (!IS_ERR(candidate))
+				erofs_put_metabuf(target);
+			*target = buf;
+			if (!diff) {
+				*_ndirents = 0;
+				return de;
 			}
+			head = mid + 1;
+			startprfx = matched;
+			candidate = de;
+			*_ndirents = ndirents;
 			continue;
 		}
 out:		/* free if the candidate is valid */
-- 
2.44.0.rc0.258.g7320e95886-goog

