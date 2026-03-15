Return-Path: <linux-erofs+bounces-2700-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D84GkDAtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2700-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:20:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691A290FC0
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:20:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgP62sBSz2yYy;
	Mon, 16 Mar 2026 01:20:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584442;
	cv=none; b=BW03hyiNoZHRNfXJxqejJmLHA/QUogkrC40EJzNlXbjPCp5L5OZQwaSPjyXTABy5SoaIj05U+HSN0FrdkmoV72RT4w8Xq9dR/nrJXwWoWwPhO3A4Bk5Iry9yVSZuNQz8qcTnOJ2s5mCnli4rNg8vDcBSbk3FFu5FJWxDB7U537iT3PtZ9klCK+9aGNtyGUwGHRvn3XjzwFhO1X6avZ4+U0Tr40VzQmD812je5VZrA8D9PZ5p2T6WJWSzITy13ZBcWlcViEG6dcXDfFVJQIx/Sg+9pyFvmVuuRk+UGCBd3EQGdoGZZ+GSsC91lBb96rV5+MIZeFB9apFysl0MOHrQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584442; c=relaxed/relaxed;
	bh=AED/3EJk3UNqp6Utc/giJwUd+5ty4KKjUUqJoVWwYA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiUi298thLxh+8y5a5zed8H8PFmVcPosqormm4cqrjj1jM/sjlqCwmCHr+NDH1UHb7nzZ9Z+0z8XXmVC75dX9YZNWapoFxtRkXv2QeMQidNAibt/4Xu58LD2iYBNij1jdxn7iwtUC1fB9TsRp2nwglYgnyRMuWgkUaESPhaERmTiECdVnaexgEP3f6KYz8GrYYR/mL1bHzH+rdPms2SOsGDpzk8TAWFqslydjmevgC32UuSILOy2xR7Sd5cSn9X16iq7FVVZk4t1tOOjmtGH+U9LM1dg9vOLv6RlMLVLcw2gbepHBGqYSuCrshA2V70Zf9OzyvLACfzp4TL5Nw8Epg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HYz2faIT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HYz2faIT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgP526Ypz2xSD
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:20:40 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so3980745ad.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773584438; x=1774189238; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AED/3EJk3UNqp6Utc/giJwUd+5ty4KKjUUqJoVWwYA8=;
        b=HYz2faIT6XRT+Pj8yB6Xe/sbX7u0hbPD7h6pIkrUz0ez0yYDyvwRPGj8pLwME44FLL
         2OknQTG/tUUq6Pn3mVwAy5K7Ai0BJShjy10Iw0vLa3QIcTLsItInCprUHmwn+qvDkAMW
         VWck1CZclnh26g2zErk8nr0i2J9d3ac7WTOKjSIeZjoksUMZP3sc8DI2GFpg2NBlqs9q
         16HcWwH6oG0SPvIRK7m9TpJ84QcvIjkRPz8htUQW+WJP+ESSB9Zr/jFzlskpCYWZTogJ
         VKk1/ibrLIqAH8Lj58lq1A17se/+qvc7UN61ZZ4FdFToOrC5bCC5OPXpQldpKDZhOX8n
         xYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584438; x=1774189238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AED/3EJk3UNqp6Utc/giJwUd+5ty4KKjUUqJoVWwYA8=;
        b=OOjyC6aSMWysX1xDivF90uTeXRPr0E47toNPHA7ajaP2TQKmdlRi5wDfZKHP7tMCoA
         VHZLJSfxlxsmRKfmhn7Tlp25dPdWEYMG4ss5cpvr2JfobVjQPCUiurB4C805qbF7N+7e
         6Ty8e+/ndCvfFv8vLJkLzZ1Gq7PVk+WDZ/5uQTwK+djyqOs7ltabZsxaP0DznyD7vdxh
         /9Xer4iSiDvPymf6DUQVhq9GlTevEv/Xm3dL6MFds0O19CSIrRw7Jv/ecqr/+F5j8uf6
         VlvkeIWhgYNKY/RnslwPIzMAktf6Wjco9tbiDUxn+C+XiUiW48LzKos7esUkt6Bsg1U8
         edsw==
X-Gm-Message-State: AOJu0YzdQjqBINJSpYteURDfi/KpV9LlO7/t7wzR54OKahDBIoS2125V
	CyYkbOTsNU/+hS2grKrrTbkrdfX1tQnJwWNAlNKEBYGViaUo/GadxVaL
X-Gm-Gg: ATEYQzwW60wbhxvvPcK0zEsHhZMspSIM8+6vrC2CwE99rSNdnXIVc4NuUCf5K1CYmSv
	gSO5PKMSvZAQPMV6uJ6LjcC86FkDpe59f7xYJqGQbbkD0On+H73fZ616Zzour6ejmACzXhnIpJk
	qcc1Y70viV0aaJ7ilQlxv352FnCONOTDtgP+MW7NWcoTg+kcR44m0NejfFs5CBDmRtencxFv7tk
	uNVRdvBLrnSyZQk1Safd18vwnWPQh3JP6HBKm4lHJgXsLXhFX2u+oArHk0pDunfQDEDMY4IKjIW
	ol2CC5a758c528KQVXJ7iOIc0x7iPhYw2oKIUIiUACE7eOXoUbFaLnKWRbW9QmVa5V/gk/aYg+t
	1MH5qW8CJoggrqwCQ50DvKxxVHjxpO35KKhqNEkClZ8EyFIyYeOrUIH6/8eAkCpsa4DHXKspkRM
	hjPVU2kf8f8XuIRb13RgMfxuDa/O2A6OXGRUtELobLvDlSjh+RQJ8pkOmALqS3nVz/rKybs3tyD
	QK1mDcG9+usXfVpKNchcIKpW8hZbzuRCkJf
X-Received: by 2002:a17:903:4b43:b0:2ae:6220:1539 with SMTP id d9443c01a7336-2aecaaf6b20mr74495885ad.6.1773584437588;
        Sun, 15 Mar 2026 07:20:37 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece63133fsm77531615ad.41.2026.03.15.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:20:37 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH v2] erofs-utils: release 1.9.1
Date: Sun, 15 Mar 2026 14:20:30 +0000
Message-ID: <20260315142030.2628-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315072806.17504-1-singhutkal015@gmail.com>
References: <20260315072806.17504-1-singhutkal015@gmail.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2700-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9691A290FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gao Xiang <xiang@kernel.org>

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 ChangeLog | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/ChangeLog b/ChangeLog
index 8b80850..f47a5e5 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,20 @@
+erofs-utils 1.9.1
+
+ * A quick maintenance release includes the following fixes:
+   - (erofsfuse) Synchronize kernel patches to fix encoded extents
+                 and shared xattrs in the metabox;
+   - (mkfs.erofs) Do not set LZ4_0PADDING for plain filesystems;
+   - (fsck.erofs) Support extracting subtrees (Inseob Kim);
+   - (mount.erofs) Fix a flag-clearing bug that can cause mount
+		   failures (Yifan Zhao);
+   - (mkfs.erofs) Fix a CPU spin when using `--tar=f` if stdin is
+                  closed (David Scott);
+   - (mkfs.erofs) Fix crashes in the rebuild mode when the source
+                  images contains xattrs (lishixian);
+   - Miscellaneous fixes.
+
+ -- Gao Xiang <xiang@kernel.org>  Wed, 04 Mar 2026 00:00:00 +0800
+
 erofs-utils 1.9
 
  * This release includes the following updates:
-- 
2.43.0


