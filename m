Return-Path: <linux-erofs+bounces-2614-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBXDLg4JsGlregIAu9opvQ
	(envelope-from <linux-erofs+bounces-2614-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:05:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C624C51D
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:05:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXd71FNYz3cHS;
	Tue, 10 Mar 2026 23:05:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.42.244.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144315;
	cv=none; b=Pbr8wHmF3Y+bHN1sl1aNBRIH9toW09Ls57ATdQ3UNtsubI63ZHeFgb+/QDZMyoJBqXDSCHVhsKTuBLl0oDGj805Ki29NMGO+JkRt0EkZNsehz1xHsU2f76j+ZZflR8Ta7pIJY7vS7Djdpw/tczJu/JI4VC1poexSLTHrkPilu2wAp493M/W93wi8xl1bbyidR/FwD/G7AYcBr1zFlPf0Exz2TKRUOCOyleiX/Fy39lx6pzogZhvTVtNHZpokhrlKbjyzPVR0G5m93HJDv5Nrmr8w9CTK8HYbTQ/KrPxqQA8ZfJ6cAM+WhSPzzUUx+lI8i2L3bIaS/jetyIdBHMZlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144315; c=relaxed/relaxed;
	bh=awwiZWdQD63BruGvltZFRwj8p2Y5WEoFULKdNAbwIBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BA+9GnRg7JLQV+L0nxNKMQ/xDibVchN8kf0XPxJJ1QFacSiNMnZZivBd4K+CrsNOZNK4+WQPUqXuQoehdsp5pEkrgn2/hK6slAS9AcEIW3uOmSJGj6K8opJUHW5gwUQXXWFiH1w+n/CqOmP8t0ytj90b8LJpZG0+3hhPQJx8m5AGnKN7R3OaM6LayzS0zWB7c0YWaHgEbZsbLMDJOA0Fzv3qWnoYhpVgzwyZqsr9lGWhQp7A5fBC8GvPIOKmbyDVtysyDdYKUd2yiJg/tRqy/0IOiKDvJvKsXNzWlAu5YxS7hewnuJ4+t0R95b3R80QtOunkdX9dfy9WE9QDcGQuLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=pkZgS6E2; dkim-atps=neutral; spf=pass (client-ip=212.42.244.120; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=pkZgS6E2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=212.42.244.120; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXd64L73z2xlh
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:05:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143724; bh=U4MQ2UyTEtTm9FfUFN8u0E2v86RR/vLyOkwrg7Rl0HM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pkZgS6E2b6HyMFIjBzS/B+8+S0biV0Szf5QLvjvxmALO/k+UU3HGuHgtEcUK6r0hT
	 l3sidqEaLmVC6CjiI74oRmEKxGfUqB5EqeVLendnLbzsQ2HomXxjkzlaNLXsRLIGkS
	 uT2G4P9Dig0e7DdWmJ/gJ1GOA6l1sZgQVMwHxKoY=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-b734-7f0000032729-7f000001c046-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:51 +0100
Subject: [PATCH 25/61] net/bluetooth: Prefer IS_ERR_OR_NULL over manual
 NULL check
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
Message-Id: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=U4MQ2UyTEtTm9FfUFN8u0E2v86RR/vLyOkwrg7Rl0HM=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYq6Vp4tN82O3UqmYAB2rCpxamSEi8qzxQbQ
 a7J5ECg00uJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGKgAKCRA0LQZT0ays
 2zTjB/4mjCTr3iXgM6OBkpfxhcEN7EQQZ1y9EXzSAaaFnPJ4J6dbscyHQ/vrwihzqSCkid2ehYX
 PXWgLr3enkVF+dbM8V9NRPpLg6F53eMyK7CDWQG9AEEJdJq5IDVkThiVxeIs2iOyPBRVnnYWh+Q
 FhA5NtTEwVLOnsWfWahJLqDe7jVY+yfeXhrX4z5N5WnqSQs4m5vScZRnTkdBPMBPzYgMtNL5igV
 SF/croNsrnotNJXtafaXYhWm05HCgfm5TNLHJLZIRe+0bC9Er8RwnfgRXEDKBgK6ljnqVy3QgCk
 bdr+gnx+ukbOMXU8jf2GxeDozNZ6NjdS7QCYNHlx/c+fJCr+
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-27DC6A3D-212813DF/0/0
X-purgate-type: clean
X-purgate-size: 1524
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: F41C624C51D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2614-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:marcel@holtmann.org,m:johan.hedberg@gmail.com,m:luiz.dentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[57];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[avm.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,holtmann.org:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/bluetooth/mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a7238fd3b03bb54f39af1afee74dc1acd931c324..06d2da67bbe14e17ee478aa939de26526c333d91 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4169,7 +4169,7 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 		mgmt_phy_configuration_changed(hdev, cmd->sk);
 	}
 
-	if (skb && !IS_ERR(skb))
+	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb(skb);
 
 	mgmt_pending_free(cmd);
@@ -5730,7 +5730,7 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, void *data,
 			  MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
 
 remove:
-	if (skb && !IS_ERR(skb))
+	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb(skb);
 
 	mgmt_pending_free(cmd);
@@ -8277,7 +8277,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 				 mgmt_rp, sizeof(*mgmt_rp) + eir_len,
 				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
 done:
-	if (skb && !IS_ERR(skb))
+	if (!IS_ERR_OR_NULL(skb))
 		kfree_skb(skb);
 
 	kfree(mgmt_rp);

-- 
2.43.0


