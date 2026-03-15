Return-Path: <linux-erofs+bounces-2707-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBj3IjTCtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2707-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:29:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A626329107E
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:29:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgZn2GtJz2yZ5;
	Mon, 16 Mar 2026 01:29:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584945;
	cv=none; b=It2DhXdl3+OB1DyoRUqZmD4b/8XjDtC2xsonh8ezmxgv6GO8O5THKpvb73OlScAYmAO/iGHkb6Dr4Je+c5wIS7GAqtDOjx+9eGaqHqUh5lDzo6lK4+NV3e8VK1z+IWkWusQMduaKrze4QEuOvhGv79QWqq4UdNG2DMloUtPopX0QXI5jqAr3XNuf0PPTD3bv5tsFeOTJ/AlBD08390LZR8suwOg+QCDj5BjrX2bNYiMqFljS4YCbbDO9IkLKO+vxiOFVONUyZzux3zePkFKHxgWRsgqnEsbAB0JKKMYC4tjo/qGUbs64oQs6WuOY78PqY3al6zwOnbmbveEnKMctTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584945; c=relaxed/relaxed;
	bh=MbULatYJhD97Ieep1lAgpdysMQgdjNvPTDiwJBW+1tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYmIvLUQuV6nfnL7P85+qQ+4LZ7QfQObJyDFb30IBMpHST5Xkj2YTEJKh+TAUnggXuYj6dpJ6yqghsTLETrTRWoy+QUpmuokt56NZBknH86Wf3GqN49pe/vBI2h2ZCixjWlJaiJvCgEY1jpg42/Y8C3jZRuUvryXvrZ9Wh1SsiHaCflstiq8uzTRFRkUH3usk48qeVrZY8QExJDDPIByvq6RObkt3hZ33bjDKFeK0po+rC+9Mo8NOEp7pua233EqovVNrlKBhoVMAgMuwCmLf6ruY6QJpkKXe192nsem1y8mELc5i/P/+EanO/SaNDeC0B/C3w51kRZXnV509UNlMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RSDqFsiE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RSDqFsiE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgZm3dWSz2yZ3
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:29:04 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35b9581befdso14035a91.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773584942; x=1774189742; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbULatYJhD97Ieep1lAgpdysMQgdjNvPTDiwJBW+1tc=;
        b=RSDqFsiEp1yw+Nf6zn4iJAeuw7/HnrpRVSiIJRopEvIPmy62YnpwFZ4DGHuaxTFUrs
         wyjyT4Pp1c3+RWzPZFYrplc6yVhRb9lKtQ7oDBwFGpoEfZ/eOJwyyyV/n3Y0x+8CSpgx
         LdL01WbMWq9ij23qYg+7LHTvBnEYP/XPkhAHlT3vXuwd9Pk23Tu23PD8BxjKSMj0k2nZ
         bsew0gifkAJ8jngXWaxTA02nU8m236xxnULWYvCBWpXGGhqCZV2JdD/znamF2ofZi1Ry
         3GXMO+0v8NVT2cxSbVbVHGnkwTSUVs0ZhHKBE/Xx/65FQMAoSjaAw6qsxtFTztd9uCdN
         VPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584942; x=1774189742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbULatYJhD97Ieep1lAgpdysMQgdjNvPTDiwJBW+1tc=;
        b=Jjy23AIAl11igpmQ2k+yi/fBVr9hU5LY257YCTylrDr/rAFgXfFcddDpRfZ5nTeMfo
         HtjWUxs4hJ8SaXs6oyfaYkfr6+9umRxLo+JkeuTe21koffzDD2Yzkw3su2Mk8sAjwoiv
         5ejFR7D3Y0Isw+BsrooPbrFGTm6r+9cKYnCInMg+Z5st5icLC7zu0Fe9V2AXs3ZIVivJ
         nZmNlQ7Ek8i1KT7O4X+wa3yA4PxVRGmxUzqgogSht7tKdl3peEO0R96AUaqnt0dQGWX9
         WZV1rxLYerhxyBX3xy+p7OPFl4k0Nnmn5S3EmroDqOCkP4kOvOT1n563Zr7UoNwl06g8
         IY+A==
X-Gm-Message-State: AOJu0YxmZJHP6u+btzBBKULp/k6yf/YZUVxex4S1m8BvY9Z6SuYTb4Zn
	GHhp3bX7xF1d4et8sXVpXTzKJCsOM7hV+FoU3qavmRMGGtlEfKlut2wpjOBvAe0f
