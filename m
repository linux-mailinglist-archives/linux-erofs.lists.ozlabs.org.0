Return-Path: <linux-erofs+bounces-2850-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAk1JsL8u2mzqwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2850-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:40:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A42CC1AE
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:40:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc6JV1h5jz2yng;
	Fri, 20 Mar 2026 00:40:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773927610;
	cv=none; b=GkS9u0p0WhXRfKRuzsykC5Mxrh7YsUZI446t4e/yjlLXPppHG9tpJfZZVcwNGgBBwn3KHOLxntQX7gyM1lBCShPlN+vWIhaIIdKKCAucJcEObzBfZeBQE3LjRDQ9HezNTDHhEM5DHR5CwOYiYD6cFViBgFm+VGH225Gk+PIObIy9JjADr04kr8wddMYYspC7w3eITX/K6uqVr4CLAoBMKRKFTtlSsLppA4nMr3zpHe4jEPGzTWe1Cgtd+l/b/WOMt15cMku6044SQxwRTrVFwEl6HlSEBFoTo1aCXar8Jh0MDkq8p4goH2/r4Dy7g6jZBZ26YyO+8C2kjduvzgoNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773927610; c=relaxed/relaxed;
	bh=IloEhG7YzDVk2vZuJaZZwzl9Y7iXiVEBC5LAbwTDUQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqLwTvOHFPrgDZIzqDxySJXUMRqruF3+INqtEPClWNXfnRc9XTovuH4WCAcFECcZ4W6isL/ykEXLdyPraxkkBKh95PR+x0gTg5Ivz+1mqCVKgiq9Y1QQAzgmw8ouY/5uHrmS8DCNhnYSTPI7fpr6kYas3AFq3/9cAzEncGsfU5tYRbzr4bBpx9fUiDZ0M6fwmOI7SSt8HefG/2PXBrMET4WrLCGzmIt7NXsqSCZdd4JHivopVpYDR5VYm5LBKeF8W/PCjhQUMQC6b+iNBxnyuQNK3aeowmsxKkkPxdRuANqPvKVPmtshDtP3bpoBmjvcqNBcTxBxXRTTn1CUbNsANw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L9tFhP0P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L9tFhP0P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc6JT4s8Gz2yLG
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 00:40:09 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c70f91776fcso419652a12.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773927607; x=1774532407; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IloEhG7YzDVk2vZuJaZZwzl9Y7iXiVEBC5LAbwTDUQQ=;
        b=L9tFhP0P8JOAsWpWU/ArTOBII59U+kP5eG2IJ7uTarq6EiruNdTd5bk5VTHjCl1Imo
         KeqzeMUJ7qzZfXBWIpNAB0FScsVopFGjZBXEuxasx4Lx9nKVhqinQRlk5FJva+QtzVqH
         1LbQRRen0SHMvPAi3alfVqVOAgz9Xf2TsRMS1sciu0PpnqbPbs/a3sgGKyv7n/Quy5/Q
         /sX64rmyxK2uS5REm++gKizYd4Vexol4ipWL4157IcYC4GjqpRpfyfsVxN3QZkNlrneO
         mtO6gUnhXqgFTReg2eJBtExvOvvSQPwEj8xzfB7K+ZQUEaIUc1P8WsYti3OJio/RD39t
         4Pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773927607; x=1774532407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IloEhG7YzDVk2vZuJaZZwzl9Y7iXiVEBC5LAbwTDUQQ=;
        b=p/aMoywUB13Yzv4jr6C3evIwpnwKp/v3y8oh8DUoNb90GYXJ6LofKqGaRYS/aqkgUa
         6j5/dNubGBEpKCvk4z4PwFbMLt7yIaYHeOYSaby5fZjS2uAdSM68iI8pI725Vv3VSn5v
         /fmT/1XEjeAf4VJIxMWJCI3KiBD7VGGW3GKJS747jXdG+zFf+zc2jEbSgIEUYpQbIjej
         KNY3QGGSzIX1KFEtuflvE+R/brlRpfvWZuVEFNEjQryU+CIDpGNYr1ppDzfYMG+ulXnO
         5GgtkzXsfhorxul7kgJPTxN8Moct+S75IFUPnmUaVvSxhEdxJ/zzwHIX/rBlhsfOu1DR
         77tA==
