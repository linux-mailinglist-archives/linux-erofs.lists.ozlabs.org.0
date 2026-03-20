Return-Path: <linux-erofs+bounces-2865-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LQPAzaQvGlU0gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2865-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 01:09:26 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229DF2D45DD
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 01:09:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcNGV47FSz2xmX;
	Fri, 20 Mar 2026 11:09:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773965362;
	cv=none; b=SMjjNAESF7Z8GoSwINSt6XOBY6WhsM92k9/4SEWMTPrNGxIb5i3i5sMLtyCRBaIEZuHY3U3eN4TDbfAp0Vdjjag4dACCmHC19swuDSCGTXHvSCzzLU/+aIvjXbw0Ej+ZFhe6Xxg5HyfIzf4EGABT14X9AhiFnMdGYMsB01DUxn2UA7vdrIiD+MPH0LwA/UwIqrU6+Beca8zKqlW29D4Q5UvfR6pBI1jWE6wWB1/iw+PwrU0fvV+Z34TcnJd1dtPSlr/+SAwaVS1JY5m8k/W+Qa6KAEUCCTQCa+Cr/1Cu30VlZD+OkHE318v5j+FZNmLGa7/nno4iMyk+ziZuObuz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773965362; c=relaxed/relaxed;
	bh=HvdXtvLMBSLWQtJNZPy+kqg8EDzFcQURgRPdwvOp3lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky5O1LuXD3Cekc2fTj4T7yWruw11p0fRp0SjVJyqIyk0ISdAScKMZ2phQJo0Z9APQ0qREbrGnliZEOckSYzKoB+7Lncm3YgKKqFZQIooRwBxCVwNaM3g5CwCT6+rDGuK5MZKTINxaWKgh3AaCeVQxzdhUB9/EQv67dXTgCz5LSgazYVtsGWyBaETjXz1v2OWYmMXN6sOOrGUfE5KiIcAd9vf6a5dEQCmybnunUgYKBNE8r6wqQIWXLyngg3+tCSUq+xzNujyR/sQf2Te+fp1prI1nFWnAtAlA+65KQnsguWPRdjLFf+qppCmgU0ejMJD+6GkFB/MKjRpMVsI8SUGEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fz+7tNIx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fz+7tNIx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcNGT53xzz2xN2
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 11:09:21 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c739d32b72cso893597a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773965359; x=1774570159; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvdXtvLMBSLWQtJNZPy+kqg8EDzFcQURgRPdwvOp3lk=;
        b=fz+7tNIxrbAub8r2RYRv7fnpnmfcBNwoQV85GEAe4NAvqkc8LPMNJgBfK9uzQXJ3dv
         /0z14fzqJE4tz3T2Cu0FStfCK4NmkxFrj6bswlIT+0f55VFv8g1pfDQtSwo8OVKol6sI
         k7JrI+/og7A95kGtO+HYgb9ffpXq3hM/eFGWDguE+F2I01s5jhlwb+BuTVWZT50fvhBF
         VMMyutzwucYidYPm/b/d/KZe3VVPldvLrI3lJjqD6DsRGv/H3+JWA0kYk0QSF/J25gVK
         jRwbU1rN3vU+eQICMakakxf7YdRVo5xmT8AQG/6aPUH7PUU+YzrQ/VSpNcRYPZOLbn+f
         bzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773965359; x=1774570159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvdXtvLMBSLWQtJNZPy+kqg8EDzFcQURgRPdwvOp3lk=;
        b=Hw9/7hR2Dcgsd+J+U5oGYjXYpDWFlMcAIfiZv5lJ6UPp1S4rpwaplXGJomvzvmnhuv
         XTE0zP6EBmFCNnyTql4wd3YZW/8fsZp35wEFdpQCNDs0aJPcIPIRcTTNBPHDarl+zPgL
         IrIr2LB0+KZTl4QogxpBAyux5rJvbnCKVwcEOooU9l2iI3CUWIDyk7ZTYYpsLFQNoLWp
         ufOtsvdoRrTcxjon+/i4q1eL8jbmautCzf0aqbMtShNGbcaoOK/63OdD0AEzOH1Z1qof
         Z5c2dr0ZGZF00teC2f0G9BGINkBeF+PD0PaoPL16mG6/7EwBA5zXK8cjyKkLtVCpMWAs
         XxtQ==
X-Gm-Message-State: AOJu0YwBXgcRMhtbCGz3AA/hkqvHiAO0Th3sTGJMpcjDRGcuvmDFZgAB
	F5nrch5TSQ4DjEp3hFC9iehzNtlEvwjNqzRmTM+10AGC46oeYjZil8eSJ1hV9Q==
X-Gm-Gg: ATEYQzwn58RUCfIqlbdSomzHzuPRHBIINGiueQhFgaq0ZOt/QgKO4BNWQO1TQvvTYvG
	+VP7lfFc6JnuL2xx1Dz1DgBvvGiE4l3qBtk15XO3yGwY8BriRr+VCePVHQLvj89Ek8I4csOWQz8
	S9OU//9jUCi98EUTZJVIRW0WocSihcJzTsjJ/poIik4thHljUKfJQ9Luw20HRte81a46tyJOQ7q
	DmB7Zmrq8DM9Iq1W8R/LNLCsrLLOfah01p72bLz+pkqQ/PJ3TswJCyp3F8DfUZg6GNjpi/VtKTm
	82+X0dovi30V7zE1X30fRP3Cup2BCAOo2ptrQXJzTrsBZ67Tjspbsnmoitw64sVzm4W5SKjTD/U
	WreQzbbaqW2gqPIcxuPDX44+eWreRmtoSAGG3Mxdj0OZO5RXAKEPG3nAiiPokRiTU/y8zVVsjyW
	pb4y9QfkxWSEp4SRoIYOwpzcRCa1EM/jTM5xzc0VroOFznyk0=
X-Received: by 2002:a17:903:46c7:b0:2b0:673a:7c75 with SMTP id d9443c01a7336-2b0827d1a00mr9428365ad.44.1773965358686;
        Thu, 19 Mar 2026 17:09:18 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4043:4ccb:27:709d:fe64:b0c1:aed5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08369e41csm3349815ad.74.2026.03.19.17.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:09:18 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>,
	Ajay Rajera <ajayrajera007@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
Date: Fri, 20 Mar 2026 05:38:55 +0530
Message-ID: <20260320000855.1653-1-newajay.11r@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2865-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.965];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 229DF2D45DD
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

Signed-off-by: Ajay Rajera <ajayrajera007@gmail.com>
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


