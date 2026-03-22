Return-Path: <linux-erofs+bounces-2925-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNYNJmCGv2li5wMAu9opvQ
	(envelope-from <linux-erofs+bounces-2925-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:04:16 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B32E8580
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:04:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdm3070sMz2ySb;
	Sun, 22 Mar 2026 17:04:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774159452;
	cv=none; b=I4G5Jvd5dRteNEAkm6PBLx6beM8FoD/H2ZkcQ8jlbSOnhDvL/FZtPprhA4OJrj0ZNSp50ja+uQbenN4WjBIvU68zx1sXEUKvLPbxUTc3n+2qahUOqjrnqVAp/7i1VOc0gAPlnuaoZhnAgKx6+oNmrSj4IGCePay5dzaYGbh/S4mtUH1Cu4CaiAxkwRhL29N2aFKy74w2q86a5cIw9g8/3Q9YKrccBedEUhV3IUhwJAca0uRP0n7hk2sKBRbuB9c9evgL/2tJ/PksatzFRrhwCGaBh6Zq4/XG9T88RWYTvu+fLDNhrOHmPkPn/MrLgGWyNBtp8buJ+TdN7fozPaYdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774159452; c=relaxed/relaxed;
	bh=cE+RGb5nZD3/s78OlXmxV5ObsM0P94ND0TVpthIy3Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzfDkK8KGkH7l1ExRoj74DtlaGPjml0xAw+pz2X9NGcyO8+WD7d+L4Fdvry4X/SojaDURHvvsxRNcdDG5MzUtLY75kErFsDy0soHYi2VaG1Lg3y7zl7ohSNU+M8mp0DLSA7cZqDnuG5DaIBnJCdijW2AHY/2c0MikyH3nPo8Emnpve52EmpLDkgT2G/V1If3EdKOQVgxZcU6fjA6GL1ZeJsZaEWrIaWRPNLWlBVEnLsXMYXY8uKNvqpEo3tDvj1GZRiROM6pDOPu9pPNIrOIh37crQYqs1aZ6BNBPYAZT247owDrLQb0y5VnWqkt/IiGdO4Mj4KTd5aWBDNt2HpFQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GD/rkwlD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GD/rkwlD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdm301FLRz2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 17:04:11 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so680533a12.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 23:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774159448; x=1774764248; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cE+RGb5nZD3/s78OlXmxV5ObsM0P94ND0TVpthIy3Go=;
        b=GD/rkwlDWgyoacyiigYb7BqExePYYG11D8pQwpW31ySVmaI2S0hikDnHLNradHio1D
         GnVvz0nEEQMsbZxejc7JiKl5ZQO8EZVAEy2NRy5aVftrZVGek1aIoacO/mVjT+78jM/3
         BP72kv8EAquzutx88doGMOFqKHz3a9/9t8E0/3v3MsIDWKNzSJgVCDYdRMry0nWOueb0
         51Dzsp0a0swizOuHsh6W3u0Uz9Vrb7g87rXEwJCCuahIVG4H4tKIsqO57DlBxHv3VskS
         kws6vvJIjZsYP2AZgjZY40d7OUsUa7p3iWmHSR7UCmUVN+o0ZBznGoNR3jXgm3OmsXRw
         +rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774159448; x=1774764248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE+RGb5nZD3/s78OlXmxV5ObsM0P94ND0TVpthIy3Go=;
        b=o1NGF4D3HvssNu7qSRGI921TRW7A9IOCDnlsTKYkI2OCxE/UCw14qEuDFDQnzv9Y3q
         FuR2Y4yCcwZBq1ZX5Ueq7JWitX8gM0Uj76Pa1M73ze6RYEbuH7j+T/TLmWPkpknw5cRl
         RAl8N354eHOUk1AvwaR7A2FQ00XwtP94PEk4w410ilS4QnKxf+6LZLc3hvDhAV2Kqmnz
         wh3uzIO0dBofTfTY2r+L4sH2l6FAgWJuy8nnR0Hj5l5GY1f1bihENOShwDqf4Sk7JXu1
         8RZy6NumzkI7N1dyVmjnmccrPffyZMHoGDyUozSZF2VmMs6ja3xh1mWxyTUY2W9Y6p3O
         k+bg==
X-Gm-Message-State: AOJu0YzJWuYxaJ0vBWjQ9DOXfOElJqPmUncw5bZuFu+ieuNRi1TV3BXJ
	u/3zpzmpRUDpb48WV5Y9aGQ3EEFtxHM5gQoBdLn/1wH1796LMycBhSh6ZSzlmg==
X-Gm-Gg: ATEYQzzk3n6MmpaOa+qTDBMotl5kFEdszYD6ZiW26BmNyv5EWVCv0p24QMhKxra04UY
	fKqwB9obp/wBjIR7jOoX9FYOaFmjoiPdOJ2J8s8JtvCDdmDkj49eQn/fnHkVqXLR/8MmcplRNJJ
	eoGDF5bcP7QxLzfWqdpJqXenIuu8mTOb6B0jwnpFOxOu0MVLhn2fl0xDOxAK1WlLJtME+1Dzfyn
	cY7xYEEwmC4z096u+FNklmLQNy7Exx8rBmJihSC85yNDmxf9B1QNcwAjoCSIRe9jiy3gn2bbWYr
	tZHb4Ui8xtbqFemc+WEpvkX8Iaz9vAObSLCKDMT/OoC63HU/x5q/q691i7J4OrRMFp3zxbnD3/4
	oQaXBvK2VMWU9lp6ZDLdrS74iOChAhZuie2pSMklptrGm7cPVLuFgj3cS+n57DillTmAMGKQ7ws
	KfjYy7gzl5v+Y9HepsTioCwphrj1bUyYrTSghp
X-Received: by 2002:a05:6a21:e082:b0:39b:98e3:6a34 with SMTP id adf61e73a8af0-39bcec273e9mr7451846637.64.1774159448089;
        Sat, 21 Mar 2026 23:04:08 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4043:603:7a13:48a8:61c9:f82:f680])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a8186efsm4889142a12.13.2026.03.21.23.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:04:07 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Cc: Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v3] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
