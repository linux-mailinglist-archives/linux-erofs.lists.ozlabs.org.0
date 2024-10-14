Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5A299CBD4
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2024 15:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728913651;
	bh=gyl8f6prEL4qyts6cj4N2EdZh9WAUVdoR2Nc+jzcKUs=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=awFxycqokVBNOJhxx9L93Ewv0F2pTh77K6qjkVSzgbZkCmA5dZbEQvVlmXhDQRNkx
	 XfOHK4Ee3oJTee41X9XTgh3s7ip2XoZEZ0k5WF/fp+lveUYyVmxAJ/oER5zgtQXwhJ
	 Alfht0ZzqVnX1QaenT3n8RzCkBn/phUMLfWnEf83X8C7hCmOzdv0+RyK/mj3HATZjH
	 EnDGnJW1z7LwukCcU64/BkBj0GcSJ5by9d+y7yy6IJbi0vcqacZC9kqrFPd+4Iderq
	 4QqvDkuLslSstCyUuCRyHfgf9Rriu+sllnE/yMurS4DEyKUnKdp4Akltcaqu+Vf2wJ
	 WI4TZWOuz2A4A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XRz7R5J0zz3bn8
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 00:47:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728913649;
	cv=none; b=MznsZq9fDzZkPdDxoKTWpOGqsAcIA4uBlfLd46Jsz22DPmq1bp2AQZX1BX7DjgfFxkRL9aWorgzHFJ1wHtOn37lV7RjUONxo9cLEq8eCujNMjtkvmlSmZwXYruZe7aZ98uWV7JsolgOU58A0sbVZIsu2wv+HqUMQk2KgeubBPIj+A5Mqpq43dvxiLuN61RUA/ibBpQ4nUQJYWkH54qP9MpCh7+VZjh/b+N9tbBFwtcQOujXDh9UWQpmLBUldPAgkcSHJgVaW+EYnqzUl33K9GRZ7O3F9218b973tKDgBpHwmOvxwlNm2VfaxktfWfRzpgC93BeMJ/e6bIV3qVGUdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728913649; c=relaxed/relaxed;
	bh=gyl8f6prEL4qyts6cj4N2EdZh9WAUVdoR2Nc+jzcKUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nEI0e8jFMsRJT5XUYgQMt1rDg8LuzPn1CoZ8Mx7EQ6QBWqWBeN3Ylf/2M4zaz2/EVwGni65Ly7B6b1OSR6P49Bdraikp10VDjV/IBZi9Kgy+ah+saaLYWEP4GY96lj04fbDXVM5XUtpd/2NL2HfFjIwuijQhbVlugiEuERgKRDRPlFpWUVn1GWagaqNbFi8JyVOvN/CD0MR92yFVQvXOwysGBNlmYJGeAoZt0VdE3v0IcY3KqF0NbqLveSoCSLxbsvRpCclsXM/crcO4OxNDaSGVvVvach99tn3pxfUaDH6NCWA7/g2vR+laI/iBXuprgeMSsEQuEXrgzsPrqD8KAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fbvpbFLG; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fbvpbFLG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XRz7N6dFJz3bn8
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 00:47:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1544A5C4D2D;
	Mon, 14 Oct 2024 13:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CBEC4CED0;
	Mon, 14 Oct 2024 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728913646;
	bh=nwwq7OHMaX1nC9S9saGAcAH78OrbUQ+EHs3XR03niTg=;
	h=Date:From:To:Cc:Subject:From;
	b=fbvpbFLGJacz7KdskTSpqFr5dESrRgMLSudV03eEwOE4BWmMszKDkhE9Dc6HvVQmB
	 BObfvY03gdlnj5csdiKAZ+YCh/Vf1+fna4ecPxhyuqQtZIxd3xo+bolmddD4HGdTgk
	 MSj95NwsdWsQt8Yy7/R9IrSWxaQ2nvV1rU74FgXyHrBy7eXRiHfY3VSXdMLoDDwoAL
	 PWpIsayPhR5TP90B9XtJ/QWAPdJ5HpNSUB/2UmdCs/bWuzotr/vW0V+/GAXT4cuqcb
	 okXyEKXhUAENIBQhpH/98qS9M5jqYJOpEICzqKW+h1eaJ38dXTsJG9UEsIMT6B0lcE
	 pHLgCpJfAG7tg==
Date: Mon, 14 Oct 2024 21:47:19 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 6.12-rc4
Message-ID: <Zw0g5xS5WXYve0Hj@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	chao@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these three fixes for 6.12-rc4?

The main one fixes a syzbot issue due to the invalid inode type out
of file-backed mounts.  The others are minor cleanups without actual
logic changes.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc4-fixes

for you to fetch changes up to ae54567eaa87fd863ab61084a3828e1c36b0ffb0:

  erofs: get rid of kaddr in `struct z_erofs_maprecorder` (2024-10-11 13:36:58 +0800)

----------------------------------------------------------------
Changes since last update:

 - Make sure only regular inodes can be used for file-backed mounts;

 - Two minor codebase cleanups.

----------------------------------------------------------------
Gao Xiang (3):
      erofs: ensure regular inodes for file-backed mounts
      erofs: get rid of z_erofs_try_to_claim_pcluster()
      erofs: get rid of kaddr in `struct z_erofs_maprecorder`

 fs/erofs/super.c | 13 ++++++++++---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 fs/erofs/zmap.c  | 32 ++++++++++++--------------------
 3 files changed, 31 insertions(+), 43 deletions(-)
