Return-Path: <linux-erofs+bounces-2698-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TnvjIPBhtmlgBAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2698-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 08:38:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 536362902C8
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 08:38:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYVSr5HW8z2yYy;
	Sun, 15 Mar 2026 18:38:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773560300;
	cv=none; b=SE9L1tYdw14S4tv1q4iW2yf0Vrz0XP/hPeMMAoi7HddQVwbrB+ateT1Jf+2c+tyxoynNPehXiVo+zgmnpacwy+fMD1PBrx5YP/wZUx31Onl0Z681RuS9xpkoPw0u0tZgkP/f9/vBirAhuxTOBuloUOYMdVBkY52Jp/sJ5iVfArTbvr8wfrR8NuVpZSXflaOzH8jcXCatJ/PP2Md9EKvqB5+hIn3Wrssn77aVEJ8KklhLDOmi/DM9qKUXDRXUfV7FoNd2DSWchoirSG0FGrJ7W5hZTcyA5d4GY4vyY581MaMQIFl2SuC/mqjYoR5ItasnkeXFH1/yirFc8BJoleNPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773560300; c=relaxed/relaxed;
	bh=xOc88+p4ZxMDipD+pnCWBppHlZx0z5TH1NQEMJryy7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiEtnZXg4fL1CmXfDslWlIR/5xGc2+9IAX01uVAUWXaZ+qEs3pMMghZDMHYNt8EM9y6Nl2/q6DCZR9wQ4vVKFp+FaPb2hTBTvfcL2jvnTBXKV0al3SR+7HaHwHFLgbY5FVoBQQfMOOOtlGRM9pCUdcTM2gLhS0+vAmbabNgeAgaknI5cbylDSw+TR0FjyFWX/VUYKSwltk1X+KyS/4DuXGt/Wkty12qtCJWvYQ2kwozqmxTmYwAMwD7wsFG1wARAgh/zyzvaI/ReMfnnst0yZI0hHHzImIuG/E4YrOaeCwhcPLtcOjmfo8nUE+546+z3fwnQWbL0Asmxcn0vz8nPMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EeknoNWG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EeknoNWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYVSq3yxWz2xlM
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 18:38:18 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35a034ca40cso369184a91.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773560296; x=1774165096; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOc88+p4ZxMDipD+pnCWBppHlZx0z5TH1NQEMJryy7w=;
        b=EeknoNWG0DEvAzJFR2uAuYNY/HCMsl9MuitxqxJXEn1hM/lfLLR5EMD3zx/62ffHlr
         PDYKrCRKEUNzBzy0GPpE1zynvjlJ7p7Km95yJk5MHdSRmGlXC76Duid7udfojz+hO4K2
         SBOU1zoKNaCHoXWCHAEqSdBe0LcSPov06/3YWaTkh6NFJqJlEc3+U73b8XaDxH2eD4Ac
         Nd/2hvm/hnv8SWyJWozOUCY8U9OvK8ljad2PJChL22nTuUN1SijxwZGUpzM1VcVdSZEI
         ZsDfpcm33qGmH6t9Us9wjQnOoJQwuXfneuNqOGpxHl86Gdp/YBr/+1jI4tKC90G7fheV
         msxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773560296; x=1774165096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOc88+p4ZxMDipD+pnCWBppHlZx0z5TH1NQEMJryy7w=;
        b=CWVR16fm39wTu0hXfNJmbHGzJutPX1vxwwSC8kIRFgR60zENP262tkUVWZkfT2Uz58
         cDXbEJoO3Px4HRgbdwQdpO17yD5aUHEPwJ8HaMVgkE69oVm0hYLvMslRZqZcaww9f6K6
         7UgtRV2e5AKwS3S4/AHZFdlNeHspnIr5E6rUWrGAmXvc2F1dmFTkF7WNVq6BeY1jk7+M
         YQfX+0QLsOdE9THalO0LeZkAqw07x2kX6devtpdEFFh5HjU8m2n7ydq5pEfA+uU5ldn0
         TGRcU8IqyQk/rCGLLkp5jgR1gp35v3du/Cz8h8Csw9Ga7VdoueMXf6+GSqK9fJMQBmlx
         qsbQ==
