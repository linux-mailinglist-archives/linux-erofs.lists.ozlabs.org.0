Return-Path: <linux-erofs+bounces-3198-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s/ZwH0C7z2mj0AYAu9opvQ
	(envelope-from <linux-erofs+bounces-3198-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 15:06:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD03944EB
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 15:06:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnJrD4lCpz2ygH;
	Sat, 04 Apr 2026 00:06:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775221564;
	cv=none; b=nS1+hydRqN59BuScdh6OyVnsMad9W+L3N2c8kCqAP99RGkgUsprzc39fOADh1yV1hDBowb4oMnUweVExBRI+ivBBsLBOKDFhADOpSnl+fjHSJLF2sE+RKEctr9W+RPohKQonJyPrzcxAdOy27pICdrqta2mRxvRLvjPUulvYTIvnjDNZ9RjvaC59G1jpC1muVM/1aaq8gBhvCaZX1g9DPdxqVUNPrbvuTT2E1WTsVTp2/ykEvNzZ9ZGDktE6VTzDsbe+L9UfXyUnH/iUI5vF8+E/PlzLzAt0OEgizGkfpa3Uvt6Hf+O8jdnKGSxzH0pzMjYLC50OUQbwsmOa3vc1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775221564; c=relaxed/relaxed;
	bh=Pwo8GVBloRPUd8HZhGGz94SQBS2QASipsKzXbQ34k2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPqIEpnF0bG7u9KMNV2VC88V0mgcfFmMjX0+BF0+iZe3lzjToHagtmbT2FdDsT16iuPbz3AAPHzCw33PSgI6whFOSTfGJIe6qxYe1gu0WVNx1ctpVh0rAmEhPAec460BQonA4k8rYQjuCRW4FQKMhGYh6WXWN8xbaj3jDFCvVZgqyvmkgf4buRNYTAxB62FxUX6FWyijRyofiBPIKnXKUR6gVQo75OMs3ZXO+x8CDp4FGFq/g3bBFEkpUga5cQUKg6lENghqa441T5+GJF71fYYyvI7Nh2u5xZe4CdiER9hprjq9RlVX4/8bJV4WPRzD4/2Qrz/eU5j+a+bIILcVlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F+aluRlO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F+aluRlO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnJrD0DtGz2yWK
	for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 00:06:03 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82ce09b61beso880868b3a.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775221562; x=1775826362; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwo8GVBloRPUd8HZhGGz94SQBS2QASipsKzXbQ34k2s=;
        b=F+aluRlOVTC8tNU/+ZXKp+zXJ/IwGLwDzb8/1k9r9+/uIPPjblksr5iElWa9rYR4Rd
         iSiW6BfPM9AaAIlO5pPw+C4P4r0vudJ3SbL45WTNi3dLY+gtlqQwmcrD8dvp0h6cjeWX
         OxHeZW/jfSjkumvNoYBWCB10QgyX7T6HwuPGgSZVJ1VrXwJnrcptOEeqnJNztUc5zG5Y
         Kbdk5D+6LsgpRh0MnNcSyAC07z5TP1NVDi7oZfIAzYrsOacDeKzC5v5GnbiMUHgWMplO
         yV9mYS/G0mkuBw2q/6+cX5IpnUhkm30hp2+IPvMY1eLayp7Gbm3jvl9LjorqTPZTKQeJ
         L1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775221562; x=1775826362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pwo8GVBloRPUd8HZhGGz94SQBS2QASipsKzXbQ34k2s=;
        b=Z5CHALjD948ttjUdoT5eBftYkk3beCv5I87BhJbnywz12DGX8jA8eRYsJCHWb4107z
         +SUXZnVTGTdMz05wNA1QRwUyjzmM3xInE6/mlJA32bpw2+az2f21EgXe98d9mm3pxmpJ
         +U2XAXlMCYUqhC0p1LPN54nXJmR+F2hS6cw9qIhzyv82BP6ZHqHxmouTcciFwJL3l50G
         p1Mzj1I86reM2SbC4c1jledghejTDUoo7O9ylmvRii/VdQE4131U1dvZLKmRumZkcoE7
         S99c0f7nOfifJkcBLiW1Od/fHvQJuIoWV2u8MrkSlXI8oXu9hKMglqhTxljWIpqt+MI+
         /1yg==
X-Gm-Message-State: AOJu0Yxzkpnfuhp4bQdfUdlekkROG4WKstVF+Cj5CnSb5NYsm0Xx7/Nz
	Scijx7+LGALBQ9TKdn3j7CJeRMo0WuJHspoUT4QSpnFxMIyRHP6YZzVgjQAayw==
X-Gm-Gg: AeBDies8KpAlrg2tE9tpYcyFGDoHuZf0yykEQchGApZyNuT/th/YB7oZYdI9I3fifkH
	dFcgPdxL+UOPKcRb2mzoDt+4I6wZozpXC/Xo6VB0r0Zn3o0p0exE9YiCVM95uVae/v2TKsKF9rg
	nCIqgNYoBGSxkXDBI3Mb4v8SEIbZG60uSCD3u2bDhst8+pF0hX3QWkgOv9aOC9uiss4pBU1bmj2
	WrLiT7EwIcnOi2tNoZTYkI18MxJc4JS5wsxl6fX6YJQPSYE24dCSdydZ1V+BkBc3tNsdTBANuCN
	5mzsfOWHlkzvexrvA7Deoj+zhpdpybxroeDg82HpIQZB/qMtH1tRAyWARTaqlX2fEAxMw3/PPYt
	IPUwhioc/tfH1GaiUCwUaH4vIANCPkDtNXQQPWVEWOkcupX131Kvg5lZLah+lFNnXAh7E30tWUN
	qyMR9dNoez6GOfoIrhi5IYQXlid7XKDvNunUUd/uvBJe86PkWN0lUZjDx7Bg==
X-Received: by 2002:a05:6a00:8008:b0:82a:e3de:27c2 with SMTP id d2e1a72fcca58-82d0dbac754mr2745914b3a.41.1775221561874;
        Fri, 03 Apr 2026 06:06:01 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b5f1dbsm6064258b3a.27.2026.04.03.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:06:01 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH erofs-utils v2 2/2] erofs-utils: handle 48-bit blocks/uniaddr for extra devices
