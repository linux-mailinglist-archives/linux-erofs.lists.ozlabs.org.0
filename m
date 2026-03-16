Return-Path: <linux-erofs+bounces-2765-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODBpCyh2uGn5dgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2765-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:29:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1652A0F53
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:29:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZSrz0C5bz2xlM;
	Tue, 17 Mar 2026 08:29:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773696546;
	cv=none; b=V9gR612y5WbeHrG0Ydt+zCOoG6k0oSmrhobkMv0rvVXYmXf2a0n5y46AzpsDKSE1mf6y9j5AlkBmLH0i+Omfrb5mTSYyAbDJtpkXe2FMOJPw+FKp9+m1P6vz+q3bGw6vv1jRjsE818FxGEyQYw53gdQo7gt6fo1uvWHrRkKlpncRxyjMfczWfswuwHjn+BjIautjVbmNfvysM7tdhdm1ZEMLT0ElYmHvZqd0CVJG5XkF4RMuhgEs3ZuBD2354UWF6GUSTwh4VmRdoaMn3aP27Sg+hKdqxzic3xV2RjznwiPMaRJvjUQtdIvNhw0n1IhZzU5SgTPHR665LdC0qn037Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773696546; c=relaxed/relaxed;
	bh=HX3+3OpwfpC7n/ylR11xAbk4tN/B03kRBsEGxbb4s6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL3TxQjPRlgmCuUwJ7GkReSBqLPFG9TW7FMxb4OEkfS9q9kgy79I7JPyBSa5zXX1qbCWa5Kdhceyn3JshmqL5vFKhiNNZjdIQxH9jai9TzPv/VBdVssq2eIzC2ypIVgoZXXkNJrAebwmvn/hkFHYTNR1uxfCMPP4ldJ6dyt3Tl8tzpOdEbqhWVbADSyBofUZao8zVmnNi6ytE4Xvazkz+nrTeb3CaMdzHjI7E/QvS2THWAgfg+eETUY9zmyH7JBAKnRWGBGaB/04Z49vJE5aKagM9lZUf5LWXhqjl3WyxtPmsko8QLNGW7ifhvJX8WaGK66jxGc9zqnG5pXjF3SOKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a6QPiF5I; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=a6QPiF5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZSry2McZz2xVT
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:29:06 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82980ceb244so399864b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696543; x=1774301343; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX3+3OpwfpC7n/ylR11xAbk4tN/B03kRBsEGxbb4s6Q=;
        b=a6QPiF5IwekfHCTqQqNH3AOYq3NFPINTnoKZn3jQbTSCAj6f8DqivApoghatFlwqLN
         iE3V3/ercXjC6FwhPboJfthSPbrvka4zPiam39Zf1qYe+PK/jue7qrYKJcWFDBWDmOoJ
         akm5U0HDwqU4sIEk/NVijD7THd6FBRrWjINxWborusYzLP3i/uCtnVvmfk3hKtih3wc3
         ZSHjCRyOzU/54lhqmtQzm0MrzyW4dScl7B+V+Fmx55Dc0Ib1ZfAiC+G093kJC6UfAXyu
         9hfW18J92IrRLxa353cgNNi2KgVTsLypxJD8lENL+ipwjOEqPNuzy5/0qvlx0idR+LUj
         5a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696543; x=1774301343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HX3+3OpwfpC7n/ylR11xAbk4tN/B03kRBsEGxbb4s6Q=;
        b=kSsitcljjv/kcPD7iYuB9jJ6teT+GR4q8Ad3AG621wmZjFYixnUFnA45hV/u09/9l7
         mzWWgrc9HjmAfBIZtIOnHlJndVWk1w+s0YXDONBZDvg8Hdvf2SGBywebqSTB58iuHaiE
         Vrjzdu/E2rgRdOqUpuqftZRVyxkVcOZKFaSASYJSUAzU2GbHbK0R3hUx5+kbKoMPMaOJ
         Hf2jI7s3KsKN8/0eypnLvTZQOBkz1Lwgg7nwUFkXEoOt0UIu/AZODSjmYF5UNBpyevE4
         om8cdc9nwohgLgjWqMOUkSDLQDH6elyjMeoh3pTzsuUtvo05BJHls64Rjw2CkXnKbbOR
         1OPw==
