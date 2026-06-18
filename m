Return-Path: <linux-erofs+bounces-3674-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w+kyLU0ZNGr4OQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3674-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 18:14:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E806A1865
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 18:14:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Y8ztyFVv;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3674-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3674-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gh5Pw1KRRz2ySJ;
	Fri, 19 Jun 2026 02:13:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781799236;
	cv=none; b=CeQv5E0oW8uk9UpPyoiJYbxwCo3VDEIcWuHRFLSg5eC5Wf60VkMC7Xw29Kyl8xRLHaSNTQGF1ZPIDDwirNpZf6Gvjph1RvQFIw0iE7dnAs2MXRPz+yNTeNPo8ne6K8HxvLoHaIem83LWGxf1wGUxrN7YXJXbPHxe0RACX4MLf1zQ9fv0cQZMPrbV0g7Xshvg/5smP6ihq9IUJyiYrv2ROZtBPRrVibG6Fk6L0LniSw7ioUbsB56VX+BicbLOPDYPbv9la3cIEnpDKl5DLeYOJTijf9mIyZHwzIUTuOo+BTGSIH8tr2zXE4prsW/ls9iM3WjowkvZgHeoVFtS6rvZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781799236; c=relaxed/relaxed;
	bh=Y0Kn3xFcX784HGCALw8UDKwMV+7xTaq6k7+mjBPooL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SkIwyZSudE3ixcZH2Z+uWqB3kgM6/332VfG4P8A4LYv5nNlovOl6lyz07YYO6UTbroyT/rfWb66OAlKFsnxAxvHiArTGSdtOWs8O41QpHWQI/PENFvms/v6IaZJOTvkYW6KEOcFRfa5Nq5AUdXmuo7zh1eVl0mwud/hShviGhxb+8O+UduIPvo/3OpoTbB8NpeKd+MMjp5Yy+1zVD6XBhLO3DigB0piqjToV1k8Yz8XGKygZTuKc/MLqKm6M6h2GKkaxLtx5hjW+90NGXxDkwEmhf/bURrpddL9thxd9GIL1sghLkl0Uxi2qv7PZOHsFYjIt2iEPds7zueTcDNuKBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y8ztyFVv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+aruiz.redhat.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gh5Pt5FlLz2yFc
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 02:13:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A9BC460098;
	Thu, 18 Jun 2026 16:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 500ACC2BCC7;
	Thu, 18 Jun 2026 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781799231;
	bh=u1QwI1AOpH0D8IvOYk4BtAtb0C1h3NOndIlroKuUmmA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Y8ztyFVvn0/mWLdgz/rF+WLiMMIrWMOEmaeYwZySET3zVq4SHuMqoNHOhDSY9OZ1f
	 nYMoqBusyuQ7X6B/NDY5Oa1PpzShFCPCvhNSoF8emNfNQ/Alnq7/EhxlMApPaZLDhT
	 rlX8njENE6jObTBAoUnKabeZYTuB7QxU6GYdaCJOvEEaQjQ7h8k/VKTFT1A6WLUHg1
	 ZveOhL5anWsr6TF6Ml/Lym8xk6isJS47E+hc2gdtbGi+QU0S93KO5Gqx/S3CKfEnLB
	 xXHnKofXE6J1eTGB0EFC3XI8ZWStPjjT4Yqti+UR7o933Xnzq7KAYVnZZgQUgaICLU
	 L/CSyXOSOwK/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7EDCD98ED;
	Thu, 18 Jun 2026 16:13:51 +0000 (UTC)
From: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>
Subject: [PATCH RFC 0/2] RFC: erofs: memory-backed mount for
 non-page-aligned ranges
Date: Thu, 18 Jun 2026 17:13:43 +0100
Message-Id: <20260618-erofs-memback-v1-0-5aa7006a241a@redhat.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Nz3dSi/LRi3dzU3KTE5Gxdg8RUIxMTi6REo+RkJaCegqLUtMwKsHn
 RSkFuzkqxEMHi0qSs1OQSkElKtbUAXYGDhHYAAAA=
