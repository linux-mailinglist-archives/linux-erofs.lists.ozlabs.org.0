Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A51EC69F
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jun 2020 03:22:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cB3160ZHzDqQl
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jun 2020 11:22:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.61;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Yp3JofzX; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yp3JofzX; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cB2v0WWVzDqNy
 for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jun 2020 11:21:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591147313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=XdDMefqXtQvKSOdzOeB1WlYYzqhxoSpy5ZSfBxK1NQg=;
 b=Yp3JofzX3apEr6yGC7T+536eaX32sYTranhsaNPenlXSer4NTuqk7ro/VtLIPrQQ3iQx7Z
 b2EzCkrJ6iGScaROKNuCJpyZULgdH04GWCykkxGc+75YEAsugF1CvKjJSRLkgSJ6brYxXO
 pC2LbIeYMSKEDpTZG+hAkWBWs0aOdpY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591147313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=XdDMefqXtQvKSOdzOeB1WlYYzqhxoSpy5ZSfBxK1NQg=;
 b=Yp3JofzX3apEr6yGC7T+536eaX32sYTranhsaNPenlXSer4NTuqk7ro/VtLIPrQQ3iQx7Z
 b2EzCkrJ6iGScaROKNuCJpyZULgdH04GWCykkxGc+75YEAsugF1CvKjJSRLkgSJ6brYxXO
 pC2LbIeYMSKEDpTZG+hAkWBWs0aOdpY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-wD7N73qoPE22xqH5ycxHTQ-1; Tue, 02 Jun 2020 21:21:51 -0400
X-MC-Unique: wD7N73qoPE22xqH5ycxHTQ-1
Received: by mail-pl1-f198.google.com with SMTP id p19so361272pli.23
 for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jun 2020 18:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=XdDMefqXtQvKSOdzOeB1WlYYzqhxoSpy5ZSfBxK1NQg=;
 b=OomojDHjXxcifQHTK/7qp3LN5Zi5f/ytyqJ9qRqiNbyt44fOlJ7NZLxgzWPiCO1tWj
 +PRTQfRvXjL6pgqiOLZnl5B2Ksgbbtgw7iljuLtI0aTXeKifMEIN3Pax1Vc+4e6X//md
 Z32dpV2rlssdOvkhzS5rjGkkTFLhA907y7MF5dDAX3ifd52WxODe76kiiHOL5Y8sru2V
 vy7kGXmkv+sujLyBFtixvqETR4ip5+JB32+Tp+qR8ORjeRrfr1U//LjBlffH+btVoiSv
 ftGc/zFNiFfXukhnKUngGhrLCZF0MCMM7ZHlTUGwzG0bjQHxHXHmk3OPkRtYFkGFqW76
 79qQ==
X-Gm-Message-State: AOAM531tiJIpad3yaHbYoeWvsHZ4MSCZKtZllhpGLyY0jSBIhGjbKe7W
 FpzjuOSxLQIVTf+8tBZV2JsQ3gL02UpPOBL8xoaTTiT9Fqu8zCb9A78JEaZ6OmiXgcKQ/rtsjcZ
 a0VVD7U+6MGIIWBI56Ft8Z6eZ
X-Received: by 2002:a17:90a:e42:: with SMTP id p2mr2386126pja.53.1591147310045; 
 Tue, 02 Jun 2020 18:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPMydSMfAwxsz807LOdY6kxveiF7ybQspwnpgsWBnQQbndEvdOz0VtdnW7wZHgW/WYK+7fIQ==
X-Received: by 2002:a17:90a:e42:: with SMTP id p2mr2386097pja.53.1591147309784; 
 Tue, 02 Jun 2020 18:21:49 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j7sm292288pfh.154.2020.06.02.18.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:21:49 -0700 (PDT)
Date: Wed, 3 Jun 2020 09:21:37 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.8-rc1
Message-ID: <20200603012137.GA12304@xiangao.remote.csb>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.8-rc1?

The most outstanding part is the new mount api conversion, which is
actually a old patch already pending for several cycles. And the others
are recent trivial cleanups here.

All commits have been tested and have been in linux-next as well.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.8-rc1

for you to fetch changes up to 34f853b849eb6a509eb8f40f2f5946ebb1f62739:

  erofs: suppress false positive last_block warning (2020-05-29 18:58:13 +0800)

----------------------------------------------------------------
Changes since last update:

 - Convert to use the new mount apis;

 - Some random cleanup patches.

----------------------------------------------------------------
Chao Yu (1):
      erofs: convert to use the new mount fs_context api

Chengguang Xu (1):
      erofs: code cleanup by removing ifdef macro surrounding

Gao Xiang (1):
      erofs: suppress false positive last_block warning

 fs/erofs/data.c     |   4 +-
 fs/erofs/inode.c    |   6 --
 fs/erofs/internal.h |  27 +++---
 fs/erofs/namei.c    |   2 -
 fs/erofs/super.c    | 255 +++++++++++++++++++++++-----------------------------
 fs/erofs/xattr.c    |   4 +-
 fs/erofs/xattr.h    |   7 +-
 fs/erofs/zdata.c    |   4 +-
 8 files changed, 136 insertions(+), 173 deletions(-)