X-Gm-Message-State: AOJu0Yy14IkbDtj4S+nxJJNtJBihgdPflCEMqrxCg7qMr6h04zBFghM7
	u6uWHkhzCq3/tRD8iFMjHwOPPlqgV2v0yQG+GW8PLPzlzTYUaS4A6zUk
X-Gm-Gg: ATEYQzy+Xvioy0cnLyS76Cym+KQTJzI1BgruiL2TOC7cKiHmHCigSTYNLGC/tt23U2D
	0wu05u2QEA7rKFIh/3pbBUKamKv5GA26O42AFeahZyKJT4OJiRvefKzH+hLJUlcCqnvxj69d+93
	MmFojalMHKO+zQqbvdAMG1nfjdkhwLxKSeOAv7hiHTTBeQOeRYB5yohbmeajOTe/uPrWoLIdFEw
	WlZlcOAcXTpMwc/Irbk0bp3maXq7Jefc1jDIBH2RwyBVKwCvZK7Ygs688kPPNCl/toVR63xt6jg
	bdCT8nPIGos/1WVAfYzckb18dD+O0IgdsVEPTfwcsqKYyR5v7xMOzRX0ex99NoyELNrNHk6b7JD
	XkkO547NTof4ag/5mipyjU/SV1u3AQ0aCYHsBgQ6bEOVwsaKXaJwGSUjYl78RNln9ftoQ7ujCKg
	8wTKJz98pBAm+kMkPUxUNnyx3JmfIpQp2/ma5qA1vwIV89N0WkZ+eUoA9TmB7B/X1Ad85ZbpwBr
	jOZRv4lCVT7/Y6N8V1f5xmGjaVWqQV6nB1J
X-Received: by 2002:a17:903:2ed0:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2aeca793a50mr63949515ad.0.1773560296161;
        Sun, 15 Mar 2026 00:38:16 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed9cdsm73690145ad.60.2026.03.15.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 00:38:15 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] fsck.erofs: xattr: validate h_shared_count before shared entry loop
Date: Sun, 15 Mar 2026 07:38:11 +0000
Message-ID: <20260315073811.26665-1-singhutkal015@gmail.com>
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
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:1032 listed in]
	[list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [112.196.126.3 listed in zen.spamhaus.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:singhutkal015@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2698-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 536362902C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The h_shared_count field in erofs_xattr_ibody_header is a raw u8 read
directly from the on-disk image.  erofs_verify_xattr() subtracts
h_shared_count * sizeof(erofs_xattr_entry) from 'remaining' without
first checking whether that product fits within the available space:

  remaining -= xattr_hdr_size;           /* remaining = xattr_isize - 12 */
  for (i = 0; i < xattr_shared_count; ++i) {
          ...
          remaining -= xattr_entry_size; /* can go deeply negative */
  }
  while (remaining > 0) {               /* silently skipped! */
          /* inline xattr validation never runs */
  }

A crafted image with h_shared_count=100 and xattr_isize=12 causes
remaining to reach -400.  The subsequent while(remaining > 0) loop
is never entered, so all inline xattr entries are silently skipped
and fsck.erofs reports the image as clean despite corruption.

Fix by checking that h_shared_count * xattr_entry_size does not
exceed the remaining space before the loop, returning -EFSCORRUPTED
on violation.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 fsck/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 16cc627..a3cd50d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -378,6 +378,20 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	ofs = erofs_blkoff(sbi, addr) + xattr_hdr_size;
 	addr += xattr_hdr_size;
 	remaining -= xattr_hdr_size;
+	/* Validate shared count fits within remaining xattr space.
+	 * h_shared_count is a raw u8 from disk; if it exceeds the
+	 * available space, remaining goes negative and the inline
+	 * xattr validation loop at line 396 is silently skipped,
+	 * causing fsck to miss structurally corrupt xattr data.
+	 */
+	if ((unsigned int)xattr_shared_count * xattr_entry_size >
+	    (unsigned int)remaining) {
+		erofs_err("nid %llu: h_shared_count %u exceeds xattr_isize %u",
+			  (unsigned long long)inode->nid,
+			  xattr_shared_count, inode->xattr_isize);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	for (i = 0; i < xattr_shared_count; ++i) {
 		if (ofs >= erofs_blksiz(sbi)) {
 			if (ofs != erofs_blksiz(sbi)) {
-- 
2.43.0


