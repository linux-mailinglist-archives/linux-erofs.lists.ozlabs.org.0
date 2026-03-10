Return-Path: <linux-erofs+bounces-2599-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FbZNU4IsGkUewIAu9opvQ
	(envelope-from <linux-erofs+bounces-2599-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:02:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C12924C29E
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:02:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXXt2G2Xz3cG6;
	Tue, 10 Mar 2026 23:01:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.42.244.94
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144094;
	cv=none; b=O0/nChpPoN74WgkjIdI+txg2vWW8fecatijRRveEmurObFHno64f8HhnJhZx2YXPllMiuodpRsb+CFa4h6qPd0RF1UdOpZGOstvVSrPGFISHipUesP6ZqN97LHYWNzHnbr0Nf45ZZAoSwP8oi9h8pMHgpDVwEjIuCfAUtxQDsohkb7g4atLay/70l6BKzh3koGWzgH2MkhdT/dHBMKsHxhofFenhljZdENR0jnIClAVAWjWJfRbkMaIZt4mj4AGEG6YMTS2iB9EDP+NiwmcN0BXtLRI78owhlIqd5H7IkBYbCFMzrlcfvxsE4lL93+mpJGJjTowxE1LLq+b6cfc8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144094; c=relaxed/relaxed;
	bh=wXP6inC1ot/jec8Yz2mJDj/4GFF4TcysvA1pHXvsm5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNj0s4A/UYA2tWXR6g8saaHGwDslIfA9OTJx1QlGUST4N66Dd1d4hfdKJUEqJCi0gr+dYpDtNixEPf2y1vsVNFe4QlWi4J2/bQrpPYcvMByCJqgpvKpFfzOWuNSeDetorrlSDm+Prl0RhsuPBY0Of8w8mUWyiQUREZJQyEQ0a9HBVYirQHod6b+Fnz9JroD9tYMmj8YBc9IUGUUL4jSm5TnYoxGv/ifSg51jQQM60VSIHR0N484547XJ3qN02raGJI0LkB17Pu4EcmSdX/JX7DjCiOr02FvpF3GbVSmEiAunhLEzP6OxVxtc7P3h/5v4nlXxil8/wLcV+sJQgKpvFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass (client-ip=212.42.244.94; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=212.42.244.94; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXXs4VzVz3cG9
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:01:33 +1100 (AEDT)
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-e21d-7f0000032729-7f000001d976-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:29 +0100
Subject: [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over manual NULL check
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
Message-Id: <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
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
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=FEizU4OZfQ9wQ3wvLqHfhAD95k5qump7I9MIi0BZQKk=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXdroDlhymGqsGkbn1SZv53cw4YuzOIIwtui
 bzXW6sBBQWJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF3QAKCRA0LQZT0ays
 2/1wB/sGTAYBPIahrXD3EXFQ9FcpHqqnw1r9sZLiba/u035gmw5LoaZhwTxHDBskl2iaWkVnIXz
 Iy7Anuu/HF1GBhMkP4ZE553CQedkoQLkwUxzFneqcFtg8dEj/bcSSJoqNhuTbcFTeYPFZ2FuuJR
 mi6wxSHOtk1jHNn9K4y3/ujXKX8zNKkMQCDkESe1H1kZKzWifi4aoEVftzahJtLslDJIa2qDL4i
 OSDOnojL7uRKrSwdvp+XJGBIrrn9XWylS2+dg5zaohBqwfc9ulGK+fMI3nM/n2Gqrv2OPrXEBM6
 17i7pbPmqS6afMN4bPYcsNPNwynB+aJ8jBm/4wPpjycn86fZ
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-7B60AF2F-D466ABAE/0/0
X-purgate-type: clean
X-purgate-size: 1467
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 1C12924C29E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.50 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2599-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[57];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.619];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:mid,avm.de:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,dubeyko.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/ceph/dir.c  | 2 +-
 fs/ceph/snap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 86d7aa594ea99335af3e91a95c0a418fdc1b8a8a..934250748ae4fd4c148fd27bdf91175047c2877d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -889,7 +889,7 @@ int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry)
 {
 	struct dentry *result = ceph_lookup(dir, dentry, 0);
 
-	if (result && !IS_ERR(result)) {
+	if (!IS_ERR_OR_NULL(result)) {
 		/*
 		 * We created the item, then did a lookup, and found
 		 * it was already linked to another inode we already
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 52b4c2684f922bfed39550311e793bfe3622cd26..528ad581be160713f91416115659e2dc6f259576 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -902,7 +902,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 bad:
 	err = -EIO;
 fail:
-	if (realm && !IS_ERR(realm))
+	if (!IS_ERR_OR_NULL(realm))
 		ceph_put_snap_realm(mdsc, realm);
 	if (first_realm)
 		ceph_put_snap_realm(mdsc, first_realm);

-- 
2.43.0


