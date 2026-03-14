Return-Path: <linux-erofs+bounces-2688-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9B8JNu3PtWnQ5QAAu9opvQ
	(envelope-from <linux-erofs+bounces-2688-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 22:15:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F728EF6F
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 22:15:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYDSC1nmSz2xb3;
	Sun, 15 Mar 2026 08:06:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773522411;
	cv=none; b=d2B1+azzj1nqNsEM4maduSXr2mkDBsc70zwl1peDIEZgKJRcbxs3vkqrLgPg4QbR6Pe1wJJQhBYXKe0//hEMRQBbSmY5vVT0y8EWSPwWQVcp63hxgZvfcW+vRAsfs5TP4ZFKZ156plbVeT08+v3yT1tIALUKFAs7StFAwaNttlpY+EYauuhfy7XXeW+Tp+Ey73QOxy94MZ+quxhtEdy5ufIuiDj8vBD1BcX1mj/aWBiMnl+ax8UCQ0rAHYj1CMo+5BtYBhpL9DfnseAhcxNWtEGscDTadhbgUgdGtxxYkdti6h1wEiz4Kz0xGaIGnqvmjZO0mY8+oKbfB4Zo/dLWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773522411; c=relaxed/relaxed;
	bh=BWuYkfEXLX9Bejai/eD6AwzJJbgaI0E7lXkE38A4GUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IS+6bZEPKaPR4156bpHofGw5Zzgql17RlkWgbj+M6C03Udp1yygUH2+0h72W5x7K2ha0rQdgKaXwlyeiyz/rYu9Zzw1qO9CPS5v6CMaiUJFXhHgnZTxAs/5R8lkk4QrGmPM98ODmElNtLd8UGlV7WRt2ggkqRQN49fpU49eHS3qFm7wLZlo27uvuY9wqZpvHXL4kUf4jtrYwVXzwiKIf6MiDEJjiyEkzQxWq4onoTHC0rwjPMPj1uiMcrfX4oKparjYCHeh9FsZAZVrCDHA5pO/tduW0/VP7w0l6TC0YBPwPUJf8uRDKOJBgPTxqOSqHFKjd344SS1nW44xid5uWMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RQMiwoQg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RQMiwoQg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYDS91XW3z2xZK
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 08:06:48 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-829b4a26a75so31923b3a.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 14 Mar 2026 14:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773522405; x=1774127205; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWuYkfEXLX9Bejai/eD6AwzJJbgaI0E7lXkE38A4GUk=;
        b=RQMiwoQgBz5btXLCI672PzqUvVZAW4GhabaoJEush4quTnOLqs1kC5xFAjYO4RPC1g
         /CLapAIDSXHfr623QgyHhNMawwefmInGp01FKC9e4K0osQAhT+tLwxkcZXUYxlZbNbdt
         Y49nvW2yY4tgJuNHMfgQVOXYX+1HtcNyTscAwJI0gX9zErvyQl3kJXNVAyt3rPLZ3jB2
         bWvQSBGJ3bdAg2fxA8PoCtiSh5oXowUJfw6j+8t56QGOahkEoEPT5wyeYLbWUlT8Lt9Y
         2M4Q7zYjbfsmN2uuiq0e0KMzk/77sDo9bwTxsLCXiOPTWooGsdCuurTI+xujfTGkDaf3
         QeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773522405; x=1774127205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWuYkfEXLX9Bejai/eD6AwzJJbgaI0E7lXkE38A4GUk=;
        b=jlOrsfuZvtsaHY3F7yGe/JYgNHCZwbGAbK5gHOh3HTMRtDPrLUVjga+vbr571fWoxI
         AmCQcNSlCSzV153qBuxScHq3emUHDnXt4sIStbPR+pweubJ6gqt5vV/C7rdU9JhGpoaR
         zon7pNro46pGHzh2cDmbQ8pQgEH8liRsLflhKBBhnDZUaLbhJY3B9N5F0qqZJpeSlfdh
         N5w8oiHmaCoruDmu9YluZKWEYN616ESrEok8ZFdXDw9yNfZzRtcRe60QjoAedabrA8Tx
         xHhHUMqwZFo4u2AIRuG4s1lkfmgyfr3VLckXxEP0S4wZ6/pdwGALsNs+H58aaXICjx+P
         OgZA==
X-Gm-Message-State: AOJu0YwihVbVDF+LgnCXWZeYc6W8BUrSUpsK45iPF8m4xuXk7MhdFuJT
	1RTUwfbfBw1ke3ggN1AH0fE1DtlSM0SjxCigTzoAnSCJII3A6n4A0lYeTfaOMsai
X-Gm-Gg: ATEYQzwy+nYznWDut5ZJUlf2qhtJDzEXQXWzplVPfR40smU/5zgffH4Vj94DfQQRlXK
	FfRKrOztJ0k5rnzckb2RWF3I5/gC96LU7CqazkAPaLNSJjYNw2kW4o5/N1H0glJdK2a7Yk5tShN
	lRDq+I9pFO4EB0rtmdQpGfx81yzLMwaoauHfDF1P29p39wT9Rq08JNFHSfLVsK1lmltdZq0MHSo
	+ULTzXiP4H1JkC02jhLQzyUCCCaDjjwY8tc0+QG26xsWoSpjtvA+tIImcEhXrZ06G5oAIriWcGT
	uxb+LiZ4fj1rIJRZIRDB2gCvjRTgcslvm6R8TT9WYYYdRvCZrOfF8K9qCm7YCkdA6zfLmulCMgm
	W29f8GQmpXxJdJEUjPlX4v2tZj6egzrQyxEn02DA9c6iyhUBGSqaesirw3tou8FSYwBWDlZ5nCl
	WlzXorH/LCQ592MUNAK5yc15fKWUhQvNvKiYq6+OuzYZIFtxOUbVO5IYdqZbtjitxllGy5a4XtC
	KDhli8Q7caOwZNPVdZlgt7yz549PHGbGa+c1w==
X-Received: by 2002:a05:6a00:a257:b0:827:3fc9:e848 with SMTP id d2e1a72fcca58-82a196ee0e6mr4375563b3a.2.1773522405230;
        Sat, 14 Mar 2026 14:06:45 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0736edd2sm9314197b3a.52.2026.03.14.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 14:06:44 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix error code loss in erofs_io_fallocate()
Date: Sat, 14 Mar 2026 21:06:14 +0000
Message-ID: <20260314210614.8994-1-singhutkal015@gmail.com>
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
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:430 listed in]
	[list.dnswl.org]
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2688-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[linux.alibaba.com,huawei.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.673];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E44F728EF6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The final erofs_io_pwrite() call in erofs_io_fallocate() used a
ternary expression that discarded the real return value. If
erofs_io_pwrite() returned a negative error code such as -ENOSPC,
the caller would receive -EIO instead, losing the original error
information and making failures harder to diagnose.

Fix this by storing the return value in ret and propagating the
real error code directly, consistent with the loop above it.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index 0c5eb2c..12a9beb 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -191,7 +191,10 @@ int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 		len -= ret;
 		offset += ret;
 	}
-	return erofs_io_pwrite(vf, erofs_zeroed, offset, len) == len ? 0 : -EIO;
+	ret = erofs_io_pwrite(vf, erofs_zeroed, offset, len);
+	if (ret != (ssize_t)len)
+		return ret < 0 ? (int)ret : -EIO;
+	return 0;
 }
 
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
-- 
2.43.0


