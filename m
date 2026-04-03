Return-Path: <linux-erofs+bounces-3192-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CujCxpgz2m/vgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3192-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:37:14 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A456391733
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:37:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn8CV4KdTz2yVP;
	Fri, 03 Apr 2026 17:37:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775198230;
	cv=none; b=eXBBH/YHvcQfk0ZfQtc2q8Eb2vAJM89ZfYBZ+6CHB3+Dh/0ze24Sj9a6gVOl+eg18pFg0nFcdxXrOEgpz9CZyTiatsPGAw+70YGGBmW2Qk48Li2KOLpqNrLpwUrvXR3qjno3oGPQ2rFBK8Vn1tcJWL6DQjgETUKEnIliXctnJKU2bJN3b+varED6AFFFXo9VKdON/HpfIFhM5H0adMZ61YjwSo35fPNpSHF1NF8V0YGw05l35uBGIcWplCQ//Mot//ihkn9v07HC4JEAf5bDKhZw9EYxrWpJqptmWvws8IBbvwaRbyEhuM/2E11UEBJ8hG4fWnu3dL4XpxTiOZygRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775198230; c=relaxed/relaxed;
	bh=WznkZC1iLDwREmUmFRaqxDds7AGj7ZhSYjV7CeXw+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYXnf9xLoAiz8ryhh31UmqJLYOzDMSh9LBCbNiCUOxQdE1IrzekyX8sFa6VQdEKMiblHIOcNzRzX5cfA6qIuvTGBuhbKNuuO/l81z+yEIfwh7B7ujhYTh2mSbgjjWUQ/o6pkd9a4xa4qL7h8GVqaghWu4TdAzjDZs6bQWgeeT35qwWcoLwXtC67LH9euyZEIThHHgPMuHQkH/P+Mn2eBulRYYfPkQ6kPlgBMDioHzoZbt623/7ETxdPAftj8xMbwxWE8sdAFah3qxDIaWlGHdWMBVUh8qn9TNfIvAKGPy7kOIrXxY0PPoTRlZLHfg0Hp/EMBAlvx1ThHzGtaDB6CUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmhKmiwq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmhKmiwq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn8CT4yDGz2xm3
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 17:37:08 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82ce49785a0so719302b3a.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775198225; x=1775803025; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WznkZC1iLDwREmUmFRaqxDds7AGj7ZhSYjV7CeXw+YQ=;
        b=pmhKmiwqpBaD/c8UU2aSLwsYWqFJ1ZWFk8hPEAOGbuJ3PPCJ4BPJCayzvphGgFdpcj
         ptoOzGLrclCySC2MbsfaV7dq8bsfEi+pytFguMhPfkxWiFj7iMzpNCEFueM71n1e2wZh
         v6Smyxiv2kgq89cWRkOfvnTi/q8/UZ6QwD5YHiQ+fl9cIHIponl3Z21Cnbzz+I6JI/Y7
         959thqzoPDqVrSmMPTTJMNxexeUgaU6Ug6NvO7S8O4x4JQ2xQFymYEXLmeqW7FpUhMfl
         8xj9x+hwKYFTHV24cj4Tc/0y/9F+kGeEHUfpdxQl5XTamhWV3tMBeY9CfAAhc52pSPMz
         uIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775198225; x=1775803025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WznkZC1iLDwREmUmFRaqxDds7AGj7ZhSYjV7CeXw+YQ=;
        b=q6r4yJei5tVLPWMsDFL6IY+IjgC8zVSHp0o7sfKuuAbZ1Gm58nZmW78AEqaaUUBtIf
         bZaCrnwSmrbEBt0N6ba8G5AsaOTTvrIlfXMez4VyNmcSvlQm2qll1TDgHvKcx2jWmgO7
         TkWe5MH4NmWx67ajMPUF9ZZGoApwVQrky1+VBYzJL+0xduVHyzr5QprP9jOwC8TIX9OO
         /4WZUe0Kp0PrDeLYARvxf30T+ll7wVynWBFIw9WBd6BZWZHlONbBdLJsLlTJmino2ziE
         cgeB9l8oVAIHndqhPyRMPNmKIpBFrzPGkrYSICucsq92IMlaxx43HKZfXNkMqXyr2s/2
         AD7Q==
X-Gm-Message-State: AOJu0YxMncZgTNs1uSK3pbcGY9Mdnu9F6lsA7CZu1vvpSRjmSlw7Yi9s
	KrjEKlghIKuIM8DVjIQ6HNoOA+R1hoTuT7VjLApTq/YYcsc3uc0DIM+N
