Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D12DAA9D
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Dec 2020 11:09:24 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CwDWP55XXzDqQJ
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Dec 2020 21:09:21 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=Ck3MXqFi; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ck3MXqFi; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CwDWH6bg1zDqNp
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Dec 2020 21:09:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608026951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=D+6s0jfbb+iw290X2QFg1tX1hHyRCtrb4U7UKAwjZ6Q=;
 b=Ck3MXqFi2Xi7xQ+YtyVKZpYsObjcvTTdGrvFQPMFZSR9cwcB0DxB4ZTeLrr0v/Byyv6UPk
 BfyaVYGzNjG2SNTGvGTYX1BcdUPxtVcVSJCjJzPuSHajTENDj+osXUcL8Q3Ccn40BbA6gD
 j75L5SOXZDDUCerK/egs1QEwer/YlOw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608026951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=D+6s0jfbb+iw290X2QFg1tX1hHyRCtrb4U7UKAwjZ6Q=;
 b=Ck3MXqFi2Xi7xQ+YtyVKZpYsObjcvTTdGrvFQPMFZSR9cwcB0DxB4ZTeLrr0v/Byyv6UPk
 BfyaVYGzNjG2SNTGvGTYX1BcdUPxtVcVSJCjJzPuSHajTENDj+osXUcL8Q3Ccn40BbA6gD
 j75L5SOXZDDUCerK/egs1QEwer/YlOw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-egMnY7KxO46V4RzrmsfFRw-1; Tue, 15 Dec 2020 05:09:09 -0500
X-MC-Unique: egMnY7KxO46V4RzrmsfFRw-1
Received: by mail-pj1-f70.google.com with SMTP id g7so6246204pji.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Dec 2020 02:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=D+6s0jfbb+iw290X2QFg1tX1hHyRCtrb4U7UKAwjZ6Q=;
 b=KOGVmQsrUhIi3+qc4asMXV1L3BRCBPDqKJbqLz7PsZ2fcIPSJNanZb0+0tHR6V06yG
 If9C0aAOEkCgTA1dYN2BibOk5d7iytv/BkeZBfGN6FdJZwYHKPkVnAgtzRawXk8CKyrs
 fXsq15i+N/Pp2CvtaxV9Vh9QXhRTw7GKW6oB63Xfiqj2FP/fDJfmsPp09y/Uc5NOqDoh
 0whVmd4H0f88nrgeDDI1y0w5ncMG3kphkz1rq45ELGNFvMD3TF9O3e/1Xzc6EiNLXZ6t
 PKHxFZhh3QnnqBaHc9NYfop/bOmg61sP52XY1FhQuBkG2vqiU9iwmbAi3Ukz5t4rsGCF
 8mxA==
X-Gm-Message-State: AOAM530cViDDaxLKAdLpvb6AOk9KxmG+5IOWjlfKvRDtwN5xgR9OGjwj
 NslhFmYAaHK1Di+xHN9QfRlbZsaPC9dnt8QuVyQ8+aSsT5TFu80cat54HtsYmPfnAKNbcuOOVAe
 8HM3PwExp/MjF0Cx5JPUnGALA
X-Received: by 2002:a17:90b:14d3:: with SMTP id
 jz19mr29645898pjb.196.1608026948331; 
 Tue, 15 Dec 2020 02:09:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJ+QJQeZhC7fWPHn8H4CTLpBoBip5gubOtmctdcTGKI/LOLgvsGcRi1coYDETI/ag/8TCvFg==
X-Received: by 2002:a17:90b:14d3:: with SMTP id
 jz19mr29645882pjb.196.1608026948125; 
 Tue, 15 Dec 2020 02:09:08 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b4sm20887252pju.33.2020.12.15.02.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Dec 2020 02:09:07 -0800 (PST)
Date: Tue, 15 Dec 2020 18:08:55 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs update for 5.11-rc1
Message-ID: <20201215100855.GA581189@xiangao.remote.csb>
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
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.11-rc1?

This cycle we'd like to get rid of magical page->mapping type marks
for temporary pages which had some concern before, now such usage
is replaced with specific page->private. Also switch to inplace I/O
instead of allocating extra cached pages to avoid direct reclaim
under low memory scenario. There are some bmap bugfix and minor
cleanups as well.

All commits have been tested and have been in linux-next for a while.
This merges cleanly with master.

[ Additionally, there is another lz4 inplace decompression fix [1] due
  to some different overlapped memcpy() implementation which was reviewed
  and added to akpm tree, hopefully upstream for this 5.11 cycle too. ]

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20201122030749.2698994-1-hsiangkao@redhat.com 

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.11-rc1

for you to fetch changes up to d8b3df8b1048405e73558b88cba2adf29490d468:

  erofs: avoid using generic_block_bmap (2020-12-10 11:07:40 +0800)

----------------------------------------------------------------
Changes since last update:

 - get rid of magical page->mapping type marks;

 - switch to inplace I/O under low memory scenario;

 - return the correct block number for bmap();

 - some minor cleanups.

----------------------------------------------------------------
Gao Xiang (4):
      erofs: get rid of magical Z_EROFS_MAPPING_STAGING
      erofs: insert to managed cache after adding to pcl
      erofs: simplify try_to_claim_pcluster()
      erofs: force inplace I/O under low memory scenario

Huang Jianan (1):
      erofs: avoid using generic_block_bmap

Vladimir Zapolskiy (1):
      erofs: remove a void EROFS_VERSION macro set in Makefile

 fs/erofs/Makefile       |   5 --
 fs/erofs/compress.h     |  54 +++++++++++----
 fs/erofs/data.c         |  26 ++------
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/zdata.c        | 172 ++++++++++++++++++++++++++++--------------------
 fs/erofs/zdata.h        |   1 +
 6 files changed, 149 insertions(+), 111 deletions(-)

