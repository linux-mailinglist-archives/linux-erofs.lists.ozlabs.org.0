Return-Path: <linux-erofs+bounces-2604-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNY6F/4IsGlregIAu9opvQ
	(envelope-from <linux-erofs+bounces-2604-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:05:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66E24C497
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 13:05:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVXd10n8Vz3cBG;
	Tue, 10 Mar 2026 23:05:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.42.244.120
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773144309;
	cv=none; b=Gp5OKOW5SVO8c1nREcjDfQYOiq3F3PFxsD3VH+EWSpG4UzM7k+8pmpJC9N2PrVN0JtXPYZVWgusHgWIX8o/7ELfYeCVgK/GV4ASaPvT1Qpp8IwRFy5nMrNgClIOVap+CPX2kNlGCGtqMAq0HpuQQyMQXQjeevz0d8//E35lAcZVZ0qf2w7FtnukcFEpc7YKHDTMdnBSY5WdhaX7V+UPvWBzRTxXgaOWPZXTNxL1J4e0eV+GaFInM3LDj9kTB9FWMn9GiGIBKsIS0xSZsb0cbfnNzM67VA8HBhrKM6isv/1fQfONkpL3v7JZqcjT0m4JYPuWxyCKtj8fEi50dlrsPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773144309; c=relaxed/relaxed;
	bh=VeyuMlBSXCUl2HyhMWtK62gNrN2xqJpTn5I2B2Zc2uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZF6QSIMnDwIDFEHhu1e8BWgVtda89DCSWjmXpIgaAbJHr9ikW7IXg55j6Js1sFm0pE2/9dnOuppBeGjgHsol3nlfd9zTHDppWaFVpI2Nq3J7/NyiI8i8Ay/E02je7iE6Brgydo6P4d7lU2Q2itY4kIb27VtAdc4mwSc7ON1mFg50TnGZxSUQYYAeAXMHMnTIESK6BdNmmr75X2vmj0NHhEA7OxMmYOENDZDuT/cdGMO4WJ8K3flEBTfLBpCGg5dN98Scocq63e/4mXAO2WTRza67jrHVU0YiNl3ON92EBLOeAHQho0NkzL/uiVN/eYPoLpi13Ek384uroeFkUfubg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=helEnKZU; dkim-atps=neutral; spf=pass (client-ip=212.42.244.120; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org) smtp.mailfrom=avm.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.a=rsa-sha256 header.s=mail header.b=helEnKZU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=avm.de (client-ip=212.42.244.120; helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=lists.ozlabs.org)
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVXd02k9Cz3cH0
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 23:05:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143725; bh=xBKhBreRFiEpPz9/49OtWlCzYkq81mZihzEqekyK7xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=helEnKZUDYmuyC7r9itC+dVARlXrRlYpZWzDAaAXEYc5wN1FHoKQsdSjCaomchjhv
	 +41zqDKlH044FWtyvi2VX9TAdQF1rs14U237EegHWJogLxynx4m+2shwi9NDMEzjxe
	 k3vCUFrBTw+1/DCUt/wn8qmUGFq+b5Q0TC9ytTvc=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-b734-7f0000032729-7f000001c024-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:48 +0100
Subject: [PATCH 22/61] md: Prefer IS_ERR_OR_NULL over manual NULL check
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
Message-Id: <20260310-b4-is_err_or_null-v1-22-bd63b656022d@avm.de>
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
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=xBKhBreRFiEpPz9/49OtWlCzYkq81mZihzEqekyK7xA=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYgLcFKxegL/bQqhgTo4RNQJgrnmxL3YCzsA
 NwbsOtNPYeJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGIAAKCRA0LQZT0ays
 21bACACtmD+JNOZZE2WtYGgZs+OKFUvGXg8BvTcg2nAeuTAfDV15mPSXGDJtr1bOhVuDnL/Nw9l
 YuHe1nCI3Kb5gMl9oJ6QTc/nxqpUehwIiPaszmCzsqUT9Av4+JV9tbiRExsTnWgWp8/ohC7O/t7
 0F2HI97L08/EOhP6er3J/caSpZnOpbWXT+xXd1cfFQmhFO8426W+HbSPnqaYqXoPZvzXs04m+U7
 Y+HhZZm9gUaVM39bOf2O7FpXKP5lXlaxHXla0Syc5xOdqOCZGHEwLXH/1MeFU5JbVnp/DFE01i8
 2gpgUDB/Kr+8ov9qYVC2ZPrR+l2cjmrUojAxw0U8eiSwxKRA
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-71DC2A3D-384367F1/0/0
X-purgate-type: clean
X-purgate-size: 1997
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: AD66E24C497
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
	TAGGED_FROM(0.00)[bounces-2604-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@l
 ists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:phahn-oss@avm.de,m:agk@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:bmarzins@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[58];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,linux.dev:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Alasdair Kergon <agk@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: dm-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/md/dm-cache-metadata.c | 2 +-
 drivers/md/dm-crypt.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index 57158c02d096ed38759d563bf27e7f1b3fe58ccc..32f7d25b83a181a30a78c663d48f7882cb97f7b5 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1819,7 +1819,7 @@ int dm_cache_metadata_abort(struct dm_cache_metadata *cmd)
 	WRITE_UNLOCK(cmd);
 	dm_block_manager_destroy(old_bm);
 out:
-	if (new_bm && !IS_ERR(new_bm))
+	if (!IS_ERR_OR_NULL(new_bm))
 		dm_block_manager_destroy(new_bm);
 
 	return r;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 54823341c9fda46b2d8e13428cbd51f3edf642d5..05eae3d3c7df6baebd0b7a4219f7b6938f6e7f87 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2295,7 +2295,7 @@ static void crypt_free_tfms_aead(struct crypt_config *cc)
 	if (!cc->cipher_tfm.tfms_aead)
 		return;
 
-	if (cc->cipher_tfm.tfms_aead[0] && !IS_ERR(cc->cipher_tfm.tfms_aead[0])) {
+	if (!IS_ERR_OR_NULL(cc->cipher_tfm.tfms_aead[0])) {
 		crypto_free_aead(cc->cipher_tfm.tfms_aead[0]);
 		cc->cipher_tfm.tfms_aead[0] = NULL;
 	}
@@ -2312,7 +2312,7 @@ static void crypt_free_tfms_skcipher(struct crypt_config *cc)
 		return;
 
 	for (i = 0; i < cc->tfms_count; i++)
-		if (cc->cipher_tfm.tfms[i] && !IS_ERR(cc->cipher_tfm.tfms[i])) {
+		if (!IS_ERR_OR_NULL(cc->cipher_tfm.tfms[i])) {
 			crypto_free_skcipher(cc->cipher_tfm.tfms[i]);
 			cc->cipher_tfm.tfms[i] = NULL;
 		}

-- 
2.43.0