X-Gm-Gg: ATEYQzy1OFyiv4+XT07wxnUVgiMzmubBt6FBsudKxLZem5F2BwEf3+o3q3TdvmmPsZf
	2l+EuTBJ4LsFcKvyAikqh5XfKC5V7/u4IABFN+eVgyhXGHDZ9mQzmrc/RkAfizWI7Zd345xufAe
	43EkuxaSOrUvJlOQ8vhDaKZVGDl1Q18qEe94w4biaYyY8Ny+HkkxTCbaYcmBwJmZhm21hB+oS6D
	acZoPdK6bRF9OW4T3hcM8HtAE+X0o/27L8IbRpK+9DgMRPxZkyihXYtnJFQD0VwuEUwSiIQ8ZSQ
	87218qP+jjtRy5dtPVefIRdWFsQqSoLAkr6u2FDO35ILuBMhDg4V5MQKcHiuhxN1qzmimNNjNbD
	FaFKJVaa7Xtv3FCY3otDhJCTegq/enQ5VzLIaAkFRiQcs51f4YQbSPBI/9/bN9++eIZ7UDVgP+b
	qCGw2rpw1GoiZQUDzbIw+a9XeB2AU1miveHRHD9vUOD0+UhfkxHBUevjP+g4bLf5/MM7KlQnpi7
	2ouV/tlcZ6wXaoDcR03PxnyV0uelz3Y9CNl
X-Received: by 2002:a17:90b:2784:b0:359:fe72:3555 with SMTP id 98e67ed59e1d1-35a21e4edc5mr6835064a91.2.1773584942136;
        Sun, 15 Mar 2026 07:29:02 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a17be605asm12558991a91.17.2026.03.15.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:29:01 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: add recursion depth limit to erofs_get_pathname_iter
Date: Sun, 15 Mar 2026 14:28:57 +0000
Message-ID: <20260315142857.7734-1-singhutkal015@gmail.com>
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [112.196.126.3 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:1031 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:singhutkal015@gmail.com,s:lists@lfdr.de];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2707-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A626329107E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_get_pathname_iter() recursively calls erofs_iterate_dir() with
no depth limit.  A crafted EROFS image with deeply nested directories
causes unbounded stack recursion leading to a stack overflow (SIGSEGV).

  erofs_get_pathname()
    erofs_iterate_dir()
      erofs_get_pathname_iter()   <- calls back into iterate_dir
        erofs_iterate_dir()
          erofs_get_pathname_iter()  <- unbounded recursion
            ...

Note that fsck/main.c already protects against directory loops via
fsckcfg.dirstack, but lib/dir.c has no equivalent guard.

Fix by adding a depth counter to erofs_get_pathname_context and
returning -ELOOP when recursion exceeds EROFS_GET_PATHNAME_MAX_DEPTH
(64 levels), consistent with typical filesystem path depth limits.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/dir.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/dir.c b/lib/dir.c
index 98edb8e..6a2c838 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -196,12 +196,15 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 
 #define EROFS_PATHNAME_FOUND 1
 
+#define EROFS_GET_PATHNAME_MAX_DEPTH	64
+
 struct erofs_get_pathname_context {
 	struct erofs_dir_context ctx;
 	erofs_nid_t target_nid;
 	char *buf;
 	size_t size;
 	size_t pos;
+	unsigned int depth;
 };
 
 static int erofs_get_pathname_iter(struct erofs_dir_context *ctx)
@@ -249,7 +252,14 @@ static int erofs_get_pathname_iter(struct erofs_dir_context *ctx)
 				.buf = pathctx->buf,
 				.size = pathctx->size,
 				.pos = pos + len + 1,
+				.depth = pathctx->depth + 1,
 			};
+			if (pathctx->depth >= EROFS_GET_PATHNAME_MAX_DEPTH) {
+				erofs_err("pathname lookup depth exceeds %u, nid %llu",
+					  EROFS_GET_PATHNAME_MAX_DEPTH,
+					  dir.nid | 0ULL);
+				return -ELOOP;
+			}
 			ret = erofs_iterate_dir(&nctx.ctx, false);
 			if (ret == EROFS_PATHNAME_FOUND) {
 				pathctx->buf[pos++] = '/';
-- 
2.43.0


