Return-Path: <linux-erofs+bounces-2809-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE6rGFOEuWlyIgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2809-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 17:41:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE642AE38E
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 17:41:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZyR35mFmz2yhV;
	Wed, 18 Mar 2026 03:41:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773765711;
	cv=none; b=MWdaCeDMq1TzC3XNwo3iiG7f1ts+DMbRcqU+2Ke+ansBwNF0tRIF5YBuJ0jvVViV8madHelul+PznWlXrfgq+sPKXnVVF0iMXM0wNNCb2gWRlXpSUsMLTKE3LShbvID0X/fD1F5v6eGxD7WeQndMUj3F9mB2+dzYN33PvS7yGiZctkgq8VCZVZ+OtYSgVx8XqiDBtRM69C7a3j8+eBsoChqGP2u1LExiOaX2oufJCUAfUjBfv/cMXSQwK0Z36I6EYVLu9JR+irHkWzRITXb4PRofGSKYC7FbKUa7lB55a786SYe30LNIKn/vFM2+pkGfrwuSTpuY8LqWmTkF3/LKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773765711; c=relaxed/relaxed;
	bh=oi7WFKnjnbvtaDtJnnUDWWC7u3TXz7txHxrui19e8QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvARwV9mIYRhGkarlQZIYjCBVgr/q0zidNH6IFGHUAS+k2YierN7mKtaqhzYpwO84dtLF/cNKHKWOYHkFalh9kMHtiz8Oi3Q4SfBjndro5J6SiJ0+0FioM3tzIiTe4sr+5O5OyfNY64UF/gbgJChEb4fPL4eqaMXqDLBFRTEAtDVJ2nerWRAVIkt0TJOYwZIuTW2R/mA7Rxkh8rtN+GzA1g8e1WaxWtzhSvxEgM92DY8UzmUDC0UMVim2JSbjW28j7Xcpml2cIlibvMW/7c0Nv6oL/izhjo9dtH9nGBIHQsVsqUMA79hcNMgv4sddZr6tq7+/2HMPR/6oMs1xtwm5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K23LaBvG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K23LaBvG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZyR23J3Wz2yFd
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 03:41:49 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c73f12fe254so114168a12.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773765706; x=1774370506; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi7WFKnjnbvtaDtJnnUDWWC7u3TXz7txHxrui19e8QU=;
        b=K23LaBvGupIpRBjpvFIWpKUC1BH3hf3flijCC6PFLKTuLmUikaugUTVnaxM4SkPYzV
         40KnQJl6BxDxHw6AHQ1t0Eakv+D8Ac1Fl0M4V3fhCixCjL3//KGXKBTioOhvs0oixI9z
         UQy9jDM+F3FSiyVOALRXtbbnLSLmPu1RNfcoB6b70+9P8wJKLYvJEYHJT088QHwLZ9sS
         ruxpSEpSPBPYfNya1ImAQH85GpAQOK+9lGsl76K6twsItfOIcAapjrD5cujEDjJ7F6GL
         LuQkaUdZzk6fP4fywv0ykb1OCzFvHRvdl9ufGxMHKNnv22vGdJLiZ5BwsVNVSkkT/ppx
         AG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773765706; x=1774370506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oi7WFKnjnbvtaDtJnnUDWWC7u3TXz7txHxrui19e8QU=;
        b=kER6gNylwJQeOxavSNuRuK7a8hBteZ8FxGibb+g1Vyl+JeE9Xev6dRXcy/bBsIaMWv
         giVTc1/VwfqaAZkZBaXT6lOjGUc0cUVXDZY3BUE6+SI9Dsk8vTMN3p/Mex1FTKPqzcJl
         re51oeymdx3PY1WbFBA++BQ2NbJ9LxyaQIFORZ2Kf+ZBGE7jFWxV4DvEGUlr/i9fMSw2
         l7yDo1FUr17ua18dhAQBvPGnzCfDKc0GDeoFlGWl2L4jpwVc9KGEVU6Yh2hjZVg7JJQv
         KhRzQeeKjHCncw4UwFVfCINnbVFWnQbQEeHPg5srj7KyyxD460TvqteXt3B1cvZsMLgm
         evKg==
