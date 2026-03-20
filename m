Return-Path: <linux-erofs+bounces-2892-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFG+BhGXvWk1/QIAu9opvQ
	(envelope-from <linux-erofs+bounces-2892-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 19:50:57 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DB2DF971
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 19:50:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcs8W6wFnz2ybQ;
	Sat, 21 Mar 2026 05:50:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774032651;
	cv=none; b=lD8aNnSwzUzjwbK0SSBBxUwbtMh1ZOhT+JdxLlyFrFFOf7LWQFaC2XW4fCMwTr/TOM18K/G9UsK2TTkdW2z83e6q3ocHGUedpIP2hMiK1m0UHm2KwmK6HW+uJx+KQmIPdA3gYSGb0OwNjAXPlGmyWD+RxqKyDCugXXjE6WF0QQBKaOFGqJtq2XNDF9whEOWW8Ijb0sJchu48hpT1f2EPcf6bL6Z0WneV4iuxG/R/ZPWVe1+MHzCGryCV1+OelaygYmuCAzg9IzVkV0aL6lxFVNKCesPNMHAnamvwfojwAQtnkRvHYfZlgONEgyxo76pXTHvVbjSpZ4WxS8D9V5+3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774032651; c=relaxed/relaxed;
	bh=RSegdbSmVxgif2HTbOvrSfYUdC2VfLnEN8R5f2oSQoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L23QRziH7mGJIF6HyV3qyKtpgI5AaFA2xwvskoPJvhlaiANuUxLsVSZLz6EOljx6fsczXsNOa2K2+OvfMYDxb4wnUwqYKBnpTgwV2hHZAym6PsPOd9nYUG8Pa2cr4bcJzuKZxFjBfUCB3HHKmpsXYnpANsBJ/Ou+62YfyI/MeSntOKDVgWBt3KdThqHg8wyUdGnT27vO6FnQyDJ8P3ioQAiM93z7wQvhJ5pU+2DDvlbttEOkVT1/j0aFjTGG+qnj+jk+S/R9BaVNRzSlQYBc62vpxeb9AoRKkzqYqIEY0Bmpv7o21JBG7a719OH3HSOJoWF2TXOTXzjJp2EtiLCXdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iZGeexQ+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iZGeexQ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcs8W0blWz2yWK
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 05:50:50 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so299149b3a.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774032647; x=1774637447; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RSegdbSmVxgif2HTbOvrSfYUdC2VfLnEN8R5f2oSQoc=;
        b=iZGeexQ+8nPFzSa43TnAJmOThtjC0V4/PSA4cMk2yJVCmelDbfNam06J+f15hL9c7l
         ftB7pLrOP5y9TuJ5gIU98UOuvnS7lMaOUX0t1DbXDSBGvzypkXqaEWd4703VPoUMhIAk
         Kh/e8j6XQlmnoWxhXRdsPFXmzQ/f3j7Ep7A1SrAD9WplyDGnv4t1FmFoJDb8q0570k89
         2dxBnUVnFvircOqIBzRUS+JOYqNLAyf+jV+vTK3D7MtlTXazc6RtwonnEX6SEEmn65sv
         aXan3YTG23guniJ/xqBP7SOhuS4RxcM6v+Zysf5HiFZFfFu1/+XBCJXcHaoqL41X7rg5
         /Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774032647; x=1774637447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSegdbSmVxgif2HTbOvrSfYUdC2VfLnEN8R5f2oSQoc=;
        b=SUdQ/uH/0SOTUsR6P7v+0SMQU7FhnhF4dM3cTgTt/LFctk2GM+kaqiKCySVp63cPw+
         P1mtD/hjnLBssGeaJYnfgLPqk9Zfa20DvlkHFlyZblbmCj5rmf+FYJi+XrW9SvBebjtC
         A9xVdaJEVPTqUlKncrghBKQIow154LUQcVeYgOKnqCWHA/4ub74ApNcyWLA2k1NNmj2A
         gcTZfhDYkglFeZkQCpRZE8J2CgDppbJOjLAburvyDLzoXP/NNl6PegMllpNrMPVi6JBR
         D3jlp/RekTb5AGmX+O4C5lTo2tCr3fmgZo+2/Jl7kOgmMbtjr6eDuDG7bG55TiEe0b09
         d1sg==
X-Gm-Message-State: AOJu0YzmUQ/SDVVRay/EoCeYmVE1+HIsrMfjtfEJrRxy0xC6CxtoHmNm
	YuRBMDJbTZaTGaXTTk7xHDHoTgQTOaZRuEBayajJqGglV/LCl0N8UwoR2wUjFA==
X-Gm-Gg: ATEYQzz1aTIGzzRE9s04tBEsVqTvC+HxljoQFJWrqt9h5/0Og699XL62XzvD5jkZ91l
	Us+3eNc02WCNYgzSVFD+bfKRbbvIa/4pbPpMxfq+PBm0dFoVcD5/FaMxirwoWFSb4xlONYSqn50
	yRmNGilh/IqnitHNfF8rulDQJCGwp2upcVtXHw/DgE9e9a0AccKzLV1ve3RdWqdx6K5bm+67cdN
	I7xaqAe8PhVBOQ5lqZmQmW9XwvA3EcWjIBjZXnTZQJGQoDGkjP+XNhmb3Epyph60/pTk85pjVKA
	uu7pGcpQa7Z1H75YCOpQePwpI8Xy9WY7RubpUlsUDS/4CQZJZby1CydJmdyLq2x1lPIh0yh3lZR
	MODqH9bsakxZWK+d4oMpTabbgFeTI3LjBjZqN9IOiqhfa1EZFC61+4aTjk5TzP6jCA+IOkJ1OCg
	86BYunXulT+nxkGwtJNK2g9x0cGe+2TMpJojgRfzI=
X-Received: by 2002:a05:6a00:2d96:b0:829:7b0f:c9de with SMTP id d2e1a72fcca58-82a8c3217aemr3273203b3a.35.1774032646853;
        Fri, 20 Mar 2026 11:50:46 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:8601:e5eb:157f:ba47:25bb:26c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbebb2sm3004487b3a.14.2026.03.20.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:50:46 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	lkarpinski@nvidia.com,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
Date: Sat, 21 Mar 2026 00:20:34 +0530
Message-ID: <20260320185034.1008-1-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2892-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: AA0DB2DF971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_io_xcopy() has a fallback do-while loop for when the
kernel fast-paths (copy_file_range/sendfile) do not handle all
the data.  The loop does:

    ret = erofs_io_read(vin, buf, ret);
    if (ret < 0)
        return ret;
    if (ret > 0) { ... pos += ret; }
    len -= ret;
  } while (len);

