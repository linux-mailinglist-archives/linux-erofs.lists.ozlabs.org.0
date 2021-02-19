Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9E31F888
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Feb 2021 12:43:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DhqT85YB5z30Qp
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Feb 2021 22:43:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GBwg8YmP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GBwg8YmP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=GBwg8YmP; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GBwg8YmP; 
 dkim-atps=neutral
X-Greylist: delayed 356 seconds by postgrey-1.36 at boromir;
 Fri, 19 Feb 2021 22:43:05 AEDT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DhqT55ZvXz30QR
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Feb 2021 22:43:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613734982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=xn1ULpHqjYib2erd8HgDp+bnvgqHCYqsU53nsfSrm1E=;
 b=GBwg8YmP8/Nikl0vVMICmrzVYruwIEamHbfOEtdD1Q7rrdzc5rQ3UFYFSBJfhMkYbUwug8
 TqBy8B1ElVnD6xTLPneh+DnyFb0cfmZiMzCjpMSdAxuDs9K9CN+qwM+j9VkfbIlRrHZ0kh
 TuDLtUi+IqXLoZ67QW4vbILYtHc+/a0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613734982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=xn1ULpHqjYib2erd8HgDp+bnvgqHCYqsU53nsfSrm1E=;
 b=GBwg8YmP8/Nikl0vVMICmrzVYruwIEamHbfOEtdD1Q7rrdzc5rQ3UFYFSBJfhMkYbUwug8
 TqBy8B1ElVnD6xTLPneh+DnyFb0cfmZiMzCjpMSdAxuDs9K9CN+qwM+j9VkfbIlRrHZ0kh
 TuDLtUi+IqXLoZ67QW4vbILYtHc+/a0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-28r82gq2OF2O_PVFuo7rXg-1; Fri, 19 Feb 2021 06:35:52 -0500
X-MC-Unique: 28r82gq2OF2O_PVFuo7rXg-1
Received: by mail-pg1-f200.google.com with SMTP id c30so3408672pgl.15
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Feb 2021 03:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=xn1ULpHqjYib2erd8HgDp+bnvgqHCYqsU53nsfSrm1E=;
 b=ohfBr5JVBogA9g7kQytdt4OJah97bNzN7yjAycDl04SBKmxMPcb752iW0KYEYIaJ0E
 YiVpO/M9kL7NowHSVbbaFc9B0L+goQMS2VeFmwZfhiPbpLN24LBuA+HUBpG05xHjaoTS
 7S3OGGLXPb3r899GNsqD/taVkfR/8/EQn/KskbLPRlVM2kUMchr1Y4jKYwZegSUxbtLR
 Ip3qyrFX+mt5bSOUI7av6uM4nBLhiS4ywKwz1XN9z0MVeVSH3A+1vkYexdxKUxiQFcvh
 3hZSBZ+ud5e0NcaHecCrhl75oWt0V4UlM7OA7EtrZ0CQiX5bMrnliIuKNQ/NIlGFgbDv
 Ti4w==
X-Gm-Message-State: AOAM532WJGG/eRm13tX7LPNOO1iOKjBCZ4f6N8AwxfZiBAcuGRw/eSnK
 NlsgCn7zaw/VPsSu9xNMtpjZBxTEOKyQJqXi9ZzIoMMVrBl6Qf0drhhS8JMW6Wfc2H5S3NFAH+9
 OjCM7+7JI7dV+Uai6ESBNj86X
X-Received: by 2002:a62:7a0b:0:b029:1de:7e70:955d with SMTP id
 v11-20020a627a0b0000b02901de7e70955dmr1552755pfc.49.1613734551605; 
 Fri, 19 Feb 2021 03:35:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJ4N/87dUKkv79oaKb1TdgD+7zCbqUbQNPc48eJdnHyHp82QLrzhF66Kh7W0cIjvCa2LqetQ==
X-Received: by 2002:a62:7a0b:0:b029:1de:7e70:955d with SMTP id
 v11-20020a627a0b0000b02901de7e70955dmr1552727pfc.49.1613734551296; 
 Fri, 19 Feb 2021 03:35:51 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ke13sm8360941pjb.44.2021.02.19.03.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Feb 2021 03:35:50 -0800 (PST)
Date: Fri, 19 Feb 2021 19:35:37 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs update for 5.12-rc1
Message-ID: <20210219113537.GA492321@xiangao.remote.csb>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Guo Weichao <guoweichao@oppo.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.12-rc1?

This contains a somewhat important but rarely reproduced fix
reported month ago for platforms which have weak memory model
(e.g. arm64). The root cause is that test_bit/set_bit atomic
operations are actually implemented in relaxed forms, and
uninitialized fields governed by an atomic bit could be observed
in advance due to memory reordering thus memory barrier pairs
should be used. There is also a trivial fix of crafted blkszbits
generated by syzkaller.

All commits have been tested and have been in linux-next for
more than a week. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc1

for you to fetch changes up to ce063129181312f8781a047a50be439c5859747b:

  erofs: initialized fields can only be observed after bit is set (2021-02-11 11:55:28 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix shift-out-of-bounds of crafted blkszbits generated by syzkaller;

 - ensure initialized fields can only be observed after bit is set.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix shift-out-of-bounds of blkszbits
      erofs: initialized fields can only be observed after bit is set

 fs/erofs/super.c |  4 ++--
 fs/erofs/xattr.c | 10 +++++++++-
 fs/erofs/zmap.c  | 10 +++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