X-Change-ID: 20260617-erofs-memback-0ae2448ba2cc
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Brian Masney <bmasney@redhat.com>, Eric Curtin <ericcurtin17@gmail.com>, 
 Alberto Ruiz <aruiz@redhat.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781799229; l=2698;
 i=aruiz@redhat.com; s=20260612; h=from:subject:message-id;
 bh=u1QwI1AOpH0D8IvOYk4BtAtb0C1h3NOndIlroKuUmmA=;
 b=0HNeFSvZBySZaDmAoh7zOYZD283faaBQL1pVldiPpNOMZn83Wgwawpurj9yk/z6wf4qeoBfTU
 FbNGZoPmudFBFuyzRlQQqx9DtP1JYkt7pCdRVbE+qe5Y+yJIcX1kR44
X-Developer-Key: i=aruiz@redhat.com; a=ed25519;
 pk=d1doFQwve1B/jU9nG5oPl1W5d+t+iFrjkkwk/hD97Ow=
X-Endpoint-Received: by B4 Relay for aruiz@redhat.com/20260612 with
 auth_id=818
X-Original-From: Alberto Ruiz <aruiz@redhat.com>
Reply-To: aruiz@redhat.com
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-kernel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:javierm@redhat.com,m:bmasney@redhat.com,m:ericcurtin17@gmail.com,m:aruiz@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3674-lists,linux-erofs=lfdr.de,aruiz.redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[aruiz@redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-erofs@lists.ozlabs.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38E806A1865

This series adds a memory-backed ("memback") mode to EROFS that
allows mounting an EROFS image directly from a kernel memory region
without going through the block layer.

I am sending this as an RFC to get EROFS maintainer feedback on
this approach before building the full initramfs series on top of
it.  The memback mode may also be useful for other use cases beyond
initramfs where EROFS images need to be served directly from
memory, though it may need further hardening for more general use
cases.

Previous review feedback on the initramfs patches raised concerns
about the block layer dependency — this series addresses that by
providing a direct memory-backed path.  It also adds support for
non-page-aligned memory ranges, which is the common case for
initramfs images packed at arbitrary cpio boundaries.  Supporting
non-page-aligned ranges is essential for true zero-copy access —
requiring page alignment would force a copy into an aligned buffer
before the data can be used, defeating the purpose.

The full initramfs integration (init/ changes) that wires up the
EROFS initrd detection and layered mount is available for reference
here[0]. It implements support for interleaved cpio and EROFS
layers, it supports cpio CPU microcode update prefix, and uses
overlayfs+tmpfs for write support.

This series was developed with the assistance of Claude Opus 4.6.
All patches carry an Assisted-by tag. I am providing the kunit
testing and I have tested this change against the initramfs series
to boot an EROFS initramfs. I welcome feedback on the approach and
implementation.

Patch 1 adds the core memback implementation.
Patch 2 adds a KUnit test that mounts a compressed EROFS image at a
non-page-aligned offset and verifies decompressed file contents.

[0] https://github.com/aruiz/linux/tree/wip/erofs-initramfs-memback

Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
---
Alberto Ruiz (2):
      erofs: add memory-backed mode for non-page-aligned mount
      erofs: add KUnit test for memory-backed compressed mount

 fs/erofs/Kconfig        |  11 ++++
 fs/erofs/Makefile       |   2 +
 fs/erofs/data.c         |  33 +++++++++-
 fs/erofs/internal.h     |  53 +++++++++++----
 fs/erofs/memback.c      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/memback_test.c | 151 ++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c        |  38 +++++++++--
 fs/erofs/zdata.c        |  16 +++--
 8 files changed, 447 insertions(+), 26 deletions(-)
---
base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
change-id: 20260617-erofs-memback-0ae2448ba2cc

Best regards,
--  
Alberto Ruiz <aruiz@redhat.com>



