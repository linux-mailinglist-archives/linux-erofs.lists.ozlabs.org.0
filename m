Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D94204CA85C
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 15:44:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7xhK6zFPz3bs5
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 01:44:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Py8eyPMi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Py8eyPMi; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7xhC44w8z3bpY
 for <linux-erofs@lists.ozlabs.org>; Thu,  3 Mar 2022 01:43:55 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 66561B81FF1;
 Wed,  2 Mar 2022 14:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C6BC340F1;
 Wed,  2 Mar 2022 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646232231;
 bh=nhXXBu0cF26IikhGW2po8nwE/w5P96Wega5gfKm7YOA=;
 h=Date:From:To:Cc:Subject:From;
 b=Py8eyPMi0Wm4CGiB2MKL+k90uui5vlOSEdCFxzxbywpMz+us1a2rZBE6YMXBO8ZwR
 TPitOwvYSpRrGKgkXSC5xw2iEHiZOo5trPq9XGIqIL2z8vu8UIAVf0GEKyc3TXQ2RK
 8JbyEt99+CMo3tcytUcWRNgvCw/+ri7bkLxZVE2icKzwKbY5QiIOvALtnbSZT6TnKV
 HJx0TiVDHCJep9ltAM6GaE0zsMe1vE6YSsdGHVX2xwwT8qMeXeDmCc497y9mRMTpDS
 kK2KDPgher4woqro+R9ujI6wM8r3Ze9krSHsUqBLDoaKt2sCeQXhQZjWU/BP3uLBp1
 uJ/r3XqCiFaTA==
Date: Wed, 2 Mar 2022 22:41:14 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fix for 5.17-rc7
Message-ID: <Yh+CCr04nTTappWl@hsiangkao-PC>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.17-rc7?

It's a one-line patch to fix the new ztailpacking feature on > 4GiB
filesystems because z_idataoff can get trimmed improperly.

Even if ztailpacking is still a brand new EXPERIMENTAL feature, it'd
be better to fix the issue as soon as possible to avoid backporting
unnecessary..

The original patch has been in linux-next for a week and no merge
conflicts. Except that I added a new RVB tag from Chao today.

Thanks,
Gao Xiang

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc7-fixes

for you to fetch changes up to 22ba5e99b96f1c0dbdfa4f4e1d9751b4c8348541:

  erofs: fix ztailpacking on > 4GiB filesystems (2022-03-02 21:58:45 +0800)

----------------------------------------------------------------
Change since last update:

 - Fix ztailpacking z_idataoff getting trimmed on > 4GiB filesystems.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix ztailpacking on > 4GiB filesystems

 fs/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
