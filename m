Return-Path: <linux-erofs+bounces-2781-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GWoKdjeuGnDkgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2781-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:55:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64722A3D80
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:55:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfmN5r3Zz2yh4;
	Tue, 17 Mar 2026 15:55:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773723348;
	cv=none; b=YOOPnVIp1WeWZ5Hon0lyqnxeY3gOIrI0EpYXCYa1L6LKhwZd8klkWm3bUjYnA5lIdlfdY+i4vg0ASkfK/Z531DDFDQSPgOu80TmbNfw+qjUxTabiVFiEClRVj1Salniwu0jHdNM9XOHv9movR5BUq93uIn5iRLmAzb0A0ONRJJu8DNuiWn1zb1qvSSlPlN2GlGiyfi4ddFQNVtydKM+FzNQy1pBW4lLWEb6pPHh+sygoV/oZBAzjX5QO+6oVtHVhu6tAILlNLgdo1M6pbUkDDyOfE9f1/iYrz+XkfXQ/8jDeq87ojuU1X1j+B1kPCdrNUHlaS1sPlrF5YAFKBxFYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773723348; c=relaxed/relaxed;
	bh=VStVtsktwzKN2X8r5SzWBGVngBWShJt1PvkrFSc4YrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvaP4F407pSH0uX8dbg5UDumdt8RT0TbEQXB+TEyFRvpRQ7YJAHeXApvsMvF7+WwU0h83FaeHCaUaTyzpm9rUbn84w0xac43bXuQZP3+FrSyyEhi3uKWgZ7TnSN9Tc/GgwCmYueA5jVtOzXnoCahK813cSpFzQo0AH9IoysPnha5Sxf4Oc4IAyNA/mFUzte4h63Q8jYV8I9+G6CXwpsBQD8/691SjEQpOYPcvTARKYrcdsbaXb1NBaDcIF3A9+b07jyES4wHNYWa3ekjNVduZsrW8nH74lG3+hee53zd+yTlvU65EstomKOaS80QaLj2dzW1H5/rc+3aWMV/C6MOaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=juz+Hh7c; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=juz+Hh7c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfmN07zXz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:55:47 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35b982990aeso111168a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773723345; x=1774328145; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VStVtsktwzKN2X8r5SzWBGVngBWShJt1PvkrFSc4YrI=;
        b=juz+Hh7c+LfUdIfVbGNdjU1L2CNZ+irTWpJkP6W1BL2ZYtd2ZHCmjL9av1wJEPGZcG
         D4zEJWfojutUXIv2skB6RrXLecYjIeK0SVRNN6LSxbdTFLIVaj4Xy0LO9yCA3VSezqkT
         EnFhqPWblB3Q7J5kF6VVYqVVrIOkvxYf/3XLV8cREmXlDz2mpKYtpVJA/7OiAPzuAY/9
         4vjjT5bQs0Qk/8LeepZiOvyRFN5t7CFZzChXP7f1b0oWadXwkb93iPSYxz8ivhqxzNwV
         QLhKhBkA5GlRWm8UogwpDwDFVst7ujzsGCc9UoykowBsYTu5N6Jrs/U04P5xnIcfZxKc
         zpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773723345; x=1774328145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VStVtsktwzKN2X8r5SzWBGVngBWShJt1PvkrFSc4YrI=;
        b=Pz+KqQjbv6Xfh/I11vGI7Kb0+EphZSWZ+PoVnzEKrCRZiQ5zPIr/Oyo6hQ1ct7Bga6
         eoPvlmXZGout6VSW8U9KmLAhM32WrJ8E8WheyT0PDJNQ3oVZt6cDMWj1KxByeAnN2FQQ
         6pP6IpDKQU/T3su7EjNiO/qemOEY/XzKWF/btbp0ZdU9zI8vmkrt/QUBDtZGHCFOK6Gk
         FF4wpFI0HEVNLlpqu9ys3UAfZGv4niwLLm0PNr9MlcCXz/2O70Wgijk4ZG5FH+EuZwZK
         IyxrB7kYBxkFLqm1F6t1XwtAuLBX3MGxp3NSRo6HS7VBp7I6KwTcahizwa/W8EABZhu/
         RKEg==
X-Gm-Message-State: AOJu0YyoVTOAp0+Y8BINAx9jZoLuxm1XRPK3hV7imdb1vNzdN/ExL4PA
	plARhaBUV+ZKcRsvVakHDxmgoLoTYIXOTwfYxKa/HJfZXv7nckTErJhA+IMI1rSQ
X-Gm-Gg: ATEYQzw3/sJg1AJPrzABqvrDV49cVlWNsFj7yaraLsjPvFJmM0cRfRJe9pUpns5Yc9g
	iKzTSBLLJKfqKgo4npRtZTIb92ZBxQ5GFzBUyzt/FASN5spQXWeFxGiJ83VH8zZhMcW52QfMGpe
	XnP2I7vm/aclj+uYdfNEp92ieGR2gMQKy1LiYsmzeKKxriDjgvFCV2//6MlnwlDE0VsUG71z62Q
	TuZNFVUlSrt/XjJuMGEQsInO9Vb4tiL0x16pTGPNgEvO4yxCEHgXvknyE3MI6TkJqox3ONs88if
	rFZYx6ZEdhD/NGJUb/wyAlP93Sm6wtCFLzA31WOotbFQQV0T0bItItgZ0Q+uVLodG4vcG5p+BcF
	G3BexOD8NnfLo6JEDW+fMRzHicakY1hctz9RkQZVahR7u0P/Ir0GhvJcXUbL+Hc/WqPCZNWmtRa
	FYqYtix2XlAmN5qBNwS8UkBahlVTiugEWaEbRyxbRu0cYKAZ/5noNrTWm4HPO2mTyb2wJpObsjM
	KxD7CW98E9wA6Zv8JErIk5toe+C5h1ZVX/P2w==
X-Received: by 2002:a17:90a:e710:b0:359:9a60:44ca with SMTP id 98e67ed59e1d1-35a22113a11mr9709095a91.8.1773723345434;
        Mon, 16 Mar 2026 21:55:45 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada43329sm1424602a91.6.2026.03.16.21.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 21:55:45 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	singhutkal015@gmail.com
Subject: [PATCH v2 1/2] erofs-utils: lib: validate ZSTD frame content size in decompression
Date: Tue, 17 Mar 2026 04:55:36 +0000
Message-ID: <20260317045537.9591-2-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317045537.9591-1-singhutkal015@gmail.com>
References: <20260317045537.9591-1-singhutkal015@gmail.com>
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
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
	*      [2607:f8b0:4864:20:0:0:0:102c listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2781-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.817];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D64722A3D80
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
rq->decodedlength bytes from it -- a potential out-of-bounds read.

Additionally, the ZSTD_getDecompressedSize() legacy fallback
returns 0 for frames without a content size field. This leads to
malloc(0) followed by out-of-bounds access on the returned pointer.

Reject frames where the reported content size is zero or smaller
than the expected decoded length.

Reproducer:
  mkdir testdir
  python3 -c "open('testdir/f','wb').write(b'A'*131072)"
  mkfs.erofs -zzstd test.erofs testdir/
  python3 -c "d=bytearray(open('test.erofs','rb').read());\
    p=d.find(b'\x28\xb5\x2f\xfd');d[p+4]=0x20;d[p+5]=0x01;\
    open('test.erofs','wb').write(d)"
  fsck.erofs --extract=out test.erofs
  # Expected: ZSTD frame content size 1 < decoded length 131072

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


