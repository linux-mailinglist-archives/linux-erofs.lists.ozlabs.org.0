Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8799F2F943F
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Jan 2021 18:46:54 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DJj632lq4zDrdH
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 04:46:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610905611;
	bh=MY9y8sEmEw4UMiPwoeI9t05kUrAMiqbFgco3VXtrkK0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aW3RnAr4YNTMY/zeWZy29H/yrhwaH5eDl4rVfJbvIFoHhBJzk8jiuHMw7q7JbaXWL
	 MtpXGQUbRIb2+0+6yiqdrIkVwSkCLIYa3064LhJEUQ6pM/jxTqKlzX1ap9w4Bwpp6I
	 TCoCXv+d/r+UvbgQ/B82/Myuu1PYnk6KzFDoZChyX7u3f6EOk7MNyFWaXoMAv9Bzm7
	 dG7hhIkynB9QGd7rSgsGMr1Oe/GQpJGGU9ZvsuaCtZsk/BNAs9xuO1BVJ3wef0KJNq
	 wSxHqPCJFdvzBPjYi18SQ1L19ErSS3h/Tog17ARwl0gIuUGieO+rqe820WcdhElnf2
	 vnlVF1PfrjNXg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.147; helo=sonic309-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Nv9T7iwu; dkim-atps=neutral
