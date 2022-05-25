Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C68533535
	for <lists+linux-erofs@lfdr.de>; Wed, 25 May 2022 04:16:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L7F7J3Ykfz3bcW
	for <lists+linux-erofs@lfdr.de>; Wed, 25 May 2022 12:16:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=alj8u9u4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=alj8u9u4; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L7F7922mZz300K
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 May 2022 12:16:37 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 95DFC614EE;
 Wed, 25 May 2022 02:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3C38C34100;
 Wed, 25 May 2022 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653444993;
 bh=q5F9s2pdE+K4CCyB8i32EvzHkMHwEzfkGQR8P31j2sQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=alj8u9u4ZWKbTxntXrENDQkfXmBzMsxsYLB3kPAuUY+ukKj6g/HoILhkEDzifpDE8
 +qMyVUDvGNnnfnHHeD6L+7rLAXVSFnxofWmxT+EtUNcS0LkpMLqb6O2Xskv3MU/TjZ
 KZdkESQCiRiYi1azI732z9M5bZlbS5FoD1PJIs99Q0J+y1TRgAae8hDG7lKd5ijCXD
 qobKjJ5dVhp8ljYjgy//P6MCFYMW3GbFtpHWAiExP53chdBoqZWjUY5X9YlS82YZG3
 UQjuB0PXXWj+3lOaOmmudt+BwAszcW+5FfsC1Tc1DOU2qUyC006XwXRWJrP7KJ488Z
 5pt0IwKb0ODZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D0D91F03938; Wed, 25 May 2022 02:16:32 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.19-rc1 (fscache part inclusive)
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yoj1AcHoBPqir++H@debian>
References: <Yoj1AcHoBPqir++H@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yoj1AcHoBPqir++H@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.19-rc1
X-PR-Tracked-Commit-Id: ba73eadd23d1c2dc5c8dc0c0ae2eeca2b9b709a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65965d9530b0c320759cd18a9a5975fb2e098462
Message-Id: <165344499284.22339.1005839809480771514.pr-tracker-bot@kernel.org>
Date: Wed, 25 May 2022 02:16:32 +0000
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
Cc: tianzichen@kuaishou.com, Yan Song <yansong.ys@antgroup.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 zhangjiachen.jaycee@bytedance.com, Zefan Li <lizefan.x@bytedance.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Tao Ma <boyu.mt@taobao.com>, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, Xin Yin <yinxin.x@bytedance.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The pull request you sent on Sat, 21 May 2022 22:19:45 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65965d9530b0c320759cd18a9a5975fb2e098462

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
