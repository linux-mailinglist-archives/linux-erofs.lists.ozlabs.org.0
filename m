Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E836D3003E5
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 14:14:40 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMfqd6M76zDrnR
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 00:14:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=d9TkBbi3; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d9TkBbi3; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMfqR13FJzDqbW
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 00:14:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611321262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rWWA2GChLjXVJy31jzVScAhZ5S4IxNk2aLeu9NGvVac=;
 b=d9TkBbi3tTbtvMjvX0DXcViMS9oST7lIqcADmCZRpyHl2lKrsR43ml2TAD3D+pYtvmKj+/
 D0tcc3T0sVFhWQ8Q95L2kFb9tsgvWvHKmi57peRag0MWDF9YzqgHM67rAGgssJB/uLceby
 xEaa2R/3wdzb9n4+APGkSxS7jYNHXiA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611321262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rWWA2GChLjXVJy31jzVScAhZ5S4IxNk2aLeu9NGvVac=;
 b=d9TkBbi3tTbtvMjvX0DXcViMS9oST7lIqcADmCZRpyHl2lKrsR43ml2TAD3D+pYtvmKj+/
 D0tcc3T0sVFhWQ8Q95L2kFb9tsgvWvHKmi57peRag0MWDF9YzqgHM67rAGgssJB/uLceby
 xEaa2R/3wdzb9n4+APGkSxS7jYNHXiA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-lyoMDKHCMoSiqplNWPFTjw-1; Fri, 22 Jan 2021 08:14:21 -0500
X-MC-Unique: lyoMDKHCMoSiqplNWPFTjw-1
Received: by mail-pj1-f69.google.com with SMTP id r7so3597997pjq.7
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 05:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rWWA2GChLjXVJy31jzVScAhZ5S4IxNk2aLeu9NGvVac=;
 b=AC/H+9hCSIKXcFSGIh04e3xCw8btClt9D1kGKWP1yxCwrryKFKyNkUXEQ6lJAWjAQM
 88/CzL8sPcNoto12TNqLJCu6N5N2QKt3SLf3hE+iV1EBtPn+d05bFkIizLoWRNQxnUGP
 DROSWiRit8Mmgot1j7yz5Dlvs9xrBLpv3AMvN7i1fDLMX10koaNKagL/8cmiKxDy7Rfj
 13pNsxH4uHzn7f+7aXtfUdCX9pfDjp3gkyl6wBiWTTvUOewyL5jXm3iM+mLZaE5EA6lX
 1srNAhxeyM5YdN2xfeDXL71MkArVvC0XMQMxtC5xShJBw1Qj9IosI6sxS7oEktQu53wS
 QQiw==
X-Gm-Message-State: AOAM532PxVRVcFvZLGgKwZKCzX31JtFPFan8ygL0mG6Qtz+1m9x0+KcJ
 enU2zCbpKaDzjsnlP9Kpz7As9e1kS393Bh+HLx4IIi7ErYh9mZtOVs5tTyFlgqTjxH4vypaYNcw
 UEnpHy1+nJ+1UQs4DRjIkhufg
X-Received: by 2002:a17:90a:404c:: with SMTP id
 k12mr5418741pjg.4.1611321258580; 
 Fri, 22 Jan 2021 05:14:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwC8NdscBFdejp+sKh+PvmfXK6DkcN7+9XTkZbY8cRYbZ92mAivkE57tI4hnTmzd+Qee6xipg==
X-Received: by 2002:a17:90a:404c:: with SMTP id
 k12mr5418722pjg.4.1611321258305; 
 Fri, 22 Jan 2021 05:14:18 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m10sm9172323pjn.53.2021.01.22.05.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 05:14:17 -0800 (PST)
Date: Fri, 22 Jan 2021 21:14:08 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v6 2/2] erofs-utils: optimize buffer allocation logic
Message-ID: <20210122131408.GB3105292@xiangao.remote.csb>
References: <20210116063106.5031-1-hsiangkao@aol.com>
 <20210119054951.7457-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210119054951.7457-1-sehuww@mail.scut.edu.cn>
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

On Tue, Jan 19, 2021 at 01:49:51PM +0800, Hu Weiwen wrote:

...

>  	bb = NULL;
> 
> -	list_for_each_entry(cur, &blkh.list, list) {
> -		unsigned int used_before, used;
> +	if (!used0 || alignsize == EROFS_BLKSIZ)
> +		goto alloc;
> +
> +	/* try to find a most-fit mapped buffer block first */
> +	used_before = EROFS_BLKSIZ -
> +		round_up(size + required_ext + inline_ext, alignsize);

Honestly, after seen above I feel I'm not good at math now
since I smell somewhat strange of this, apart from the pending
patch you raised [1], the algebra is

/* since all buffers should be aligned with alignsize */
erofs_off_t alignedoffset = roundup(used_before, alignsize);

and (alignedoffset + size + required_ext + inline_ext <= EROFS_BLKSIZ)

and why it can be equal to
used_before = EROFS_BLKSIZ - round_up(size + required_ext + inline_ext, alignsize);

Could you explain this in detail if possible? for example,
size = 3
inline_ext = 62
alignsize = 32

so 4096 - roundup(3 + 62, 32) = 4096 - 96 = 4000
but, the real used_before can be even started at 4032, since
alignedoffset = roundup(4032, 32) = 4032
4032 + 62 = 4094 <= EROFS_BLKSIZ.

Am I stll missing something?

IMO, I don't want too hard on such math, I'd like to just use
used_before = EROFS_BLKSIZ - (size + required_ext + inline_ext);
and simply skip the bb if __erofs_battach is fail (as I said before,
the internal __erofs_battach can be changed, and I don't want to
imply that always succeed.)

If you also agree that, I'll send out a revised version along
with a cleanup patch to clean up erofs_balloc() as well, which
is more complicated than before.

[1] https://lore.kernel.org/r/20210121162606.8168-1-sehuww@mail.scut.edu.cn/

Thanks,
Gao Xiang