X-Gm-Message-State: AOJu0YxC1Runhbl0Z++ottNvuXgk99dPjHLQ3VY9sUzlkc234POpuG/7
	tk6e4gyP/wVvkbqDffoSJUsCqC0JIB/yIK9AtwBe9eFfH6i3gBQCXG4Yk767lA==
X-Gm-Gg: ATEYQzypg6NvWDziLremXMACeshZrLWpJ3VlL072U3riMO55/93aJBBdXQAQjRM/ahj
	qLp7fgoC8sAqDPyv3lPJNbquzWHUNAtKPZZ4BYf91U5mUVDJVpflTU9Qxq06NUy8RAQXZ4QvFEv
	Z4P6lbIr0Baw+6hG4DXAGTTo8yMDbPNfpLRjIeXpg1nhZD4iJ7oaTYRESTu2R0897+vH/97gfSk
	sXRRwKYNwlIYRwr0h+9SY/IKyZLHc8e2h7Bq3jCTH/TaI7FwgOAiuS26LI2niH48NnfHsLmgHQi
	J6GZDtX1x1icW0nrwkeF6bCCFbUtv+S0/NSmi6SXyQdH5JN+81kgKNrXuv7ZbzNpHFgdjf92Z7B
	YBBdGnKCMmTJl8p+VQ17kuDjObCM2VyymfQnLyNjdthQPNXeiYhn9p+y7rLkr8aLGiuGfyKNT9p
	5gJx9resf3Pjk1xzabD0RI+jhlzObcyIfQWxAKd0Y=
X-Received: by 2002:a17:902:da81:b0:2b0:3f76:9e98 with SMTP id d9443c01a7336-2b06e30ea79mr71881985ad.17.1773927607051;
        Thu, 19 Mar 2026 06:40:07 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:ad85:41d3:35ed:5117:45ed:d381])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e4316b5sm83638885ad.23.2026.03.19.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:40:06 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH 2/2] erofs-utils: lib: fix meta_blkaddr handling for 48-bit layout
Date: Thu, 19 Mar 2026 19:09:48 +0530
Message-ID: <20260319133948.396-2-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260319133948.396-1-newajay.11r@gmail.com>
References: <20260319133948.396-1-newajay.11r@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2850-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9C9A42CC1AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix the FIXME in metabox.c by properly handling meta_blkaddr for 48-bit layouts. In erofs_writesb(), set meta_blkaddr to 0 on-disk when 48-bit layout is enabled since meta_blkaddr is encoded differently in that mode. Remove the now-resolved FIXME comment in metabox.c as the issue is addressed in super.c.

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/metabox.c | 1 -
 lib/super.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/metabox.c b/lib/metabox.c
index d6abd51..077f88b 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -62,7 +62,6 @@ int erofs_metadata_init(struct erofs_sb_info *sbi)
 		if (ret)
 			goto err_free;
 		sbi->m2gr = m2gr;
-		/* FIXME: sbi->meta_blkaddr should be 0 for 48-bit layouts */
 		sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
 	}
 
diff --git a/lib/super.c b/lib/super.c
index 088c9a0..99d2a24 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -209,7 +209,7 @@ int erofs_writesb(struct erofs_sb_info *sbi)
 		.epoch     = cpu_to_le64(sbi->epoch),
 		.build_time = cpu_to_le64(sbi->build_time),
 		.fixed_nsec = cpu_to_le32(sbi->fixed_nsec),
-		.meta_blkaddr  = cpu_to_le32(sbi->meta_blkaddr),
+		.meta_blkaddr  = cpu_to_le32(erofs_sb_has_48bit(sbi) ? 0 : sbi->meta_blkaddr),
 		.xattr_blkaddr = cpu_to_le32(sbi->xattr_blkaddr),
 		.xattr_prefix_count = sbi->xattr_prefix_count,
 		.xattr_prefix_start = cpu_to_le32(sbi->xattr_prefix_start),
-- 
2.51.0.windows.1


