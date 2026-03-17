Return-Path: <linux-erofs+bounces-2784-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEjFFxkPuWkaoQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2784-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:21:45 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8912A581B
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:21:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZlKx4j1Qz2yjN;
	Tue, 17 Mar 2026 19:21:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773735701;
	cv=none; b=kT7r+f7xOcX/BnTMMsrXeCWFd7Ukj8yI3vbY1IDwVlYKxjvIGA+ALCgrFQZZEC0KPGdm6ALfIk5zMhG02J3R2vFf7F+KapbybauFyendIP6eWWT6b1sPXPKM+OPSSiwUw7eY1zjptVrx79POKxLOWwTP9FC80uN3D81n5mwB2wANXpUn64MKfa9r0EP6X2ycgh5DDUH8zJh2LJcPbp9dRXKtK9ddFe+zjtI+qsILA4kNu0fDbJFclH4izrARSAny/PTYcqeYOCLHBbHQvlhFb+nXTG3dcMo+WjSeV997QKui2O1od7W08zB2pAfkzR2B66HQqKabIW9wvJSTqc4iPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773735701; c=relaxed/relaxed;
	bh=LPVHGKQpOKL7D1yrH0TjZ6aMlGtTfZhGE8uh5gtlT2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWLkwepP8a3QMD0do5mybfiiXpYcLA6QxnsAHaLUM6/ZWChtCJypWto3XgM+KV2QKjBwW+IksmQsJfvbR2EsPMI7mesA3GYsMXE+EUGFlUKHPIEiezODZ4xnrCzeauOsPiIVP5wBJhNfILgtBwbWauPO2DCuki3RoQwjCkyrwk6aNQ9bjYdHflh0AU6TRgkrO4bgTQ9Qf6RjHOq+6g/Ci/nQYfzaukhZVRo/dp/f8QMmS7faddtqQ1ymZeUDMh0od2qgsiWG5jUiXpao9+0wiQeFKVyah18fMijPJK+HqwnuHWI5vWZ8qV8buhOsMxCh7HrApCVwVtwmLt9aGRGahQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Bzvco3Wq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Bzvco3Wq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZlKv6rvmz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 19:21:39 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35a277dcff6so211290a91.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773735697; x=1774340497; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPVHGKQpOKL7D1yrH0TjZ6aMlGtTfZhGE8uh5gtlT2M=;
        b=Bzvco3WqcZlX/YP3sRnhzh+gpkGVYkOtHBGYfap2A63qdMOLIgFEduQHgkYysAQG0s
         Yl4a4j+Fz3BFrsTgdHOJe02ZFlACMch/0SYQeKyUyUtEr616JauLOCFwVek/FEljafbm
         jD3rZH+XHYEUR+YCHvXTbDdXJuvBArDQH+9O29QkNtXocS4ILG9kjVpyAvRxe0ilAGsv
         isdtALE9xeaAnIDMBSREY1aL2Q5PRP+36TD8Dl+P8EQ4L4hVWEWoaLyDmuXlnnrqWoY6
         3Zo6UeudN1eOEFj/FLYK9Ow4g9f1mH3SN6WB8DMl3QvBM0cpPot4cEEcNUVFC1okdKfc
         DUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773735697; x=1774340497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPVHGKQpOKL7D1yrH0TjZ6aMlGtTfZhGE8uh5gtlT2M=;
        b=MhXoHbXIVlaEtLLOrVaPBHTq8Vngz2L6C9Nrua1BNajXdoftNa6nzO8de59fHuTXTc
         7Dq16hyZqMcz4E+fnIY1UtHylgg05k2dNW6z3x/MNX3WBmVPLFWB2ndk7YIAA3aLS51E
         /Jc+I1jRY28rMlZB9KZrUDNC5ohlx5sZkfi5yVcVudWerF0lU5m7q9GK5SJXP5lbOPbJ
         rWgg+i/q+PE2D2f6Wra6Po2mkpo5GHYiev8mGurNGpPQWscWAPHJS27o67J0DZpQPVAV
         I+PcZO3ulyrWDIRu9fJ8U2c+YxPh1kaI73oNZaBlGMn1D+MKQEbsn+O1X4M8dQkqoaJJ
         H7Bw==
