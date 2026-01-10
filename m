Return-Path: <linux-erofs+bounces-1806-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10824D0D2B3
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 08:28:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dp9GW1DWCz2xRv;
	Sat, 10 Jan 2026 18:28:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768030083;
	cv=none; b=L9HEx4IACLWd5UEqHZejR4i3GGuBMx45RQvZmRKzvUy1zTCpT0h75MXNJZ3OwepTAn+Tb0YwLDEPPzTH4bWOi4Q6IbbTF5z3nRaLs3TxdRrBdNWgRpr4XZHwonD1yH51QXHeKZJc4KPk+Xf/2ksaG4WrezynXhSBFJ5x4iiDnjqrl9iS5Jqil86Y0XoPdr2qGIQA/M3xzxge8wS4502091MlqlF1+PGTiWNUG0J8Ei9YYZXh6goUScWwHZ99TL6NragJ8whv3RGTI4aGk4Cm6zkCYWuFO0Ys+mAeuuC5gSJTW4xFDRuSgRuHrsuB1ATzRvlRQQLeYM8+KQu6mRxXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768030083; c=relaxed/relaxed;
	bh=BGxMbjqPJKSbfD/mpfSUZlulGcSJFnXJED8pqfeMIJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBifUHTlYhvo3cdYHmZhKp+ppVe2klntlP5Cyz2MBlhUyoqtCOBaYY8y4edxtgqpwrzBubnIB/y196WcD2wLHrTysZw+bAOhrBR98yMQiwnU22x6rSp8ojYq0+NxDvRHXH7Wff3y675sdX2mGpyNqVnjSGRLhiq6wYNs5jmLRU92/rtLFjKKfQQMf694n1x2EA4vVFAeYo8YfRLB5GoEOUOkpsWvx09DH1SFSCy1Dxdh3FmRGEyzWE7vsB0u9jAVqkKoqLCRBeabQMnCTUSwU65deRKRzeXU70PTHOG1wpgG1Fn9L6xX+/q4KQmIOxwnfGkXH4wxNgyjPX7mWmE1gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BO/yX0uV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BO/yX0uV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dp9GV3cySz2xQs
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 18:28:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 37B5860052;
	Sat, 10 Jan 2026 07:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C6CC4CEF1;
	Sat, 10 Jan 2026 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768030078;
	bh=f4fXI2upeTBI6F7Pio3h5Q6G/PFsNcsmTz/C4Klt41s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BO/yX0uVKgwSNzZI5p2XV+ZsvppCrl7MdfNPaKI6sTkyV9l7AvugomVQ6Wq9Pjado
	 UujPEZoCTSRGqqr+EUSrv4xFkfV5vGapB7DhmTEFnBDYdwC9wez/KH6aDuwWFdygNe
	 cLQgX4LyotLdi1THBMltSoA0BjRVu/Wt+nYUbiD6MRdlaIFUJndkYOekUt7Cp1WqFV
	 u949MUfSus7BDA4xsXHazCjJ2f5ffU+TU+/+oeXE42nn2po5L0noYU4oOelLJExNk9
	 DRWoR4OtxKRRPXh8SDVd/dnutBeharWHLuIv8VJSyyJ8UAK8ZNNCRH4omPfehE3rai
	 MbBa7jTVD5qSQ==
Date: Sat, 10 Jan 2026 15:27:48 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [GIT PULL] erofs fix for 6.19-rc5 (fix the stupid mistake)
Message-ID: <aWH/dP4xD51Rqwa+@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Larsson <alexl@redhat.com>,
	Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>,
	Sheng Yong <shengyong1@xiaomi.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>
References: <aWHibOkAT18Hc/G5@debian>
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
In-Reply-To: <aWHibOkAT18Hc/G5@debian>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Linus,

Very sorry I sent an incorrect pull request which used an
outdated PATCH version (I just manually applied tags on the
incorrect version, but I didn't realize), I shouldn't make
the stupid mistake in the beginning.

Someone reminded me the mistake just now.

Could you please apply this pull request, I promise that I
won't make the similar fault again and I should be blamed.

Thanks,
Gao Xiang

The following changes since commit 072a7c7cdbea4f91df854ee2bb216256cd619f2a:

  erofs: don't bother with s_stack_depth increasing for now (2026-01-10 13:01:15 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.19-rc5-fixes-2

for you to fetch changes up to 0a7468a8de7a2721cc0cce30836726f2a3ac2120:

  erofs: don't bother with s_stack_depth increasing for now [real fix] (2026-01-10 15:13:12 +0800)

----------------------------------------------------------------
Changes since last update:

 - Revert the incorrect outdated PATCH version

 - Apply the correct fix of
   "erofs: don't bother with s_stack_depth increasing for now"

----------------------------------------------------------------
Gao Xiang (2):
      Revert "erofs: don't bother with s_stack_depth increasing for now"
      erofs: don't bother with s_stack_depth increasing for now [real fix]

 fs/erofs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

