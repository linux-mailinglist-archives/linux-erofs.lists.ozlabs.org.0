Return-Path: <linux-erofs+bounces-3685-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qzG4IgEXNWp5mwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3685-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 12:16:33 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25106A5273
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 12:16:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UWzW85yS;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3685-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3685-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghYR038Wbz2y1Y;
	Fri, 19 Jun 2026 20:16:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781864188;
	cv=none; b=hCzhLKf0t6dY8WCNmy0dNH+VSABIlPeKnCywy2GIWkObCxN6NW7ScRQGkFjc107v/5ttktOveOuQWlgMsjS+Nff+HLqkxaXDCuuUbGaGOnNPSMQGKD9FAqLqVUplWwlY7SrD665PaX3iaktEXtB7XMl+m7p23IfPSbs3J2ar8KqQPWcs0OUPI6udp44ZaAGuU/Uw2qDFiz8A5fEHHGLe0VOnOSgVpLMtcF0KF457IrEDjbKy+Hd8CKgqt6Mn3lw2G6r+mEpqBoX79IMGnWDOSQxDZ/IJFcsKnWZjpqWItN8FoRZdMHkeGEu9F/ZgVbaW2ueaV1O3vvGN65UbS6JHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781864188; c=relaxed/relaxed;
	bh=T4Ku6vxk8hJWYI5hTD/JvplJiBVBM2hA5xPuKUywqtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUFvSmhGlH1/smPfGn4fe2JivqaEd0zMyKK+6iBu9fj1iCWS+Y1pS8rNxUdbSEpa2NbLH6QCZzlyGGDCX3PAl/W7qwvjpkAB5FduJNNeIF629Eo+Ft+CxpCL7zCzEqvSiUUmsGZ4As7cqshpnM8vF2ksSP0EDC2/u40GHHQpn3mLzpWOQB2jvvFAlbeo2/di+K2pqzoQry3XtT9Rc5ytNnx5D9Tuib3O2VMFpGZsvUtCTbaw2VSQLhd16mdzR+mSeQlszTYRkz2gbL2Lij2BXkuMFeibhKoR658s/WT+2Av6B1wCCSbBnEaOlPJkFDp7mVuHiq5L8EkghwkFSs/PbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWzW85yS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghYQz2wFSz2xF8
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 20:16:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A109D601E1;
	Fri, 19 Jun 2026 10:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E291A1F000E9;
	Fri, 19 Jun 2026 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781864184;
	bh=T4Ku6vxk8hJWYI5hTD/JvplJiBVBM2hA5xPuKUywqtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWzW85ySRdjp0ho+faIX+ktbjM7q0E71ZtySVmHB/lVksOkWs35ujR/kmWxc8PucY
	 d57zq/tQ0SpuUcEsoTMhQjfDBNpBccmyqE0960iJZvb7wPhVcCsnVwOk6EJFUS48+W
	 23W7iGHjVNZ7wvPZmG/w0ZOETozKdf20KjzfaaepQ2z6Pm+bztuSfNf691rYrTrtVE
	 ZbygRWbI7Chha4MkTeSYI04PFr63DUfViiz8/ix+pexFnGub2diHQMuRG/Ra6pKcWu
	 Cc6twnKRPzc9n2sX330e43I70bDRH9RmWYM7GSDuvj70NBSTWfQ7+sYeW8UMyWjYCg
	 DamksD6HmZNVg==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Kelu Ye <yekelu1@huawei.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: submit read bio after each extent
Date: Fri, 19 Jun 2026 12:15:56 +0200
Message-ID: <20260619-kundgeben-hippen-abrunden-643fba56e35d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619050105.439956-2-hch@lst.de>
References: <20260619050105.439956-2-hch@lst.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=brauner@kernel.org; h=from:subject:message-id; bh=tn0AV2gYpBnl6skQdfrlTXr7GXWTF+FHRBN4aCvCt5w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSZin2KPFU0f2ZCVoTv/yyj999qeNO2TPv1csPWjGUcZ YsMU4XsO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSvJeR4bHukrfPUs2Dan+e sT67jWeTzn5FpivTp9zfrJbuWrcpew8jw0ypS5991LL4kudO+cE6a1nLxunxkZl5pm8nLNQqYc8 S5AYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.80 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3685-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F25106A5273

On Fri, 19 Jun 2026 07:00:53 +0200, Christoph Hellwig wrote:
> Currently the iomap buffered read path tries to build up read context
> (i.e. bios for the typical block based case) over multiple iomaps as
> long as the sector matches.  This does not take into account files
> that can map to multiple different devices.  While this could be fixed
> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
> over iomaps actually was a problem for the not yet merged ext2 iomap
> port, as that does want to send out I/O at the end of an indirect
> block mapped range.
> 
> [...]

Applied to the vfs-7.3.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.iomap

[1/1] iomap: submit read bio after each extent
      https://git.kernel.org/vfs/vfs/c/dce5617fca3a

