Return-Path: <linux-erofs+bounces-3708-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nskrE4LlOGo8jwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3708-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 09:34:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0C6AD463
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 09:34:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WdPTGsYU;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3708-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3708-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkKhZ61Bhz2yVZ;
	Mon, 22 Jun 2026 17:34:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782113662;
	cv=none; b=OYN2p7PSSU4D3Yyd4jL0uOAKcHGn7lAeAOc84b1lUqF7GNt52HhY892D5j5sdt+TkvcIMxiAB2w5J5wmw2FoyWd4Vl8DNXxosqUMcl3QWEwjuETzqyUl1t5gokZvoleWrBensugF/9nBrFNQWzT2kxZSHdeYkJR6j5sUMP2aNTnBKrGL4b6lEF+v3S+Cesz1UydyKIg3tOUfNOhU1wx6cENyMqVBmqWypfhD6n9ojv6NPRFhRbVAyiEAOncjRqHjShMRs3MMLQpmpMZ3r+II5KbbMD3w3AkKTaTGBOpOPaBQXwTnc5AY5obyLf0Ooa/Ta/3IbZ2CEX3nRzyIcWDKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782113662; c=relaxed/relaxed;
	bh=xsc6/cL+QBQi9eqFxKobfPmjzS1J21OTu3Lo5X9UYLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkE9dA5nO/uaBpcq6LeEQZfow9LI1tQxd2mUJl1pgs0rtBgZ7mUrUqxAWDRI35WqeIVFEnSca3Z9kf1lQARWaZpnx74su1iw8/0Ofu9J/NO141aJMeuR8SQR3jBI94CTZlOTUK8RbLE75HCkCswvGKJiaV7YRwRCv3wb9YA2hx3LLeoIVmQB2peS8jZeYlGWmUFWLLMYmDdcnVHoMxY/HXkhJdorrPv55eciGW8MXzPyzfkCgmcXBiChaoEAnFvzHKK9GBganIdh97OnwDBPSyNIZjWHquySa9xH0WFe7CyjYEeDzZZuZCLbHtvZuLlDv/5fKM3a4REZgDJuA28bmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WdPTGsYU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkKhY44Gwz2xyh
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 17:34:20 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso1506629a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113658; x=1782718458; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsc6/cL+QBQi9eqFxKobfPmjzS1J21OTu3Lo5X9UYLc=;
        b=WdPTGsYUoz2/0EnDLiwZnmOGHbs3QMTkaeefdLGxKq+fQ0QEFFIkZ+Wcg9hMnGsLaa
         BN634jF8n7kRgpGx31MjGMaK1RXRd01CgKJeU6tUc6BBpQk+aONPLQ8qDNpO4SZ+D1Qs
         AWyI8PoU/sV5rAATtUkLYS1Eg8zAKPHyL2roF9sEKIuWxD6tbbsqWSkqrxl2Sv9qxwIn
         o99nSGtYZ5hHi+YCqIrl+2fFaOsRh6MChv0Fnb+QicnC9V+ZLBfukv4KSio3xG+WiMza
         ZOtojkfsqxmglvyd4fqLux3RxgjZLTsaAIdcjB2scyHroIVcwRBvE5ogYLituSreRXEY
         pARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113658; x=1782718458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsc6/cL+QBQi9eqFxKobfPmjzS1J21OTu3Lo5X9UYLc=;
        b=UsGMM38rHija8lRS+X47f724N7cHbbGtBdTIZI+3BLix0Ixn1rdXu/S1PepJKu5RaQ
         hstz4jklDP42kbut3zjufx3tqQFmJLW4Ige/l++U7/W78GVmCq/bQaIqjRafffQZub0C
         z4C06V0GVvPOI/oRw3j1FCZFbcADUMpfL+qZuOs8d69u+oI13i6gSj7d8mbtiKb4fvcM
         8m1S+Ucj8X1IvgZz2rSEAMwQGDbMdw4bn+40yQ8GSxNvfSOBn6YIV+arPNABlN4SxKTm
         0cFYD53NVCSfZX/Pqj0Y6pzUVCWfk79ELZcCXvv11jtCod1EZ1Zvn5vFV4PB6zagAP7W
         C5CQ==
X-Forwarded-Encrypted: i=1; AFNElJ8r4wO94pFzvdpocT9YNCysqhirtwSp8XO7r2Mvw65na1yDWpm47nR/EEMwIB5KKTnOKwhwVA0iLERGFw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwKzGKXS9rBE1FTeR1AA2xRGFHAQPJHthb+DbXQBmbFdpixzrlx
	TMjaDv7uifup9ZPdRXWwIMEaPfmDY0sHEYuzEVRASdiJou9wvGw9zvhf
X-Gm-Gg: AfdE7ckseMFknP8a76rNHHVpcbCOl+sqPh7ckb2EXW3YFG23GLKSSPwdzukk8OPxHJv
	3wKdpfR3uN9wB3Wbt3MJfyUl8hzPVDCua/JzC/qn3Vr3VHnnfLMPus+AZoiWUBhG4+OKGdpARBW
	hnyjMmiMI/o8muJTNi27nEDVGM1Mt+x8L45en9ZJmeddU4C6WLVpMLN24NZprkhbYAlIqXEOYCP
	F5dEX6HFCO10fysktwHuZZC01NmD7LcgVqFX30Ln8fbBDp1kkOZQ+RGxsx6E4Rbo2hoI9KAsmc1
	8/bBlO8KVwouiahwzhEty76J4b+NNeXjJd7lUBYNozkqgr8cKf/InTZJGkIo1M3Ij16IskW1wHR
	mNvhVFIJXCLj8TO0dHQ8kVJ7MNvOQdroj3DPBwqmD9g4hrvN6BkWc7uiJeyptE2AwJNYJIgBaWB
	S5RhH3sALWT8Oi9zbxZC/zdx8=
X-Received: by 2002:a05:6a00:3c81:b0:842:80c5:c420 with SMTP id d2e1a72fcca58-845625b3e08mr9637827b3a.40.1782113657890;
        Mon, 22 Jun 2026 00:34:17 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e9dab2sm6752777b3a.41.2026.06.22.00.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:34:17 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] erofs: handle 48-bit blocks_hi for compressed inodes
Date: Mon, 22 Jun 2026 15:34:10 +0800
Message-ID: <20260622073410.2934415-1-zhanxusheng@xiaomi.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3708-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,xiaomi.com:mid,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EC0C6AD463

Combine i_nb.blocks_hi with i_u.blocks_lo when computing
inode->i_blocks for compressed inodes, mirroring the startblk_hi
handling for unencoded inodes a few lines above.  Also evaluate
the shift in u64 to avoid truncation.

Fixes: 2e1473d5195f ("erofs: implement 48-bit block addressing for unencoded inodes")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/erofs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a188c570087a..cf2f00e13cae 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -191,8 +191,9 @@ static int erofs_read_inode(struct inode *inode)
 		err = -EFSCORRUPTED;
 		goto err_out;
 	} else {
-		inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
-				(sb->s_blocksize_bits - 9);
+		inode->i_blocks = ((u64)le16_to_cpu(copied.i_nb.blocks_hi) << 32 |
+				   le32_to_cpu(copied.i_u.blocks_lo)) <<
+				  (sb->s_blocksize_bits - 9);
 	}
 
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
-- 
2.43.0