Date: Fri,  3 Apr 2026 21:05:46 +0800
Message-ID: <20260403130546.76579-3-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403130546.76579-1-zhanxusheng@xiaomi.com>
References: <12b129db-0206-44f3-a53c-9eec6fe3fda3@linux.alibaba.com>
 <20260403130546.76579-1-zhanxusheng@xiaomi.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3198-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,xiaomi.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: DFFD03944EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_write_device_table() only writes blocks_lo and uniaddr_lo to
the on-disk device slot, but does not write blocks_hi or uniaddr_hi.
Similarly, erofs_init_devices() only reads the _lo fields for extra
devices.

For extra devices whose blocks or uniaddr exceed 32 bits in a 48-bit
EROFS image, the upper bits are silently lost in both read and write
paths.  This is inconsistent with the primary device handling, which
correctly writes blocks_hi (super.c:231) and reads it (super.c:125).

Also sync the erofs_deviceslot on-disk definition with the kernel:
blocks_hi should be __le16 (not __le32), matching the 48-bit design
where all block address high parts are 16-bit.

A corresponding kernel fix has been applied:
  ("erofs: handle 48-bit blocks/uniaddr for extra devices")

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 include/erofs_fs.h |  4 ++--
 lib/super.c        | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index ff8ac78..5d12049 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -45,9 +45,9 @@ struct erofs_deviceslot {
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
 
diff --git a/lib/super.c b/lib/super.c
index 86d50a1..fd7972c 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -54,6 +54,8 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	if (!sbi->devs)
 		return -ENOMEM;
 	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
+	bool _48bit = erofs_sb_has_48bit(sbi);
+
 	for (i = 0; i < ondisk_extradevs; ++i) {
 		struct erofs_deviceslot dis;
 		int ret;
@@ -65,8 +67,10 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 			return ret;
 		}
 
-		sbi->devs[i].uniaddr = le32_to_cpu(dis.uniaddr_lo);
-		sbi->devs[i].blocks = le32_to_cpu(dis.blocks_lo);
+		sbi->devs[i].blocks = le32_to_cpu(dis.blocks_lo) |
+			(_48bit ? (u64)le16_to_cpu(dis.blocks_hi) << 32 : 0);
+		sbi->devs[i].uniaddr = le32_to_cpu(dis.uniaddr_lo) |
+			(_48bit ? (u64)le16_to_cpu(dis.uniaddr_hi) << 32 : 0);
 		memcpy(sbi->devs[i].tag, dis.tag, sizeof(dis.tag));
 		sbi->total_blocks += sbi->devs[i].blocks;
 		pos += EROFS_DEVT_SLOT_SIZE;
@@ -423,6 +427,8 @@ int erofs_write_device_table(struct erofs_sb_info *sbi)
 		struct erofs_deviceslot dis = {
 			.uniaddr_lo = cpu_to_le32(nblocks),
 			.blocks_lo = cpu_to_le32(sbi->devs[i].blocks),
+			.blocks_hi = cpu_to_le16(sbi->devs[i].blocks >> 32),
+			.uniaddr_hi = cpu_to_le16(nblocks >> 32),
 		};
 
 		memcpy(dis.tag, sbi->devs[i].tag, sizeof(dis.tag));
-- 
2.43.0