X-Gm-Gg: AeBDieumMm0KNqHP9nG+XRTetyYckAVgT7cOJbiryiP9k1hq72y0778lfTiHwVR5AAb
	O3HR/f5vKGA90C0fCkBxNdBdBn0l7I79Uyr+r7gW+60DgSJ6fcKfkQS5E4jpuHAIQMtVhOkJYPE
	d6KKnCeo0QmTkyk7kwf7u6b37a6bWtSLSvinu6/zcWxghFnZYN6nNWbSYlf8gy0Oe55SdsmTBGX
	Oq9E9M35bIJgpGVCurI8AT7NNnflkPJwtaNUtu481/mMSfTlmzzQaz3oKugZGfvNwrb7PSUjx9Q
	22FGAqoIWe54J7RPBX8DHccGQX265tc43kSfK8wi1RwPDRI/5fciXuoW7XwyFoRHfeJHkgyK863
	8RLWGhtwUxE0gCncY7R/wUU/Ij4MlwPQ1RV9uYddUPszXsR/UQHNdettZo/Uenp+KI+Rybdn0nF
	KGK1p5Fnvh8/2DwhhUHVmBP1jenTFFpoTk9hfC0VWSQJs4vMg=
X-Received: by 2002:a05:6a00:234a:b0:82a:6167:b1ae with SMTP id d2e1a72fcca58-82d0da8f2b9mr1989714b3a.24.1775198225286;
        Thu, 02 Apr 2026 23:37:05 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b5fb22sm6418466b3a.26.2026.04.02.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 23:37:04 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: handle 48-bit blocks/uniaddr for extra devices
Date: Fri,  3 Apr 2026 14:36:58 +0800
Message-ID: <20260403063658.72140-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f54ce712-9d7b-488b-8dc2-9d5e2455f80c@linux.alibaba.com>
References: <f54ce712-9d7b-488b-8dc2-9d5e2455f80c@linux.alibaba.com>
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,m:hsiangkao@linux.alibaba.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3192-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4A456391733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_init_device() only reads blocks_lo and uniaddr_lo from the
on-disk device slot, ignoring blocks_hi and uniaddr_hi that were
introduced alongside the 48-bit block addressing feature.

For the primary device (dif0), erofs_read_superblock() already handles
this correctly by combining blocks_lo with blocks_hi when 48-bit
layout is enabled.  But the same logic was not applied to extra
devices.

With a 48-bit EROFS image using extra devices whose uniaddr or blocks
exceed 32-bit range, the truncated values cause erofs_map_dev() to
compute wrong physical addresses, leading to silent data corruption.

Fix this by reading blocks_hi and uniaddr_hi in erofs_init_device()
when 48-bit layout is enabled, consistent with the primary device
handling.  Also fix the erofs_deviceslot on-disk definition where
blocks_hi was incorrectly declared as __le32 instead of __le16.

Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/erofs/erofs_fs.h | 4 ++--
 fs/erofs/super.c    | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b80c6bb33a58..7871b16c1d33 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -44,9 +44,9 @@ struct erofs_deviceslot {
 	u8 tag[64];		/* digest(sha256), etc. */
 	__le32 blocks_lo;	/* total blocks count of this device */
 	__le32 uniaddr_lo;	/* unified starting block of this device */
-	__le32 blocks_hi;	/* total blocks count MSB */
+	__le16 blocks_hi;	/* total blocks count MSB */
 	__le16 uniaddr_hi;	/* unified starting block MSB */
-	u8 reserved[50];
+	u8 reserved[52];
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 972a0c82198d..802add6652fd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -129,6 +129,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct file *file;
+	bool _48bit;
 
 	dis = erofs_read_metabuf(buf, sb, *pos, false);
 	if (IS_ERR(dis))
@@ -175,8 +176,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		dif->file = file;
 	}
 
-	dif->blocks = le32_to_cpu(dis->blocks_lo);
-	dif->uniaddr = le32_to_cpu(dis->uniaddr_lo);
+	_48bit = erofs_sb_has_48bit(sbi);
+	dif->blocks = le32_to_cpu(dis->blocks_lo) |
+		(_48bit ? (u64)le16_to_cpu(dis->blocks_hi) << 32 : 0);
+	dif->uniaddr = le32_to_cpu(dis->uniaddr_lo) |
+		(_48bit ? (u64)le16_to_cpu(dis->uniaddr_hi) << 32 : 0);
 	sbi->total_blocks += dif->blocks;
 	*pos += EROFS_DEVT_SLOT_SIZE;
 	return 0;
-- 
2.43.0


