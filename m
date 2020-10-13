Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BB52628CE54
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Oct 2020 14:29:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C9Zbt28CTzDqY7
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Oct 2020 23:29:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DOuWIowR; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DOuWIowR; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9Zbj6phwzDqW7
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Oct 2020 23:29:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602592142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WGXCaU67FieVgGooevqAzXyML/TMiyX7cvaxSfDQ0OM=;
 b=DOuWIowRX01wVa4DuX/rtBam++pUJohq1NVDCh1QZevrqYCTmIZRwI4JmdCRCOHjFLnLVN
 LwkRqIWlIjpYjl4hUCQKhK4+9oRJF+JIvJ4YkPShZ+mTWSMUA4RwCG0OT3NoWLDf9Ro9Sh
 flUs0ptwqsvNAy2yJwWhNW4NMumnnys=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602592142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WGXCaU67FieVgGooevqAzXyML/TMiyX7cvaxSfDQ0OM=;
 b=DOuWIowRX01wVa4DuX/rtBam++pUJohq1NVDCh1QZevrqYCTmIZRwI4JmdCRCOHjFLnLVN
 LwkRqIWlIjpYjl4hUCQKhK4+9oRJF+JIvJ4YkPShZ+mTWSMUA4RwCG0OT3NoWLDf9Ro9Sh
 flUs0ptwqsvNAy2yJwWhNW4NMumnnys=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584--2CfDyBsOLmZqS7l_UQRaA-1; Tue, 13 Oct 2020 08:29:00 -0400
X-MC-Unique: -2CfDyBsOLmZqS7l_UQRaA-1
Received: by mail-pj1-f71.google.com with SMTP id p4so472143pjm.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Oct 2020 05:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=WGXCaU67FieVgGooevqAzXyML/TMiyX7cvaxSfDQ0OM=;
 b=D8t7EgHhDurdpmOOMgkvvvY7G8+kfAbs28SaDo3YKJLujnyjked2A/eGCPXW/Xyrgp
 RH/YORSddgg4wjq4OieZdxhEGeTchQEJ6DQYgVYiQec65RaQEWseX4VCcUbItCDthgnH
 HWM2478+79k/EopPTBI0xvICrc704L+p3/RwEfACQ06sfYByysup97K3pLmuhzfe/t4H
 ySZSt6PtCmcS7h4gq+t5NB5UonG58NDV4Loq5GYoJs4LJr8H4WQS8Sst1xBaZcRpoW4k
 uZSQjIkm0WR0piaJhaCqF8+fwZ3EYd5XUJ4+UIF9i8MxdXyI/qNbU9UewyNxbdBxBhfO
 Pjnw==
X-Gm-Message-State: AOAM532YbVNJey9pgV5JqyjL2prZxfbrmOiKdiZ/hHqxFcFG2bc65FH8
 kt0eW99vjcCViFZ/muekUgydtaTfI1HTTk6lURzVVNQuWCYgRrrVGawAvBZqM6XorsEN7EgAy/z
 K/tJ+R1EQchwDMOlWo7vRlWRK
X-Received: by 2002:a17:902:8b86:b029:d4:c98b:c314 with SMTP id
 ay6-20020a1709028b86b02900d4c98bc314mr15646394plb.48.1602592139267; 
 Tue, 13 Oct 2020 05:28:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUcl6wtJ7HnOp/yr+4xV7u2SG+7tIFyYatx49CXeVv7QLxSDU47ZqAF6powlDSDzvZ4PjcpA==
X-Received: by 2002:a17:902:8b86:b029:d4:c98b:c314 with SMTP id
 ay6-20020a1709028b86b02900d4c98bc314mr15646365plb.48.1602592138943; 
 Tue, 13 Oct 2020 05:28:58 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 17sm17568228pgv.58.2020.10.13.05.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 05:28:58 -0700 (PDT)
Date: Tue, 13 Oct 2020 20:28:46 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs update for 5.10-rc1
Message-ID: <20201013122846.GA12025@xiangao.remote.csb>
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

Could you consider this pull request for 5.10-rc1?

This cycle addresses a reported permission issue with overlay
due to a duplicated permission check for "trusted." xattrs.
Also, a REQ_RAHEAD flag is added now to all readahead requests
in order to trace readahead I/Os. The others are random cleanups.

All commits have been tested and have been in linux-next as well.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc1

for you to fetch changes up to 915f4c9358db6f96f08934dd683ae297aaa0fb91:

  erofs: remove unnecessary enum entries (2020-10-09 10:37:42 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix an issue which can cause overlay permission problem
   due to duplicated permission check for "trusted." xattrs;

 - add REQ_RAHEAD flag to readahead requests for blktrace;

 - several random cleanup.

----------------------------------------------------------------
Chao Yu (1):
      erofs: remove unneeded parameter

Chengguang Xu (1):
      erofs: remove unnecessary enum entries

Gao Xiang (4):
      erofs: avoid duplicated permission check for "trusted." xattrs
      erofs: avoid unnecessary variable `err'
      erofs: fold in should_decompress_synchronously()
      erofs: add REQ_RAHEAD flag to readahead requests

 fs/erofs/data.c  |  2 +-
 fs/erofs/super.c |  2 --
 fs/erofs/xattr.c |  2 --
 fs/erofs/zdata.c | 48 +++++++++++++++++++++---------------------------
 4 files changed, 22 insertions(+), 32 deletions(-)

