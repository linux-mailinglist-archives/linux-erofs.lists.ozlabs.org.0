Return-Path: <linux-erofs+bounces-3378-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHRMMDQT+mlRJAMAu9opvQ
	(envelope-from <linux-erofs+bounces-3378-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 05 May 2026 17:56:36 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D88074D0B8D
	for <lists+linux-erofs@lfdr.de>; Tue, 05 May 2026 17:56:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g93684vz3z2xfB;
	Wed, 06 May 2026 01:56:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777996592;
	cv=none; b=An3uVZjSwYjIAfTnbntRuaik8N3eNYZnut1zhAHhtn/89Fb402sY6LGLjHTPYgwgC0QL5k5oynpwvxQnSqa8XMgZTzDMJWZWroSGtmAZ53ByBihUL0mXRCO2k4BELI1+6U1YDpwZGaCQO5bsUCNUoxSM2F8bQOPl0UNKm0NIFIJ2E6EjUOu0jW/R2EQBPFVoevl8FguGpm35jBOKlA2vqEaSv8jsNcmi0fxgAHjyW2Q3kuSXXA3UI3uz/EbqC4jVI7wzuEL74aJ+dMUXj2NBEJoa+7pWeQxeWA0CDU4Oamd2RNrpI5p1FaWwE1t/II3ouJIat5V6E0SBMPf2CRwnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777996592; c=relaxed/relaxed;
	bh=pYXhan5/BhHZaUFYN6mzVa2Xk6sTmgmZ+Veyox0lqTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI3QJ8Qd8lB4dCHuux+a+0liTtofz7Qh64FGSO6GBCmvbBS7xoLkDAI6vi7GahBB5cOiYN1tYwM9dVOOiQlRw4Va1KljKK6+dQok2gqFJ1ivc33dGMjvOW6Y7MjFB7xGvLAYdX7SefugvCd5ae0S06PJcxl+WehAMfP+KhxXZv8nDk7L5w196+NG31glfLzjxfeUGc+vHnx/Sw42qKtRroLbcq6Ce+d1nQaROUCKEKHO6FSlT92k70/Bg+ayfrGCU4k9LfPf/hoEMvrWWCGwP2MY35FceonqUXWztjzSa2QcD6e5O45YYAuBN13f4VI5pkjf3RF2xaRQdE1qfeq5KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C+mqG1Y8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=C+mqG1Y8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g93663zJFz2xMV
	for <linux-erofs@lists.ozlabs.org>; Wed, 06 May 2026 01:56:28 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777996583; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pYXhan5/BhHZaUFYN6mzVa2Xk6sTmgmZ+Veyox0lqTA=;
	b=C+mqG1Y8/m1t0BzZeLfE+E6IxcBHxX1FwhAHSmTtoGe26dhWeayUV/j1EVSU3dyzG7uTetxxEx3HMYHE0aR236t2dhPBgtFWsmcVnK95RjneDfgfaPeu3IduosaWqQTtOc4N03Da7DeC6DhuiM8DFXz0NV/npmzoI59jV0a8FTQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X2IBQDW_1777996576;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2IBQDW_1777996576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 May 2026 23:56:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Carlos Llamas <cmllamas@google.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Subject: [PATCH] erofs: use the opener's credential when verifing metadata accesses
Date: Tue,  5 May 2026 23:56:15 +0800
Message-ID: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Queue-Id: D88074D0B8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3378-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
credentials when accessing backing file"), rw_verify_area() needs
the same too.

Fixes: 307210c262a2 ("erofs: verify metadata accesses for file-backed mounts")
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Tatsuyuki Ishi <ishitatsuyuki@google.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Can we verify this patch resolve the android-mainline issue?

 fs/erofs/data.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b2c12c5856ac..51b8e860b6b2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -40,9 +40,11 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 	 */
 	if (buf->file) {
 		fpos = (loff_t)index << PAGE_SHIFT;
-		err = rw_verify_area(READ, buf->file, &fpos, PAGE_SIZE);
-		if (err < 0)
-			return ERR_PTR(err);
+		scoped_with_creds(buf->file->f_cred) {
+			err = rw_verify_area(READ, buf->file, &fpos, PAGE_SIZE);
+			if (err < 0)
+				return ERR_PTR(err);
+		}
 	}
 
 	if (buf->page) {
-- 
2.43.5


