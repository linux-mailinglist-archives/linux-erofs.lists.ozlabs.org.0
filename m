Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 518472ABEE7
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Nov 2020 15:41:08 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CVDFY1CPzzDqfJ
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Nov 2020 01:41:05 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=D7D2BS+k; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7D2BS+k; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CVDF949pMzDqcW
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 Nov 2020 01:40:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604932841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=I/Q1jINkP3Xtm3EvEAfNeb/q7P7VJGLtTGjJrvhjYXs=;
 b=D7D2BS+kZnvTIbYQ011nHvIPoxzcbkU6eR2thfxjCTlIn1faNxGBwf8lC1RsJYy1J/thSQ
 cfctSom0tsEMAYHuKU6FeazKtfAG/vijna1UKCZccMLW198dBnsCS7NJYZL2Bs+tCt1ddr
 vSWAJW4cXGDPBfFyFH1CnpRDI/vtnTA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604932841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=I/Q1jINkP3Xtm3EvEAfNeb/q7P7VJGLtTGjJrvhjYXs=;
 b=D7D2BS+kZnvTIbYQ011nHvIPoxzcbkU6eR2thfxjCTlIn1faNxGBwf8lC1RsJYy1J/thSQ
 cfctSom0tsEMAYHuKU6FeazKtfAG/vijna1UKCZccMLW198dBnsCS7NJYZL2Bs+tCt1ddr
 vSWAJW4cXGDPBfFyFH1CnpRDI/vtnTA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-cD5ql1UfPpmi23_wvwtsiA-1; Mon, 09 Nov 2020 09:40:38 -0500
X-MC-Unique: cD5ql1UfPpmi23_wvwtsiA-1
Received: by mail-pg1-f199.google.com with SMTP id j13so6527671pgp.11
 for <linux-erofs@lists.ozlabs.org>; Mon, 09 Nov 2020 06:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=I/Q1jINkP3Xtm3EvEAfNeb/q7P7VJGLtTGjJrvhjYXs=;
 b=RoB9vFu7/AUpNlxrTvFcalR/+o0p+w/UUIW6S3zLxbF42Jsy04zXzilRaeh3tQv8mO
 KgqdusBM9yihm1Lz+f2wfWkgMjJrcOrpqy3g3BvLG53GR56+lxAwoWCfmkG2aQ3ns879
 J7X1p3WriFrLwxslfqE/uAGp7HDlY6ur/OBmFbvMFx+f0EjHlW7Rkrv70Zy7sQCW/DFk
 0jurGkzfZTA/Bj2C53RNGQGNzr/2xd0ygA9a3dJip0sQU8DOYhvC+Nlcs2h6nyY4o6/k
 seIJz8Dz9H20fUG9xet8VyooZGUkpTM9Gqo8H3vhNsKnV1ZrBcfmOETvLbC8/ONCebd1
 /ymg==
X-Gm-Message-State: AOAM530CiLZ8a8tvNRpvVyyNSlCvQ3Mss3NWZ7MnawnCTBcK4KcpBYiP
 dCyjYZQu1K6h85C/Pd6PprmIw8hefILF81htN7u5DNcQ6sF6nNvs4Hxan4j/DXlcQzPtATVkpfM
 iv0+tvgsMPFKN5lg5+Lx1+qdm
X-Received: by 2002:a17:902:82c8:b029:d6:b42f:ce7a with SMTP id
 u8-20020a17090282c8b02900d6b42fce7amr12700021plz.23.1604932836415; 
 Mon, 09 Nov 2020 06:40:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgapOqkxKFrpo7nLldnvouaKn24P8F3ngFyqamK2WaakqTMfsV3ADaacKnD779TOHnd/Cwaw==
X-Received: by 2002:a17:902:82c8:b029:d6:b42f:ce7a with SMTP id
 u8-20020a17090282c8b02900d6b42fce7amr12699999plz.23.1604932836129; 
 Mon, 09 Nov 2020 06:40:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b6sm9899704pgq.58.2020.11.09.06.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 06:40:35 -0800 (PST)
Date: Mon, 9 Nov 2020 22:40:23 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.10-rc4
Message-ID: <20201109144023.GA2232414@xiangao.remote.csb>
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
Cc: nl6720 <nl6720@gmail.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <vladimir@tuxera.com>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider these 2 bugfixes for 5.10?

A week ago, Vladimir reported an issue that the kernel log
would become polluted if the page allocation debug option is
enabled. I also found this when I cleaned up magical page->mapping
and originally planned to submit these all for 5.11 but it
seems the impact can be noticed so submit the fix in advance.

In addition, nl6720 also reported that atime is empty although
EROFS has the only one on-disk timestamp as a practical
consideration for now but it's better to derive it as what
we did for the other timestamps.

All commits have been tested and have been in linux-next for
almost a week as well. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc4-fixes

for you to fetch changes up to a30573b3cdc77b8533d004ece1ea7c0146b437a0:

  erofs: fix setting up pcluster for temporary pages (2020-11-04 09:15:48 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix setting up pcluster improperly for temporary pages;

 - derive atime instead of leaving it empty.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: derive atime instead of leaving it empty
      erofs: fix setting up pcluster for temporary pages

 fs/erofs/inode.c | 21 +++++++++++----------
 fs/erofs/zdata.c |  7 +++++--
 2 files changed, 16 insertions(+), 12 deletions(-)

