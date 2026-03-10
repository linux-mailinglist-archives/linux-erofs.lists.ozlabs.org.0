Return-Path: <linux-erofs+bounces-2628-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMwYMl8jsGlhgQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2628-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:57:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 70767251171
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 14:57:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVb6z4Hv4z3bjb;
	Wed, 11 Mar 2026 00:57:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8:216:3eff:fe9d:e7b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773151067;
	cv=none; b=JlFytw5ztnszPizVwlaxj7FvWN30Qnd9QPJ9UviIhOsngIiUiwsuMuhtEf+w/YbgHI+EZ1TcE4AncN9P0OTxmN4qPdnF196V+sjBcCDLQK4y5rmULQIXGtsKsy/5vErNj7tIvWO6+6WltZqG7r9tjcLW6ZgElkYx9CNJRW5Yr0tuJlt2KTk7CoKEOdwj/8dFtXJ3nwoiSoY/mYDdGqXr2IS0oIxhVauKoPL57ed0lSpNfIgCCHds/oViobuB80ftGyIkDlX08LmHpvJW1cI6Pg3256qrFpXlYGoqw0Mpmm0pDiu8zZTqw3ODlvMeQHuUkdSQxGS+kJUWLIDHS9uz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773151067; c=relaxed/relaxed;
	bh=765ZgLXaPzReFoXtpkbv3MYN7L9J6JKDHvE8MxWus3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kc7LqUalaHwVOqpYr/ohBvbj6uPXa8aG/fWcAiTjUqygX4sNCTNEEJN/eWJ9LnhwMJI5ml6bawoJurN2S01cf6WkwxANqFDA3n7R/HqZrd4EZX+axWhmMShpCyd1Kcz5EnkP2PDHwDRm2hQnjUrAjGN3a9bcpJvErLGV6NC4q7iWraKc4U8n+YB3yJry7s5/GuEjP9tXtQT6CFTl59mtKsrBxnaqQLufmnmlPnkfZk5K30GIcNImxJ8SV7HBNo282FUybv35s0ubPZ3uJvxheFRDAC4z6atabEHtd90ByPN8nZqasfkJ2m+G2aZ1IhAZLkw/9cQwz3eIWjIQdg7fbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass (client-ip=2001:4b98:dc4:8:216:3eff:fe9d:e7b4; helo=mslow3.mail.gandi.net; envelope-from=hadess@hadess.net; receiver=lists.ozlabs.org) smtp.mailfrom=hadess.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hadess.net (client-ip=2001:4b98:dc4:8:216:3eff:fe9d:e7b4; helo=mslow3.mail.gandi.net; envelope-from=hadess@hadess.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 95 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 00:57:46 AEDT
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [IPv6:2001:4b98:dc4:8:216:3eff:fe9d:e7b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVb6y4b3cz30Lw
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 00:57:46 +1100 (AEDT)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id E37C358170E
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 13:56:11 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 539B3433BD;
	Tue, 10 Mar 2026 13:55:53 +0000 (UTC)
Message-ID: <375c7c30c184d331c199876e45920976030f3cbc.camel@hadess.net>
Subject: Re: [PATCH 25/61] net/bluetooth: Prefer IS_ERR_OR_NULL over manual
 NULL check
From: Bastien Nocera <hadess@hadess.net>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
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
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 14:55:52 +0100
In-Reply-To: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepheefleeufeegfeefueffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepheejpdhrtghpthhtohepphhhrghhnhdqohhsshesrghvmhdruggvpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvu
 ggvshhkthhophdrohhrghdprhgtphhtthhopegrphhprghrmhhorheslhhishhtshdruhgsuhhnthhurdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghphhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-GND-State: clean
X-GND-Score: -100
X-Spam-Status: No, score=-0.0 required=3.0 tests=SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 70767251171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.00 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2628-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[hadess.net];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:marcel@holtmann.org,m:johan.hedberg@gmail.com,m:luiz.dentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hadess@hadess.net,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[57];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hadess@hadess.net,linux-erofs@lists.ozlabs.org];
	NEURAL_SPAM(0.00)[0.094];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[holtmann.org:email,avm.de:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,hadess.net:mid,hadess.net:email]
X-Rspamd-Action: no action

On Tue, 2026-03-10 at 12:48 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Johan Hedberg <johan.hedberg@gmail.com>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0net/bluetooth/mgmt.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index
> a7238fd3b03bb54f39af1afee74dc1acd931c324..06d2da67bbe14e17ee478aa939d
> e26526c333d91 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4169,7 +4169,7 @@ static void set_default_phy_complete(struct
> hci_dev *hdev, void *data, int err)
> =C2=A0		mgmt_phy_configuration_changed(hdev, cmd->sk);
> =C2=A0	}
> =C2=A0
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -5730,7 +5730,7 @@ static void read_local_oob_data_complete(struct
> hci_dev *hdev, void *data,
> =C2=A0			=C2=A0 MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
> =C2=A0
> =C2=A0remove:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -8277,7 +8277,7 @@ static void
> read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
> =C2=A0				 mgmt_rp, sizeof(*mgmt_rp) +
> eir_len,
> =C2=A0				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
> =C2=A0done:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	kfree(mgmt_rp);

