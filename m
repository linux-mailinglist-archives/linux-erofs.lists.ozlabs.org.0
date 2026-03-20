Return-Path: <linux-erofs+bounces-2866-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FYdND2TvGkY0wIAu9opvQ
	(envelope-from <linux-erofs+bounces-2866-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 01:22:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E8C2D4710
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 01:22:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcNYQ1Jt5z2xnj;
	Fri, 20 Mar 2026 11:22:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773966138;
	cv=none; b=XA9bNjYIewSO/ubQ7WTWGZS7IMAnGUpJGQ8OKSiJXOwPeWGXmgBtpVRNkMB3GR+C0XwwjzpfH3go9nJWIuS3BxMOYOIokuYQeg9oi+H8uC+nxlb8kyzOnWfFx8THHZune01pjHRotVV9hJT2zmZ4Ss0uepIK2N8SlL44OsIyZxYs/SDqGAUUrANK3PkJcnb0fB8I+fA+Y3UGyw79PWcxvX60jSqx8xYkA+fX1yLIe/jHZUhuBeMAV/Q3IH2zuwutHj399NXvQqQiLGMCxkIUWglUfRrjUSILg4bCPj8RLzfRJ9zjJxccbTuFwkbj/1xdo57MmfpXgmXuwI8VYdAgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773966138; c=relaxed/relaxed;
	bh=PwEbvfxXxKC0zuRwpeyEUA+6CuHAAqMtPUgGBjAXzZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/2SbiRe2OIbkIuVFurAVbnIoYlARHzFtZ+wCKUER7QGQSG25bCnS33gdwMkQbC+wTsAafDPhi7OfD9UOrerdQZkiF7rgiwlhj6cYDDot6oyHyFhEkxKuhqkoucwpt4XCl15fT1y94M0lPwIG1tVj+epDnQLopcFy1Juz4MVV9dlkkG8P3XNsWGTEFY8/+eC72VaPEwR7ZB+6ThdlJpRumuYS8AeIubctsTlTYGJ9+8pk+dOz++tKheMnSrvPXPcCzChg07INnsM9DC9ChTJArgm3BrqWCSpSN8pIe7TzrLPkyiGnO2n4YQBJ1QwduFlV2YpSvfoZMkQSS6o7wOISQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T3ZLqy15; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T3ZLqy15;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcNYP0R9Jz2xm3
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 11:22:16 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2aecefc7503so9100465ad.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773966133; x=1774570933; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwEbvfxXxKC0zuRwpeyEUA+6CuHAAqMtPUgGBjAXzZA=;
        b=T3ZLqy15G20XCh6Jchkff5T/7GRrzm7oHQ2JB7JGSJow92J7qunLPydmhqFXH7G5IA
         6ghfKXQFXR8yXDRsSjKHyDE0vi4zYeiSLfamIT8K8lyMPOoCpreshPjUq1l0jgToJSNt
         0P1/nv0f6Pd0pOAA5mTUVdu+0vqkLupIu2c3saB4yyTfWuoO2OAXhOlbY/Iken0r3O2B
         Tf1/KTPaNMfElqP/6PNcbflAF5IwlI9asONb+K5iqY/b2U1+dV8YOIlrY8o+3vp6YqyS
         d9Xi3gCOcYap2zl+Jt4xtQo4GOO5DmQqbVrpoL51PWBKEOi8IDEto15OjNIlvzWpNOZs
         MpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966133; x=1774570933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwEbvfxXxKC0zuRwpeyEUA+6CuHAAqMtPUgGBjAXzZA=;
        b=FdZPPwWjke5JwAG1DnArCIo5kICrrEikf1L9HwPJFATj2/HeDNGRTtmisyCpmM2Zgj
         2eQjc3i2h3lEM+8Y85Um+MTqgD84zUvEd06k/95IraAQcFoGZvAxwgdBfsD3eFPCvqG8
         1zoPxb8Dg/88UBpA6Ms6VSF0ZdA1aUcU+LKiRRGpnv0uVgMhFdIyggtHD0RY/s8zyvvn
         mB8wJx3OlhF3chgPmvdKM3/gd5amORUTwSAwG47arA1JFDfVvboTCgFKjGB2TYRgn+82
         Vm/SDkll+yY3Oev5VDeRmQ55PgPpkQ/NWZUjKf+9PB5qrptECenbyObFy76gCow9njFh
         XNcw==
X-Gm-Message-State: AOJu0YzF2FGqVH9xQfKgYVeSlch0yijJVU1NDJ0KLK005cgDOaf62FVV
	5SmknMc3t/HnQfp79TE/u76cVRmnroxBlu6cCnds+SZOI1hJFcM/U0LGlMp0uQ==
X-Gm-Gg: ATEYQzxKevvQAMLPEdh5ExITShi659SWK0FdEUbujL9S7m9DELOqBsV0oZ05voYWFjg
	DMKbIoqBTvtOCAZ0m//ZnTguF9kGBgAJDSK5Q20u1FYih4HJSqoyvtuF10MKhGRZq1iD/Rkja7d
	aaAQh7zhwDhWneGVwwzpXCh8Hab25PYZU89t87x+Lc1EImrb5bLou3ch7UoEnC+eUnhlLhogHer
	hmkicfPeRRQHayF95+81+VZXIXa87jkTE5J0IVGFD5eqmdsdQPyOi6eetNBPoexdRrP2+jwnFCe
	LV6U648Zp17K56b9oVEyCXVXXRHBKAmC2q8VJ8ZQWfbJ78ZmTMbL9bKGvpgCrpFRLPBKlF9WfCV
	W3M7xfl1nbMIRoY+6W/RLj5el03xZkfR/SgQxmMZ8jbDdLdb3cPgw90P4rjI830QqaY/dL/dQyF
	7OxxjewuWApxm2+kxsTlXpFtwbzbQVY4w7sFpA
X-Received: by 2002:a17:902:d48a:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b08277cae4mr8885375ad.26.1773966133210;
        Thu, 19 Mar 2026 17:22:13 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4043:4ccb:27:709d:fe64:b0c1:aed5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083688ca4sm4090485ad.67.2026.03.19.17.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:22:12 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
Date: Fri, 20 Mar 2026 05:50:52 +0530
Message-ID: <20260320002052.238-1-newajay.11r@gmail.com>
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2866-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D3E8C2D4710
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

Fix it by treating a zero return as an error (-ENODATA) so the
caller fails cleanly instead of hanging indefinitely.

Also fix the long-standing 'pading' -> 'padding' typo in the
short-read diagnostic message of erofs_dev_read().

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 0c5eb2c..583f52d 100644
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
@@ -665,14 +665,15 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 		int ret = min_t(unsigned int, len, sizeof(buf));
 
 		ret = erofs_io_read(vin, buf, ret);
-		if (ret < 0)
+		if (ret <= 0) {
+			if (!ret)
+				return -ENODATA;
 			return ret;
-		if (ret > 0) {
-			ret = erofs_io_pwrite(vout, buf, pos, ret);
-			if (ret < 0)
-				return ret;
-			pos += ret;
 		}
+		ret = erofs_io_pwrite(vout, buf, pos, ret);
+		if (ret < 0)
+			return ret;
+		pos += ret;
 		len -= ret;
 	} while (len);
 	return 0;
-- 
2.51.0.windows.1


