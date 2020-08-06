Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1523D5B9
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Aug 2020 05:20:51 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMYfR5K77zDqg5
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Aug 2020 13:20:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Nzih4P64; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IGBTTK/D; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMYfJ730dzDqX3
 for <linux-erofs@lists.ozlabs.org>; Thu,  6 Aug 2020 13:20:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596684033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fv3CnjYaDNIHTU7CqIhzqNedLZ06zeIgR5EU/DfXL/4=;
 b=Nzih4P649zzpRxPtPTvJdzvoNQiLekAjg3/Z107wWP1/Z/3+xaNUOqL24fo9F2YehY1KDC
 79/0+iT78jnF2Pwg7PZX6N+80o9nXCWyWnYR4z9TcCPE+fXIoeghAlRF/itoaSxV/p0N3M
 9TyCgr2fu9kAXdnW4eEp+Id24fp+1vo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596684034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fv3CnjYaDNIHTU7CqIhzqNedLZ06zeIgR5EU/DfXL/4=;
 b=IGBTTK/DrkFR11gKpVCq0nUDkRD3T4NFsSI5CgEt/HiyoA2jXv5GV7GidZtKdGDmhAJE/1
 jFsQ4a2qZyJmBY+nc8ow5bawy5BbPda9DI4vOvcD5v4NnmJfpuoGdr6AwBNpsErum4U9zE
 KZhj81Gq6bsJ2QhOF2VvFZZsVQjkiPE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-ftpw6Eo0MrCrTsYg9P1Byg-1; Wed, 05 Aug 2020 23:20:31 -0400
X-MC-Unique: ftpw6Eo0MrCrTsYg9P1Byg-1
Received: by mail-pl1-f197.google.com with SMTP id w9so10135843ply.14
 for <linux-erofs@lists.ozlabs.org>; Wed, 05 Aug 2020 20:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=fv3CnjYaDNIHTU7CqIhzqNedLZ06zeIgR5EU/DfXL/4=;
 b=mEZTC9JfcS2Le8BpcdJ7c+UwjVvsjbwWizf7auRzxDnW985wIjZ+xKiNyQuGVBPXTK
 BId4V4YEsynAdc/FZthYYzO9PUbZeUDnnUhfI+gDiX5v0qFwv45rx19Lo2U7oV5TxQGq
 B2dYtDx3AZyxamGqWabsbCACeMM9z3uSc5ugwfXQsANRyc+C51Fksa6iA/OH8h1l2md4
 KfMItNg8ubQSRwt8zOjuM5/vc/MXJw18tTnIRM1+oNKuIi+2tCBBw9qHTGFF+NYSq8T+
 9yqzlD8i8bhueF3mTWseDsJ3wsW0awYMrHjtRb/lOL9MUp1iVkFk+7gwkP+RTq8hrDIn
 vYrw==
X-Gm-Message-State: AOAM533t7qSG8VvJ0XuTOWvqov6ZP0dPwUxq1HLZspArvcRJ/EswTtat
 rFTUGeDNfs3v8rhNkQ3D1Zjs+pl1cuu9OyIoyIxnMiCKV9ohoDWsqGBg6C9f+N0PK/esBX91nIz
 nCsVloXSMxvYcbv4usOJzzBAD
X-Received: by 2002:a17:90a:6d26:: with SMTP id
 z35mr6170207pjj.164.1596684030850; 
 Wed, 05 Aug 2020 20:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1dO1CoIriHlooHe7iPiLtnA9/a4o5ehfwXRyowc0cEPLGbBaMduX4YaDzusso9AlMTbBwLw==
X-Received: by 2002:a17:90a:6d26:: with SMTP id
 z35mr6170176pjj.164.1596684030608; 
 Wed, 05 Aug 2020 20:20:30 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g4sm4971772pgn.64.2020.08.05.20.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 20:20:29 -0700 (PDT)
Date: Thu, 6 Aug 2020 11:20:17 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.9-rc1
Message-ID: <20200806032017.GA4442@xiangao.remote.csb>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.9-rc1?

This cycle mainly addresses an issue out of some extended inode with
designated location, which can hardly be generated by current mkfs but
needs to handle at runtime anyway. The others are quite trivial ones.

All commits have been tested and have been in linux-next as well.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.9-rc1

for you to fetch changes up to 0e62ea33ac12ebde876b67eca113630805191a66:

  erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's (2020-08-03 21:04:46 +0800)

----------------------------------------------------------------
Changes since last update:

 - use HTTPS links instead of insecure HTTP ones;

 - fix crossing page boundary on specific extended inodes;

 - remove useless WQ_CPU_INTENSIVE flag for unbound wq;

 - minor cleanup.

----------------------------------------------------------------
Alexander A. Klimov (1):
      erofs: Replace HTTP links with HTTPS ones

Gao Xiang (3):
      erofs: fix extended inode could cross boundary
      erofs: fold in used-once helper erofs_workgroup_unfreeze_final()
      erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's

 fs/erofs/compress.h     |   2 +-
 fs/erofs/data.c         |   2 +-
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/dir.c          |   2 +-
 fs/erofs/erofs_fs.h     |   2 +-
 fs/erofs/inode.c        | 123 +++++++++++++++++++++++++++++++-----------------
 fs/erofs/internal.h     |   2 +-
 fs/erofs/namei.c        |   2 +-
 fs/erofs/super.c        |   2 +-
 fs/erofs/utils.c        |  16 ++-----
 fs/erofs/xattr.c        |   2 +-
 fs/erofs/xattr.h        |   2 +-
 fs/erofs/zdata.c        |   6 +--
 fs/erofs/zdata.h        |   2 +-
 fs/erofs/zmap.c         |   2 +-
 fs/erofs/zpvec.h        |   2 +-
 16 files changed, 100 insertions(+), 71 deletions(-)