X-Gm-Message-State: AOJu0YyVbaEu33Rr5bjHOJLJR9WIKtW/lB1kwGTDJ8Vzs9zj0dS6MD2T
	SWDmbdqZNa1BCxfoLK5wKqbzf4OyNQ/N8pKwxzARy8+4wM8+wAMClsGhwOIzXYDd
X-Gm-Gg: ATEYQzyZnLaXUmlqArZD0f6+MSsTtqFsSGo2Ir8MftN7XcPlaD/KLZKv7daFI4h2WQH
	3hn5Q7mO+jmzPta5Z9s8wWNIg9Kjjtq0NZptsAMQrSwfzKSdMCqktjSaKabKWh8EWM0ChiYxS/e
	IC+jdpbcqyYX7+5VLIdvtMZZ9Q4F+31jNb4K34Ry3bLLubUFKpEnNFePWn+t8AKI3ulyx9rzPvr
	IotrUrODpk769Ys9Ae/ur8h3suM0fw6ywAatudm8YqaFfG5pIilAEnsJ3ObSFniiAZ0O7jTJj+1
	k47B2QudY/sXlE/fqAEk6VX3f0klzvCEWrP0tgRKAaKG40fpA99QV4IaN0WQxxK5fDo/EjVZiaf
	QNWR5ESDWjkpWvEOL6Nw5Bg2hc5VL4DYb+iT9kcpnRCNpys89MVPAc35ANukz1+caliU2sOjqer
	SMsL5Q+rhAgs256o+D/I8ykULbd9P2+MLGs3g1OoGlp2cJ4fVRNph6SbwepW7HQ7CsvrNHoUjUt
	7ecDA7CaMZofUGk14plTUBzVd61SrOMHfkR
X-Received: by 2002:a17:90b:2784:b0:359:fe72:3555 with SMTP id 98e67ed59e1d1-35a21e4edc5mr10982489a91.2.1773735696694;
        Tue, 17 Mar 2026 01:21:36 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada470d2sm2781942a91.7.2026.03.17.01.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 01:21:36 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	singhutkal015@gmail.com
Subject: [PATCH] erofs-utils: lib: validate z_extents against inode size
Date: Tue, 17 Mar 2026 08:21:15 +0000
Message-ID: <20260317082115.34389-1-singhutkal015@gmail.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2784-lists,linux-erofs=lfdr.de];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6E8912A581B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

z_extents is read from on-disk metadata and used as the upper bound
for extent lookups in z_erofs_map_blocks_ext().  A corrupted value
can be arbitrarily large (up to 2^48-1), causing erofs_read_metabuf()
to access offsets far beyond the actual extent table.  The resulting
garbage is parsed as z_erofs_extent records, leading to wrong physical
addresses used for I/O, silent data corruption, or crashes.

Since each extent covers at least one logical cluster, the extent
count cannot exceed DIV_ROUND_UP(i_size, 1 << z_lclusterbits).
Validate z_extents against this bound at inode initialization time
and reject invalid values with -EFSCORRUPTED.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/zmap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/zmap.c b/lib/zmap.c
index 0e7af4e..2f679b7 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -675,8 +675,26 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	vi->z_lclusterbits = sbi->blkszbits + (h->h_clusterbits & 15);
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 	    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
+		u64 max_extents;
+
 		vi->z_extents = le32_to_cpu(h->h_extents_lo) |
 			((u64)le16_to_cpu(h->h_extents_hi) << 32);
+
+		/*
+		 * Each extent covers at least one logical cluster, so
+		 * the extent count must not exceed the number of lclusters.
+		 * Reject bogus values to prevent out-of-bounds metadata
+		 * reads in z_erofs_map_blocks_ext().
+		 */
+		max_extents = DIV_ROUND_UP(vi->i_size,
+					   1ULL << vi->z_lclusterbits);
+		if (vi->z_extents > max_extents) {
+			erofs_err("bogus z_extents %llu (max %llu) for nid %llu",
+				  vi->z_extents | 0ULL, max_extents | 0ULL,
+				  vi->nid | 0ULL);
+			err = -EFSCORRUPTED;
+			goto out_put_metabuf;
+		}
 		goto done;
 	}
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
-- 
2.43.0