Received: from sonic309-21.consmr.mail.gq1.yahoo.com
 (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DJj5g6RS3zDqty
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 04:46:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610905587; bh=NwmT2T+d7Y53cVpmP6XkSiWf58IlKLbPbbrlYlECeaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Nv9T7iwu/dN6Rp+1x54cmKNLBFgYpupTwhU0E8/IVrSE5UUQ9nc1HPBacprf9oELZdb8Qg9nU3aFX3HeMtHMuYVxeO3ZjmMBeFd0H/tx4SJOYqrJX/yaT+3MMVHo9dnox0mFH+8o+3CB8FJ/XQ8WiXORSJ9We7S/7JoxN9rsI4agXYeV0qm9QkH9JIVl/2Dju+w903PoBy7yivzfkHLDW7ZAQ1WFEMooWQgMY/imbw1GulKlqFEiHJJoAyX7zYjboT4cOVjkIchVjBL3Ij4ufH242m6/3JqAZ/GmxhIjI9DYRvEMD77onBedMZBFsko9GVkFJlplt1ai1wdvY2ve0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610905587; bh=G3KNONlVsEaNZok7NGJdxhD4oEXur7cZHz1DyiYakJm=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=NaGN5nDYQ6flDuxu/w7iBAOae0Ew2vh6LoBbxcuVrME1f+wsf14icfauVwrhYzBkh99u4Dk31fvgGvvTDW6t7S0UTox7dNVcJkoleOsiyM/mybyWQG3AwJCZiYQIVskQmrTa4T6zgeHrBAH1bgSLBzHMYwO2lhmFJR7xyUepTWeMg1HWMzbZyp3Wir8kd5gvlda/2YFhj1fnVcKGedA4f8od2kSmFQY4rE3/accDArf80Wj6HMdkRCCwKcibp++BH8lfiOcCDhldOlwh0BesI/+zxxtfrPBzhZhLgQttsU2MJ0Krph1OM20k4lYp5iOt6B7bkRX0Xis62t7KZXxFEQ==
X-YMail-OSG: aAKjjMIVM1ny3FGmwWcJStyM0dl3X6x3OEB5DcpngIaCmMLm11rY3JUN.U.ppLI
 VOdwAH_KZK0S7w9iTwQoHzookEpmosHzzE_aWBnnnOHYtgcWrPY7jAqzYnGd89tO2ELZarInSOi9
 Polj7acgn6RccDgbvie83BV6UvDvDsLGlPps1leuQ5qWMdh7fJe0QgobHrCTEEawja_nq7X4qbpC
 xKXvsEroAKxmuRTvuRUAM.jHAbeprbFLFDcIwvO7.pf1NgwjZK.aT60qpssAIQcXu1UrjLadxWXN
 DwDHTsjGxEcIAHkeji2K4sY1kv760ueb757iBOKlDyk6vR_qQJnIMjU0ncwQb72PEg6Cr3mZ641G
 G0ukhoeP7XUd0db4T.OFw.qVvgTGp_lZ8xK2_b_jwanHCDbA3D68WVVOCZxeU63pvcapHcStHW5S
 nc8G_.sZEdnDWuZqPTgBFqPeCfmFBD4xOt9TY32_BJKTroUgtDCFcVrdQGxVrExBnL9OcL99gVSn
 I1xdfaZ890RXLxH7q9QNRyr47Stu61WLN8UJgTKRxR5wzKEpHeCH0HJIAcvkSLqeVF4NH4YMzlDY
 R13dl.QViqAJk9qxwqQXsfsMqBrMEefsRFMQmFkG74dcdo27F8kwY.4mP7nDZ0EJvukFbWNey_.e
 JOW2DjsXY8A3_s8Qn6zMi5ETPE5wodI4xDhxFacCZR2FqUYSEcf6.hDETzIgRXIT1P_uIX7BPoca
 ABOciICWYZOZKMnfht494cRRSDJsiSHZCHELlRfHgLT6odQ6GUt6KLUCB5wId7NdCmQVenmECj_8
 hOTFVot3ew0qmuL8Sq57x8Xv9tRzby5cr_fQg7iIH3B8kD0qgQ6E.hsM.cbL9g4liOieNHghGPnr
 lTHGEyuHSi6QhTieTEqxC1TMbc4kpooEd7jqOxHOol6HUwks0xqleG88vsHLltGAAwCQsjOStuww
 Ui5FzFNXWnYQQ6Jx5.Di_VkxZ.0Se4hJAYe3MfZIhZbdntEsLWjc1cJiaPJMaeERbHjXwMij.YUB
 V2SzIXcpwxqS_NIioSq4.dqhWw7xw03YgXLHnUxzP6U9sH_SEbcAtF5VOj84ZTBGTsFDkORmMo2H
 .7k5BSQlbG0IbDMGPM.we9EpVNNdQrjf4c18fjbrHh9eEq3SsYNlEb7fBpaEET3ESUD7Ye5FlItK
 aBqThEfDGH4WQB.O7pn1ZXhnfOLRNJlB_9SXXwtmo6lUMRlfQvABjTZFoqI4te0zBF0jugChoeh1
 kyNr7KwzYdCMFU_zOzy5Jv9EiGrEUowIDLRS24pWFgPor49FWl5KWqpE.6OgVhCTg3V21H4GecjT
 qNEZAQelzImnSzS49tvoE.gVX4epq1gcL2j8PbZnNqHP31XTdvGxwFZQGUUw9XnxrHrlPyMf2N3Q
 59j0A_F.4_zqAJP5oDrzXivLZFeofbqjsjOR__c_BKJr.VZrfmNF7WVb_d_OXix.0.nfesOgRsXi
 8ubyMELPSw3hN0RRpCTUcj1vWrIH4GD.E27yq0nkaRdRHBruhWQXh1prqXoPNbJMWQrxUmt4KHtN
 CjG6HID_ywrKvf9zO5674AnnR7_Q1jV0oGQH0bcV1OAoayaLv46TRF8RIBfcRkHxZFA0Vku8Ayxk
 g_etDCqrR53JXIiLG53621bRG_6GMtu4u61qItbgiCtD09JNdiejwF3VbJuCzvO.fYHBoHNLTEbG
 ol4WPYCwJ_Q5neWAKcup3rupRkDhZcAPbK0_AuJbX3mylkF8BFCiiRQczRal4CkyoOjbv_rp5UGe
 craKrEOiOeA_ykqrzV77sMKvgQSrTZzVdBtMU67D4ffLaclcgo6Jzwp9V3MO4i3qoIZj_TjsDz6i
 U.4Tw4ButtMSC0phbFdvcC.Wywpd3sOihORoCaq2NRdnq8KdsGQg0xKVYl8cIQ0CtDprU1JbE5Gx
 V2AgS399vEw2W7R0UVIYUyjigqq45w0K2SEdvEb3TK_9T1g8v4xVoKArq4ROVuIDdBvjJUbEHZ3_
 FIWVvOJjv1d.d7Uybr7X_awpNEIomISaLifDwM0dT_167Tzdrhaf0aqYyK_k_7njBFk4oIR4Wv4v
 mdM6zdwRMVyamqqfkbgyLcikrcUO0EhXDXUC8.jDZoH0GWA9aF6gG88F_VtAe0n6NntwueS2KARy
 wSTfvSba_ItjJjLvY3tVw3t6OmYsZymeLQHD6tagaGJ.PNUK0LLKgBVlXRuB_LdHdtsilQkWfa09
 auVQoyOHcJ0zDaS2IaZg9D5oGhltE4tNWqrepm9bubfxXfc.zLcy7Rir.ZQyXVHuvhI16yl8CIDW
 7qsAcosRAp_TqEdkxUBilc97U7Qws0C9iK1Ox_63XMBhkZpd4owhsgN23VlMhgwJa8B.00AWxOQU
 4GYD4LRwVHyNS9ME.UBv3MuVrVaugiqOVt.bnMdX6mo51wMPRUpM3BvJmpMCRQn3UuV4czOnQQCY
 c4Ay9kfBo8HOzBBToqprOmYszRSy0Iith_ji_ZiRfTlNpqpo5LlpbTDLwY1FWnTJvWMHAtQGnpn9
 1Kuj4FwDsEy.581ze.nh.7F1FFotw6WggLljU8C8-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 17 Jan 2021 17:46:27 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 84aafc302758bb6691fa0c94699b2296; 
 Sun, 17 Jan 2021 17:46:25 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 2/4] erofs-utils: add liblzma dependency
Date: Mon, 18 Jan 2021 01:46:01 +0800
Message-Id: <20210117174603.17943-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210117174603.17943-1-hsiangkao@aol.com>
References: <20210117174603.17943-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

liblzma [1] has an experimental fixed-sized output LZMA compression
support now. Let's use it to have a try!

TODO:
	complete configure.ac / Makefile.am

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am | 2 +-
 lib/Makefile.am  | 1 +
 mkfs/Makefile.am | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index e7757bc7d047..e471cb810c8c 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -7,4 +7,4 @@ erofsfuse_SOURCES = dir.c main.c
 erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} ${libselinux_LIBS}
-
+erofsfuse_LDADD += -L/tmp/xz-test/lib -llzma
diff --git a/lib/Makefile.am b/lib/Makefile.am
index f21dc35eda51..e048a16d73f2 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -13,3 +13,4 @@ liberofs_la_SOURCES += compressor_lz4hc.c
 endif
 endif
 
+liberofs_la_CFLAGS += -I/tmp/xz-test/include
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 8b8e05132bc0..7993cb76ee23 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -7,4 +7,4 @@ AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${liblz4_LIBS}
-
+mkfs_erofs_LDADD += -L/tmp/xz-test/lib -llzma
-- 
2.24.0

