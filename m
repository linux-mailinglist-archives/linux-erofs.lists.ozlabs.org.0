Return-Path: <linux-erofs+bounces-3417-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGYFGHuqCmoK5gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3417-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC5B5667F0
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnCb4Jkjz3dRp;
	Mon, 18 May 2026 15:58:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083883;
	cv=none; b=loFPTlmbtgEkoqYzXz0PhwNjn5otRHZWWtFYKJlnPYA0iJkubbh49ESN0Lol3yxK7MPZAUXpQbQJUk5gx4mwb3WU95oJN+iSV2oDTrQ5Mz4SWbRKJRMB1WFv4elVndC+g0igViHbglHBHXFPuzSmBPAb08MadleNHyxafJUvN03fjI6AOtdtGRUHI10YFgD+cMWNmXzQDghDd+aWoQQXC4mUUAPMCWeDe2AiMdwFRzDvni3dxLOflI0uiopDxuiPwYMNAYyab0Sl3o7fFL9PVGRKnDeXUuIViamJ+osS/Qcdc0B1FPCXB4VlwpPr5su5ah03u3yoW012gJeEBqxsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083883; c=relaxed/relaxed;
	bh=hHE00v2eyN70rDAqdfUddg4aqAHr8N8KYCgruEHMiSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoVg4cF8RA2NBtlWVatEj+dszOEAubeTqk21C/yLHVIiPV4zYnxfr2YGNN3vTL8oA3SNo1YnnASPCRglSH+8k0HeSupE6LRJRQQTTckDIV74ko/YgHgJNSL5cR6QSvC1HAFH+WHzJrG+v7M3AYvCgUrzkY61BHaQW6E6PLVoLsz3sONyjpwvfAaH8Sn+wcv1mvJ5FHTh5QXQPh9f5adznhhmM2Tw5FBH/tsUjsKziCQD7k33478wT0s4G+EhGHni47WmnuOtnmYuf5LTUyz6Tw3PNs/j/POKFKUHEJpRlykGPvGD/sqC643fzDth6y52bsMgECxnxt2as5NOR6hrFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=IHlGMwM4; dkim-atps=neutral; spf=pass (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=IHlGMwM4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnCZ1KJlz3dRs
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 15:58:02 +1000 (AEST)
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de [46.114.109.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 118A541795;
	Mon, 18 May 2026 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779083875;
	bh=hHE00v2eyN70rDAqdfUddg4aqAHr8N8KYCgruEHMiSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=IHlGMwM4tXmBk0al33ptMWbWHvuVShqaFjNV1PeBlfkSxpvxkbdc/jXTnGejqKgZe
	 LNhODKWo8y6DOs6GU899yDuwPgHaz+pvpT4aMiubcbaTt4z7Bj7Crs+DzgLetb2tg2
	 oOXalpaO4U1hl2dTq6egfbvekCJ9KFZV60TaaX9VlxFav+uhcmN3N+Vo4m3qBDUIAb
	 yYoB/6rVXg/h00xjbuKWsVfnPXnb0hVLmGs4d2/CIDvRxKMRWGL240ZpW5mmmRgz14
	 giR+VNtlskzIqOyp1obpY29Dl5k7uQAIC/a4VwiCAw/tEjISOoesiO5XdOANqPvGwl
	 KOv0w0MB5e75hPkX8BbzPeSIoCo9LcrpsuUlscwIRE7oC6oc42nDYcHMOXt/m10GWY
	 PSEaFnoQA15SsSIBcJrgBE6ixcKKZXVLZHC7wHsMBmn0VzDsjwHHBtXuxlOeDHjko0
	 312SDlnfBg2H+2W7gFMFXSZeLBAFCeXIv3uUR1lRANkXPjiNQU8zu3Xt8L8QTKCQUD
	 cSOczoDmAij8MTjJGPUmJ235wcPaL4Xw3gVZVPb/cKUvb6DwnZa/FiXfciLpKbVUk2
	 Xvnoy+ae/kRZ5y46AiHO8A/tpw1QyvhxVDGqzE797SFgxOH3o5VGAJWNWynJBQUTTK
	 E33A9/6tfHnurRs3dn+rzU1o=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
	Huang Jianan <jnhuang95@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Tony Dinh <mibodhi@gmail.com>,
	=?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
	Francois Berder <fberder@outlook.fr>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	Sughosh Ganu <sughosh.ganu@arm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	u-boot@lists.denx.de,
	linux-erofs@lists.ozlabs.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/9] test: Probe RTC early in dm_test_host()
Date: Mon, 18 May 2026 07:57:25 +0200
Message-ID: <20260518055728.178507-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: BCC5B5667F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3417-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:heinrich.schuchardt@canonical.com,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org,canonical.com];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[heinrich.schuchardt@canonical.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

The ext4 driver probes and reads the RTC which allocates memory.

Ensure that the device is already probed and read once in dm_test_hook()
to avoid false positives.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/dm/host.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/dm/host.c b/test/dm/host.c
index f577377da6a..32a9818248a 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <fs.h>
 #include <os.h>
+#include <rtc.h>
 #include <sandbox_host.h>
 #include <asm/test.h>
 #include <dm/device-internal.h>
@@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
 	ulong mem_start;
 	loff_t actwrite;
 
+	/*
+	 * Probing and first read from the RTC allocates memory.
+	 * Do it before the measurement.
+	 */
+	if (CONFIG_IS_ENABLED(DM_RTC)) {
+		struct rtc_time tm;
+
+		uclass_first_device(UCLASS_RTC, &dev);
+		if (dev)
+			dm_rtc_get(dev, &tm);
+	}
+
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_HOST, &dev));
 	ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_PARTITION, &part));
 
-- 
2.53.0


