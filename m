Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C74AC7C0
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Feb 2022 18:40:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JsthC1Sgcz30R0
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 04:40:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1644255611;
	bh=0LbShPEb0f9DECJ7jCqc3dSYz1pLhpD7del2vi9ALF0=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SYjT5ZgjI6/16lQlae1uHaefYQ/updMmou7gXhDRYXL/IgAr6zT+grR0WQvFNeVAU
	 GicIBR6J+U764wok2WkzzSh88Pun5F831FWwjReG2nhcsy+bj2lzMxyyK94GQt+njF
	 uWbHO2K+2M6diTPDuhTMuc7/M5lSLiVQOr82TjqAXfTRTiqYKsM5jo54S23dLhdnfy
	 D4M1ry2lf242VJ0WW35LBXO+iGF2xBlats1RTcu/T+Wce2lkVE23/EvVjxqkmdt/js
	 ePC1fxaarqumI6pIZwtZDoP4aBsE3qidS7o0xxqPs0IKiYl/3l6rljsBA/QMEVTbpA
	 75KIjxvF5Qnrg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com;
 envelope-from=3c1kbygskc0i3lerkoipzmrksskpi.gsqpmry1-ivsjwpmwxw.s3pefw.svk@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=q3SXn57d; dkim-atps=neutral
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jsth80lq6z2xBl
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Feb 2022 04:40:07 +1100 (AEDT)
Received: by mail-yb1-xb49.google.com with SMTP id
 a88-20020a25a1e1000000b00615c588ab22so29863909ybi.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 07 Feb 2022 09:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=0LbShPEb0f9DECJ7jCqc3dSYz1pLhpD7del2vi9ALF0=;
 b=p+RarXXxYo7l42NXqV4LPcSo0b45ZAiuEepsKllJItUFYMTkZSvIeayxg/BYyk8mgC
 eZtdsOeHF/1cZObaRzmzMm5pT11FK9Rpsin0F/5b1DLtfzD3zh/+kbu/OtoTsi/L3BvX
 ibcB09/IO2ZGPlrnPPM6KQ3lB4C16S8SY6H/LKgXgAAQYP2/UKXhFXgV2PrMWs7I6AEu
 QJ8r8xZH3xoR5wqQuc1WNVamqlkiHliktaWVinbO0zG/WXNBOscjw12thQBoVtpxufsD
 eoyZeM6Jw/tLogT9WdRC1+ChKaggN/d/v2PIP326o+QaOaRO49EAaP83C3kv5wjOCLnd
 pAkA==
X-Gm-Message-State: AOAM530UURzVcZGb9s2toZ3FKpEz9WclVh9W7J7g6skNdHhfoVuUYWfK
 sZe5cqx0ovHELuWmsF5vX+iyWOhgzb5zB6dNGOBjmzKM76y34BzsWy0F7Oj7KZMiAPwKxrjk099
 W4lXM8D18uJynJws1t6kzw9OoiOCx+gxGEZGfL+/Mh7E32mhCDZtRdahyKS/45uURKwasDpKr6z
 QDf8mNl+0=
X-Google-Smtp-Source: ABdhPJxcmcCQGN5zotVpUGe89FbyAdKebSaWVd0/YU3XwEKDG87kKraBjiex8E0sRo+/12+aMQbrYPiUpwqFMTwL7Q==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a25:ad18:: with SMTP id
 y24mr836151ybi.420.1644255603105; Mon, 07 Feb 2022 09:40:03 -0800 (PST)
Date: Mon,  7 Feb 2022 09:39:58 -0800
In-Reply-To: <YgB+/+xCCjqT6AQO@B-P7TQMD6M-0146.local>
Message-Id: <20220207173958.3322920-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YgB+/+xCCjqT6AQO@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v2] erofs-utils: lib: Fix 8MB bug on uncompressed extent size
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, uncompressed extent can be at most 8MB before mkfs.erofs
crashes on some error condition. This is due to a minor bug in how
compressed indices are encoded. This patch fixes the issue.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 lib/compress.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 98be7a2..2f7ffa7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -97,7 +97,37 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 		} else if (d0) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 
-			di.di_u.delta[0] = cpu_to_le16(d0);
+			/*
+			 * If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
+			 * will interpret |delta[0]| as size of pcluster, rather
+			 * than distance to last head cluster. Normally this
+			 * isn't a problem, because uncompressed extent size are
+			 * below Z_EROFS_VLE_DI_D0_CBLKCNT * BLOCK_SIZE = 8MB.
+			 * But with large pcluster it's possible to go over this
+			 * number, resulting in corrupted compressed indices.
+			 * To solve this, we replace d0 with a number that's
+			 * smaller and doesn't have the
+			 * Z_EROFS_VLE_DI_D0_CBLKCNT bit set if
+			 * the uncompressed extent size goes above 8MB. This is
+			 * OK because if kernel sees another non-head cluster
+			 * after going back by |delta[0]| blocks, kernel will
+			 * just keep looking back.
+			 * The largest number smaller than d0 that doesn't have
+			 * Z_EROFS_VLE_DI_D0_CBLKCNT bit set is obtained by
+			 * first clearing Z_EROFS_VLE_DI_D0_CBLKCNT bit, then
+			 * set all bits before Z_EROFS_VLE_DI_D0_CBLKCNT to 1.
+			 * Using Z_EROFS_VLE_DI_D0_CBLKCNT-1 would work, but it
+			 * produces suboptimal indices in certain cases. e.g.
+			 * (Z_EROFS_VLE_DI_D0_CBLKCNT<<4)|
+			 * (Z_EROFS_VLE_DI_D0_CBLKCNT)
+			 */
+			if (d0 & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+				di.di_u.delta[0] = cpu_to_le16(
+					(d0 & (~Z_EROFS_VLE_DI_D0_CBLKCNT)) |
+					(Z_EROFS_VLE_DI_D0_CBLKCNT-1));
+			} else {
+				di.di_u.delta[0] = cpu_to_le16(d0);
+			}
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else {
 			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
-- 
2.35.0.263.gb82422642f-goog

