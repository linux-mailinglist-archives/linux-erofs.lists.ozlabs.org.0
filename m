Return-Path: <linux-erofs+bounces-1133-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FBBA999B
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Sep 2025 16:35:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cb3cz03VQz304x;
	Tue, 30 Sep 2025 00:35:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759156514;
	cv=none; b=YLLlHgwd2BR2+kmWGnASChC89yML09g4SWdudKlG1BpsUiEgxpnWwRffSao3wU165fkF1qPUfFUK142u+F2OESWwrz9mnXwFKvw1RvgvLdEM5S7INajN2lz1pBIwcL9TaJneHFRxqGMEi8cqWsMYPO0O/IIbQNsZLsWPO0tq7N0DgHlFc+XFwKi7L8tPMj2nkrkgkinrMOJj56GqJ1Y64/gSSDV5c9CpJn63waogLDMrsitMpX2360qbEQipJ1PxjFBWTxRjqu4uzadps30U7esuxJP6nI6DdCRLC82Bhua/Z61U1MyV1XVvjUVlSuGd4Cwt+clqvZ0qUk4TIveKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759156514; c=relaxed/relaxed;
	bh=JhfHreEaYLKuMCbi7DRxhEyE5p8scgM7V6dy2dLX/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aKZjZ60xYW+fEkMiNLA5FrRxCD7wNSGQPTLfzQsFZ7fqdsjhdxVwZkh25qthjSm76uHinlvE/6mEUlET1cvu5jSlMMyrUUwhsThNKinDglEjtgy65j52LOQVHRZYKlVjpFFDJwvRPw1yG0LEXPzSaAtyTp74ys6oQEkvxn5lGDWoW+jdLQCI1aAEX2WMO9uvkOMB6JBbwBsiFgRHRoiS6YJ82y9GMvzsS6cw8OY4UXuLOSR+OPxM1alpHXCtILVgsBPbGYP+a6wZST6WwlfanJOgTj/tNNIYpBo8GGRMSfttW54lvJa3MdNWoKXIIn4gW0ZNaWW2gq+TzfZvKEW/Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F3vVNnhO; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F3vVNnhO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cb3cw3gF1z2ynf
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 00:35:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 99B8140B70;
	Mon, 29 Sep 2025 14:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EFFC4CEF7;
	Mon, 29 Sep 2025 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156508;
	bh=DRSihkHoMG81fVQdMHQHT+bezqKWPcqqJdII+FwnuCM=;
	h=Date:From:To:Cc:Subject:From;
	b=F3vVNnhONYoBUjn+EAL66VwRehAnkHJF+jLdZoi44sIK7DSBu98nkX4IlYnSn156B
	 EwD6yJCad7V/zjuXY5WSbxHd930TIqIGGKX1992hdX3ASfwjm9KFq/OIQjxAqtspTL
	 8HGPyaP8B6mrO7VFMfe1r2FPtMlRUHR4lKP16FODsTzq7y0TjVrqy7S/nLh59V2rjb
	 sEsv2EXwn6CTWv1NsRn2F5vDWrCHB960wc0fAjYqgJdZIrNrvmuqMWYpuYNctSDqjw
	 cglP55NaAFo0m78GZfy3mZt/cdbIJkEsj8PqPF7CiOzzTRm6OZmVqLFTTkCSJahU4t
	 ygWoA+JzhDBiA==
Date: Mon, 29 Sep 2025 22:34:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs updates for 6.18-rc1
Message-ID: <aNqZE+ex0ci1etXU@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>, Chao Yu <chao@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>
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
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Could you consider this pull request for 6.18-rc1?

There is no outstanding feature for this cycle.  One change adds
support for FS_IOC_GETFSLABEL, and the others are fixes and cleanups.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc1

for you to fetch changes up to e2d3af0d64e5fe2ee269e8f082642f82bcca3903:

  erofs: drop redundant sanity check for ztailpacking inline (2025-09-25 11:26:39 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support FS_IOC_GETFSLABEL ioctl;

 - Stop meaningless read-more policy on fragment extents;

 - Remove a duplicate check for ztailpacking inline.

----------------------------------------------------------------
Bo Liu (OpenAnolis) (1):
      erofs: Add support for FS_IOC_GETFSLABEL

Gao Xiang (2):
      erofs: avoid reading more for fragment maps
      erofs: drop redundant sanity check for ztailpacking inline

 fs/erofs/data.c     |  4 ++++
 fs/erofs/dir.c      |  4 ++++
 fs/erofs/inode.c    | 40 ++++++++++++++++++++++++++++++++++++----
 fs/erofs/internal.h |  5 +++++
 fs/erofs/super.c    |  8 ++++++++
 fs/erofs/zdata.c    |  7 ++-----
 fs/erofs/zmap.c     |  4 ++--
 7 files changed, 61 insertions(+), 11 deletions(-)

