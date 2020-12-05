Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C72CFAD8
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 10:35:07 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp4DR6nx9zDqjR
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 20:35:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YHNC7ZrA; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YHNC7ZrA; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp4DM37R9zDqgZ
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 20:34:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607160895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2EoFPWLxbrLhQT9Q8II3FIVUuHvIE1LSA4Ep9h+4JA=;
 b=YHNC7ZrA0u5Ru91vgTi2wwQWAvRTtVCJqaSmsWDeOTinEaqRjRrF0rn8npttz2scWRwfCQ
 lq0CUysz0N+gxc3M7Ljmf0Uk1fUAyJx5VlfkVjD11PIGAm9fSc70r33/B5HgVma/2e5URd
 tKg9GMswSOPRLqMoOnlSeXGnomR/bq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607160895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2EoFPWLxbrLhQT9Q8II3FIVUuHvIE1LSA4Ep9h+4JA=;
 b=YHNC7ZrA0u5Ru91vgTi2wwQWAvRTtVCJqaSmsWDeOTinEaqRjRrF0rn8npttz2scWRwfCQ
 lq0CUysz0N+gxc3M7Ljmf0Uk1fUAyJx5VlfkVjD11PIGAm9fSc70r33/B5HgVma/2e5URd
 tKg9GMswSOPRLqMoOnlSeXGnomR/bq0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-07-q0tK1PEqKllr5MCUjDw-1; Sat, 05 Dec 2020 04:34:51 -0500
X-MC-Unique: 07-q0tK1PEqKllr5MCUjDw-1
Received: by mail-pg1-f198.google.com with SMTP id 1so5063959pgq.11
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Dec 2020 01:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K2EoFPWLxbrLhQT9Q8II3FIVUuHvIE1LSA4Ep9h+4JA=;
 b=YnIBkfNND9H4smeCSmTi31A1ykb8s2O9RLmZE2e4bsP9Cdd4ScH8eXrAEoCxbvUoT8
 fNpslPQ7Hu5/6E8nziziOI8qPvoCr12BMS1i5qnow+QekJzhaMmugM8MHSuotJxSEplK
 ZFnv8YzINBuWd7C/RyyILDrMzNRwZT6yGhfcBz2eTBTBkB85IdIVWjB/N3ZNT8nNnBG+
 D+eHElS9H4lbXnd3lFrSG/WvCUKjjkcbct5wjMr1diEjp3VN0nVlWpX089FtNryiSn95
 W+g8HGsHoEI/epco+rgif5baHT/BO6DDgpJBbgHEKu5g66dWgJ940jyO5tlYOIiZceeH
 ZW1g==
X-Gm-Message-State: AOAM533EsM32XlTJLngcpZ+E9w49VnNibak0rD3G1EWKBuc5k25ii0jq
 aKSJyauybDHflXOv5a6yct/p9th30Eg5xtwV8CXAo/H3xsfWW9TQ7DDiOvfaWrV1efe2dchYcoV
 VbWkQxEU0+wjiPNd0WcqW6YoY
X-Received: by 2002:a65:418c:: with SMTP id a12mr10935915pgq.357.1607160890442; 
 Sat, 05 Dec 2020 01:34:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+9l9yE2sHCv08uLjG+PVwRJjL/fcM5hDnzltqFJaZGkuVjjCYh7y7PXrBAtLF2d/QTob8rg==
X-Received: by 2002:a65:418c:: with SMTP id a12mr10935897pgq.357.1607160890194; 
 Sat, 05 Dec 2020 01:34:50 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id fv22sm4731312pjb.14.2020.12.05.01.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Dec 2020 01:34:49 -0800 (PST)
Date: Sat, 5 Dec 2020 17:34:39 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v2] erofs-utils: update i_nlink stat for directories
Message-ID: <20201205093439.GE2333547@xiangao.remote.csb>
References: <20201205091637.8944-1-hsiangkao.ref@aol.com>
 <20201205091637.8944-1-hsiangkao@aol.com>
 <a289b333-c1ef-02f2-9897-c69061053409@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <a289b333-c1ef-02f2-9897-c69061053409@aliyun.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Sat, Dec 05, 2020 at 05:22:13PM +0800, Li GuiFu via Linux-erofs wrote:
> 
> 
> On 2020/12/5 17:16, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@aol.com>
> > 
> > Previously, nlink of directories was treated as 1 for simplicity.
> > 
> > Since st_nlink for dirs is actually not well defined, nlink=1 seems
> > to pacify `find' (even without -noleaf option) and other utilities.
> > AFAICT, isofs, romfs and cramfs always set it to 1, Overlayfs sets
> > it to 1 conditionally, btrfs[1], ceph[2] and FUSE client historically
> > set it to 1.
> > 
> > The convention under unix is that it's # of subdirs including "."
> > and "..". This patch tries to follow such convention if possible to
> > optimize `find' performance since it's not quite hard for local fs.
> > 
> > [1] https://lore.kernel.org/r/20100124003336.GP23006@think
> > [2] https://lore.kernel.org/r/20180521092729.17470-1-lhenriques@suse.com
> > Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> > ---
> > v1: https://lore.kernel.org/r/20201205055732.14276-1-hsiangkao@aol.com
> > changes since v1:
> >  - update a DBG_BUGON statement suggestted by Guifu.
> > 
> >  lib/inode.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> > 
> 
> It looks good
> Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks for the review. I've applied all pending patches from experimental
to dev branch. Tonight, I'll update README for erofsfuse (if you have time,
kindly review it then, but I think I'm not going to wait for a long time)
and will release erofs-utils v1.2 this weekend since we already have many
commits and the release period has been somewhat longer than v1.0 ~ v1.1.

Thanks,
Gao Xiang


> Thanks,
> 

