Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0F28D22B
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Oct 2020 18:24:24 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C9gq76q7QzDqZx
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Oct 2020 03:24:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=cG2Df1wR; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9gpw6B5CzDqVZ
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Oct 2020 03:24:08 +1100 (AEDT)
Subject: Re: [GIT PULL] erofs update for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602606246;
 bh=E119DNK1X8tpoZOQlm5Bj2GU5Jd2BI/tK7K8HcqbuLc=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=cG2Df1wRSNDtkKyu2RdWRzsC021nD5L065ISaOfnUZtM3IMKWx3p3OQorQVbTabCE
 fORg/jnGVtV3xZl++HDjwR0hhH+IYZ//cYPb40yUrfGOwbUsuA16XucQsUOK6SSbrF
 CR2cpXVhukriRhz2XmnUYc2XaMT8rZ3cXAFBVw3M=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20201013122846.GA12025@xiangao.remote.csb>
References: <20201013122846.GA12025@xiangao.remote.csb>
X-PR-Tracked-List-Id: Development of Linux EROFS file system
 <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20201013122846.GA12025@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.10-rc1
X-PR-Tracked-Commit-Id: 915f4c9358db6f96f08934dd683ae297aaa0fb91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfef313e999058530396497fd41399c0a637c188
Message-Id: <160260624607.24492.5030532070752989179.pr-tracker-bot@kernel.org>
Date: Tue, 13 Oct 2020 16:24:06 +0000
To: Gao Xiang <hsiangkao@redhat.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Tue, 13 Oct 2020 20:28:46 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfef313e999058530396497fd41399c0a637c188

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
