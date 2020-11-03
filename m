Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFEA2A4C3B
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 18:04:49 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQbk639lpzDqd7
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Nov 2020 04:04:46 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=HeLwgTjM; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HeLwgTjM; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQbjz0vzKzDqVs
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Nov 2020 04:04:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604423076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P6Nqd/GTymSo6mkhELu0bxwV3r/gwkmZPBYT64Awjzw=;
 b=HeLwgTjMWvS9joUSbXxBccGlOhrjx6Ozo7/Fj7AFn4UpJyx0ZwBb8RTtacfdnOCrREGPkr
 ZsThG3Ff4FWNV+2iHFeNFL7D5TOVBOisAUBp/rEL6xFt6RhtV1H1Uy1q1vVdxlvH9tGDkC
 xUP/VstOqX+yJU2RGvwlut4TXlMC50c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604423076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P6Nqd/GTymSo6mkhELu0bxwV3r/gwkmZPBYT64Awjzw=;
 b=HeLwgTjMWvS9joUSbXxBccGlOhrjx6Ozo7/Fj7AFn4UpJyx0ZwBb8RTtacfdnOCrREGPkr
 ZsThG3Ff4FWNV+2iHFeNFL7D5TOVBOisAUBp/rEL6xFt6RhtV1H1Uy1q1vVdxlvH9tGDkC
 xUP/VstOqX+yJU2RGvwlut4TXlMC50c=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-QOGTw91oMu6rHFnnY_CwCA-1; Tue, 03 Nov 2020 12:04:34 -0500
X-MC-Unique: QOGTw91oMu6rHFnnY_CwCA-1
Received: by mail-pf1-f197.google.com with SMTP id z125so12593792pfc.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 03 Nov 2020 09:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P6Nqd/GTymSo6mkhELu0bxwV3r/gwkmZPBYT64Awjzw=;
 b=UoQABK3b9YZ1oO4/7tmr0i77T0wd6HAH9xyaYXLwYZoQQMhkseKbpSReu71pDjWqL1
 kWQ90RPZgxQ86eL8LqAb7BO32s6DON9cus08Pr5sFuBYddOsMNCY5mDec2DYzKYEKIje
 TA+ZJ81v80AIZFGIAcMs6AlRYBTw3hGO1FeTloxz3F6qfoxwd4YZOf9KuJzXSI1zTiky
 JTqnhTzgu01CtjXT7VodFNhymaecd+e9J/1pVZk9xfa6Ya1ABkwl6zUxXmu/dU5Pfb08
 JTg+ebpFdojZea94qtxOPJ8Y9PypzNkTmAZTEDuUrzPRxZ61/cNhjrhFAB0hR6VKi94l
 y4ug==
X-Gm-Message-State: AOAM531CGGoFojwQ5VYGcAndWh5AiysAF8U8wiYb7YnoMVUpfqaLUMp7
 RNfntZ8UhbsSq9R8BtPhYU//CAXRGMbxg5LFwA5/a4eZoSoNfcQaFCaUWZAvuWh0mz2/AAzwIhU
 ogGncSVi9rC9XGRrB8OhNhFAf
X-Received: by 2002:a17:90a:7089:: with SMTP id g9mr160160pjk.4.1604423072874; 
 Tue, 03 Nov 2020 09:04:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKrStQIiawQJXfEFp92+BAuOv0tSVW7WzCsy3loX2ZPEWNt9Fyvdp3RWqxou54wmyvUe6r9g==
X-Received: by 2002:a17:90a:7089:: with SMTP id g9mr160141pjk.4.1604423072675; 
 Tue, 03 Nov 2020 09:04:32 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v24sm15775598pgi.91.2020.11.03.09.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:04:31 -0800 (PST)
Date: Wed, 4 Nov 2020 01:04:21 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: derive atime instead of leaving it empty
Message-ID: <20201103170421.GB886627@xiangao.remote.csb>
References: <20201031195102.21221-1-hsiangkao.ref@aol.com>
 <20201031195102.21221-1-hsiangkao@aol.com>
 <20201103025033.GA788000@xiangao.remote.csb>
 <275b73d7-9865-91c0-ecf2-bceed09a4dae@kernel.org>
MIME-Version: 1.0
In-Reply-To: <275b73d7-9865-91c0-ecf2-bceed09a4dae@kernel.org>
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
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Tue, Nov 03, 2020 at 11:58:42PM +0800, Chao Yu wrote:
> Hi Xiang,
> 
> On 2020-11-3 10:50, Gao Xiang wrote:
> > Hi Chao,
> > 
> > On Sun, Nov 01, 2020 at 03:51:02AM +0800, Gao Xiang wrote:
> > > From: Gao Xiang <hsiangkao@redhat.com>
> > > 
> > > EROFS has _only one_ ondisk timestamp (ctime is currently
> > > documented and recorded, we might also record mtime instead
> > > with a new compat feature if needed) for each extended inode
> > > since EROFS isn't mainly for archival purposes so no need to
> > > keep all timestamps on disk especially for Android scenarios
> > > due to security concerns. Also, romfs/cramfs don't have their
> > > own on-disk timestamp, and squashfs only records mtime instead.
> > > 
> > > Let's also derive access time from ondisk timestamp rather than
> > > leaving it empty, and if mtime/atime for each file are really
> > > needed for specific scenarios as well, we can also use xattrs
> > > to record them then.
> > > 
> > > Reported-by: nl6720 <nl6720@gmail.com>
> > > [ Gao Xiang: It'd be better to backport for user-friendly concern. ]
> > > Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> > > Cc: stable <stable@vger.kernel.org> # 4.19+
> > > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > 
> > May I ask for some extra free slots to review this patch plus
> > [PATCH 1/4] of
> > https://lore.kernel.org/r/20201022145724.27284-1-hsiangkao@aol.com
> > 
> > since it'd be also in linux-next for a while before sending out
> > to Linus. And the debugging messages may also be an annoying
> > thing for users.
> 
> Sorry for the delay review, will check the details tomorrow. :)

No problem, thanks! If we'd like to submit a -fixes pull request,
it'd be better not to be in the latter half of 5.10 rc... And
considering that it'd be stayed in linux-next for almost a week,
so yeah... (Only these 2 patches are considered for -fixes for now.)

Thanks.
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks a lot!
> > 
> > Thanks,
> > Gao Xiang
> > 
> 

