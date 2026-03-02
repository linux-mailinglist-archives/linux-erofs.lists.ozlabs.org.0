Return-Path: <linux-erofs+bounces-2453-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFolLsKCpWltCwYAu9opvQ
	(envelope-from <linux-erofs+bounces-2453-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:29:54 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C642E1D871F
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:29:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdYB6YhZz3btf;
	Mon, 02 Mar 2026 23:29:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454590;
	cv=none; b=FUveuyP07Nd0MyXLYiC2ISibDLSc6QylBhQPBj/lCf78cjF/0l/5/nUgrvBwKQj7AoSo9vMeSruSWwI9HBqv1pnIZeksJtSHR6RcvS7+oQoSceOnb2fyDYdM3ZOVuApowtHYMPSZdqPgQBA8KHrb2Dg2UYa+4HLUcIBxIZPsBratCCa7fDu/wAulrEaRB6LXKqZl+iclWPMB7WSV3igH336PGU396O+SlC4Qh4o+OT2VnfzaslffUU8+o4C0Ziopu4NPNRvh5J4k5eZxYWKQ4pKcw/sWzEFSzyYu4CHoMZzY1HSwnFKWmi9YmDDJMaEJ19/Mfzycti80o4XLXauU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454590; c=relaxed/relaxed;
	bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+7qQk8lCCKow5IB/PBcC4JXO12ieDynQvuu7hx94rkoprp8p8Pk53xr3Rh8c9LwC+0ZzFX1mrmAaOUwyqJitzY0gpgE4PLl7zz4WJ5RoebVw8ckx2OJGAU6/L1WqNglLalXxuAMUHwP8E7uNd2M4/+z86xuWrxSsIvzxVJ51xng+HC1OG2JjXoB1mH13/okSsVeT/XsvjPWyZMwjGcgy+IafHvbr3NTBJ0yayR2esfabvbUhD3DoFU0VKvcgyh1U/P8InfUbV6WDMpt6sueMH3jNuGDBy7QwexqdBrsFBECHklwoOjZggB6HVZPPQ0RzVCOJ/1u8Jo1m0lYI+5xoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EpPFqy2T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EpPFqy2T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdYB1Hvbz3bW7
	for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 23:29:50 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-827307b12dfso2363050b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 04:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454588; x=1773059388; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
        b=EpPFqy2TNzWLroLGAPLHmCmUMDUE2IZc1GGA+U365fsu14KUmx1rm3EuWpS7d5V7fH
         iobSOlSeKyF6Ck9/IOgVnCDbJjZlldgz7iW/DjbyzFwP28DnkmPWiEnOoe+JWkyib6zH
         8ZaTO0X0YAMa53bsk3XoZZYMhUFMGn1y6tI8IF3apzZ4crzbtVQ7YATdijTZ2satoib6
         s04Zokhw4ThJeWM1YFHgLM2UXIRrhHBwnaXDIbgeMjNL7UG9HFZRUR12fWQZ9515kQLn
         Rfh7yEr4hWfFpown6ip/z3Dc/Ja3zGFIq1BXoqORDdbGuGMfO4VLmSMP6c5/Bsjj/VuU
         Mx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454588; x=1773059388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
        b=Bb3MxZoyldxLKxhwx/WRm9f9PjZO4Z/E5VVmFusrE470T+o1J/lcXjYZ1TnAuOrg6y
         VnO6k+nj1/8B+1ebdUZkAmPSo/WjCmmedhvs99z7Ceo+jrH682o7I21kd7b4Jujd9C5Z
         Eb+6bPICUfRa1GMlI8urlzdY/4HnVvbuNX9wQ3BtMo31tM1Tqdy0nti70ZkFux/vhtj2
         dpwUpfjXnqB4UCv/7BfG2nceXAx53/2WG1osSaYwffV09c85Nhrzl3WcY8Js3M4UMxz8
         3w/39Bvvc2RObsFy6B//1D/uld7eTktZ+g03Px6cJ2hEPFGBITUpBRxrZHFcKe9NBreQ
         +uCg==
X-Gm-Message-State: AOJu0YyIkTMVOs/lCxUqU8yauHHc3yn11NtGD29E8Z/6+KWfiq5gD02C
	th8R68f8C0ZaNE0XxD+/JRvx82sJ8hyAMuqXyIfxGT3XeQ8Yr52W0DTseKfcV6q2
X-Gm-Gg: ATEYQzyuLdk70lPy9XHErkgAUSKHsN4BYijQwa8XMtCaSxquVMq/gpFXqlO9YLHUl/o
	+n0SzMuPu9Btg7Klasy5ZvwyMjLu63HE7mwtUhoRKo/RB7xl7vSse1qpbiyyAzgKOnLmUkZ1cmh
	E1dfuu9CYCyRqsIZQ1G0VU2iHIewin/0s6st/O39ornyNX4nmpEXHJTKezF8+CDPrjUTHyleu4Z
	/EgHhqd4M4FHAa+HZheB1VccwaZtKRtLoV9RA0EuzObP1xlvDb9NuA3KHnqkSLI0tWlaSnPCulI
	74PGQDCYvlGDLNxKwu52ApnVMjy6f/jQ0fQCULJvCvaNy6NhcUFI8igsIgNf+wyU7JT/zJ6mAai
	cq7RvMp7L8XzZCjhfIVWkI2PS4CAdvBiWRS8zGan3YEumS1yOY7xvWu3llvh1bVX0h5X1/yzCNk
	Qu34RJ3MLi8zP6TQpQ4r6np/sK
X-Received: by 2002:a05:6a00:408b:b0:824:b03f:2f65 with SMTP id d2e1a72fcca58-82739742f8bmr12585073b3a.7.1772454588003;
        Mon, 02 Mar 2026 04:29:48 -0800 (PST)
Received: from vitap ([2a09:bac6:d866:16aa::242:a3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a9dasm13092638b3a.49.2026.03.02.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:29:47 -0800 (PST)
From: Hardik <hardikkumarpro0005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com
Subject: [PATCH] erofs-utils: mount: fix flag-clearing bug and missing error check in parse_flagopts
Date: Mon,  2 Mar 2026 17:59:43 +0530
Message-ID: <20260302122943.54-1-hardikkumarpro0005@gmail.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-2453-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hardikkumarpro0005@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,foxmail.com:email]
X-Rspamd-Queue-Id: C642E1D871F
X-Rspamd-Action: no action

From: Yifan Zhao <yifan.yfzhao@foxmail.com>

The MS_* constants in glibc's <sys/mount.h> are defined as members of
an anonymous enum whose underlying type is unsigned int (because the
last member, MS_NOUSER, is initialised with '1U << 31').  Therefore
~MS_RDONLY, ~MS_NOSUID, etc. are unsigned int values that, when stored
into a 'long flags' field, undergo zero-extension, not sign-extension.
As a result every 'clearing' entry (rw, suid, dev, exec, async, atime,
diratime, norelatime, loud) produced a positive long, so the
opts[i].flags < 0 guard in erofsmount_parse_flagopts() was never true
and the corresponding flags were set rather than cleared.

Fix by casting the operand to long before applying bitwise-NOT,
ensuring the result is a negative long with the correct bit pattern.

Also add the missing return-value check for erofsmount_parse_flagopts()
in the '-o' option handler.

Reported-by: Robert Rose <robert.rose@mailbox.org>
Closes: https://github.com/NixOS/nixpkgs/issues/494653
Signed-off-By: Yifan Zhao <yifan.yfzhao@foxmail.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/tencent_003DF0338EAB42F1573BC0CCFBEACE321E06@qq.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index b04be5d..dbee2ec 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -203,15 +203,15 @@ static long erofsmount_parse_flagopts(char *s, long flags, char **more)
 	} opts[] = {
 		{"defaults", 0}, {"quiet", 0}, // NOPs
 		{"user", 0}, {"nouser", 0}, // checked in fstab, ignored in -o
-		{"ro", MS_RDONLY}, {"rw", ~MS_RDONLY},
-		{"nosuid", MS_NOSUID}, {"suid", ~MS_NOSUID},
-		{"nodev", MS_NODEV}, {"dev", ~MS_NODEV},
-		{"noexec", MS_NOEXEC}, {"exec", ~MS_NOEXEC},
-		{"sync", MS_SYNCHRONOUS}, {"async", ~MS_SYNCHRONOUS},
-		{"noatime", MS_NOATIME}, {"atime", ~MS_NOATIME},
-		{"norelatime", ~MS_RELATIME}, {"relatime", MS_RELATIME},
-		{"nodiratime", MS_NODIRATIME}, {"diratime", ~MS_NODIRATIME},
-		{"loud", ~MS_SILENT},
+		{"ro", MS_RDONLY}, {"rw", ~(long)MS_RDONLY},
+		{"nosuid", MS_NOSUID}, {"suid", ~(long)MS_NOSUID},
+		{"nodev", MS_NODEV}, {"dev", ~(long)MS_NODEV},
+		{"noexec", MS_NOEXEC}, {"exec", ~(long)MS_NOEXEC},
+		{"sync", MS_SYNCHRONOUS}, {"async", ~(long)MS_SYNCHRONOUS},
+		{"noatime", MS_NOATIME}, {"atime", ~(long)MS_NOATIME},
+		{"norelatime", ~(long)MS_RELATIME}, {"relatime", MS_RELATIME},
+		{"nodiratime", MS_NODIRATIME}, {"diratime", ~(long)MS_NODIRATIME},
+		{"loud", ~(long)MS_SILENT},
 		{"remount", MS_REMOUNT}, {"move", MS_MOVE},
 		// mand dirsync rec iversion strictatime
 	};
@@ -281,6 +281,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 		{0, 0, 0, 0},
 	};
 	char *dot;
+	long ret;
 	int opt;
 	int i;
 
@@ -305,9 +306,11 @@ static int erofsmount_parse_options(int argc, char **argv)
 			break;
 		case 'o':
 			mountcfg.full_options = optarg;
-			mountcfg.flags =
-				erofsmount_parse_flagopts(optarg, mountcfg.flags,
-							  &mountcfg.options);
+			ret = erofsmount_parse_flagopts(optarg, mountcfg.flags,
+							&mountcfg.options);
+			if (ret < 0)
+				return (int)ret;
+			mountcfg.flags = ret;
 			break;
 		case 't':
 			dot = strchr(optarg, '.');
-- 
2.53.0.windows.1


