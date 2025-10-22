Return-Path: <linux-erofs+bounces-1278-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D7BBFC81F
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Oct 2025 16:26:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csBLV2Nq6z3bfN;
	Thu, 23 Oct 2025 01:26:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761143202;
	cv=none; b=SOYJNIA8huuubK02VtKhO624tgdLjCz79MlPDSizwBt6baqTogonf4dnW0B4pBN6QyK0+H/SNZx9J4uFklf0TB3o5agud9JE3xOqRnImiW2IHXNbesLi4nJnfJbEUtynEgT9uRSlVXwgG6qMVA61JvMJhlnUZbCD4lnhQuvyMf8gH2fpTzE8TaWsx28s8My5W7073+AZq/DttA13Ix6yiv2gYwqo9xNmN2yQizWV1FMj8imjMsNZcC0PKzJITIVM6VgbL4Iy2hDdaA6ig8e72x8nQkXYPb7/iqvEEQKQlma5tsaaNMwCevLZmz0LCt1vclqIjGSTGlv4tS+UAj7LCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761143202; c=relaxed/relaxed;
	bh=QtLprgk3SEquFB2MwBfTzk2J65B+z+pHiNZr4hUmydQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jAb/lMPtg8VYkCEdGVKwT/x7v3qDuj1icWr8JkIVp3BALPi+XYEP9qpiZ5KjR3hk8jCTdStTMWU60S/E2irK5EhDSpj5q0G4z9rvrc6oZ/WQA2e0m1kar9kfnA0iwjbbhbss/BJHPaOucH38rOf7mZmQazSSZ75H0wXu9V2GfGryT1PD0ClIbqAliPX/X14ouHVfJVXMr+duqhX4DY/DmmlYBKC9nI3aBv9AS02re2Gi6ts83Yspskm/3/5HPT2M/C7gG7OgSedE0PbA+/I12w0UOk70Hhs07FeOgrtyEKdhkoODt8Q/fEzc3wFhYVAE3yeyLGM6hCc7li6d9+PPKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I5tmfBCo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I5tmfBCo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csBLT5WGYz2xxS
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Oct 2025 01:26:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 66B6A48C77;
	Wed, 22 Oct 2025 14:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C297C4CEF7;
	Wed, 22 Oct 2025 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143199;
	bh=WPFbo9YO3Pyw1iyvVznyFGv5zJuD7NvB1FRw0HBOe9w=;
	h=Date:From:To:Cc:Subject:From;
	b=I5tmfBCoHIjqQdpWx9JLd4NhTdht8cyYwBvpbw3fFbiBLlUUJORDtqGBWf1SVkYZB
	 CY9EqJSpGkUmfVoQofbVL6Ay0PcTDDYS5KaR+DXJXOJFK9Hd7gWFzYY5D97fmj+wQm
	 uuNa5NmGjckWWQnOg9m0bE10DrA/lFdsK/mSzKVtLpa/mnNffCyphrWrxjNH7m4+sY
	 EWir05GBMyRQSgLXrR36g5Wqq6jpoDj+kR4/pv7zNA6znNUS/PRuogZMOWDOwPXppt
	 Uzi9TzfBt+Im/x9lFFs8wUi2nlat9cQuDZVOJ6HPRQsvxCKzDY63jVuurMrbJUbUB6
	 3tGm35fxXlnzg==
Date: Wed, 22 Oct 2025 22:26:25 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Subject: [GIT PULL] erofs fixes for 6.18-rc3
Message-ID: <aPjpkWvwoMrKHxvc@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
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

Could you consider those fixes for 6.18-rc3?

Just three small fixes to address fuzzed images in relatively new
features, as reported by Robert.

Thanks,
Gao Xiang

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc3-fixes

for you to fetch changes up to 2a13fc417f493e28bdd368785320dd4c2b3d732e:

  erofs: consolidate z_erofs_extent_lookback() (2025-10-22 07:54:31 +0800)

----------------------------------------------------------------
Changes since last update:

 - Hardening against fuzzed encoded extents

 - Fix infinite loops due to crafted subpage compact indexes

 - Improve z_erofs_extent_lookback()

----------------------------------------------------------------
Gao Xiang (3):
      erofs: fix crafted invalid cases for encoded extents
      erofs: avoid infinite loops due to corrupted subpage compact indexes
      erofs: consolidate z_erofs_extent_lookback()

 fs/erofs/zmap.c | 59 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)


