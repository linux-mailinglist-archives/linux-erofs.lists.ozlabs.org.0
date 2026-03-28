Return-Path: <linux-erofs+bounces-3055-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFB1Fjwjx2lATgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3055-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 01:39:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F02334CBB9
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 01:39:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjJYK16Xyz2yfs;
	Sat, 28 Mar 2026 11:39:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774658357;
	cv=none; b=OXQ2vqjdeaK80R9qdTnaG7PI2TxyW/uv1aGOxSaPcEzIjN1+lQIRqdQXuYmxDCYBMkfoY2eAn8KSW8KsTeD1jAvBGMeFIH5sFtg8VbxR/X/oGbLG0eoKZnBhPABpch+JMXoZ0wlN2pzNQm7vxlYowNT0rwZ968bnzcDGK68ZVXpkVhU87ZkOCSQddgBmXDU7W+RL8fqeoNABiJh2ubvPhsjFmDuCPWQ5GEYj3+Cdt5Dd7Rcct6i3uoGjyQrKbzqf58g0sPZOsO1Y6n6apyGgSquSoUXrSfnGu19s8jq8xY2bivLSDQffhahI3eOb7ydUDiSJdBv5NbrQsz0rmAOLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774658357; c=relaxed/relaxed;
	bh=tUdokBkR/qw2HfHhGa3zK9wdyg770Xn2wGdNb8w77ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0HZoO79K0zI8bIW/Hr1fkqjHhba2nC1BNdWMzQMERRvX8fRjk9MZPlWwmsiqRYguIwYeaThQ+iAk9O8YmDH2kHYy7EtQ3msxup8+WyyRaArDBqJqKP/tFkmI7WHhks9BBq7C3FUZRiNIU9M5Gkl5U+HPKWVayIBcddkHtLlIUkP/cmIh8nPLV9Ui30gc0Kig9iVffc3+W7hJDvKjMbC6Y3x2pclUa+wZ/NBXNzKSnNuWiZddLZt04uAnVf3UJlF7nZQg/BsJ6hCxGkR1ftrm1CSSilb+hMMdM79GGZby/Wnin5lz2KlTzY3D70CwM3p10Rd49jOavA5zGUAAGMNQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UduwFsYB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UduwFsYB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjJYH6TmQz2xNT
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 11:39:14 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82735a41920so1005661b3a.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774658351; x=1775263151; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUdokBkR/qw2HfHhGa3zK9wdyg770Xn2wGdNb8w77ZA=;
        b=UduwFsYBqX7ctHKIy26eeaWWZtMLbiGlpU/Lg62Te1M9OSrhREeUeHBlnv5zzc3lQJ
         LXvO2itPXK8iv+KcdD0jMpV+0IkxvkucorpUC4hsd2gGqlNhuRyEYaFkzHptRZ4swPk7
         CvY9FUERS3zZiCK3Wq8dW9vGqaukAKlq1G3dM75NhRS3ff9iIlGK4yTYUtXt8YWrJKPZ
         rFklTDRQ+y3829Ty7R3sHOmccG2kB0uAC+wHIjelPyoo4eDvwXdXMY7bKT9u7ja3nblG
         xAMZq4UFmHZpIDXO/qBkeX+VgNWU2+KsHaskehzm7lyhKRZ3NHFXXHvl4Rz/cG6Vducu
         /7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658351; x=1775263151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUdokBkR/qw2HfHhGa3zK9wdyg770Xn2wGdNb8w77ZA=;
        b=Mhx0izDA1plmNaOoUpONOhgtp6skE9QQ8Ao3Dhqwjsrx8LQI32gvMAB8wiV+EasNBW
         InSO3F1qBoXDN+fpWyAQvGPzhPP8NEF6guNLAZZkqN6Z5JeA47tgAxULQI+INK6+jIqK
         BJYdLnxUlaA4qChAV8gxDwfg2Uy+pPpmWho3ejm5UUd2vXdtd7iIAkArGY7LolID147v
         XurYzEbSWKOSnHCXhP04/yWkAKzgFgd2pBB9HXwYbe1A7PrufLeM037zR1gMqdzXdBfr
         FlB5EjAIqg82s1gddsu0NoQGEGoECHVQqeUjHiI1hQ9hTZojzxIEbxufSwV7/yMEPPUk
         F12Q==
