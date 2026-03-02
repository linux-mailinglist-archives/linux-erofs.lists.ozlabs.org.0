Return-Path: <linux-erofs+bounces-2450-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DDbOLKApWl1CgYAu9opvQ
	(envelope-from <linux-erofs+bounces-2450-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:21:06 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B59AA1D8304
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 13:21:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPdM03kGwz2xc8;
	Mon, 02 Mar 2026 23:21:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772454060;
	cv=none; b=Jb2VR0oQrVlCUyFBiRIsgar5hA5DDSdftSgm6XJT6wYl7o+igQwefEEhm+GJ7P6bSeQRiZXZsmVeCgjgcwM6kwWT1LH8x34j0YsemmqlhFH1b6PFE1rRnQx5+wXzumaNmjiEFj1SlXC98D/qGtcLbnYjIkTgSIJdOYg/jG2cdHgvMT8W0Iu8oZenc19suuhCJbY9dS834dEHJDFWHyZ2O67Ok2ACpQ0Pw/u0ACZWQcxmGNNlQ6JRTZyqh7LVRxYfMTTF/kAaFOuhxO7KLt3DWParPczdIETAGibC/WAimIe1DLgKR0A71ikFRVta5aJX1y77/N15Zd3ZODy2ZS2vsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772454060; c=relaxed/relaxed;
	bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFlyvB77XBNyniLy5BJeMFpEOua43cV0Vn5PBkfdvzYP4wtQCnfh8aI89pT3ICqlTSXc/BVh6bCaFEHFNWX+ptd6OqbxsfcCpRBaAdfYEL49ji51md6SGzI5fFMvt4hDUkjHBBAXfugSNRi2+4qgXqD4iNkqy6TMtC+1xIIU7tLdakpFSrQklx+G5+obalSgx4hvDsxVMTs5eA637DIufkFMdFmf8hxeScACvFpqaYNwhUeZsVexyeGQ6cj9QCwbvriOG8MyG/sOu1KHm+Z6BAdwCZXJCu+3kJyW9YeTm9FczPJ90JpaZFJSCQDKKvdC7z2jQF4HM2c5+N+XiKVW1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lhORCY+y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lhORCY+y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=hardikkumarpro0005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPdLy3Pwnz2xGF
	for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 23:20:57 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8274936d2c0so4217661b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 04:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454054; x=1773058854; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
        b=lhORCY+yn6VeDlAGeks4Tiw0aHMbtKE77dq7PtrGgP3tPlq3CHBPp+MslfH6x94N49
         u7kQ9ycvUFLwEt+y6WomYe8It6R+TaOMjMgtaOkaf+9LoNSx08UU0Rdr3SbYLSLILMsK
         mMSufYlCdvOva3kEredt0f+Btv8PWsfEhXKr/vOYXX94Y660R9BTPNXGa0K0iiwBmuX+
         bm09iudfIzF8+40f3GVWhHddzneEKi0AoVf9AkmqkY4nCJtEVVbRMwu5UAdV1k1+8Uox
         wAr73CbwQ2Ip/qIvfjEkKk6qsBpqPFtEfEB0x5VTbmPLSfli827YIKWWFt3d1IbixXCY
         cbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454054; x=1773058854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG16c1sDYe3TyH1iYdzCyMngiyeEqWIPPMfKug2p/8o=;
        b=dbuSk3S9VixmwlnvPQsRCD6VgARppqvBMv8iKOE9XEAW90XQ8wpbZrphq8D5TM8mPP
         eXCjmANcdX2SKCz5sbEbXNnVIMBrwXLTPIZ8KosaN9JrxzeVtLK5OHuWA3CtiUBQEgZ0
         MGDptquZKCuGOSpWEu2iReDdCiLJrwaaUubI24dYpqETaGmG5f0flOKoqmyZ+Dm1Lkb3
         NTfDfdQU9QvZ68Uu7QnduiniRlpPi5Dqo4rO2n4wotqIosmlj8wubVhSUunpPjLE7dJ9
         i5OZclJAQe5TrsDQxNvlgesRsdzK5J1eF6T8+o/xL//FPmYbuxyR/r1WgPe+yzCyppsc
         CQLQ==
X-Gm-Message-State: AOJu0YwHBCivqloqJAyd1UCBFHgmFO09GhU//Rq3HGziRef8w8VdPJ0O
	Gd7RgStGAWzX3p0FV+ruNbWN5EO6SnwkgAr562f5l4rrP/CRytRmBb8TLxq8fMEW
X-Gm-Gg: ATEYQzwqz2/LFFT5CGcF0O6rIDFILSQlHjOdEL9KpWfywh9yv6Pexcalx/kdleXTIBO
	knAEOU+VvW0ZiDIklYo+asPDmQcUwuDUwzrSSOv6XWBoteb+GuC/ve4wAqQjXEzkdu7XeSuv09t
	TVPTizJ2sMAMrzsi7Br+uT4N1O/RYlpUuQmkboN2VNisNU3ysBp1zcp/hDDyapoVwBhlF1vwoNs
	/DuLq5dksszJcm4HPH1BFTHh5PodEZ1hV+CNdyXTrlP0I+BFIngrwCNIFl0tGCWJ42/ndQU8yJp
	8+IsFaDp5ouKQWHbpf0qmukbpf57FFCQes2fncJeAyjLgx72TMJqo/ckDDEpzSYnUmPndJ28NwA
	XDVuSdYHONpbE0Jm8wd5WLmR+CnacGonYKlDihiCvGEkc7H+3DHPDoqjweeL03vU0L8WCZjGBvb
	nHvr/PhuEK5tzXCQ==
X-Received: by 2002:a17:90b:2496:b0:356:3ba2:122c with SMTP id 98e67ed59e1d1-35965c4982emr7731206a91.9.1772454053875;
        Mon, 02 Mar 2026 04:20:53 -0800 (PST)
Received: from vitap ([2a09:bac6:d862:16aa::242:a3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359814e3eb4sm5975497a91.16.2026.03.02.04.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:20:53 -0800 (PST)
From: Hardik <hardikkumarpro0005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Yifan Zhao <yifan.yfzhao@foxmail.com>,
	Robert Rose <robert.rose@mailbox.org>
Subject: [PATCH] erofs-utils: mount: fix flag-clearing bug and missing error check in parse_flagopts
Date: Mon,  2 Mar 2026 17:50:48 +0530
Message-ID: <20260302122048.1792-1-hardikkumarpro0005@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,mailbox.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2450-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hardikkumarpro0005@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mailbox.org:email,foxmail.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B59AA1D8304
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


