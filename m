Return-Path: <linux-erofs+bounces-2684-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHknAMUWs2mDSAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2684-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 20:40:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4F27836B
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 20:40:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWydr4TfFz3cHH;
	Fri, 13 Mar 2026 06:40:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=116.203.167.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773344448;
	cv=none; b=S4lhCAlhTLzRIcCeGPruVwSijUBjEIEXIeHYApQvqWVMcLNTvR75DiDNImLzOiVpgApHZTj0ajSS6yJGsRlkTcV8YxVwOe1F1ycnsBrwZmn0IBDl5xziE7ma+9oXZmLnm7XrSzVaMzFUDvTVNqX/qr+rSzofQPzzQezOxwQzUsyAfxeuquZWac35KrVeaepUrLFn2VVhFoh99/t6N2tODz+cjtrmiq1r+jVD141P2Bf1RqeOnGisu4ArTw8rvHFx/I75hmunOgS3p4FOF/p4d4W9Fyiy+zxAKNDQ4UhJW2JS2e7iOaYiQ0IFwJbZYGrDHe3j11bPCso6QS1LbIINNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773344448; c=relaxed/relaxed;
	bh=VQ4I1//oujMg/wMbvtHZ1fNg62i5rEhIWcPKRohhj4U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CzPciRDKpznxsIS/9OXno2bGsiamn6aDwxdJTUgqpcTMAbYoiAagMqvbRAq2zXp1C+OBE1FrLIIFn9OVozXr09FUyzdXv12eLa4TIZCKti8sUH3srZKzoK4cOZ/o03ZQErKBtOLW70EkyvCBAaHfqQOZDsAD/+bQiSx3sbHWnxVYPg75vvWcVYV2djyWmqg23zh00WvLg6LwtEvCLnnTW2Fpi1Zo5GzkCvqsdqT5Mn9f0nTUwXeGQb1Y3F03Y2otAfKdvqcvUbOEkY3XhUYWt6PHEuKWWiA/R4LMj00tY2tvRmmrLnC74zLJhKTGzbdkCKaRHvuOLvJzJevECj4RCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=permerror (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org) smtp.mailfrom=nod.at
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Unknown mechanism found: ipv4:195.201.40.130) smtp.mailfrom=nod.at (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org)
X-Greylist: delayed 417 seconds by postgrey-1.37 at boromir; Fri, 13 Mar 2026 06:40:47 AEDT
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWydq2KwPz3cGf
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Mar 2026 06:40:47 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4DE582C14A8;
	Thu, 12 Mar 2026 20:33:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yCwNT8mwVvHB; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8A34D2C14AA;
	Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3HN7guaAFMsE; Thu, 12 Mar 2026 20:33:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ABF4A2C14A6;
	Thu, 12 Mar 2026 20:33:42 +0100 (CET)
Date: Thu, 12 Mar 2026 20:33:42 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>, 
	apparmor <apparmor@lists.ubuntu.com>, bpf <bpf@vger.kernel.org>, 
	ceph-devel <ceph-devel@vger.kernel.org>, cocci <cocci@inria.fr>, 
	dm-devel@lists.linux.dev, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, 
	gfs2 <gfs2@lists.linux.dev>, 
	intel-gfx <intel-gfx@lists.freedesktop.org>, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, 
	linux-bluetooth@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-cifs <linux-cifs@vger.kernel.org>, linux-clk@vger.kernel.org, 
	linux-erofs <linux-erofs@lists.ozlabs.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-gpio@vger.kernel.org, 
	linux-hyperv <linux-hyperv@vger.kernel.org>, 
	linux-input@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-leds@vger.kernel.org, 
	linux-media <linux-media@vger.kernel.org>, 
	linux-mips <linux-mips@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, linux-modules@vger.kernel.org, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	linux-omap <linux-omap@vger.kernel.org>, 
	linux-phy@lists.infradead.org, linux-pm <linux-pm@vger.kernel.org>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	linux-scsi <linux-scsi@vger.kernel.org>, linux-sctp@vger.kernel.org, 
	LSM <linux-security-module@vger.kernel.org>, 
	linux-sh <linux-sh@vger.kernel.org>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-usb@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, ntfs3 <ntfs3@lists.linux.dev>, 
	samba-technical <samba-technical@lists.samba.org>, 
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, v9fs <v9fs@lists.linux.dev>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1584421372.26258.1773344022512.JavaMail.zimbra@nod.at>
In-Reply-To: <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
Subject: Re: [PATCH 48/61] mtd: Prefer IS_ERR_OR_NULL over manual NULL check
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF148 (Linux)/8.8.12_GA_3809)
Thread-Topic: Prefer IS_ERR_OR_NULL over manual NULL check
Thread-Index: 0l8CyewQmrWlgaG6N3QgQFfukutRbA==
X-Spam-Status: No, score=1.0 required=3.0 tests=PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.00 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2684-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[richard@nod.at,linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:miquel.raynal@bootlin.com,m:vigneshr@ti.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[nod.at];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[richard@nod.at,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:email,nod.at:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 91A4F27836B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

----- Urspr=C3=BCngliche Mail -----
> Von: "Philipp Hahn" <phahn-oss@avm.de>
> -=09if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
> +=09if (!IS_ERR_OR_NULL(gpiomtd->nwp))

No, please don't.

This makes reading the code not easier.

Thanks,
//richard

