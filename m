Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 485BE2FA252
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 14:59:53 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKD1c39JpzDqnT
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 00:59:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=c1tAf+hr; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c1tAf+hr; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKD1M4t3mzDqkZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 00:59:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610978370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y/prChMH8jenUH2wDQJCWlk0s+jym+QBlVivZM1oCM0=;
 b=c1tAf+hrhBA1OqjgtutinFV4OCtTHmeUKygdbt4iWr3doKJdiGh3igiuWgetr5jkmD0LBz
 IxjvpUdyKegjpqFs31zqk3R3tqZGr4aBRLlwlhObRY9c2OoSzW96Z3pwUkMTab3zKmDczz
 timDRN6exoXOH9EnDK6Wf9z1Vz/B+aM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610978370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y/prChMH8jenUH2wDQJCWlk0s+jym+QBlVivZM1oCM0=;
 b=c1tAf+hrhBA1OqjgtutinFV4OCtTHmeUKygdbt4iWr3doKJdiGh3igiuWgetr5jkmD0LBz
 IxjvpUdyKegjpqFs31zqk3R3tqZGr4aBRLlwlhObRY9c2OoSzW96Z3pwUkMTab3zKmDczz
 timDRN6exoXOH9EnDK6Wf9z1Vz/B+aM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-vpP2zfwRND-etS261_oWsg-1; Mon, 18 Jan 2021 08:59:28 -0500
X-MC-Unique: vpP2zfwRND-etS261_oWsg-1
Received: by mail-pf1-f197.google.com with SMTP id n123so867245pfn.10
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 05:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=y/prChMH8jenUH2wDQJCWlk0s+jym+QBlVivZM1oCM0=;
 b=X85t8fpOuIfI2Bn8f6UyQpUV0uXC5qY3Rp5ETjzrVuouCYK5T9hR9/cmQnUYZ9DUXZ
 bE2qWbNQssFqf+j5rreAJ//EsFfQtuuFTcj4eTbBtoF12DJvoYj5HrIog3/KskwFPO9/
 S223DRatFrxfd9mEpgGpLcdduiydtHFQNvyNzOOe0ngLmYuE9CBm/9q8cCkGY2saqJzC
 4T67hqh8/s3H8UQnKK1cpyE+zA8dLKs4K8QE+Mh4+rSccpLhtyLi49g3CMT87LQhM2yM
 tT4Zx3p7ohV/8vpWBu0qPPXENVRyhCpx5hE1E24kbF1wWs+jZleeZGveajTZrvAFmJuo
 VqEA==
X-Gm-Message-State: AOAM533UnGfpaV5NDy4PcR1GiKgMbDJ4rpR0Ct8EFA8etHU6X185KFWU
 zwBty8AcoNUocGFL0cFKd7AY5YS0yDdLNW4CMee5luGhCzAU+plEDUhBqcYlDLk9IsoGVacO9W9
 WMOyktCv56p5SSdN3Vu1+P3i1
X-Received: by 2002:a17:902:16b:b029:dc:4ca1:f5fc with SMTP id
 98-20020a170902016bb02900dc4ca1f5fcmr26391882plb.26.1610978367389; 
 Mon, 18 Jan 2021 05:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9V66Vq7NRh0TCauAGTzNIVA9NKC1IsKFMBMz+vXJbaL8h67P1qYuASRKQ/wCx5C3BMT1izA==
X-Received: by 2002:a17:902:16b:b029:dc:4ca1:f5fc with SMTP id
 98-20020a170902016bb02900dc4ca1f5fcmr26391871plb.26.1610978367199; 
 Mon, 18 Jan 2021 05:59:27 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c11sm17394239pjv.3.2021.01.18.05.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 05:59:26 -0800 (PST)
Date: Mon, 18 Jan 2021 21:59:16 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210118135916.GB2423918@xiangao.remote.csb>
References: <20210118123945.23676-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210118123945.23676-1-sehuww@mail.scut.edu.cn>
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

Hi Weiwen,

On Mon, Jan 18, 2021 at 08:39:45PM +0800, Hu Weiwen wrote:
> When __erofs_battach() is called on an buffer block of which
> (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' will not be
> updated correctly. This bug can be reproduced by:
> 
> mkdir bug-repo
> head -c 4032 /dev/urandom > bug-repo/1
> head -c 4095 /dev/urandom > bug-repo/2
> head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
> mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
> 
> Then mount this image and see that file `3' in the image is different
> from `bug-repo/3'.
> 
> This patch fix this by:
> 
> * Don't inline tail-end data in this case, since the tail-end data will
> be in a different block from inode.
> * Correctly handle `battach' in this case.
> 

I will evaluate this condition later, yet if you have some interest
and extra time, could you also help on writing a regression testcase
for this, so we can look after such regression in case of the future
code changes?

This is also an ongoing work for the next erofs-utils release, see:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/

Thanks,
Gao Xiang