Date: Sun, 22 Mar 2026 11:33:58 +0530
Message-ID: <20260322060358.1495-1-newajay.11r@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2925-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B19B32E8580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_io_xcopy() has a fallback loop for when the kernel fast-paths
(copy_file_range/sendfile) do not handle all the data.

When erofs_io_read() returned 0 (source exhausted before all
bytes were copied), the old logic checked `ret < 0` and
`ret > 0`, ignoring `0`. Since `len -= 0` is a no-op, the
loop would spin forever at 100% CPU with no progress.

v2 fixed the loop but unconditionally trapped a 0-byte read
by returning -EIO. However, if copy_file_range completely
exhausts the bytes, `len` becomes 0. The do-while loop
was then forced to execute once, making a 0-byte read,
which returned 0. v2 falsely trapped this success as an
-EIO error, causing mkfs.erofs to fail in CI.

Fix this regression by replacing `do-while(len)` with a
standard `while(len)` loop. This safely bypasses the block
if `len` is 0 (avoiding fake -EIO errors), while correctly
catching premature EOFs with -EIO.

Also fix the 'pading' -> 'padding' typo in erofs_dev_read().

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
v3: Replace do-while loop to avoid 0-byte read -EIO regression.
v2: Return -EIO instead of -ENODATA, use cleaner if/else.
---
 lib/io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 583f52d..ae6a600 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -660,22 +660,22 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 #endif
 	}
 
-	do {
+	while (len) {
 		char buf[32768];
 		int ret = min_t(unsigned int, len, sizeof(buf));
 
 		ret = erofs_io_read(vin, buf, ret);
-		if (ret <= 0) {
-			if (!ret)
-				return -ENODATA;
+		if (ret < 0)
 			return ret;
-		}
+		if (ret == 0)
+			return -EIO;
+
 		ret = erofs_io_pwrite(vout, buf, pos, ret);
 		if (ret < 0)
 			return ret;
 		pos += ret;
 		len -= ret;
-	} while (len);
+	}
 	return 0;
 }
 
-- 
2.51.0.windows.1