X-Gm-Message-State: AOJu0Yyg3u3qTVmoLT0vkrE8Ox82vOIrWw95f18tYchu8wGOv5hlJmIZ
	VowmZ50/YUJGdh+1WVqeo4fkiBBR16/LnJuz0HGF3QF2eYbpCogM6xLQv3fkaw==
X-Gm-Gg: ATEYQzwl+RSgUPPr+U2fsnhBYcwf0FmuKLkjfJc+DB5VRFSv5gPHO0TeB+p6sD9/VQy
	wI12Ob0ZH+5nuuVOYU1pjsdb2kJz//OSri31igxhSpc+6P9RQGkqSW1unWgiN03+4RmiWIT+v0F
	lXL4+42NoT1czUfE/ElTreRtrdQo5DvwRv4g+TQ3yKRgqOlR7ksP26udNKjdGK4zrtN0J1tRRPw
	R/SmCFldcMnvm71tSGJKY8hxJdW4oLd2HSyKGWLcS0ur9MlAPmmJJo7z4p3jp3NdcoUTDms8C3d
	3yhRwmDPFMMHUnvCe2OogkD6zaUda3RfW8Dxa1ngESJRRpMDmwyDcN8pm7moNpjpRiwfrmqHHL/
	8Rf8Mnp8vbi/Y/rauZggfXNr3FYKX9uVNelPbs6sy25dclHUDfZVfPKt4KUDsmDyChChCD44daJ
	pa6PHBYpqEnp3VzYmvdGug3LNMvsWG21NUZLRb6g==
X-Received: by 2002:a05:6a00:3cc6:b0:82a:6d3d:9ba1 with SMTP id d2e1a72fcca58-82c95e588aemr4537958b3a.24.1774658350970;
        Fri, 27 Mar 2026 17:39:10 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4043:603:7a13:a4ae:bcf3:3904:bd07])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d02fasm425955b3a.34.2026.03.27.17.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:39:10 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v3] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
Date: Sat, 28 Mar 2026 06:09:00 +0530
Message-ID: <20260328003900.1317-1-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <ab_b8heJ7z2hF3y9@debian>
References: <ab_b8heJ7z2hF3y9@debian>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3055-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0F02334CBB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_io_xcopy() has a fallback loop for when the kernel fast paths
(copy_file_range/sendfile) do not handle all the data.

When erofs_io_read() returned 0 (source exhausted before all bytes
were copied), the old logic checked `ret < 0` and `ret > 0`,
ignoring `0`. Since `len -= 0` is a no-op, the loop would spin
forever at 100% CPU with no progress.

v2 fixed the loop but unconditionally trapped a 0-byte read by
returning -EIO. However, if copy_file_range completely exhausts
the bytes, `len` becomes 0. The do-while loop was then forced to
execute once, making a 0-byte read, which returned 0. v2 falsely
trapped this success as an -EIO error, causing mkfs.erofs to fail
in CI.

Fix this regression by replacing `do-while(len)` with a standard
`while(len)` loop. This safely bypasses the block if `len` is 0
(avoiding fake -EIO errors), while correctly catching premature
EOFs with -EIO.

Also fix the 'pading' -> 'padding' typo in erofs_dev_read().

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
v3: Replace do-while loop to avoid 0-byte read -EIO regression.
v2: Return -EIO instead of -ENODATA, use cleaner if/else.
---
 lib/io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 0c5eb2c..ae6a600 100644
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
@@ -660,21 +660,22 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 #endif
 	}
 
-	do {
+	while (len) {
 		char buf[32768];
 		int ret = min_t(unsigned int, len, sizeof(buf));
 
 		ret = erofs_io_read(vin, buf, ret);
 		if (ret < 0)
 			return ret;
-		if (ret > 0) {
-			ret = erofs_io_pwrite(vout, buf, pos, ret);
-			if (ret < 0)
-				return ret;
-			pos += ret;
-		}
+		if (ret == 0)
+			return -EIO;
+
+		ret = erofs_io_pwrite(vout, buf, pos, ret);
+		if (ret < 0)
+			return ret;
+		pos += ret;
 		len -= ret;
-	} while (len);
+	}
 	return 0;
 }
 
-- 
2.51.0.windows.1


