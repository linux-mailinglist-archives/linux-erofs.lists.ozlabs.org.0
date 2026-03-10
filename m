Return-Path: <linux-erofs+bounces-2586-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBRSMjkIsGkUewIAu9opvQ
	(envelope-from <linux-erofs+bounces-2586-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:02:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F724C20A
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:02:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXXm29Xfz3cDt;
	Tue, 10 Mar 2026 23:01:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.42.244.94
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144088;
	cv=none; b=RhogH0RWIg4OWTWhW6iZIJ4wbX6n1qj+wbX4k2YvutMgpprSHmeN5xwCWS09E5mD/+DSX4wHBAihGB5i7mSB1lyEyHQ5jCqA2ZuXAKHo+OWuFZOWnMXkYYbmMnm54rQEbH/cKrVjaQrN1nu8z2FrVwa585iJDLsIhIhjZ2M7BJi7RKt95feS08cxMBW67Uz8FTBdJIfTbbiURAx+z3l8wouodbjBs39uLVerARcm5yB83KHIUAiFLDSeIhl9EyWZLfITca2UTKnxUgr/p/H8BE/wbDJNl9HtLFO8tJv+fXdsP3Bn+Oq2HiCWdekdcqbi2w/U+9zsz0dfVcM8lPSEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144088; c=relaxed/relaxed;
	bh=uE139u5zoua9TnetiXGtcYlFuz9R+VpXRn5VBlrCpnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4Y1XuruYp6pt3voQ3ZvCF9RKFsoVPRq0GS8EU/Lub6N5e3Sqdgfii0lvmL1PqsC0z3Yru/3Oagdxw8QNiepCUI0T/OfoJgE0gmBCzMVVB6QTrVSlbpsbYgLz6hRRrZVopCn2IJpRnlIWIYJ8Jgk3kvi+/nMRtF9HLyd7t/QUMJUit63bxE/hhtIpPfQfKymnqZ53XcEIhHk+p3Ix6FkB3AiTS7pA7gkspuoGwSR97BkjvsGNSyFNk24X83jvLAEG6gLXYjavoK+TpTZRM4+M0yQ8Hk8z5XzL5mSobS0YYY/bdpkTwWZii/JlFRArvb8fkAxom4WMDEFC2EDmXCE+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=ykq5xCtC; dkim-atps=neutral; spf=pass (client-ip=212.42.244.94; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=ykq5xCtC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=212.42.244.94; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXXj2TyTz3cDy
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:01:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143728; bh=u291MpoQyOoQ8laFPzXzGEOIKYw0K1QgWZAkzpMyO94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ykq5xCtCLnpuisjh7yCkntpXVoj7+lenTonMwnNyj3HEswqyJb7tAewrRcpMAVrss
	 htdRzuKIhEkY2u9z8HmZVLAVG9LXQEK5KzfFb+glv/mPDwZDOJWP8p2pGfwANfwg8Y
	 cyh+Ai5Y49rs9bC9KZyLfdR4nR4N9Gt4Gg3G9z8A=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-e21d-7f0000032729-7f000001ba8e-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:11 +0100
Subject: [PATCH 45/61] thermal: Prefer IS_ERR_OR_NULL over manual NULL
 check
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-45-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=u291MpoQyOoQ8laFPzXzGEOIKYw0K1QgWZAkzpMyO94=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZv85jT8mK77P0DgzyoB3jbjqxnd52qin/43
 73TECCS4NSJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGbwAKCRA0LQZT0ays
 2zstCACwpYJlOocsZ3HBVMWCF0IhNq09wby5LkvAsENXavKVYKWH0lNK553mHyG2L0hqOjwgfmQ
 2R6ChfeUAdB1pLjTViMeeaIXq4AlyCRjEyAsVR/bQ5/US1JrFGhJzXarTPhODhjHiBoPAuzZhOB
 8fipmcjA1HLbJFaREcynXwQWmFtG9ouLXgkvipVtzsg9HQdQPWOUefHLkAAvMOKdk+hmDB4ECbB
 NiykkLaAUziz7cfWSAQQRPcA1Gr6EaK8Vw6tF4Kl2S0zRlJlORdN+u8vB04XH9TW/DB1ISJvpll
 cqhryBZ8g4FfGeREfmgUyiQqqlzXdeOdKWH1FU8uNB4YFH+q
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-7DE07F2F-8C4B41F9/0/0
X-purgate-type: clean
X-purgate-size: 1240
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 0E9F724C20A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2586-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:edubezval@gmail.com,m:j-keerthy@ti.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,kernel.org,intel.com,arm.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[60];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[avm.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,arm.com:email,ti.com:email,intel.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Eduardo Valentin <edubezval@gmail.com>
To: Keerthy <j-keerthy@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0cf0826b805a998abd0d4e2cfa6938de8a46c4f0..9218417e6d923ec370e032f5b91f9a839fd293f4 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -228,7 +228,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 		return 0;
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
-	if (!data || IS_ERR(data))
+	if (IS_ERR_OR_NULL(data))
 		data = ti_thermal_build_data(bgp, id);
 
 	if (!data)

-- 
2.43.0


