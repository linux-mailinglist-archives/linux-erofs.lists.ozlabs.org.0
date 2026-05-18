Return-Path: <linux-erofs+bounces-3412-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGTmDnKqCmpE5gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3412-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953345667D3
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 07:58:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnCX4cbxz3dRJ;
	Mon, 18 May 2026 15:58:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083880;
	cv=none; b=k93FE5p6oTz1kGsikgcK4yANcyA1lmocGBRw3cV22pznehGPh/rXS3iqbdL01RFIgT6uAFxVy+3jDX5RbwBgR71RmyaFlDkei2CaJPzSkCrkCUm/CZFXw5eWsc6MtIw90T2no/60H1KvZ7nUOSMUHfl6iWM2OCnsI0bOSIZJKeoe+6oAgZUY/ORUENASGBQ4kziU4JNfhI93ADwwU7RpHeBUo5qtmCiPFtFBSv2PFzMInB78QbHWZWh2JktibDZsMZ7Lp/rioBg2qAWmf1XgB53CN+gUI4oEXt6VruTMdc/Q5u7RNGXjyT+gWoK0GK1472ZC10MTly2aEUTgu6AuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083880; c=relaxed/relaxed;
	bh=rZ34LCbq2pNFaDxGnKA6p3saaRkrcQKrSdAmHUrGc6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da82uHN3BoiNMDoLPU64R3mcUhhri9RUBDb26tIz4XTvuB3QD7jYKFrHKYuP+7mHqX3KKnRLSbu9Hx0sLg3nmtGWw8PR4IonjLKXL3bAPKgwi4n5+7IFmhy4ECTeU8H/Gxaj3tUbnj5JPQTw1O3krDuKG9NhRtkZ9+rcvBzKXiqmD22O2hmZNUzvGx+J7zSnyRD4aum+DqJOCCbvA41VGzNULsEFJghnp8XgsKVFh6MB84dqc2R65+DdgQfkd7DwQSAF13QL7tUswJzMsaSqquv2cfAFRuEJ45WT0bXoADGiDfx24azCF8r0IdXcSCmn/cY7xZXdVQjeBnbjL7TdXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rS8V2N0c; dkim-atps=neutral; spf=pass (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rS8V2N0c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnCS6BZNz3dRT
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 15:57:56 +1000 (AEST)
Received: from LT03 (dynamic-046-114-109-175.46.114.pool.telefonica.de [46.114.109.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7336F41789;
	Mon, 18 May 2026 05:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779083874;
	bh=rZ34LCbq2pNFaDxGnKA6p3saaRkrcQKrSdAmHUrGc6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=rS8V2N0cQs2JYG9WVBHk9l9T7k9f0rg2/UOOuNDRlVOT48GNlsdyajHWOiX15EgUz
	 2wuK8+UGrTjwSH11lyUPeUB/XMIwMOUR+a6ua8MpWmHIW5VQefIlGVCCtXZIRDiiry
	 3z58xN/zvcpNwFazZzePE5zyJjptmRRlNydpKgvE/FLBLDqtfxjB1MctVXjaIRMB/Q
	 kfKifQkhJxlUGjaA2sRlVLEoCqrayRfOFUBMVbMfOp4zH3KHy1MoBj7W7np7/EKTzw
	 f7HO7+5jiT/pt8z0dFecrUvhHTP46ErbfTVssDeUhgnF0dqRcRrlauOkDrwDmxsf6F
	 h9skGdW69R7NRfhWikbvSKbmiEasB0YGSMhhHDVuvq6dJG45EF6YNr+WzZv93Kgyx+
	 MHBLUSFuaV6ivFL5OETwZDc4rIc4C1arQh6m1gwsNfb7BQUsKrMsNKdQxLUVLPb6av
	 TkGcFNNMjQVaZM8rLQZx4Y6IDBQUcpS+KIrZyv6ENLpYM6sQAfj+ZOdqN9AaWA+wA9
	 u5l+2M/h0I05e1ta9jXFmI5RyzkG80lKH9Gl+JHu0payNeq8HWNWQcBq98jxArNDdy
	 u+8bBOzpv26Qh+jMzK6eWiHNZiunTAnbo/QwAPcI3cidprj4LbjFx5TpokUYpOrkQq
	 dmmlQV51IvkpjU69P72pyV0c=
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
Subject: [PATCH 4/9] fs: ext4: don't read time fields in XPL
Date: Mon, 18 May 2026 07:57:23 +0200
Message-ID: <20260518055728.178507-5-heinrich.schuchardt@canonical.com>
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
X-Rspamd-Queue-Id: 953345667D3
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
	TAGGED_FROM(0.00)[bounces-3412-lists,linux-erofs=lfdr.de];
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

The ext4 readdir implementation populates dent time fields in XML
builds though that information is never used.

Guard the three rtc_to_tm() calls with !IS_ENABLED(CONFIG_XPL_BUILD),
consistent with the FAT driver.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4fs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 3c79a889bc2..abf4a9835bc 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -319,9 +319,11 @@ int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 		dent->type = FILETYPE_UNKNOWN;
 	}
 
-	rtc_to_tm(fdiro.inode.atime, &dent->access_time);
-	rtc_to_tm(fdiro.inode.ctime, &dent->create_time);
-	rtc_to_tm(fdiro.inode.mtime, &dent->change_time);
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		rtc_to_tm(le32_to_cpu(fdiro.inode.atime), &dent->access_time);
+		rtc_to_tm(le32_to_cpu(fdiro.inode.ctime), &dent->create_time);
+		rtc_to_tm(le32_to_cpu(fdiro.inode.mtime), &dent->change_time);
+	}
 
 	dirs->fpos += le16_to_cpu(dirent.direntlen);
 	dent->size = fdiro.inode.size;
-- 
2.53.0