When erofs_io_read() returns 0 (EOF -- source exhausted before
all bytes were copied), only the ret < 0 and ret > 0 branches
were handled.  Since ret == 0, `len -= ret` is a no-op and
`while (len)` stays true, causing the loop to spin forever at
100% CPU with no error and no progress.

This can be triggered when building an EROFS image from an input
file that is shorter than expected -- e.g. a truncated source
file, a pipe/FIFO that closes early, or a file being modified
concurrently during mkfs.

Fix it by treating a zero return as an error (-EIO) so the
caller fails cleanly instead of hanging indefinitely.

Also fix the long-standing 'pading' -> 'padding' typo in the
short-read diagnostic message of erofs_dev_read().

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
v2:
 - Use a cleaner if/else if structure instead of nested ifs (Lucas)
 - Return -EIO instead of -ENODATA on premature EOF as it represents an I/O issue (Lucas)
Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 0c5eb2c..cb99dee 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -430,7 +430,7 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 	if (read < 0)
 		return read;
 	if (read < len) {
-		erofs_info("reach EOF of device @ %llu, pading with zeroes",
+		erofs_info("reach EOF of device @ %llu, padding with zeroes",
 			   offset | 0ULL);
 		memset(buf + read, 0, len - read);
 	}
@@ -667,12 +667,13 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 		ret = erofs_io_read(vin, buf, ret);
 		if (ret < 0)
 			return ret;
-		if (ret > 0) {
-			ret = erofs_io_pwrite(vout, buf, pos, ret);
-			if (ret < 0)
-				return ret;
-			pos += ret;
-		}
+		else if (!ret)
+			return -EIO;
+
+		ret = erofs_io_pwrite(vout, buf, pos, ret);
+		if (ret < 0)
+			return ret;
+		pos += ret;
 		len -= ret;
 	} while (len);
 	return 0;
-- 
2.51.0.windows.1