X-Gm-Message-State: AOJu0YxYEmdLjwvTiQEO8N/BYB6DZ9GszaMR+U2zLwfwnAFMisaPUw5H
	lcge1fpYbzaxp4Q8lsK00jIWpZmk24xHWP2ASUeK0LRr0nfAj7qGIct7Hh7mhgAk
X-Gm-Gg: ATEYQzwU9CES1SZjo55KVEUBGNQWCskUChfujr/lPHIT66RFG8DFsxUYQzDzmVTn+Wf
	uYROVVwT4lz7nkjrbY1Qxy9/G/zNh/zI5mu6s7WqV+omwVLKB/3vzhg2dy7gQs+31sdI+GMf7b2
	WE3cb7dgAHaaiaPbfIhXLMfWbFY9MXupNOB/fjyTuJ6hnDPCLeliDxPt5qcIxU2Op/um4+IeTK/
	0/jtKmXI58EUa1SiaJolZuo/dqEgTF23nq3/xEZFTHE6vKGxJvy/qt1xHsshX8aCtc0KnrAwct7
	p+PoEhN5bAQh23PEm+BSbc+lQFNNt7G8Za5VgBH9D08nXss35HIDoquTdSjPx5QFiSfVKcwPVfw
	YeZ5VWaYpzjLLfgzVMgFxjacPw3BPfZtLNgys/jf612tbaUUyqDCea/UEFClFlG9A59a8ZPVigz
	tLDEBLtv911no7xIwF7pMs7MufS5LPgHEF7wPMqrE/lzWIYJohfBwtBbpw2rZt6R6EAN3y/ywY5
	EiLc1U4mYCbPidUhhNfOUD9Ug1DQ91JWnGo
X-Received: by 2002:a05:6a00:27a0:b0:823:26e8:aa41 with SMTP id d2e1a72fcca58-82a196bad9dmr8821697b3a.2.1773696543200;
        Mon, 16 Mar 2026 14:29:03 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([14.139.242.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0734039asm17051846b3a.41.2026.03.16.14.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:29:02 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	singhutkal015@gmail.com
Subject: [PATCH v1 1/2] erofs-utils: lib: validate ZSTD frame content size in decompression
Date: Mon, 16 Mar 2026 21:28:46 +0000
Message-ID: <20260316212847.57030-2-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316212847.57030-1-singhutkal015@gmail.com>
References: <20260316212847.57030-1-singhutkal015@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [14.139.242.98 listed in zen.spamhaus.org]
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
	*      [2607:f8b0:4864:20:0:0:0:430 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [3.80 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2765-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.802];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 3D1652A0F53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ZSTD_getFrameContentSize() reads the content size from the ZSTD
frame header in the compressed data. This is untrusted on-disk
metadata, independent from the extent map that provides
rq->decodedlength via z_erofs_map_blocks_iter().

A crafted EROFS image can set the extent map to claim a decoded
length larger than the actual ZSTD frame content size. When this
happens, a buffer of the (smaller) frame content size is allocated
and decompressed into, but the subsequent memcpy copies
rq->decodedlength bytes from it — a potential out-of-bounds read.

Additionally, the ZSTD_getDecompressedSize() legacy fallback
returns 0 for frames without a content size field. This leads to
malloc(0) followed by out-of-bounds access on the returned pointer.

Reject frames where the reported content size is zero or smaller
than the expected decoded length.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/decompress.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/decompress.c b/lib/decompress.c
index 3e7a173..fb81039 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -48,7 +48,14 @@ static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
 #else
 	total = ZSTD_getDecompressedSize(src + inputmargin,
 					 rq->inputsize - inputmargin);
+	if (!total)
+		return -EFSCORRUPTED;
 #endif
+	if (total < rq->decodedlength) {
+		erofs_err("ZSTD frame content size %llu < decoded length %u",
+			  total, rq->decodedlength);
+		return -EFSCORRUPTED;
+	}
 	if (rq->decodedskip || total != rq->decodedlength) {
 		buff = malloc(total);
 		if (!buff)
-- 
2.43.0


