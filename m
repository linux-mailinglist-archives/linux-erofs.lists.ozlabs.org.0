Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 100674E4607
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 19:32:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KNKpB6lvkz2yfm
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 05:32:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QwN68IJ8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QwN68IJ8; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KNKp44SZ9z2yN1
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Mar 2022 05:31:56 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5475D615ED;
 Tue, 22 Mar 2022 18:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE76EC340EC;
 Tue, 22 Mar 2022 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647973911;
 bh=XQFBCQ2mnxzKUADqqIpqYqyNn1PFGesqW02zRxcoVBk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=QwN68IJ8N1JOJ48gkPiDzEtlfcP4IRQxrAgDoUB0cXT9kc6VBSpOviDJQcTr8EudS
 kGsmEv8DJEUpd1h2D0hOkR1FfLcA1T6dEihmp0P214YFSY/QsdoSON/i+i3vFCJw53
 ZohNNjTJhZ1VDnVQq2ALvDY43AU+KnC9JQZTNERk9uJe72PTr70zR+N7G3iLakLicf
 P4a+UFs3IfI4ZmHjHvsxaazRDNbKhsPAErcE+Pd0rJvq9MI5d48lma2DKBK51rRqqA
 uoi4+rKvA1ue+K1NNAZZ8K+xujIs0wdIHxZ1xzt5WYwxIrkDVQ4HkkkWmdA+g9oaqY
 RAv99w0blAHsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 9C8A6E6D402; Tue, 22 Mar 2022 18:31:51 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <YjgtIqJK0Io+zYeI@debian>
References: <YjgtIqJK0Io+zYeI@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YjgtIqJK0Io+zYeI@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.18-rc1
X-PR-Tracked-Commit-Id: a1108dcd9373a98f7018aa4310076260b8ecfc0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aab4ed5816acc0af8cce2680880419cd64982b1d
Message-Id: <164797391163.17704.7734840067307301191.pr-tracker-bot@kernel.org>
Date: Tue, 22 Mar 2022 18:31:51 +0000
To: Gao Xiang <xiang@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, lihongnan <hongnan.lhn@alibaba-inc.com>,
 Dongliang Mu <mudongliangabcd@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Mon, 21 Mar 2022 15:45:38 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aab4ed5816acc0af8cce2680880419cd64982b1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