X-Gm-Message-State: AOJu0Yx7bMi3w20h2RBPfd3RfrCOU0McHIj98heBrOdBUKe2vAbn1zt5
	nwUJTBgrNpn3hMU9gQE8RxUE5H7/KO2GtifhMrI/IM1lLL70wJ7XOLZkuuQ5A2xX
X-Gm-Gg: ATEYQzzCI1gyLBg/JiwCclEB91y5ql4kuJPvqvDh6T4SnKVl8isfoLT9B6BwlI2UDEB
	T3wsArdU6mfCAaBeKgq/7akMIOqfFgm1oLDRj4ZZljikYwDlZfiGltcgdCyRW8jPQ4xe8KoM7hP
	1BsjCruFUbWd5Cl8/KUZTYzv9JjUc99O8j4V8D4JLFFm+Vj+ddyC5NeazKO2JVFv48hJ4tYgOqr
	L98Hhg5Z1PQKdpbwKj2JAnraN+M+tLR1q0Ka8e/FaUu01JbaKH9EtCyxFtVI6SV74A1P+e9510t
	e5WAUNlVoKoZeQBX7KsNdWkuqwsrVoBTsnZ2rRf5uHMZE2/WND9vV/9GpCg+2NXNe46MIz1slSz
	wDa+FSsc4GY6Wb5KMnYki+vxKQuYJmOLWYyEgTUUDyafHV06nS8Ed1T3DYuPxrxu4vrrM3QMCBk
	2MkP4kO61VUDEut2kQDICTkNtKsHVeiB+WMHQRf2lJgbDLmA1rW15A+aTfl1/oILwQSoUGUnr5A
	ntoH6VZKfV8iYvmPK/ycltI3nj6oDBRqF/pRPYpht1TwZU=
X-Received: by 2002:a05:6a21:32a4:b0:356:3b05:2955 with SMTP id adf61e73a8af0-398ecda31ebmr11679125637.6.1773765706320;
        Tue, 17 Mar 2026 09:41:46 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a1e72cf33sm12998842b3a.37.2026.03.17.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:41:45 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@linux.dev,
	linux-kernel@vger.kernel.org,
	singhutkal015@gmail.com
Subject: [PATCH v3] erofs: validate h_shared_count in erofs_init_inode_xattrs()
Date: Tue, 17 Mar 2026 16:41:35 +0000
Message-ID: <20260317164135.24892-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317152439.5738-1-singhutkal015@gmail.com>
References: <20260317152439.5738-1-singhutkal015@gmail.com>
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [singhutkal015(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [singhutkal015(at)gmail.com]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [112.196.126.3 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:531 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2809-lists,linux-erofs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.908];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 7FE642AE38E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A crafted image can set h_shared_count to a value much larger than
what xattr_isize allows. The loop in erofs_init_inode_xattrs() then
reads shared xattr IDs far beyond the inode's xattr region, causing
an out-of-bounds metadata read.

Add a sanity check ensuring:

  h_shared_count <= (xattr_isize - sizeof(erofs_xattr_ibody_header)) / 4

Return -EFSCORRUPTED when the check fails.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
v3:
 - use local variable sb instead of inode->i_sb in erofs_err()
   to match existing code style in erofs_init_inode_xattrs()
 - confirmed compile-tested with make fs/erofs/xattr.o
v2:
 - initial patch with bounds check against xattr_isize

 fs/erofs/xattr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index c411df5d9dfc..af16cf634a01 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -85,6 +85,15 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
+	if (vi->xattr_shared_count >
+	    (vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) /
+	    sizeof(__le32)) {
+		erofs_err(sb,
+			  "bogus h_shared_count %u for nid %llu",
+			  vi->xattr_shared_count, vi->nid);
+		ret = -EFSCORRUPTED;
+		goto out_unlock;
+	}
 	vi->xattr_shared_xattrs = kmalloc_objs(uint, vi->xattr_shared_count);
 	if (!vi->xattr_shared_xattrs) {
 		erofs_put_metabuf(&buf);
-- 
2.43.0


